Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC25C3D31F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhGWCAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 22:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233238AbhGWCAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 22:00:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96A9960EBF;
        Fri, 23 Jul 2021 02:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627008084;
        bh=JSAe/f6FLauxnrmz5Uq68q6e5ZvuMKEjBqoyrMmhzpQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=aIX5knDUMaNsdXTyV8roJWrHI4dBY+/KrlZGPP8Dw3gytFDkhvvzT7tO4oETmLD+b
         /9n2C4kCWz7q6DHvbEm7SV42vDdGI/UnMUb9QmZ+fTNhWWJiuSoBKtivcQnAItn0C0
         GfZaxiRm+HLQ7s6v/FjaoF0jf3e/AaZgIcxBbPdDJGq/O9lEowGHuHHmQVFfT6eYHm
         7hbVBfyjZbF2it6vyptN+o7g9h4S+5bnwoEttBldLdn3fQkTyUnbNDjrZr1oDPtxI8
         EoN3dniWaYjIDrS/C1aPbD5rY4NVW1Mb70ISbu1bZ1e+D6TNz3b2ZwaBWPZDdcjU63
         g5ZcF/OSScsKw==
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't sleep while grabing
 nat_tree_lock
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210722014149.525166-1-jaegeuk@kernel.org>
 <YPmufPvn9FJXfcip@google.com> <YPorDEwJcW3bi4DF@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <014f9855-3268-1d7e-98b6-0b8eb252bf39@kernel.org>
Date:   Fri, 23 Jul 2021 10:41:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPorDEwJcW3bi4DF@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/23 10:35, Jaegeuk Kim wrote:
> This tries to fix priority inversion in the below condition resulting in
> long checkpoint delay.
> 
> f2fs_get_node_info()
>   - nat_tree_lock
>    -> sleep to grab journal_rwsem by contention
> 
>                                       checkpoint
>                                       - waiting for nat_tree_lock
> 
> In order to let checkpoint go, let's release nat_tree_lock, if there's a
> journal_rwsem contention.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   Change log from v2:
>    - don't bother checkpoint
> 
>   fs/f2fs/node.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 0be9e2d7120e..b26642daa3d2 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -552,7 +552,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
>   	int i;
>   
>   	ni->nid = nid;
> -
> +retry:
>   	/* Check nat cache */
>   	down_read(&nm_i->nat_tree_lock);
>   	e = __lookup_nat_cache(nm_i, nid);
> @@ -564,10 +564,19 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
>   		return 0;
>   	}
>   
> -	memset(&ne, 0, sizeof(struct f2fs_nat_entry));
> +	/*
> +	 * Check current segment summary by trying to grab journal_rwsem first.
> +	 * This sem is on the critical path on the checkpoint requiring the above
> +	 * nat_tree_lock. Therefore, we should retry, if we failed to grab here
> +	 * while not bothering checkpoint.
> +	 */
> +	if (rwsem_is_locked(&sbi->cp_global_sem)) {

You mean: if (!rwsem_is_locked()) ?

IMO, once CP is processing, all readers who needs read nat will be blocked...

Thanks,

> +		down_read(&curseg->journal_rwsem);
> +	} else if (!down_read_trylock(&curseg->journal_rwsem)) {
> +		up_read(&nm_i->nat_tree_lock);
> +		goto retry;
> +	}
>   
> -	/* Check current segment summary */
> -	down_read(&curseg->journal_rwsem);
>   	i = f2fs_lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
>   	if (i >= 0) {
>   		ne = nat_in_journal(journal, i);
> 

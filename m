Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550E73C2BF1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 02:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhGJATt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 20:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhGJATt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 20:19:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B1D3613C5;
        Sat, 10 Jul 2021 00:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625876225;
        bh=umyVC+0Nj+PZL1A4xnrSLxFt2AKxxnuQx070lhPlUfg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=offRgoJmSYZARoBqYvSj5qHLOYDJyEPOCCTT+aiYrayNPgvr9p8n9PrnFPNshcf5d
         LlOk8V1ZGJqFQWVt93y6UKtStQ14DR+cW0xFrXnXK/69iTM0vh9hvxl/QvW/voFBlT
         HcAfmmSxGxAhbFfBBi21SWOVkRccdA+RwVyC5I6CTbSJbfIcW5FFnkm/Ir+wJA0Uv9
         AlVUUetYiAOKaEzcJdd1Mv1ofhTvXjX3oM1fqeSlIJHZMRHEXEl5knw9/utoavCWUf
         U8F887/Eft4bwc3q1SdoWcsPCPKtifxd38jL1jVhJWDh/pAjAMTiU56vK9P8gMK7rO
         QIdHsEq0tOssw==
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sysfs nodes to get GC info for
 each GC mode
To:     Daeho Jeong <daeho43@gmail.com>,
        Daeho Jeong <daehojeong@google.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20210709204430.1293298-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <4f88fac8-2838-45ac-8f87-789b8b7c2d09@kernel.org>
Date:   Sat, 10 Jul 2021 08:17:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709204430.1293298-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/10 4:44, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added gc_dirty_segs and gc_dirty_segs_mode sysfs nodes.
> 1) "gc_dirty_segs" shows how many dirty segments have been
> reclaimed by GC during a specific GC mode.
> 2) "gc_dirty_segs_mode" is used to control for which gc mode
> the "gc_dirty_segs" node shows.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 14 +++++++++++++
>   fs/f2fs/debug.c                         |  9 ++++++++
>   fs/f2fs/f2fs.h                          |  5 +++++
>   fs/f2fs/gc.c                            |  1 +
>   fs/f2fs/sysfs.c                         | 28 +++++++++++++++++++++++++
>   5 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 95155e4ec7fe..0d863eb185f6 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -493,3 +493,17 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
>   Description:	When ATGC is on, it controls age threshold to bypass GCing young
>   		candidates whose age is not beyond the threshold, by default it was
>   		initialized as 604800 seconds (equals to 7 days).
> +
> +What:		/sys/fs/f2fs/<disk>/gc_dirty_segs

How about renaming gc_dirty_segs to gc_reclaimed_segments?

> +Date:		July 2021
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	Show how many dirty segments have been reclaimed by GC during
> +		a specific GC mode (0: GC normal, 1: GC idle CB, 2: GC idle greedy,
> +		3: gc idle AT, 4: GC urgent high, 5: GC urgent low)

3. GC idle AT

> +		You can re-initialize this value to "0".
> +
> +What:		/sys/fs/f2fs/<disk>/gc_dirty_segs_mode

You know, F2FS_IOC_FLUSH_DEVICE/F2FS_IOC_RESIZE_FS needs to migrate all
blocks of target segment to other place, no matter the segment has partially
or fully valid blocks, so it looks 'gc_segment_mode' will be more appropriate?

Thanks,

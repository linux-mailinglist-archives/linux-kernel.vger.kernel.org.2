Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F793C7BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbhGNCaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237375AbhGNCaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:30:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DEB6611C0;
        Wed, 14 Jul 2021 02:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626229644;
        bh=Bj+HpaEPtkQE5eY6vbygK1YC7JiEJPnWWpcKchZsslY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BKiFegzHYXscUYOtgpqkndal3xjPRF+5NV0ZiTfdLdLnSt2JD2JLzSskyKiW7vWVh
         bhSFm5vTgauPYGP4frZB519ChPzGQw2sualqo971t9yX/5wfidcFUHjJGmcjaZ8xIp
         nMHfGwVHY0ShUYyfBbfMf0l/+YhGnMfB/WBlOHlqktXZXSpFXCBR0XCCbLauui1ZMl
         5ZZn+ckCww9xKYvs7qgN/pjyTB6tEcCAunp44rM33nTSC8lX3krkNEqh3AQcbMajNO
         If2AfKX2tRJvOLuiZh9iTfC4J+OT8E27gPt72D93sCnYdl6qTxFJtwWm5JksbONTvR
         fNZHK8ZpYxN6w==
Subject: Re: [RFC NO MERGE] f2fs: extent cache: support unaligned extent
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210707015815.1978-1-chao@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <ac39c9af-2ddd-5033-2b64-cb10aadc66a2@kernel.org>
Date:   Wed, 14 Jul 2021 10:27:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707015815.1978-1-chao@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/7 9:58, Chao Yu wrote:
> Compressed inode may suffer read performance issue due to it can not
> use extent cache, so I propose to add this unaligned extent support
> to improve it.
> 
> Currently, it only works in readonly format f2fs image.
> 
> Unaligned extent: in one compressed cluster, physical block number
> will be less than logical block number, so we add an extra physical
> block length in extent info in order to indicate such extent status.
> 
> The idea is if one whole cluster blocks are contiguous physically,
> once its mapping info was readed at first time, we will cache an
> unaligned (or aligned) extent info entry in extent cache, it expects
> that the mapping info will be hitted when rereading cluster.
> 
> Merge policy:
> - Aligned extents can be merged.
> - Aligned extent and unaligned extent can not be merged.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> 
> I just post this for comments, it passes compiling, w/o any test.
> 
>   fs/f2fs/compress.c     | 25 ++++++++++++
>   fs/f2fs/data.c         | 38 +++++++++++++-----
>   fs/f2fs/extent_cache.c | 90 +++++++++++++++++++++++++++++++++++++-----
>   fs/f2fs/f2fs.h         | 33 +++++++++++++---
>   fs/f2fs/node.c         | 20 ++++++++++
>   5 files changed, 181 insertions(+), 25 deletions(-)

Jaegeuk, any thoughts about this idea?

Thanks,

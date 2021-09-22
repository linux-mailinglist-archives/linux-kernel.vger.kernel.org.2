Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E2A414F60
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbhIVRug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:50:36 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48361 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233552AbhIVRuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:50:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UpFichl_1632332936;
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0UpFichl_1632332936)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Sep 2021 01:49:03 +0800
Date:   Thu, 23 Sep 2021 01:48:56 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix misbehavior of unsupported chunk format check
Message-ID: <20210922174856.GA87201@rsjd01523.et2sqa>
Reply-To: bo.liu@linux.alibaba.com
References: <20210922095141.233938-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922095141.233938-1-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 05:51:41PM +0800, Gao Xiang wrote:
> Unsupported chunk format should be checked with
> "if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL)"
> 
> Found when checking with 4k-byte blockmap (although currently mkfs
> uses inode chunk indexes format by default.)
>

Good catch.

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

thanks,
liubo

> Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
> Cc: Liu Bo <bo.liu@linux.alibaba.com>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 31ac3a7..a552399 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -176,7 +176,7 @@ static struct page *erofs_read_inode(struct inode *inode,
>  	}
>  
>  	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
> -		if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_ALL)) {
> +		if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
>  			erofs_err(inode->i_sb,
>  				  "unsupported chunk format %x of nid %llu",
>  				  vi->chunkformat, vi->nid);
> -- 
> 1.8.3.1

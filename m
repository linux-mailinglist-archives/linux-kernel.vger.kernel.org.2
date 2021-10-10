Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C9E427E34
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 03:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhJJAzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 20:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJJAzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 20:55:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055B0C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 17:53:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m21so7104125pgu.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 17:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7wuj6HN3VNW3ptFcFJ4L3dpizlPYPTVNtf1I5u19kY=;
        b=Luroea3fH4AMlCvnNg36I9vUfanhj3Dn1Xk0Vh+wEONZ1AZ3+m76I0Z4tQO0Zrr682
         HWsyULrxeCtyVNF+u7ZaqWwXrnAKdU19QuJDlPFWKwo2rUJT6Ki6uoJ0PgEUFNb1Ibmq
         +Rl/h94iG+Kcz8/8L4aduz4DStMGabs3hPwHTNa8dM9eY2o3knel6yqWRwbyvQFWdxyq
         Wj4CQu9Z+/4SUFdhJgsTEypBoL5kqhzVRYOqpJy7ridkBj5j+rKnJ6jvklKTXxcLOvMv
         Q4mxLytlgOHm9Mwymd2P/D7qml//Vyk8BDGO1D/l9vNngghznpS/FG9b3HwxjzisKR4Q
         JZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7wuj6HN3VNW3ptFcFJ4L3dpizlPYPTVNtf1I5u19kY=;
        b=La1aKBbC3XSpZhWwuVfwIdVWw9GBxSpecvXycfpukZjfc2l7aK2b7k+4+qRIZ3JvRx
         Rq7CLBYhDzFFONzzHi2Wm9JqWn35+5NYqCGq/+MCqlp4hgyow1UcUBQo55aRYh2AbIow
         b6kumYFKkvbE9aTM7qvGiokiO/HlnwQoiQjX7k35gWHBcjb0FG+PP2YQHrxO6bmO/FRF
         Yl0baR3og7egLee31q43yYLteB63DEmVaG0tbpiyKksYopruNs89gXTSblfBjYMUyeXu
         rylhSYpkXVEQ4BASwJCDAoESfkkbrVMai5Ww8redgchcVSEXIhIxdwVbeROdgDstxGvM
         b/3A==
X-Gm-Message-State: AOAM531ESzfKgb+wyzhpTovR2tjflxzz+YGsJUrk6yffSzU9lLBNOtgU
        wM7fEhd0r7yGVB8ggfqCxI5VhsFx6VsT5g==
X-Google-Smtp-Source: ABdhPJwaqTjKeH5saHli8+diCDUoFx9BMZ3DeWWYyt92gbN+7aHkE9Ib1Uunfe7nqwkGwGOtvjQDow==
X-Received: by 2002:a63:e10d:: with SMTP id z13mr11861107pgh.375.1633827219597;
        Sat, 09 Oct 2021 17:53:39 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id v2sm3028041pje.15.2021.10.09.17.53.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Oct 2021 17:53:39 -0700 (PDT)
Date:   Sun, 10 Oct 2021 08:53:32 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <xiang@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>, huyue2@yulong.com,
        zhangwen@yulong.com
Subject: Re: [PATCH v3 2/3] erofs: introduce the secondary compression head
Message-ID: <20211010085332.00007e53.zbestahu@gmail.com>
In-Reply-To: <20211009181209.23041-1-xiang@kernel.org>
References: <20211008200839.24541-3-xiang@kernel.org>
        <20211009181209.23041-1-xiang@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2021 02:12:09 +0800
Gao Xiang <xiang@kernel.org> wrote:

> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Previously, for each HEAD lcluster, it can be either HEAD or PLAIN
> lcluster to indicate whether the whole pcluster is compressed or not.
> 
> In this patch, a new HEAD2 head type is introduced to specify another
> compression algorithm other than the primary algorithm for each
> compressed file, which can be used for upcoming LZMA compression and
> LZ4 range dictionary compression for various data patterns.
> 
> It has been stayed in the EROFS roadmap for years. Complete it now!
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2: https://lore.kernel.org/r/20211008200839.24541-3-xiang@kernel.org
> changes since v2:
>  - simplify z_algorithmtype check suggested by Yue.
> 
>  fs/erofs/erofs_fs.h |  8 +++++---
>  fs/erofs/zmap.c     | 38 ++++++++++++++++++++++++++------------
>  2 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index b0b23f41abc3..f579c8c78fff 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -21,11 +21,13 @@
>  #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
>  #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
>  #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
> +#define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
>  #define EROFS_ALL_FEATURE_INCOMPAT		\
>  	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
>  	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
>  	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
> -	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
> +	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
> +	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2)
>  
>  #define EROFS_SB_EXTSLOT_SIZE	16
>  
> @@ -314,9 +316,9 @@ struct z_erofs_map_header {
>   */
>  enum {
>  	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
> -	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
> +	Z_EROFS_VLE_CLUSTER_TYPE_HEAD1		= 1,
>  	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
> -	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
> +	Z_EROFS_VLE_CLUSTER_TYPE_HEAD2		= 3,
>  	Z_EROFS_VLE_CLUSTER_TYPE_MAX
>  };
>  
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 9d9c26343dab..864d9d5474d5 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -28,7 +28,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  {
>  	struct erofs_inode *const vi = EROFS_I(inode);
>  	struct super_block *const sb = inode->i_sb;
> -	int err;
> +	int err, headnr;
>  	erofs_off_t pos;
>  	struct page *page;
>  	void *kaddr;
> @@ -68,9 +68,11 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
>  	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
>  
> -	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
> -		erofs_err(sb, "unknown compression format %u for nid %llu, please upgrade kernel",
> -			  vi->z_algorithmtype[0], vi->nid);
> +	headnr = 0;
> +	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
> +	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
> +		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
> +			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
>  		err = -EOPNOTSUPP;
>  		goto unmap_done;
>  	}
> @@ -189,7 +191,8 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
>  		break;
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>  		m->clusterofs = le16_to_cpu(di->di_clusterofs);
>  		m->pblk = le32_to_cpu(di->di_u.blkaddr);
>  		break;
> @@ -446,7 +449,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>  		}
>  		return z_erofs_extent_lookback(m, m->delta[0]);
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>  		m->headtype = m->type;
>  		map->m_la = (lcn << lclusterbits) | m->clusterofs;
>  		break;
> @@ -470,13 +474,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  	int err;
>  
>  	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
> -		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
> +		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 &&
> +		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD2);
> +	DBG_BUGON(m->type != m->headtype);
> +
>  	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
> -	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
> +	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1) &&
> +	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
> +	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) &&
> +	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
>  		map->m_plen = 1 << lclusterbits;
>  		return 0;
>  	}
> -
>  	lcn = m->lcn + 1;
>  	if (m->compressedlcs)
>  		goto out;
> @@ -498,7 +507,8 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  
>  	switch (m->type) {
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>  		/*
>  		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
>  		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
> @@ -553,7 +563,8 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>  			DBG_BUGON(!m->delta[1] &&
>  				  m->clusterofs != 1 << lclusterbits);
>  		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
> -			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD) {
> +			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 ||
> +			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
>  			/* go on until the next HEAD lcluster */
>  			if (lcn != headlcn)
>  				break;
> @@ -612,7 +623,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  
>  	switch (m.type) {
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>  		if (endoff >= m.clusterofs) {
>  			m.headtype = m.type;
>  			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
> @@ -654,6 +666,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  
>  	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
>  		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
> +	else if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2)
> +		map->m_algorithmformat = vi->z_algorithmtype[1];
>  	else
>  		map->m_algorithmformat = vi->z_algorithmtype[0];
>  

Looks good to me.

Reviewed-by: Yue Hu <huyue2@yulong.com>


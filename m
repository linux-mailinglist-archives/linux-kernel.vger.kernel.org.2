Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B5A427702
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 05:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbhJIDwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhJIDwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:52:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EB5C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 20:50:38 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s75so4958218pgs.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 20:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qn3VO9TX+pIEqHsNnrQsSRHoGXlUJQFsmUa2joL3IPw=;
        b=ZjgG7b5C8AZ7bflPUYEASFNTqtsHfyPPy1EclzjnyP8/Yf7g5K5FU3oGlM3KbMd+V2
         SayK4IZ425j3BadSSdI/iU8lxivMsTdoF8w3fcmKTqqqIlFawx+2TNEh70rJ0ZunHe9k
         5KTxKrV6Km2pOA3J1WJVP/EN8xwhrYnePbQyE4FIKzuoyxgIbIQvl548CNgq9C3R6oaC
         s0JKDa0xEx3mO3cL3CSB9qCMCqri5tdPaOsqAK4dgk7iFuRKt9Hhk7l6Bvpswx6eqbPh
         t0u/8pvKTAVh02+jyV2dAJq67MwO4TBoTSCbZEqq5Dh+oznwfLfpBBFDHhYAyMpDxa0i
         oK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qn3VO9TX+pIEqHsNnrQsSRHoGXlUJQFsmUa2joL3IPw=;
        b=AMeC8YZUZSRzBByCl9fNV2ZW13hT4+lVK4x3q6EKhyDt86QosuSKQAMFVcWRiscy6E
         HGJyEE4G8v8ruvYC04Ado8LQuL9EYnuWwDLEIUMRshZonFblWWFzZVrNaxplmtpQk+oL
         MUbT+ThzrqNlt2QHAhkg1Ifyvot2Kv3Nq7RphrWWtl9NtWUrELGKu+wKQA6kn7ar5W3c
         wtoKom+pclPGx03lsS6c+2jMz5fihIBu8fhfvfB3D+sR71S4tgZeAWSWZsvO5A9/bhSn
         Wo+3spFFUEO/xrXjNR9W6jIwNpk0J3VYyk11sH9083sq6MMLj+pnu5snSHyIOHfrCu+r
         CnqQ==
X-Gm-Message-State: AOAM5339+6toYxR3JQ21r9ZhPK/NW7uberCfwARUKDdB56oqSs2zV68P
        pv2Wg8CvsESDzMJeZZdXM3iT0niih4TN8Q==
X-Google-Smtp-Source: ABdhPJwrdLQzB7NQb5rT0Jc0lzXVz/5flW55L1ff74MKJgsomrBQVr92Z9MQVSL6YxdHzP/bV8tWUg==
X-Received: by 2002:a63:3d4a:: with SMTP id k71mr7924665pga.276.1633751438224;
        Fri, 08 Oct 2021 20:50:38 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id k9sm657242pfa.88.2021.10.08.20.50.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Oct 2021 20:50:38 -0700 (PDT)
Date:   Sat, 9 Oct 2021 11:50:32 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <xiang@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>, huyue2@yulong.com,
        zhangwen@yulong.com
Subject: Re: [PATCH v2 2/3] erofs: introduce the secondary compression head
Message-ID: <20211009115032.00002f26.zbestahu@gmail.com>
In-Reply-To: <20211008200839.24541-3-xiang@kernel.org>
References: <20211008200839.24541-1-xiang@kernel.org>
        <20211008200839.24541-3-xiang@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Oct 2021 04:08:38 +0800
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
>  fs/erofs/erofs_fs.h |  8 +++++---
>  fs/erofs/zmap.c     | 36 +++++++++++++++++++++++++++---------
>  2 files changed, 32 insertions(+), 12 deletions(-)
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
> index 9d9c26343dab..03945f15ceae 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -69,11 +69,17 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
>  
>  	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
> -		erofs_err(sb, "unknown compression format %u for nid %llu, please upgrade kernel",
> +		erofs_err(sb, "unknown HEAD1 format %u for nid %llu, please upgrade kernel",
>  			  vi->z_algorithmtype[0], vi->nid);
>  		err = -EOPNOTSUPP;
>  		goto unmap_done;
>  	}
> +	if (vi->z_algorithmtype[1] >= Z_EROFS_COMPRESSION_MAX) {
> +		erofs_err(sb, "unknown HEAD2 format %u for nid %llu, please upgrade kernel",
> +			  vi->z_algorithmtype[1], vi->nid);
> +		err = -EOPNOTSUPP;
> +		goto unmap_done;
> +	}

Seems duplicated a little, how about below code?

	if (vi->z_algorithmtype[i] >= Z_EROFS_COMPRESSION_MAX ||
	    vi->z_algorithmtype[++i] >= Z_EROFS_COMPRESSION_MAX) {
                erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
			  i, vi->z_algorithmtype[i], vi->nid);
		err = -EOPNOTSUPP;
		goto unmap_done;
	}

>  
>  	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
>  	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
> @@ -189,7 +195,8 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
>  		break;
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>  		m->clusterofs = le16_to_cpu(di->di_clusterofs);
>  		m->pblk = le32_to_cpu(di->di_u.blkaddr);
>  		break;
> @@ -446,7 +453,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>  		}
>  		return z_erofs_extent_lookback(m, m->delta[0]);
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>  		m->headtype = m->type;
>  		map->m_la = (lcn << lclusterbits) | m->clusterofs;
>  		break;
> @@ -470,13 +478,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
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
> @@ -498,7 +511,8 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  
>  	switch (m->type) {
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>  		/*
>  		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
>  		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
> @@ -553,7 +567,8 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>  			DBG_BUGON(!m->delta[1] &&
>  				  m->clusterofs != 1 << lclusterbits);
>  		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
> -			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD) {
> +			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 ||
> +			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
>  			/* go on until the next HEAD lcluster */
>  			if (lcn != headlcn)
>  				break;
> @@ -612,7 +627,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  
>  	switch (m.type) {
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>  		if (endoff >= m.clusterofs) {
>  			m.headtype = m.type;
>  			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
> @@ -654,6 +670,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  
>  	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
>  		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
> +	else if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2)
> +		map->m_algorithmformat = vi->z_algorithmtype[1];
>  	else
>  		map->m_algorithmformat = vi->z_algorithmtype[0];
>  


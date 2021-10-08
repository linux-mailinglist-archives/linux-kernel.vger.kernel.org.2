Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436484262A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhJHDCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhJHDCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:02:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E40C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 20:00:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id o133so710536pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 20:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dj0s5gHpb3ZbMoqbjqKgxJDgSpnR8KBBUz69TXB+ylM=;
        b=VOn/Q9jMxilGMYrm/f9y0YpvbgJdWgwjXqPiQCM0YjuT9He1HSKicLiXT5iCniVz4G
         J98lcSjyumXBlcgRSD8wWG+KsAtDsbCWB/hFrA8imeDQoSkq4c1dg7HdTRuhREwgD8Ne
         5Ix79QHgTCrz4bPlhaInrT/HWqJvsHH5MANvOj1u/FunOETOoOANCT58TzSJAhqb6bbM
         91+7TbxINeaDFCLoZw4FgIQhh7bITU2Ho/YpeobdUykFrhhPc4mSr4B7Q12o7IuOSBNW
         0VEXVn8LPKeABVR7RVmsaBMyGPpYdGnsWmzIvfnshW5k0/Wc79BGozjsz8LzXUQsPaah
         5pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dj0s5gHpb3ZbMoqbjqKgxJDgSpnR8KBBUz69TXB+ylM=;
        b=7erLeeVcpe/DpRpO04hL8o5038OxvMMWOVj0pR5Y3YnJHDxPu7uvOfNghPva/ItjYu
         QlaJo5waB2rqRKe+7wT+un6dk301LT61fG8kD5XVquCjWnitkMKIsWezfOJO45pX8pzH
         6LnxGbni9fzaD8CQDQUebdrZ0GSaD1nMC4u1819gFO3rMbLZ0tw2zk1WVIQokb91hfiC
         DxT97W8CWwc4GjGgpLmev5Md71esIDW+jhVutCXulIgVYHAEF55LGzddc7Klhva5k3Ab
         HBGz8FIyLHjc+3PMkVkIPqjd85ktA9xOmT8Zzkjxb65qIPDj+X6ABTfgdxt3KfAFoqBQ
         d87A==
X-Gm-Message-State: AOAM533Z/ceYJZl1AGMHg5QNeUHweKQHPvuAlUSDgltr2LelSUC0ZvRh
        j3qcDucbjmBnAA6qoDy+eWE=
X-Google-Smtp-Source: ABdhPJxvoZvwTNLYNZte1Y49PFZs5zGtriRYHpyVw38Pq0Tienu7yLSLI6dOlk+O2T6J3BYh11pxQA==
X-Received: by 2002:a63:7b48:: with SMTP id k8mr477530pgn.208.1633662036058;
        Thu, 07 Oct 2021 20:00:36 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id g4sm653874pgs.42.2021.10.07.20.00.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Oct 2021 20:00:35 -0700 (PDT)
Date:   Fri, 8 Oct 2021 11:00:29 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <xiang@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] erofs: get compression algorithms directly on
 mapping
Message-ID: <20211008110029.0000181f.zbestahu@gmail.com>
In-Reply-To: <20211007170605.7062-2-xiang@kernel.org>
References: <20211007170605.7062-1-xiang@kernel.org>
        <20211007170605.7062-2-xiang@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Oct 2021 01:06:03 +0800
Gao Xiang <xiang@kernel.org> wrote:

> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Currently, z_erofs_map_blocks returns whether extents are compressed

Mapping function is z_erofs_map_blocks_iter()?

> or not, and the decompression frontend gets the specific algorithms
> then.
> 
> It works but not quite well in many aspests, for example:
>  - The decompression frontend has to deal with whether extents are
>    compressed or not again and lookup the algorithms if compressed.
>    It's duplicated and too detailed about the on-disk mapping.
> 
>  - A new secondary compression head will be introduced later so that
>    each file can have 2 compression algorithms at most for different
>    type of data. It could increase the complexity of the decompression
>    frontend if still handled in this way;
> 
>  - A new readmore decompression strategy will be introduced to get
>    better performance for much bigger pcluster and lzma, which needs
>    the specific algorithm in advance as well.
> 
> Let's look up compression algorithms directly in z_erofs_map_blocks()

Same mapping function name mistake?

> instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/compress.h          |  5 -----
>  fs/erofs/internal.h          | 12 +++++++++---
>  fs/erofs/zdata.c             | 12 ++++++------
>  fs/erofs/zmap.c              | 19 ++++++++++---------
>  include/trace/events/erofs.h |  2 +-
>  5 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> index 3701c72bacb2..ad62d1b4d371 100644
> --- a/fs/erofs/compress.h
> +++ b/fs/erofs/compress.h
> @@ -8,11 +8,6 @@
>  
>  #include "internal.h"
>  
> -enum {
> -	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
> -	Z_EROFS_COMPRESSION_RUNTIME_MAX
> -};
> -
>  struct z_erofs_decompress_req {
>  	struct super_block *sb;
>  	struct page **in, **out;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 9524e155b38f..48bfc6eb2b02 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -338,7 +338,7 @@ extern const struct address_space_operations z_erofs_aops;
>   * of the corresponding uncompressed data in the file.
>   */
>  enum {
> -	BH_Zipped = BH_PrivateStart,
> +	BH_Encoded = BH_PrivateStart,
>  	BH_FullMapped,
>  };
>  
> @@ -346,8 +346,8 @@ enum {
>  #define EROFS_MAP_MAPPED	(1 << BH_Mapped)
>  /* Located in metadata (could be copied from bd_inode) */
>  #define EROFS_MAP_META		(1 << BH_Meta)
> -/* The extent has been compressed */
> -#define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
> +/* The extent is encoded */
> +#define EROFS_MAP_ENCODED	(1 << BH_Encoded)
>  /* The length of extent is full */
>  #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
>  
> @@ -355,6 +355,7 @@ struct erofs_map_blocks {
>  	erofs_off_t m_pa, m_la;
>  	u64 m_plen, m_llen;
>  
> +	char m_algorithmformat;
>  	unsigned int m_flags;
>  
>  	struct page *mpage;
> @@ -368,6 +369,11 @@ struct erofs_map_blocks {
>   */
>  #define EROFS_GET_BLOCKS_FIEMAP	0x0002
>  
> +enum {
> +	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
> +	Z_EROFS_COMPRESSION_RUNTIME_MAX
> +};
> +
>  /* zmap.c */
>  extern const struct iomap_ops z_erofs_iomap_report_ops;
>  
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 11c7a1aaebad..5c34ef66677f 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -476,6 +476,11 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
>  	struct erofs_workgroup *grp;
>  	int err;
>  
> +	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
> +		DBG_BUGON(1);
> +		return -EFSCORRUPTED;
> +	}
> +
>  	/* no available pcluster, let's allocate one */
>  	pcl = z_erofs_alloc_pcluster(map->m_plen >> PAGE_SHIFT);
>  	if (IS_ERR(pcl))
> @@ -483,16 +488,11 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
>  
>  	atomic_set(&pcl->obj.refcount, 1);
>  	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
> -
> +	pcl->algorithmformat = map->m_algorithmformat;
>  	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
>  		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
>  			Z_EROFS_PCLUSTER_FULL_LENGTH : 0);
>  
> -	if (map->m_flags & EROFS_MAP_ZIPPED)
> -		pcl->algorithmformat = Z_EROFS_COMPRESSION_LZ4;
> -	else
> -		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
> -
>  	/* new pclusters should be claimed as type 1, primary and followed */
>  	pcl->next = clt->owned_head;
>  	clt->mode = COLLECT_PRIMARY_FOLLOWED;
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 7a6df35fdc91..9d9c26343dab 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -111,7 +111,7 @@ struct z_erofs_maprecorder {
>  
>  	unsigned long lcn;
>  	/* compression extent information gathered */
> -	u8  type;
> +	u8  type, headtype;
>  	u16 clusterofs;
>  	u16 delta[2];
>  	erofs_blk_t pblk, compressedlcs;
> @@ -446,9 +446,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>  		}
>  		return z_erofs_extent_lookback(m, m->delta[0]);
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -		map->m_flags &= ~EROFS_MAP_ZIPPED;
> -		fallthrough;
>  	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +		m->headtype = m->type;
>  		map->m_la = (lcn << lclusterbits) | m->clusterofs;
>  		break;
>  	default:
> @@ -472,7 +471,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  
>  	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
>  		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
> -	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
> +	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
>  	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
>  		map->m_plen = 1 << lclusterbits;
>  		return 0;
> @@ -609,16 +608,13 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  	if (err)
>  		goto unmap_out;
>  
> -	map->m_flags = EROFS_MAP_ZIPPED;	/* by default, compressed */
>  	end = (m.lcn + 1ULL) << lclusterbits;
>  
>  	switch (m.type) {
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -		if (endoff >= m.clusterofs)
> -			map->m_flags &= ~EROFS_MAP_ZIPPED;
> -		fallthrough;
>  	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
>  		if (endoff >= m.clusterofs) {
> +			m.headtype = m.type;
>  			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
>  			break;
>  		}
> @@ -650,12 +646,17 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  
>  	map->m_llen = end - map->m_la;
>  	map->m_pa = blknr_to_addr(m.pblk);
> -	map->m_flags |= EROFS_MAP_MAPPED;
> +	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;

Seems the new flag EROFS_MAP_ENCODED may be a little redundant?

It is used only for checking whether the file system is corrupted or not when
entering z_erofs_register_collection(). 

And before collection begins, we will check whether the EROFS_MAP_MAPPED is set
or not. We will do the collection only if EROFS_MAP_MAPPED is set. That's to say,
the above checking to EROFS_MAP_ENCODED should be not possible?

Thanks.

>  
>  	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
>  	if (err)
>  		goto out;
>  
> +	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
> +		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
> +	else
> +		map->m_algorithmformat = vi->z_algorithmtype[0];
> +
>  	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
>  		err = z_erofs_get_extent_decompressedlen(&m);
>  		if (!err)
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index db4f2cec8360..16ae7b666810 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -24,7 +24,7 @@ struct erofs_map_blocks;
>  #define show_mflags(flags) __print_flags(flags, "",	\
>  	{ EROFS_MAP_MAPPED,	"M" },			\
>  	{ EROFS_MAP_META,	"I" },			\
> -	{ EROFS_MAP_ZIPPED,	"Z" })
> +	{ EROFS_MAP_ENCODED,	"E" })
>  
>  TRACE_EVENT(erofs_lookup,
>  


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4E430A07
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343958AbhJQPaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343951AbhJQPaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:30:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9A6160FE3;
        Sun, 17 Oct 2021 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634484483;
        bh=PNJBWudaj4UdT5rrn60hnrCNulmXWQLafb1LOAfGlTg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tIiHk11j1V+EeTGmq9LG6Up6ScmZ+h0DxAbJrmFrJVqWaBbO/1K16lQ/KVUSCq0hr
         xaVh5Ez8fF7Y4oqeLFWyIezwn3R9c/ACzy8N5fMpF68zbUFtABdSWvOg0EdazvLrxr
         UkyEP/rR06AKkIYJb7irjzAfhWvPWYKvw50tK5Fl8gn+/ppsPGBd4JGVzzoDd9fh5e
         wzPhonOzQ1N4eSCU/80kMg3Expg9GRrCXjLArH4aAHwwIq930KXPyu+nJvndrbvCgE
         RyWir90G5DYn09/ky4ZFGU8wi8OpXicIzIPLkEyUcdXXEwdjTOCt6ztOOM4VlkyDfb
         D1Dcv1Df+QYVw==
Message-ID: <c3ad3f92-6a35-acbb-923a-21611d232689@kernel.org>
Date:   Sun, 17 Oct 2021 23:27:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 2/3] erofs: introduce the secondary compression head
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211008200839.24541-3-xiang@kernel.org>
 <20211009181209.23041-1-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211009181209.23041-1-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/10 2:12, Gao Xiang wrote:
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
>   - simplify z_algorithmtype check suggested by Yue.
> 
>   fs/erofs/erofs_fs.h |  8 +++++---
>   fs/erofs/zmap.c     | 38 ++++++++++++++++++++++++++------------
>   2 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index b0b23f41abc3..f579c8c78fff 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -21,11 +21,13 @@
>   #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
>   #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
>   #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
> +#define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
>   #define EROFS_ALL_FEATURE_INCOMPAT		\
>   	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
>   	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
>   	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
> -	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
> +	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
> +	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2)
>   
>   #define EROFS_SB_EXTSLOT_SIZE	16
>   
> @@ -314,9 +316,9 @@ struct z_erofs_map_header {
>    */
>   enum {
>   	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
> -	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
> +	Z_EROFS_VLE_CLUSTER_TYPE_HEAD1		= 1,
>   	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
> -	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
> +	Z_EROFS_VLE_CLUSTER_TYPE_HEAD2		= 3,

It needs to update comments above as well.

Thanks,

>   	Z_EROFS_VLE_CLUSTER_TYPE_MAX
>   };
>   
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 9d9c26343dab..864d9d5474d5 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -28,7 +28,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
>   	struct super_block *const sb = inode->i_sb;
> -	int err;
> +	int err, headnr;
>   	erofs_off_t pos;
>   	struct page *page;
>   	void *kaddr;
> @@ -68,9 +68,11 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>   	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
>   	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
>   
> -	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
> -		erofs_err(sb, "unknown compression format %u for nid %llu, please upgrade kernel",
> -			  vi->z_algorithmtype[0], vi->nid);
> +	headnr = 0;
> +	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
> +	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
> +		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
> +			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
>   		err = -EOPNOTSUPP;
>   		goto unmap_done;
>   	}
> @@ -189,7 +191,8 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>   		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
>   		break;
>   	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>   		m->clusterofs = le16_to_cpu(di->di_clusterofs);
>   		m->pblk = le32_to_cpu(di->di_u.blkaddr);
>   		break;
> @@ -446,7 +449,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   		}
>   		return z_erofs_extent_lookback(m, m->delta[0]);
>   	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>   		m->headtype = m->type;
>   		map->m_la = (lcn << lclusterbits) | m->clusterofs;
>   		break;
> @@ -470,13 +474,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   	int err;
>   
>   	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
> -		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
> +		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 &&
> +		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD2);
> +	DBG_BUGON(m->type != m->headtype);
> +
>   	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
> -	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
> +	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1) &&
> +	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
> +	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) &&
> +	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
>   		map->m_plen = 1 << lclusterbits;
>   		return 0;
>   	}
> -
>   	lcn = m->lcn + 1;
>   	if (m->compressedlcs)
>   		goto out;
> @@ -498,7 +507,8 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   
>   	switch (m->type) {
>   	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>   		/*
>   		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
>   		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
> @@ -553,7 +563,8 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>   			DBG_BUGON(!m->delta[1] &&
>   				  m->clusterofs != 1 << lclusterbits);
>   		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
> -			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD) {
> +			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 ||
> +			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
>   			/* go on until the next HEAD lcluster */
>   			if (lcn != headlcn)
>   				break;
> @@ -612,7 +623,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>   
>   	switch (m.type) {
>   	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
>   		if (endoff >= m.clusterofs) {
>   			m.headtype = m.type;
>   			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
> @@ -654,6 +666,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>   
>   	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
>   		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
> +	else if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2)
> +		map->m_algorithmformat = vi->z_algorithmtype[1];
>   	else
>   		map->m_algorithmformat = vi->z_algorithmtype[0];
>   
> 

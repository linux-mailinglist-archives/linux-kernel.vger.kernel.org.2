Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEAB32252A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhBWFVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:21:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229961AbhBWFVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614057580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRY4EIG8QWABwtBIFNtzKLvglOXNCK9nv/ZZ50jZYQw=;
        b=L8BO77TZy/i8nHJmO3Iscu2F2EgMDR68osiWYgq7MPlbENyUrxvF+U0kQNmUP6colFj6sE
        a7iFK0pVIvzBOiOdLB7CUQBJTp44vg/A3Quqad3SbRHusfS3T2gj+e7qhbsohTainrwKLs
        fjJxI7FPE33U4Xi4RV+nO+wb8/HdlaU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Dc5uS8fMO1qCHULUSgeysA-1; Tue, 23 Feb 2021 00:19:37 -0500
X-MC-Unique: Dc5uS8fMO1qCHULUSgeysA-1
Received: by mail-pl1-f199.google.com with SMTP id p15so9492289plq.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 21:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nRY4EIG8QWABwtBIFNtzKLvglOXNCK9nv/ZZ50jZYQw=;
        b=HKMVOuB5zGyKsr67cVH4w9AvHw9hLKKITjLQ737V59JQ77Dge5vgZdMiRqDGDGH9LQ
         42mInShxW5DdKtzNLymbHU6XXcjrz8z95Gtx9kf0YOImP6lswOKYCEo2DGFYHhX3/th/
         s+UP9uSWjAAct0xPyll/5oVDeKQgbwoHRiN/B3N8LKPx4w9yJzx1yJXCz+LvIz25/N/o
         PDliv7H1Y1PYe/hdyYlUb8Xh/rP0/Uc2phGJIa9dAm/uY9+Yc7fKCabwYddBSXBmZIfi
         wxqow/js4DY1hgWrHdpjAiqHwrMZGSSfC0k0GLvA5fQnK/SarzZR7W4e9eK4km0MM4jO
         AvAg==
X-Gm-Message-State: AOAM5315K4er1+yl2E5sYZwzOiIymKxBjGOTlI8Se8UNU/csWILeagXC
        xY3ta2vbs0UuBZapJOaYB6OF63v3kKqqoNTPTTERIm86zFEqtdZsx1FzoFx3mrVooQqv8PXdGxv
        UAcYxMuIwspmO7dx0UQAceoLC
X-Received: by 2002:a17:902:c083:b029:e3:ef59:5a15 with SMTP id j3-20020a170902c083b02900e3ef595a15mr10198803pld.83.1614057576771;
        Mon, 22 Feb 2021 21:19:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvvO9RshceS/wXHkdZ4j5fG/eyTXtrflV7OndDWJJLFMiCnAR7r3atl1duV8eWrVt4zjhGpw==
X-Received: by 2002:a17:902:c083:b029:e3:ef59:5a15 with SMTP id j3-20020a170902c083b02900e3ef595a15mr10198786pld.83.1614057576508;
        Mon, 22 Feb 2021 21:19:36 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f7sm1293346pjh.45.2021.02.22.21.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 21:19:36 -0800 (PST)
Date:   Tue, 23 Feb 2021 13:19:26 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        guoweichao@oppo.com, zhangshiming@oppo.com
Subject: Re: [PATCH v2] erofs: support adjust lz4 history window size
Message-ID: <20210223051926.GB1225203@xiangao.remote.csb>
References: <20210223043634.36807-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223043634.36807-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 12:36:34PM +0800, Huang Jianan via Linux-erofs wrote:
> From: huangjianan <huangjianan@oppo.com>
> 
> lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
> using rolling decompression, a block with a higher compression
> ratio will cause a larger memory allocation (up to 64k). It may
> cause a large resource burden in extreme cases on devices with
> small memory and a large number of concurrent IOs. So appropriately
> reducing this value can improve performance.
> 
> Decreasing this value will reduce the compression ratio (except
> when input_size <LZ4_DISTANCE_MAX). But considering that erofs
> currently only supports 4k output, reducing this value will not
> significantly reduce the compression benefits.

It'd be better to add some description words here to explain why
old kernels could use such new adjusted images (because we only
decrease the sliding window size, and LZ4_MAX_DISTANCE in principle
is 64kb due to the length limitation of "offset" field for each
lz4 sequence.)

> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
> 
> changes since previous version
> - change compr_alg to lz4_max_distance
> - calculate lz4_max_distance_pages when reading super_block
> 
>  fs/erofs/decompressor.c | 12 ++++++++----
>  fs/erofs/erofs_fs.h     |  3 ++-
>  fs/erofs/internal.h     |  3 +++
>  fs/erofs/super.c        |  5 +++++
>  4 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 1cb1ffd10569..fb2b4f1b8806 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -36,22 +36,26 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>  	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
>  	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
>  					   BITS_PER_LONG)] = { 0 };
> +	unsigned int lz4_max_distance_pages = LZ4_MAX_DISTANCE_PAGES;

How about directly
unsigned int lz4_max_distance_pages = EROFS_SB(rq->sb)->lz4_max_distance_pages
here... (and see below.)

>  	void *kaddr = NULL;
>  	unsigned int i, j, top;
>  
> +	if (EROFS_SB(rq->sb)->lz4_max_distance_pages)
> +		lz4_max_distance_pages = EROFS_SB(rq->sb)->lz4_max_distance_pages;
> +
>  	top = 0;
>  	for (i = j = 0; i < nr; ++i, ++j) {
>  		struct page *const page = rq->out[i];
>  		struct page *victim;
>  
> -		if (j >= LZ4_MAX_DISTANCE_PAGES)
> +		if (j >= lz4_max_distance_pages)
>  			j = 0;
>  
>  		/* 'valid' bounced can only be tested after a complete round */
>  		if (test_bit(j, bounced)) {
> -			DBG_BUGON(i < LZ4_MAX_DISTANCE_PAGES);
> -			DBG_BUGON(top >= LZ4_MAX_DISTANCE_PAGES);
> -			availables[top++] = rq->out[i - LZ4_MAX_DISTANCE_PAGES];
> +			DBG_BUGON(i < lz4_max_distance_pages);
> +			DBG_BUGON(top >= lz4_max_distance_pages);
> +			availables[top++] = rq->out[i - lz4_max_distance_pages];
>  		}
>  
>  		if (page) {
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 9ad1615f4474..5eb37002b1a3 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -39,7 +39,8 @@ struct erofs_super_block {
>  	__u8 uuid[16];          /* 128-bit uuid for volume */
>  	__u8 volume_name[16];   /* volume name */
>  	__le32 feature_incompat;
> -	__u8 reserved2[44];
> +	__le16 lz4_max_distance;	/* lz4 max distance */
> +	__u8 reserved2[42];
>  };
>  
>  /*
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 67a7ec945686..7457710a763a 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -70,6 +70,9 @@ struct erofs_sb_info {
>  
>  	/* pseudo inode to manage cached pages */
>  	struct inode *managed_cache;
> +
> +	/* lz4 max distance pages */
> +	u16 lz4_max_distance_pages;
>  #endif	/* CONFIG_EROFS_FS_ZIP */
>  	u32 blocks;
>  	u32 meta_blkaddr;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index d5a6b9b888a5..3a3d235de7cc 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -174,6 +174,11 @@ static int erofs_read_superblock(struct super_block *sb)
>  	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
>  	sbi->root_nid = le16_to_cpu(dsb->root_nid);
>  	sbi->inos = le64_to_cpu(dsb->inos);
> +#ifdef CONFIG_EROFS_FS_ZIP
> +	if (dsb->lz4_max_distance)
> +		sbi->lz4_max_distance_pages =
> +			DIV_ROUND_UP(le16_to_cpu(dsb->lz4_max_distance), PAGE_SIZE) + 1;
> +#endif

How about adding a new helper e.g. z_erofs_load_lz4_config(sb, dsb)
in decompressor.c, and

int z_erofs_load_lz4_config(sb, dsb)
{
	if (dsb->lz4_max_distance)
		sbi->lz4_max_distance_pages = DIV_ROUND_UP ...
	else
		sbi->lz4_max_distance_pages = LZ4_MAX_DISTANCE_PAGES;
	return 0;
}

Also add a declaration in internal.h:

#ifdef CONFIG_EROFS_FS_ZIP
int z_erofs_load_lz4_config.....
#else
static inline int z_erofs_load_lz4_config() { return 0; }
#endif

Thanks,
Gao Xiang

>  
>  	sbi->build_time = le64_to_cpu(dsb->build_time);
>  	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
> -- 
> 2.25.1
> 


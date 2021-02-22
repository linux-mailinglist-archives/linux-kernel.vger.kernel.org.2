Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA4321010
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 05:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhBVEp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 23:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230044AbhBVEpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 23:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613969063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cd7HPIL9dlAr5R+7k2bPsLA7MXZ+jz1lBX7uDhHKXsU=;
        b=NizrVJI8X0rrVNOUnuomqDRAPlRvDnyIlk5MBg60K+gBzV0451fKNW/JiKyiXQP55beOQT
        cc0gGJSB9hGUrNS9VsuOFQ3wqY5OjA6+E3MfcfxLagtkuXhF7UPBSZ4Uw4d10zeeMHU4CS
        cre5Rm7SFHZ4WrsU7cr/RD0ZPjAnSBc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-Tw3WugusMqyVXhe-KJ4kkg-1; Sun, 21 Feb 2021 23:44:22 -0500
X-MC-Unique: Tw3WugusMqyVXhe-KJ4kkg-1
Received: by mail-pl1-f200.google.com with SMTP id p1so1044095plf.14
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 20:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cd7HPIL9dlAr5R+7k2bPsLA7MXZ+jz1lBX7uDhHKXsU=;
        b=RTxIWziA+5iIdgTiRZf54tstyV6PHWyD+/B/c4n5oyjI7R/LWmNrYVhS+uT9t0wCLj
         aFLJ8+5cbr2QnipBFYvvRftnWqjYcm4NALexjnQI6XaPeUrORvdOPc8gGiwnuX6rva7u
         2hS1WcY4QTRGzm9Ye2eyXNTMRafNEB8nzVlSOcvsQkT7rt7696RreeC2tJAOOKPk93Y/
         7LQ3EFkg8h3rPCedvZkW9j1AovkttgZtrcx6YEp3Mbnyrv7mCDNrM+IOkccT3x7Y7nhM
         TOVEI4I+qjdpOEcDqyE7DEJC1GZ9WHDaCUJc1ljr0pwhDAnMFjBX4okFJ5KUmxZbCXEa
         Yj4g==
X-Gm-Message-State: AOAM531PpfXXwQjXOHiGV4wzetXJ382IyPLf58to+YdrLKXad18hEqdN
        GgfVflcA3+s1i/L9lI11dcLZZbYdoYEh3DDpD89ET0anofxGDBlW/dM82Y3Fq9Fn2A/bCgO1BXp
        GjFUhJuxMvXeopXyOJC6R2nqZ
X-Received: by 2002:a17:902:bb8c:b029:dc:2e5e:2b2 with SMTP id m12-20020a170902bb8cb02900dc2e5e02b2mr13242186pls.10.1613969060907;
        Sun, 21 Feb 2021 20:44:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOa2eb4CQrT/ncR+h9iFyBY5fki5umtXxuZB9gaBTvUfQP8AGxjQHVIItflA8v5pCqvRsdFw==
X-Received: by 2002:a17:902:bb8c:b029:dc:2e5e:2b2 with SMTP id m12-20020a170902bb8cb02900dc2e5e02b2mr13242172pls.10.1613969060675;
        Sun, 21 Feb 2021 20:44:20 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l11sm16495311pfd.194.2021.02.21.20.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 20:44:20 -0800 (PST)
Date:   Mon, 22 Feb 2021 12:44:10 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        guoweichao@oppo.com, zhangshiming@oppo.com
Subject: Re: [PATCH] erofs: support adjust lz4 history window size
Message-ID: <20210222044410.GA1038521@xiangao.remote.csb>
References: <20210218120049.17265-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218120049.17265-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianan,

On Thu, Feb 18, 2021 at 08:00:49PM +0800, Huang Jianan via Linux-erofs wrote:
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
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/decompressor.c | 13 +++++++++----
>  fs/erofs/erofs_fs.h     |  3 ++-
>  fs/erofs/internal.h     |  3 +++
>  fs/erofs/super.c        |  3 +++
>  4 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 1cb1ffd10569..94ae56b3ff71 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -36,22 +36,27 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>  	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
>  	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
>  					   BITS_PER_LONG)] = { 0 };
> +	unsigned int lz4_distance_pages = LZ4_MAX_DISTANCE_PAGES;
>  	void *kaddr = NULL;
>  	unsigned int i, j, top;
>  
> +	if (EROFS_SB(rq->sb)->compr_alg)
> +		lz4_distance_pages = DIV_ROUND_UP(EROFS_SB(rq->sb)->compr_alg,
> +						  PAGE_SIZE) + 1;
> +

Thanks for your patch, I agree that will reduce runtime memory
footpoint. and keep max sliding window ondisk in bytes (rather
than in blocks) is better., but could we calculate lz4_distance_pages
ahead when reading super_block?

Also, in the next cycle, I'd like to introduce a bitmap for available
algorithms (maximum 16-bit) for the next LZMA algorithm, and for each
available algorithm introduces an on-disk variable-array like below:
bitmap(16-bit)    2       1       0
                ...     LZMA    LZ4
__le16		compr_opt_off;      /* get the opt array start offset
                                       (I think also in 4-byte) */

compr alg 0 (lz4)	__le16	alg_opt_size;
	/* next opt off = roundup(off + alg_opt_size, 4); */
			__le16	lz4_max_distance;

/* 4-byte aligned */
compr alg x (if available)	u8	alg_opt_size;
				...

...

When reading sb, first, it scans the whole bitmap, and get all the
available algorithms in the image at once. And then read such compr
opts one-by-one.

Do you have some interest and extra time to implement it? :) That
makes me work less since I'm debugging mbpcluster compression now...

Thanks,
Gao Xiang


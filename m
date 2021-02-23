Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F61322698
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhBWHqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231937AbhBWHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614066290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CSL7R8N6aFwp9SJMIxBXlxzl46HE12DDQh37CYhkuaQ=;
        b=GvK7vw9EhPBey0+M5ELgCdORd7RfDg6tjxF6gvLe2iDbyTvE+YQ3GI1UFCMgO2UKsQv39H
        EzhhX0Hnk9dsIEeLMbtcPdTAOyE8hADZTpRIER3/7KONqPE/BCrk51oWKaXBnwSVzbhqnF
        s9UcH4uHcqAbFgkTfmMn7XOkGvbH/oU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-4grnEWBxOouELFLIcLeqjA-1; Tue, 23 Feb 2021 02:44:30 -0500
X-MC-Unique: 4grnEWBxOouELFLIcLeqjA-1
Received: by mail-pl1-f200.google.com with SMTP id o8so9624578pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CSL7R8N6aFwp9SJMIxBXlxzl46HE12DDQh37CYhkuaQ=;
        b=HpHOc9BO5IiTP3WzUjJ9CaWk2BjAMCNtJ8prJ5odumOoTcgaOJCHLQuWsWmlnlg//l
         EBgZj5JfWJdXcEGqxr4jAgp22ZJoS5pBa9Y+QFpKN/FkqXXJQK/cOkbGh8THSbycIymd
         y1odtoBaSu5Iwv27qSg4nf35QdHj9gX/5C0FZ+lWFPNBWSpeh6avSLHFbt/E+ZOmrS0j
         FxVoPt5XrRXvm+CN1UMOhj5EJJSTZmBnuhN/71OtN2kvDCZxJiZ0dDXSc4scqpdXC3UG
         J7p2gHuEY50pNli4y7kT2y9BlK33AF+cjsSQA9sECBjWAu7Xl2h8d7cY0A0hLEAwg7kF
         zCJg==
X-Gm-Message-State: AOAM530mgAlw377OmsIyhFth27AKeN02kCCiPgRM7VMljDtT04CsgGg0
        OZUHRWWYOBn/wxwCbI1X1s9P2pQuTH3DxlMlbgDvktX229iuOLKrigd3fSgtr4NNsoahulW7KDj
        wb0dHViPDHObpHLBRe8Iuo4P4
X-Received: by 2002:a17:90a:4e0b:: with SMTP id n11mr28454039pjh.145.1614066269755;
        Mon, 22 Feb 2021 23:44:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJza7ENGaVXTDs4pzYM7+xeO9o3YBuiJvpHYifqtjV2ZtXxHInra/9gMuV+LEzN6dGZpKHYzdw==
X-Received: by 2002:a17:90a:4e0b:: with SMTP id n11mr28454027pjh.145.1614066269540;
        Mon, 22 Feb 2021 23:44:29 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s62sm14021560pfb.148.2021.02.22.23.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:44:29 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:44:18 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        guoweichao@oppo.com, zhangshiming@oppo.com
Subject: Re: [PATCH v3] erofs: support adjust lz4 history window size
Message-ID: <20210223074418.GA1269766@xiangao.remote.csb>
References: <20210223073119.69232-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223073119.69232-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 03:31:19PM +0800, Huang Jianan via Linux-erofs wrote:
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
> The maximum value of LZ4_DISTANCE_MAX defined by lz4 is 64k, and
> we can only reduce this value. For the old kernel, it just can't
> reduce the memory allocation during rolling decompression without
> affecting the decompression result.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
> 
> change since v2:
> - use z_erofs_load_lz4_config to calculate lz4_distance_pages
> - add description about the compatibility of the old kernel version
> - drop useless comment
> 
>  fs/erofs/decompressor.c | 22 ++++++++++++++++++----
>  fs/erofs/erofs_fs.h     |  3 ++-
>  fs/erofs/internal.h     |  7 +++++++
>  fs/erofs/super.c        |  2 ++
>  4 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 1cb1ffd10569..0bb7903e3f9b 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -28,6 +28,18 @@ struct z_erofs_decompressor {
>  	char *name;
>  };
>  
> +int z_erofs_load_lz4_config(struct erofs_sb_info *sbi,
> +			    struct erofs_super_block *dsb)
> +{
> +	u16 distance = le16_to_cpu(dsb->lz4_max_distance);
> +
> +	sbi->lz4_max_distance_pages = distance ?
> +					(DIV_ROUND_UP(distance, PAGE_SIZE) + 1) :

Unneeded parentheses here (I'll update it when applying).
Otherwise it looks good to me.

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang


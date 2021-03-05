Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C77D32E271
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 07:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCEGqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 01:46:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhCEGqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 01:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614926763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hj8HqudFGVHUWiSyYmBUwWyXDG72GKTMlEsdwheJpVE=;
        b=Z5oLQgPy7Ttnp3zVNtfhcyOC7B9E8clxZlXkDm8ghb+Kj2621gmP2oAc2qROUUKpvlpuHq
        zBORq5YJYIVI5TJ32Kui2FqZtF1vw4LfEGJ8TJQZ2qP7wws0jPz8JWzjHvMp+aJb3UKWhb
        XqbOU9JTfOX+hsVs0CURLxlobcAAdEI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-eXYDx2bGN_6TiIaCxlT3Qw-1; Fri, 05 Mar 2021 01:46:01 -0500
X-MC-Unique: eXYDx2bGN_6TiIaCxlT3Qw-1
Received: by mail-pj1-f72.google.com with SMTP id 2so892289pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 22:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hj8HqudFGVHUWiSyYmBUwWyXDG72GKTMlEsdwheJpVE=;
        b=QxbBVuWc0EZziun1a796nHFeuVrd7Y83lnKhbZjONH/a9wZNvcmSmDroxgdd++/tk4
         vO2680lkiKwN+ztuj34ALXy+qgsgGImkRPn1jL9IefASg8w5t26X/wZQV1IgqhTSjEAO
         6jY0y791SltGUruPCmXy08G+qTWiyzti8ZKe372dXNDgLneaMMq15EJx0gKpDR5lrQck
         mUtmIBy+P7PSJ3xBcWqmysvqkoBtAxeCRGqYeWthqJg2rA+nJkCanXlFP4EUqVjamnK6
         V0ZMTiwz7mwkv8OGyodiriWk3jvibnN8YKfXXoQdsfSqz02zzMe8uVm60GD0Ey2ZD8ht
         Oscw==
X-Gm-Message-State: AOAM532xuKsmE0V2SdGXdCz09RuBO2/+FMhfxFhHlaWLGHB8HHdrfP5F
        8Tei5m5CC1okHlDVahuosFPmEPB9WsUlofqmYYfBIxFSavS2xaC4B0IYnpyCDxJL0Nl69Zcr2qz
        bmchFffkh9F5jbPMh0EXuSbWr
X-Received: by 2002:a17:90a:ff05:: with SMTP id ce5mr8586381pjb.156.1614926760002;
        Thu, 04 Mar 2021 22:46:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlrKATqRMyJryVPF6PYEUhsb4vjq/nTU8pFKEfFuk/PZeK5jrzjcKIHOHOqgJUttIZrDLJKg==
X-Received: by 2002:a17:90a:ff05:: with SMTP id ce5mr8586359pjb.156.1614926759711;
        Thu, 04 Mar 2021 22:45:59 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z3sm1330626pfn.7.2021.03.04.22.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 22:45:59 -0800 (PST)
Date:   Fri, 5 Mar 2021 14:45:49 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        guoweichao@oppo.com, zhangshiming@oppo.com
Subject: Re: [PATCH 1/2] erofs: avoid memory allocation failure during
 rolling decompression
Message-ID: <20210305064549.GB3093390@xiangao.remote.csb>
References: <20210305062219.557128-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210305062219.557128-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 02:22:18PM +0800, Huang Jianan via Linux-erofs wrote:
> It should be better to ensure memory allocation during rolling
> decompression to avoid io error.

Currently, err would be treated as io error. Therefore, it'd be
better to ensure memory allocation during rolling decompression
to avoid such io error.

In the long term, we might consider adding another !Uptodate case
for such case.

> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/decompressor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 49347e681a53..fb0fa4e5b9ea 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -86,7 +86,7 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>  			victim = availables[--top];
>  			get_page(victim);
>  		} else {
> -			victim = erofs_allocpage(pagepool, GFP_KERNEL);
> +			victim = erofs_allocpage(pagepool, GFP_KERNEL | __GFP_NOFAIL);

80 char limitation.

Thanks,
Gao Xiang

>  			if (!victim)
>  				return -ENOMEM;
>  			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
> -- 
> 2.25.1
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E7B441536
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhKAIVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231223AbhKAIVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635754720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1VJ7I9+UXANPnUsj7WuJy/EQjAg507IxwXZkWzzQG2E=;
        b=hRja0s/qJRTGJaoErCwu4cP+BhQFBvknbNJeFL12V20ICzotRrmLbBaGEa+AZb7dFqH0U2
        UvD3crTBVM+D9K9eE50y173BoJbdj+IQZsQb1cJLiDNL5IxfbsVs+r3ChhDt+fXFVZ2Ji4
        sSczBvVJsxeNxqm+d34No+7ImIpwbxU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-KQszCzRdM8m9qkFeXLGm8w-1; Mon, 01 Nov 2021 04:18:39 -0400
X-MC-Unique: KQszCzRdM8m9qkFeXLGm8w-1
Received: by mail-ed1-f71.google.com with SMTP id s12-20020a50dacc000000b003dbf7a78e88so14880828edj.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1VJ7I9+UXANPnUsj7WuJy/EQjAg507IxwXZkWzzQG2E=;
        b=ByiUJt3iolL+Qkw6s81XCWQGtCtCFqv3jH/oG2ovGCWWxgEO4SkTt6GKA3EMgvA240
         YjuImI7qn2ilK2/i8SOFrjQmWDHqRz5RH1MV4gVU3qdqWMcdHaHKb0PQsLw3S2YLTzCq
         tVdQogXPOGLoL5BRpaKiKUY6AIjGlRv7BCqK16lF90m6eak+a4QSsaVZINn7qvjgxj2y
         spljGnCLvmLWpdTaenxWv3lcEzCrwes7MFjE+cAjNBO0qY1Pa9geF/7gGAkZXpvy9Q3M
         nl46Y8Yc7xsnC+6fT/cZRrVD4ElF+XMTfpwRBXsJ6BXx57SPPdPGHn4r6K24/vBdKvXn
         S/tA==
X-Gm-Message-State: AOAM530tBUprLDNiy0v0v8IvTq797kIWp0uzmhCkqfYxMvkkLc3760S3
        GInNEWW8sJrodw7yCBbDK8EQBNh4mzmF5re1nsE99nxY+sosnugLAIpn7wB6SscItycOncffr+W
        Lp+VkCz+uUyn2gipJhHnRs3EJ
X-Received: by 2002:a50:9eab:: with SMTP id a40mr39722372edf.281.1635754718314;
        Mon, 01 Nov 2021 01:18:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjgeNnO1O2bOJHQh8lmeLqGbJq9Vgsp7BeICMK7EiQVwicym1EUAm8TwLuENIy8A/xBTFpNg==
X-Received: by 2002:a50:9eab:: with SMTP id a40mr39722356edf.281.1635754718179;
        Mon, 01 Nov 2021 01:18:38 -0700 (PDT)
Received: from redhat.com ([176.12.204.186])
        by smtp.gmail.com with ESMTPSA id g10sm7504925edr.56.2021.11.01.01.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 01:18:37 -0700 (PDT)
Date:   Mon, 1 Nov 2021 04:18:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wei.yang1@linux.alibaba.com,
        Arnd Bergmann <arnd@arndb.de>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v7 9/9] eni_vdpa: alibaba: fix Kconfig typo
Message-ID: <20211101041739-mutt-send-email-mst@kernel.org>
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <cover.1635493219.git.wuzongyong@linux.alibaba.com>
 <0945b37f19b96ecadb79a4e1b01f486119a0b83a.1635493219.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0945b37f19b96ecadb79a4e1b01f486119a0b83a.1635493219.git.wuzongyong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 05:14:50PM +0800, Wu Zongyong wrote:
> The Kconfig symbol was misspelled, which leads to randconfig link
> failures:
> 
> ld.lld: error: undefined symbol: vp_legacy_probe
> >>> referenced by eni_vdpa.c
> >>>               vdpa/alibaba/eni_vdpa.o:(eni_vdpa_probe) in archive drivers/built-in.a
> 
> Fixes: 6a9f32c00609 ("eni_vdpa: add vDPA driver for Alibaba ENI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

This one I'll squash into the previous one. That commit hash is not
going to match anything useful.

> ---
>  drivers/vdpa/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 07b0c73212aa..50f45d037611 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -80,7 +80,7 @@ config VP_VDPA
>  
>  config ALIBABA_ENI_VDPA
>  	tristate "vDPA driver for Alibaba ENI"
> -	select VIRTIO_PCI_LEGACY_LIB
> +	select VIRTIO_PCI_LIB_LEGACY
>  	depends on PCI_MSI && X86
>  	help
>  	  VDPA driver for Alibaba ENI (Elastic Network Interface) which is built upon
> -- 
> 2.31.1


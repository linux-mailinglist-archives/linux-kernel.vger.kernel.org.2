Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C676361A68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbhDPHPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhDPHP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:15:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3604C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 00:15:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso14126812pje.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=BzihCKLSn5zDahlSfxZpVN+H6HlVaY3GCUyxBAUfdLQ=;
        b=YXGCN5pL3en+V1lnsbKkewxe6z62T9YCtJrt5Qgn59jA+RTQ7H/kg+KlNAoD2/aSeZ
         E9Flt7AmhulS59kAeBj7Rh/lNrPoV8fHug6KFClhT8g7WbGvhSAcrhJ1oNtCE/Z+0L1+
         E0kBN5F6PriHe9zTWzS6ewqJA2NBOlokLxLhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BzihCKLSn5zDahlSfxZpVN+H6HlVaY3GCUyxBAUfdLQ=;
        b=NMJjHPcoCZGXZ+FmQgW8yDJKqR5dncioZrbq2i4R62tQUa0PG5mxZZbiYGWCHM8fjn
         y+7r6K6wIxkfdj3HCSYZYi2qPWuYsOjn1Za400sZj5Xh/Zzbowip15iOo62iZs92Onrf
         Qr0ITjD+5HONvMmB2Meh7dv9dAicF6KtJabEnHMfCeGG3JjuThAkrAfbu+kWTfZ6MLqE
         KzR0hqPqdRz5xX1jkvK8Dr5/+8Qrq7y7oDUytgeF0OrmS79OqMs8EDJeT9R5U9tBDRN1
         ffic2FEkItIqE6j6GFXWTPuQOW4qP2dtWq3mWv/WYEyDxTj1aB28256TFfl0R3g74fDC
         17ow==
X-Gm-Message-State: AOAM531xT7bByUuqI+LM3zekHCZ+hz0WZvnEXkKRKDvOTbLUvQysRfks
        TVPpfXjB9a989pwR6ZJUjfERDA==
X-Google-Smtp-Source: ABdhPJyL/bVQGB2j1SyQSTZxiabgYxoP8rXxgYmkXLPKRCg/zorqcQ8i+YMrNm90RtJGI2WRnMDxQg==
X-Received: by 2002:a17:90b:3b4e:: with SMTP id ot14mr7907331pjb.81.1618557303436;
        Fri, 16 Apr 2021 00:15:03 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-09c3-a49e-2955-78c6.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:9c3:a49e:2955:78c6])
        by smtp.gmail.com with ESMTPSA id e65sm4107570pfe.9.2021.04.16.00.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 00:15:03 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: extract host bridge from pci_bus prior to bus removal
In-Reply-To: <20210211182435.47968-1-tyreld@linux.ibm.com>
References: <20210211182435.47968-1-tyreld@linux.ibm.com>
Date:   Fri, 16 Apr 2021 17:15:00 +1000
Message-ID: <878s5ig0p7.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tyrel,

> The pci_bus->bridge reference may no longer be valid after
> pci_bus_remove() resulting in passing a bad value to device_unregister()
> for the associated bridge device.
>
> Store the host_bridge reference in a separate variable prior to
> pci_bus_remove().
>
The patch certainly seems to do what you say. I'm not really up on the
innards of PCI, so I'm struggling to figure out by what code path
pci_bus_remove() might invalidate pci_bus->bridge? A quick look at
pci_remove_bus was not very illuminating but I didn't chase down every
call it made.

Kind regards,
Daniel

> Fixes: 7340056567e3 ("powerpc/pci: Reorder pci bus/bridge unregistration during PHB removal")
> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/pci_dlpar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
> index f9ae17e8a0f4..a8f9140a24fa 100644
> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> @@ -50,6 +50,7 @@ EXPORT_SYMBOL_GPL(init_phb_dynamic);
>  int remove_phb_dynamic(struct pci_controller *phb)
>  {
>  	struct pci_bus *b = phb->bus;
> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(b->bridge);
>  	struct resource *res;
>  	int rc, i;
>  
> @@ -76,7 +77,8 @@ int remove_phb_dynamic(struct pci_controller *phb)
>  	/* Remove the PCI bus and unregister the bridge device from sysfs */
>  	phb->bus = NULL;
>  	pci_remove_bus(b);
> -	device_unregister(b->bridge);
> +	host_bridge->bus = NULL;
> +	device_unregister(&host_bridge->dev);
>  
>  	/* Now release the IO resource */
>  	if (res->flags & IORESOURCE_IO)
> -- 
> 2.27.0

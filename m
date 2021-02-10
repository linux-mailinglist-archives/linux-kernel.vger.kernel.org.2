Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5673171F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhBJVHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:07:34 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:37002 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhBJVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:07:30 -0500
Received: by mail-wm1-f46.google.com with SMTP id m1so3169765wml.2;
        Wed, 10 Feb 2021 13:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QxVKcMPVlZSU1s6PYt/R8Rb76zHOdHRNUhzAj/OgexQ=;
        b=XjdJ0yIMtJ+ym7Zg5enTlyvGJyTMmAI5WygJ3wkc/aZe+yJbgU5XeB+TCQmRHvo7jd
         FW2OOFN9IvFKAAjDzp9fA8pU9PUspp4vhuhcU09LVH2fiqAJuUQq2WyMgw4hlohp/ir+
         mqpscOKHsko2J35sNdiB1vG+GDEN87Lx2Ib36Ih4LI9LRsyyE67OxqZKrMutDVxBlduK
         u8rt8ggW1t7ZKVYoZIhsDVtPkOjSmMg6DeCVtcRWuFNJ3SGj3y9zNBYPkx/rqjnbZ2wJ
         mzmCi+JTpM1QqS9/th9xi4oi2Av+tahkiajraBrncuhZO2ZqjrJ3peclPBGbPhX9eDif
         v/0w==
X-Gm-Message-State: AOAM531Ctyi533uW6qnQBoV3/8YPF/SkUwof1f7piegirz1J2aV0ztVG
        747QmnsRNK3yb+NdPR6+dXc=
X-Google-Smtp-Source: ABdhPJyutwczC6gENkSYbGydAjbEIfbr8/xDGH+x6zloSJ2vMT8py8hwsZqxN/svIs773XJbJ72Wlg==
X-Received: by 2002:a05:600c:2d44:: with SMTP id a4mr890464wmg.95.1612991207591;
        Wed, 10 Feb 2021 13:06:47 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id w2sm4826858wmg.27.2021.02.10.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 13:06:46 -0800 (PST)
Date:   Wed, 10 Feb 2021 22:06:45 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH v5 3/4] usb: host: xhci-plat: Create platform device for
 onboard hubs in probe()
Message-ID: <20210210210645.xapaua7djdsvr3ca@kozik-lap>
References: <20210210171040.684659-1-mka@chromium.org>
 <20210210091015.v5.3.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210091015.v5.3.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:10:38AM -0800, Matthias Kaehlcke wrote:
> Check during probe() if a hub supported by the onboard_usb_hub
> driver is connected to the controller. If such a hub is found
> create the corresponding platform device. This requires the
> device tree to have a node for the hub with its vendor and
> product id (which is not common for USB devices). Further the
> platform device is only created when CONFIG_USB_ONBOARD_HUB=y/m.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v5:
> - patch added to the series
> 
>  drivers/usb/host/xhci-plat.c | 16 ++++++++++++++++
>  include/linux/usb/hcd.h      |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 4d34f6005381..e785fa109eea 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/usb/onboard_hub.h>
>  #include <linux/usb/phy.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> @@ -184,6 +185,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	int			ret;
>  	int			irq;
>  	struct xhci_plat_priv	*priv = NULL;
> +	struct device_node	*np;
>  
>  
>  	if (usb_disabled())
> @@ -356,6 +358,17 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	 */
>  	pm_runtime_forbid(&pdev->dev);
>  
> +	np = usb_of_get_device_node(hcd->self.root_hub, hcd->self.busnum);
> +	if (np && of_is_onboard_usb_hub(np)) {

This looks hackish... what if later we have something else than hub?
Another if()?

What if hub could be connected to something else than XHCI controller?

Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE663192C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhBKTEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhBKTBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:01:47 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8649C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 11:01:06 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t11so4547782pgu.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 11:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=38z+MQX41khqI4CrfgsdKCbVUZuEtmzm0vpGYv2oT/g=;
        b=P1Z9ylhoK6aFfRrdpwiLZS0OMGndod97oFC7yb3dqZvLg8Gx9QYB5OA2npK10G3+RR
         HkRwR4kDaLOHc+i+OOoqADEaeU/NtIUC8trKUbXNr4B0nVfwzzr5gjEuK5AQLfdmCLxD
         ln1JifQ5EgUk0XAuMpl7m4gSTEaWhoNvQWqp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=38z+MQX41khqI4CrfgsdKCbVUZuEtmzm0vpGYv2oT/g=;
        b=kbv5NjPOkGku3YFxidmqxs70OyVDerB4lu9M35E7XmawYU3kb2ox22wv+TTb8Rw28q
         hmiZ4RVvlChPrsnfMbKpbhGYESFMHoNCKqLFT5Kxyi22aehVx5D4B7EmU7vPLyVhv3e2
         99OI7GG1N4bAUw74SDHmt83bHJTUTMZvoHS9tr/8v/D0f8q8KLPOsUA2yQzNOZVC7FeG
         6sx1uF5G4k/uPONgkAz5z/dQeZ1crbc/aBiAKUeXsMmdYM+IM3Q8dEiS2/aA6K8J/cj3
         RkTNCFYufcS5CAN6HfB6TY3dHp9oCQQVieeDOMAl9QakU2bwub4iuyqYkyQwFZ20i4Kc
         fiUw==
X-Gm-Message-State: AOAM532IYW4+js+UZp/9I4OGMG5Pu9m5ahCpZn0PIV1jIvKglhRD0sov
        jStgNnKiDTZVezL9FB6fJrbMmg==
X-Google-Smtp-Source: ABdhPJwUJi9shALaYdk06rsyxl0whyeAsF17SGdQZ6EWt5HbYkjEqoshMB5Iyt3Fo0kD28w5VX6qpQ==
X-Received: by 2002:a62:5a45:0:b029:1e5:4c81:c59 with SMTP id o66-20020a625a450000b02901e54c810c59mr9388889pfb.51.1613070066195;
        Thu, 11 Feb 2021 11:01:06 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fc92:99c:fc2f:8603])
        by smtp.gmail.com with UTF8SMTPSA id a37sm6555705pgm.79.2021.02.11.11.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 11:01:05 -0800 (PST)
Date:   Thu, 11 Feb 2021 11:01:03 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH v5 3/4] usb: host: xhci-plat: Create platform device for
 onboard hubs in probe()
Message-ID: <YCV+7z8Y/l0eyse9@google.com>
References: <20210210171040.684659-1-mka@chromium.org>
 <20210210091015.v5.3.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
 <YCTVjx480BzT+saO@kroah.com>
 <YCV7XGloQIjtFAqf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCV7XGloQIjtFAqf@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 10:45:48AM -0800, Matthias Kaehlcke wrote:
> Hi Greg,
> 
> On Thu, Feb 11, 2021 at 07:58:23AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Feb 10, 2021 at 09:10:38AM -0800, Matthias Kaehlcke wrote:
> > > Check during probe() if a hub supported by the onboard_usb_hub
> > > driver is connected to the controller. If such a hub is found
> > > create the corresponding platform device. This requires the
> > > device tree to have a node for the hub with its vendor and
> > > product id (which is not common for USB devices). Further the
> > > platform device is only created when CONFIG_USB_ONBOARD_HUB=y/m.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > 
> > > Changes in v5:
> > > - patch added to the series
> > > 
> > >  drivers/usb/host/xhci-plat.c | 16 ++++++++++++++++
> > >  include/linux/usb/hcd.h      |  2 ++
> > >  2 files changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > > index 4d34f6005381..e785fa109eea 100644
> > > --- a/drivers/usb/host/xhci-plat.c
> > > +++ b/drivers/usb/host/xhci-plat.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/of_device.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/usb/onboard_hub.h>
> > >  #include <linux/usb/phy.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/acpi.h>
> > > @@ -184,6 +185,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
> > >  	int			ret;
> > >  	int			irq;
> > >  	struct xhci_plat_priv	*priv = NULL;
> > > +	struct device_node	*np;
> > >  
> > >  
> > >  	if (usb_disabled())
> > > @@ -356,6 +358,17 @@ static int xhci_plat_probe(struct platform_device *pdev)
> > >  	 */
> > >  	pm_runtime_forbid(&pdev->dev);
> > >  
> > > +	np = usb_of_get_device_node(hcd->self.root_hub, hcd->self.busnum);
> > > +	if (np && of_is_onboard_usb_hub(np)) {
> > > +		struct platform_device *pdev;
> > > +
> > > +		pdev = of_platform_device_create(np, NULL, NULL);
> > 
> > A platform device is a child of another platform device?  Ok, but
> > really, why?  What uses this device?
> 
> In earlier versions there was a standalone platform device:
> https://lore.kernel.org/patchwork/patch/1313001/
> 
> However this was rejected by Rob, since the DT would require a node for the
> platform device and (implicit or explicit) nodes for the USB devices,
> representing the same physical device:
> 
> https://lore.kernel.org/patchwork/patch/1305395/
> https://lore.kernel.org/patchwork/patch/1313000/
> 
> Both Doug Anderson and myself argued that it seems legitimate to distinguish
> between the devices connected to the USB bus, and the chip which might have
> GPIOs, regulators, clocks, ... but apparently our arguments were not
> convincing enough.

To let the xhci-plat driver create the platform device was suggested by Alan:

https://lore.kernel.org/patchwork/patch/1313000/#1510227

Personally I would favor a standalone platform device, since it provides more
flexiblity (also works for hubs connected to a non-root hub) and doesn't require
cooperation from other driver, however I doubt I could convince Rob of the
corresponding DT bindings.

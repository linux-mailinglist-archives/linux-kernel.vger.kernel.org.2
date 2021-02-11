Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0130F319278
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhBKSrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBKSqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:46:31 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403CBC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:45:51 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q10so840526plk.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QgIYTyhfH72b4fULrOrfaw7q3uY66r3eG0ZY6y6h27g=;
        b=hFEBW2MXaPJFYKkCfGxQdNc1eSytYrBeXV3p6ZT1FrjSEGdacvycOmi8Rrwh5bYz/E
         oxAhJutYjhrytLuCWHZqOdVBRUqq4PTcpkkHdX4o9eEdd3mqGLw+pourJhqeSlsRshJB
         3JTlBxWOkUKkPcCMCY3h0D6zLNdTh9Ml8GXd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QgIYTyhfH72b4fULrOrfaw7q3uY66r3eG0ZY6y6h27g=;
        b=X+W9Tba1nlf4q+783tgKfdjc3GmsCKJwdkfmLqdeMYltSiw+wGwA0QJUmTlOTvLXdc
         X96kD46mOjFlrrb7rSXmIEffAosxwef3txDsiDPJzDk8fkMBbkGNWeCkwAFmNzNZXS2b
         1wQ8q3rPCdwLiKnpaNa9bPZlUM1BLO7vz4dxaryiwiwW6mMdLc9qvuzwA/vYXU7KoyJi
         glr67JY3mRXllsplmGrG92e3St4Zxc1AMfE37ez3rGyjk3YV+Eay7Y2u32225B9TO2HK
         Ku4ztr8KFgZRsUMJ/Hz8TSl4eyMCveoMXbjQrnSYmN3CtrbPlEtkX5R5XH5Dh8fvOLU4
         7ftQ==
X-Gm-Message-State: AOAM533yJgDIqVhVYDivwqHVvhuPTpxhJyCvsx81c76G1mKohzin33fn
        +2M2hMsdPr6WzH1oFgFAEn8rqw==
X-Google-Smtp-Source: ABdhPJyWoJFOTr/Z0khlbxK+fLlWgo3O1EoJvvJueeEg2GOZoTLwS1zrIYglhtQ5DwbHOYjFzx6E9A==
X-Received: by 2002:a17:90a:d34b:: with SMTP id i11mr5118092pjx.235.1613069150706;
        Thu, 11 Feb 2021 10:45:50 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fc92:99c:fc2f:8603])
        by smtp.gmail.com with UTF8SMTPSA id d18sm5808929pjz.40.2021.02.11.10.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 10:45:50 -0800 (PST)
Date:   Thu, 11 Feb 2021 10:45:48 -0800
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
Message-ID: <YCV7XGloQIjtFAqf@google.com>
References: <20210210171040.684659-1-mka@chromium.org>
 <20210210091015.v5.3.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
 <YCTVjx480BzT+saO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCTVjx480BzT+saO@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Feb 11, 2021 at 07:58:23AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 10, 2021 at 09:10:38AM -0800, Matthias Kaehlcke wrote:
> > Check during probe() if a hub supported by the onboard_usb_hub
> > driver is connected to the controller. If such a hub is found
> > create the corresponding platform device. This requires the
> > device tree to have a node for the hub with its vendor and
> > product id (which is not common for USB devices). Further the
> > platform device is only created when CONFIG_USB_ONBOARD_HUB=y/m.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> > Changes in v5:
> > - patch added to the series
> > 
> >  drivers/usb/host/xhci-plat.c | 16 ++++++++++++++++
> >  include/linux/usb/hcd.h      |  2 ++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 4d34f6005381..e785fa109eea 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/usb/onboard_hub.h>
> >  #include <linux/usb/phy.h>
> >  #include <linux/slab.h>
> >  #include <linux/acpi.h>
> > @@ -184,6 +185,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >  	int			ret;
> >  	int			irq;
> >  	struct xhci_plat_priv	*priv = NULL;
> > +	struct device_node	*np;
> >  
> >  
> >  	if (usb_disabled())
> > @@ -356,6 +358,17 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >  	 */
> >  	pm_runtime_forbid(&pdev->dev);
> >  
> > +	np = usb_of_get_device_node(hcd->self.root_hub, hcd->self.busnum);
> > +	if (np && of_is_onboard_usb_hub(np)) {
> > +		struct platform_device *pdev;
> > +
> > +		pdev = of_platform_device_create(np, NULL, NULL);
> 
> A platform device is a child of another platform device?  Ok, but
> really, why?  What uses this device?

In earlier versions there was a standalone platform device:
https://lore.kernel.org/patchwork/patch/1313001/

However this was rejected by Rob, since the DT would require a node for the
platform device and (implicit or explicit) nodes for the USB devices,
representing the same physical device:

https://lore.kernel.org/patchwork/patch/1305395/
https://lore.kernel.org/patchwork/patch/1313000/

Both Doug Anderson and myself argued that it seems legitimate to distinguish
between the devices connected to the USB bus, and the chip which might have
GPIOs, regulators, clocks, ... but apparently our arguments were not
convincing enough.

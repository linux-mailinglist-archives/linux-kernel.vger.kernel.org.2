Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BEE346E50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 01:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhCXAih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 20:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhCXAiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 20:38:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10997C0613D8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 17:38:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso231981pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 17:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pPlIrrXflt8RSnipMg07xZQ+rTbq5XKn0Tjy7Ot7/1M=;
        b=LaUeWaLc2Gkl/HXwkVwIpesHnN6jyLWGxSB57EnR1oo05e56FF9akaxxbx31UDFYWD
         a9siLX/X03G30bnlPJ8qqUAtO9dXE9FNYaKzcc2Zg3RcgirtGG0JifYFlSKomHaP1ulF
         lxy84KVhxL3N0oKi4nCJwEV7aVMwyaCS3X5xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pPlIrrXflt8RSnipMg07xZQ+rTbq5XKn0Tjy7Ot7/1M=;
        b=kKq7qMnTAsWqGqGqW4ujd2kJPTp8K0EyAN97ARnTu0ZrVcHNZY8PfHbo1mtwTLCy8h
         3/Gy1GrM2lCa1WpLVdfFUgGp6+L0yqTuL2T5I+mAlbaoSL2hQtfqDBGfGaC/FYcFFgPi
         CoT5ff3qfjKoXqV8CVbbPIDQlyt25QiURyQrnpRSMmLl4juimCaki3ROnfhu5Zfb810q
         IS5eAq0ShIE5gFNmNPTuVT0VGcoH0ceyGZfXKYoCiKvf/5UduKnWS4zbq1pgWUBYLC5Q
         1F8Bt1fVI0QW1cHfZ6+bVwGARyxOB2iarmcRtUwfHhoQ+Pp3IomVr6QIOdKsp/eqG4jp
         KeZg==
X-Gm-Message-State: AOAM531zg1VbSVuV4sykKkFuJEp4rtuFlxez2DnGJdQhZ+mU0BHpNJ5s
        sZQgan8g+4Iz1tzG42PuN/Or5w==
X-Google-Smtp-Source: ABdhPJz9oyfMCYlP8x3ieh7MnofBo34nULsK4kbKiNcr0RlZ2x3yRwTVeckXoKmXU5lD5QW/MgqAzg==
X-Received: by 2002:a17:902:c1c4:b029:e6:7bc9:71fd with SMTP id c4-20020a170902c1c4b02900e67bc971fdmr939065plc.5.1616546282478;
        Tue, 23 Mar 2021 17:38:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:40a3:9725:46c3:85f6])
        by smtp.gmail.com with UTF8SMTPSA id m21sm338568pff.61.2021.03.23.17.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 17:38:01 -0700 (PDT)
Date:   Tue, 23 Mar 2021 17:38:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v5 2/4] usb: dwc3: host: Add suspend_quirk for dwc3 host
Message-ID: <YFqJ6MfQOrt5CRp2@google.com>
References: <1616434280-32635-1-git-send-email-sanm@codeaurora.org>
 <1616434280-32635-3-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1616434280-32635-3-git-send-email-sanm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:01:18PM +0530, Sandeep Maheswaram wrote:
> Adding suspend quirk function for dwc3 host which will be called
> during xhci suspend.
> Setting hs_phy_mode, ss_phy_mode , phy_power_off flags and phy mode
> during host suspend.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  drivers/usb/dwc3/core.h |  3 +++
>  drivers/usb/dwc3/host.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index ce6bd84..f05546c 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1113,6 +1113,9 @@ struct dwc3 {
>  
>  	bool			phys_ready;
>  
> +	unsigned int            hs_phy_mode;
> +	bool			phy_power_off;
> +
>  	struct ulpi		*ulpi;
>  	bool			ulpi_ready;
>  
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index f29a264..3db042c 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -11,6 +11,13 @@
>  #include <linux/platform_device.h>
>  
>  #include "core.h"
> +#include "../host/xhci.h"
> +#include "../host/xhci-plat.h"
> +int xhci_dwc3_suspend_quirk(struct usb_hcd *hcd);
> +
> +static const struct xhci_plat_priv xhci_plat_dwc3_xhci = {
> +	.suspend_quirk = xhci_dwc3_suspend_quirk,
> +};
>  
>  static int dwc3_host_get_irq(struct dwc3 *dwc)
>  {
> @@ -115,6 +122,13 @@ int dwc3_host_init(struct dwc3 *dwc)
>  		}
>  	}
>  
> +	ret = platform_device_add_data(xhci, &xhci_plat_dwc3_xhci,
> +			sizeof(struct xhci_plat_priv));
> +	if (ret) {
> +		dev_err(dwc->dev, "failed to add data to xHCI\n");
> +		goto err;
> +	}
> +
>  	ret = platform_device_add(xhci);
>  	if (ret) {
>  		dev_err(dwc->dev, "failed to register xHCI device\n");
> @@ -127,6 +141,50 @@ int dwc3_host_init(struct dwc3 *dwc)
>  	return ret;
>  }
>  
> +static void dwc3_set_phy_mode(struct usb_hcd *hcd)
> +{
> +
> +	int i, num_ports;
> +	u32 reg;
> +	unsigned int ss_phy_mode = 0;
> +	struct dwc3 *dwc = dev_get_drvdata(hcd->self.controller->parent);
> +	struct xhci_hcd	*xhci_hcd = hcd_to_xhci(hcd);
> +
> +	dwc->hs_phy_mode = 0;
> +
> +	reg = readl(&xhci_hcd->cap_regs->hcs_params1);
> +
> +	num_ports = HCS_MAX_PORTS(reg);

nit: remove empty line between the two lines above. 'reg' is read to
determine the number of ports and discarded afterwards, so it makes
sense to establish that relationship visually. You could (optionally)
add an empty line after assigning 'num_ports'.

> +	for (i = 0; i < num_ports; i++) {
> +		reg = readl(&xhci_hcd->op_regs->port_status_base + i * 0x04);
> +		if (reg & PORT_PE) {
> +			if (DEV_HIGHSPEED(reg) || DEV_FULLSPEED(reg))
> +				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_HS;
> +			else if (DEV_LOWSPEED(reg))
> +				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_LS;
> +
> +			if (DEV_SUPERSPEED(reg))
> +				ss_phy_mode |= PHY_MODE_USB_HOST_SS;
> +		}
> +	}
> +	phy_set_mode(dwc->usb2_generic_phy, dwc->hs_phy_mode);
> +	phy_set_mode(dwc->usb3_generic_phy, ss_phy_mode);
> +}
> +
> +int xhci_dwc3_suspend_quirk(struct usb_hcd *hcd)
> +{
> +	struct dwc3 *dwc = dev_get_drvdata(hcd->self.controller->parent);
> +
> +	dwc3_set_phy_mode(hcd);
> +
> +	dwc->phy_power_off = true;

it seems silly to assign this field only to overwrite it two lines later
if wakeup capable descendants are connected. Making the assignment in an
'else' branch would be clearer IMO.

> +
> +	if (usb_wakeup_enabled_descendants(hcd->self.root_hub))
> +		dwc->phy_power_off = false;
> +
> +	return 0;
> +}
> +
>  void dwc3_host_exit(struct dwc3 *dwc)
>  {
>  	platform_device_unregister(dwc->xhci);

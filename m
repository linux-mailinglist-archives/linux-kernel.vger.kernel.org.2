Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB3331949B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhBKUhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBKUhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:37:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D2C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:36:38 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gx20so4108483pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CJoKOyJ/+fV1yTi8COq9+GsinjN35J8Xxpn6tpcdpRU=;
        b=QbmbfyI0qQypKcIHnyCYOUMh+edEbR9HP19kIJJF9u+VacXRyXbibnJTcvI7IFeIgC
         mfNLBXVuJ9JX+sWaGOhu7GezZGF5Tik1rXGY+b37aIBMezXmRJUz+hV+jQ0yU7wxsmfp
         vg4KdaSz6StsHsNMB+12sh/Ekya7zOtYuUXVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CJoKOyJ/+fV1yTi8COq9+GsinjN35J8Xxpn6tpcdpRU=;
        b=BVT9brJHFeD9qkz2tHYncrAwv0N+cPLprsMonmo0GDGmCJdfDquqI+jC0GnJYNNwz3
         1TUQBV6ZdxQdnElL1sKVbgCwP2e+y7zIsRK3RxUkInJ+JNn8NnVtmSM2kpfY141gpAke
         ADhb5G6hASF1uT4gZAYz+dF/UREC8nLFtq+tIiGWNwH3RKkJTAO1309OI2vvKtsbFkL4
         HfTpnOEDhfjDDEM+F82XAIDA5f2gUzsX3VQyR2/xJlvsSPjHkcrcGRJHvFH04+1UiLPL
         DGNcf8zkGBVcuFkaAMqayYKp23WdWq8UoUqoSl7Q9+1fkpqBu2cHGVethpA63dTGUCMY
         vNoA==
X-Gm-Message-State: AOAM5322G1nR/TBQrCESw9o+rjpWORQ7NZhTRtKyuuOE7wyguXBA6fWq
        ZwR7kDGdeldDjL60yVws/4AxzA==
X-Google-Smtp-Source: ABdhPJyvwsXbtNkPHebU5byTz3n/UhWwr1foC+7U/kGK0y+cS85N6zpcfchbtNLyti/UzJJfwuQ9Yw==
X-Received: by 2002:a17:90b:618:: with SMTP id gb24mr5390563pjb.163.1613075798069;
        Thu, 11 Feb 2021 12:36:38 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fc92:99c:fc2f:8603])
        by smtp.gmail.com with UTF8SMTPSA id b14sm6308643pfi.74.2021.02.11.12.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 12:36:37 -0800 (PST)
Date:   Thu, 11 Feb 2021 12:36:35 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH v5 3/4] usb: host: xhci-plat: Create platform device for
 onboard hubs in probe()
Message-ID: <YCWVU7YCE+WzRx9v@google.com>
References: <20210210171040.684659-1-mka@chromium.org>
 <20210210091015.v5.3.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
 <20210210210645.xapaua7djdsvr3ca@kozik-lap>
 <YCRcIuCxB8nYi7/e@google.com>
 <161307087919.1254594.11784819060723374369@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <161307087919.1254594.11784819060723374369@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Feb 11, 2021 at 11:14:39AM -0800, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2021-02-10 14:20:18)
> > 
> > On Wed, Feb 10, 2021 at 10:06:45PM +0100, Krzysztof Kozlowski wrote:
> > > 
> > > This looks hackish... what if later we have something else than hub?
> > > Another if()?
> > > 
> > > What if hub could be connected to something else than XHCI controller?
> > 
> > In earlier versions this was standalone driver, which was more flexible and
> > didn't require cooperation from the XHCI driver:
> > 
> > https://lore.kernel.org/patchwork/patch/1313001/
> > 
> > Rob Herring raised objections about the DT bindings, since the USB hub would be
> > represented twice in the DT, once in the USB hierachry (with an explicit node or
> > implicitly) plus a node for the platform device for the new driver:
> > 
> > https://lore.kernel.org/patchwork/patch/1305395/
> > https://lore.kernel.org/patchwork/patch/1313000/
> > 
> > Alan Stern suggested to create the platform device in the XHCI platform driver:
> > 
> > https://lore.kernel.org/patchwork/patch/1313000/#1510227
> > 
> > I wasn't super happy about involving xhci-plat, but at least the code is minimal
> > and all the device specific stuff is handled by the onboard_usb_hub driver.
> > 
> > If you have better suggestions that might satisfy all parties please let us
> > know :)
> > 
> 
> Is it possible to use the graph binding to connect the USB controller on
> the SoC to the port on the hub? Then the hub would be a standalone node
> at the root of DT connected to the USB controller (or phy) and xhci code
> could probe the firmware to see if there's a graph connection downstream
> that is a powered hub like this. I didn't see this idea mentioned in the
> previous discussions, but maybe I missed it.

Thanks for bringing this up. I'm not sure I completely understand your
suggestion, but in general it seems a direction that could be worth
exploring.

I think something like the following should work even without requiring
cooperation from the XHCI code:

onboard-usb-hub {
    compatible = “realtek,rts5411”, “onboard_usb_hub”;
    #address-cells = <1>;
    #size-cells = <0>;

    vdd-supply = <&pp3300_hub>;

    port@0 {
        reg = <0>;

        rts5411_3_0: endpoint {
            // should not be needed
            remote-endpoint = <&usb_1_dwc3_port1>;
        };
    };

    port@1 {
        reg = <1>;

        rts5411_2_0: endpoint {
            // should not be needed
            remote-endpoint = <&usb_1_dwc3_port2>;
        };
    };
};

&usb_1_dwc3 {
    dr_mode = "host";
    #address-cells = <1>;
    #size-cells = <0>;

    port@1 {
        reg = <1>;

        usb_1_dwc3_port1: endpoint {
            remote-endpoint = <&rts5411_3_0>;
        };
    };

    port@2 {
        reg = <2>;

        usb_1_dwc3_port2: endpoint {
            remote-endpoint = <&rts5411_2_0>;
        };
    };
};

That looks like an actual description of the hardware, without multiple DT
nodes for the hub.

The USB part of the onboard_hub driver could determine the platform device
from the remote endpoint and register the USB device with it.

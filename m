Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1B53AAEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFQI32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhFQI3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:29:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECDAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:27:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v9so5728268wrx.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bezVjNF1qbCOcnc4blR43las++KIXRSmLJ9h7NBFNiU=;
        b=fRDhLhwEi0iM1dBiH0qc03gAhlemGeWetksl+JntJ7Ve+gNurDNpWagdV5Iw76zTfU
         Z3MX3gzVK5J+q7sPSAs3YQTggUTqbE2vUMr7oJSp3YjfxT53iNHo8rpaRoRpVKxKw3WC
         SJWFMpknno+GvzAoteY+V7joShsyYdTXKhNbEKt3rrU9E271nBlPKIm+1OQcnmwTZTcw
         NzEURLbKfSeYtztMRO/zL6UWRFXlKoSOJwzhm2RZpNFUQYvKDVZJCtHp3aku2GOK4ATm
         CVWAwjOeifplHKFjlVz3MB0k+UsbvjjUpd1/kZQOpCZhRrn/v5+L3+jDepgbDdUxiRUW
         Kiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bezVjNF1qbCOcnc4blR43las++KIXRSmLJ9h7NBFNiU=;
        b=hPCIaox4iM367O6JYvPQ+9buKZROHQ8lIfa/CFn0t/qngYFRaYbta1OdGxFlrt1tkf
         ELQgQrM/fClwitW0ZLl9KjWhF8yXPfjfh4fxKz7czMhPzGF1RUJ14RX4ljJoFjSHwrUH
         7OS/f2fhujdQQp+y3Uk/upiNTDMJ6m+oBcxaOLo9N73KMLwZK87vaNXrzny4ZkkxhOdU
         DVl0IUIbZaVXORDS/I13MgWTsGLLecqyJ1t18UXDo4Lw7CtMEW5Pv1qfZHjo5x8v90kR
         z51e8yRE7GCRwJ1BoEYQXAAisx26cP2yhqIzfM3Z/u0HO/T5qBFqhKem9A3FHoBXERv4
         Vemg==
X-Gm-Message-State: AOAM53150yx/U+HR4AtcS5L+uINQ9Siu+hIZzclE2UTM5aiS46htjRH1
        fzzdErTpvi0uu/8yUMs7rs499g==
X-Google-Smtp-Source: ABdhPJy2JVz8tURWgG/qOuULPC4tBf2XoDNhX9uDhgi/Mg9JgwWSv/IwOMk8uVXdNtIRLcRE9fs1lw==
X-Received: by 2002:a5d:4a02:: with SMTP id m2mr4113347wrq.315.1623918430751;
        Thu, 17 Jun 2021 01:27:10 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id v15sm7074335wmj.39.2021.06.17.01.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 01:27:10 -0700 (PDT)
Date:   Thu, 17 Jun 2021 09:27:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yunus Bas <Y.Bas@phytec.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <YMsHXEP36Vxr7lAb@dell>
References: <20210616081949.26618-1-y.bas@phytec.de>
 <YMm+VXRrRKIHGgmr@dell>
 <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021, Yunus Bas wrote:

> Hi Lee,
> 
> Am Mittwoch, dem 16.06.2021 um 10:03 +0100 schrieb Lee Jones:
> > On Wed, 16 Jun 2021, Yunus Bas wrote:
> > 
> > > The MFD-core iterates through all subdevices of the corresponding
> > > MFD-device and checks, if the devicetree subnode has a fitting
> > > compatible.
> > > When nothing is found, a warning is thrown. This can be the case,
> > > when it
> > > is the intention to not use the MFD-device to it's full content.
> > > Therefore, change the warning to a debug print instead, to also avoid
> > > irritations.
> > > 
> > > Signed-off-by: Yunus Bas <y.bas@phytec.de>
> > > ---
> > >  drivers/mfd/mfd-core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > > index 6f02b8022c6d..e34c97088943 100644
> > > --- a/drivers/mfd/mfd-core.c
> > > +++ b/drivers/mfd/mfd-core.c
> > > @@ -213,7 +213,7 @@ static int mfd_add_device(struct device *parent,
> > > int id,
> > >                 }
> > >  
> > >                 if (!pdev->dev.of_node)
> > > -                       pr_warn("%s: Failed to locate of_node [id:
> > > %d]\n",
> > > +                       pr_debug("%s: Failed to locate of_node [id:
> > > %d]\n",
> > >                                 cell->name, platform_id);
> > >         }
> > 
> > Can you provide an example of a device tree where this is a problem?
> 
> Of course, sorry for the poor description.
> 
> Here is an example of the imx6qdl-phytec-phycore-som.dtsi which uses
> the DA9062 multi-functional device. The DA9062 has five mfd-cell
> devices with compatibles defined as subfunctions. The devicetree needs
> and uses just three of them:
> 
> ...
> pmic: pmic@58 {                                                       
> compatible = "dlg,da9062";                                            
> pinctrl-names = "default";                                            
> pinctrl-0 = <&pinctrl_pmic>;                                          
> reg = <0x58>;                                                         
> interrupt-parent = <&gpio1>;                                          
> interrupts = <2 IRQ_TYPE_LEVEL_LOW>;                                  
> interrupt-controller;                                                 
> gpio-controller;                                                      
> #gpio-cells = <2>;                                                    
>                                                                       
> da9062_rtc: rtc {                                                     
>     compatible = "dlg,da9062-rtc";                                    
> };                                                                    
>                                            
> da9062_onkey: onkey {                                                 
>     compatible = "dlg,da9062-onkey";                                  
> };                                                                    
>                                                                       
> watchdog {                                                            
>     compatible = "dlg,da9062-watchdog";                               
>     dlg,use-sw-pm;                                                    
> }
> ...

So, looking at the mfd_cells table, I see:

  static const struct mfd_cell da9061_devs[] = {
        {
                .name           = "da9061-core",
                .num_resources  = ARRAY_SIZE(da9061_core_resources),
                .resources      = da9061_core_resources,
        },
        {
                .name           = "da9062-regulators",
                .num_resources  = ARRAY_SIZE(da9061_regulators_resources),
                .resources      = da9061_regulators_resources,
        },
        {
                .name           = "da9061-watchdog",
                .num_resources  = ARRAY_SIZE(da9061_wdt_resources),
                .resources      = da9061_wdt_resources,
                .of_compatible  = "dlg,da9061-watchdog",
        },
        {
                .name           = "da9061-thermal",
                .num_resources  = ARRAY_SIZE(da9061_thermal_resources),
                .resources      = da9061_thermal_resources,
                .of_compatible  = "dlg,da9061-thermal",
        },
        {
                .name           = "da9061-onkey",
                .num_resources  = ARRAY_SIZE(da9061_onkey_resources),
                .resources      = da9061_onkey_resources,
                .of_compatible = "dlg,da9061-onkey",
        },
  };

Not sure why "da9061-core" is even in there.  It looks like this would
be referencing itself (if this driver's name contained the "-core"
element).  So what from I can tell, I think this entry should actually
just be removed.

With regards to "da9062-regulators", this looks like an oversight at
best or a Linux hack at worst.  Device Tree is designed to be OS
agnostic.  It should describe the H/W as-is, which would include the
Regulator functionality.  Choosing to opt-out and instead use Linux
specific systems (i.e. MFD) for device registration is a hack.

I've always said we should not mix DT and MFD in this way.

> Since the driver iterates through the mfd_cells-struct tries matching
> compatibles in the devicetree MFD node, it throws a warning when there
> is no counterpart in the devicetree.
> 
> In fact, I could also evalutate oder devicetree's using MFD-devices not
> to it's full content.
>  
> > 
> > Probably worth popping that in the commit message too.
> 
> Yes, I will send a v2 ASAP. Thank you for the advice.

I think the current code is fine as it is.

It's the implementation that needs to change.

Maybe Steve would like to comment?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

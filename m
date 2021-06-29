Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EFD3B6FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhF2JJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhF2JJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:09:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD97C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 02:07:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u8so11595631wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9TL0oiRT0bbpzMPvJ6XjhO8hU1vWFtA0ocWrs2Ya1kQ=;
        b=hfgzePDrsjJu4xxLCoKKQEYtlejy+fRoNKnPXh490U5i6VdWyjVqBlI8rUvKE+alwg
         8ZLVUP8IwxlJjCDVED11IRqGrqrGoemHrLaCEhvdQ6aENonQKANmGoMmw62UbXYh8xnp
         0mENMzJHyKAaHYDA3E/QZfW8O3sH//4QXCYTfWntR1NKa8HQ3jvjrlxGEDR1IjsgVcSr
         lXzAaogiOns90/TtPyNkil9NdNZBkvjJgqxc4CU1KRP7y3nE7VaeDNRsITrR8C00eLOD
         7vzc6NoYRV9W6MbY5gcYjKkMnf7MeKyvEOgsHrJHCvYoAqV+r5+dPghs9C/GH0S4xMii
         9n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9TL0oiRT0bbpzMPvJ6XjhO8hU1vWFtA0ocWrs2Ya1kQ=;
        b=Vb2KdxE3f2s34vDpNmCEO2TIFnPMqMRxxS9INXXqMJlnmuBiSfcN6Ju49bH9mZvMs9
         IT2wwBxfpqONDkjebV9VzLWGeHNIJOEolckU5GVntvv7GHh6E7022oL9IJs5r2zYj0hA
         f/fqWnYyCP9cZ80Jihbp1/sjtDOxxxg2Al+xWGbvS5TlbPXYwoCdPBoXkiNLzsq98ZTJ
         EzoBhj5ES2mTPJLnBKSTK1cv/mkLvAB5z0d5udg9CPb4ICdwvQD7shK+LIdOtO/iBaO9
         f5CRAhUf2pOcQuh5ryYRdU+FtIZUdQgORLj3QTtUEeGQQxO04TmFfksI1zL9br9aRrKq
         9F7g==
X-Gm-Message-State: AOAM530/6E2E7gyFDTQiE8JlChmjpfWsseYOCxVQVtNBqrl+hOJnY7Rq
        sqlfqRC+VZiZrReBwEtQvKhFgg==
X-Google-Smtp-Source: ABdhPJzRtNDVK2aHy67X8KYg1UQR8Zhz2CtuYaO3uR1c9ofq1WZ3NV3voJEOuNlk4e0sbx9Iw9ssXg==
X-Received: by 2002:a5d:64ab:: with SMTP id m11mr33266538wrp.336.1624957623445;
        Tue, 29 Jun 2021 02:07:03 -0700 (PDT)
Received: from dell ([95.144.13.129])
        by smtp.gmail.com with ESMTPSA id t17sm15945383wmi.47.2021.06.29.02.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 02:07:02 -0700 (PDT)
Date:   Tue, 29 Jun 2021 10:07:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yunus Bas <Y.Bas@phytec.de>
Cc:     "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <YNritAU1p/R+WZ9I@dell>
References: <20210616081949.26618-1-y.bas@phytec.de>
 <YMm+VXRrRKIHGgmr@dell>
 <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
 <YMsHXEP36Vxr7lAb@dell>
 <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021, Yunus Bas wrote:

> Am Donnerstag, dem 17.06.2021 um 09:27 +0100 schrieb Lee Jones:
> > On Thu, 17 Jun 2021, Yunus Bas wrote:
> > 
> > > Hi Lee,
> > > 
> > > Am Mittwoch, dem 16.06.2021 um 10:03 +0100 schrieb Lee Jones:
> > > > On Wed, 16 Jun 2021, Yunus Bas wrote:
> > > > 
> > > > > The MFD-core iterates through all subdevices of the corresponding
> > > > > MFD-device and checks, if the devicetree subnode has a fitting
> > > > > compatible.
> > > > > When nothing is found, a warning is thrown. This can be the case,
> > > > > when it
> > > > > is the intention to not use the MFD-device to it's full content.
> > > > > Therefore, change the warning to a debug print instead, to also
> > > > > avoid
> > > > > irritations.
> > > > > 
> > > > > Signed-off-by: Yunus Bas <y.bas@phytec.de>
> > > > > ---
> > > > >  drivers/mfd/mfd-core.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > > > > index 6f02b8022c6d..e34c97088943 100644
> > > > > --- a/drivers/mfd/mfd-core.c
> > > > > +++ b/drivers/mfd/mfd-core.c
> > > > > @@ -213,7 +213,7 @@ static int mfd_add_device(struct device
> > > > > *parent,
> > > > > int id,
> > > > >                 }
> > > > >  
> > > > >                 if (!pdev->dev.of_node)
> > > > > -                       pr_warn("%s: Failed to locate of_node
> > > > > [id:
> > > > > %d]\n",
> > > > > +                       pr_debug("%s: Failed to locate of_node
> > > > > [id:
> > > > > %d]\n",
> > > > >                                 cell->name, platform_id);
> > > > >         }
> > > > 
> > > > Can you provide an example of a device tree where this is a
> > > > problem?
> > > 
> > > Of course, sorry for the poor description.
> > > 
> > > Here is an example of the imx6qdl-phytec-phycore-som.dtsi which uses
> > > the DA9062 multi-functional device. The DA9062 has five mfd-cell
> > > devices with compatibles defined as subfunctions. The devicetree
> > > needs
> > > and uses just three of them:
> > > 
> > > ...
> > > pmic: pmic@58 {                                                      
> > > compatible = "dlg,da9062";                                           
> > > pinctrl-names = "default";                                           
> > > pinctrl-0 = <&pinctrl_pmic>;                                         
> > > reg = <0x58>;                                                        
> > > interrupt-parent = <&gpio1>;                                         
> > > interrupts = <2 IRQ_TYPE_LEVEL_LOW>;                                 
> > > #gpio-cells = <2>;                                                   
> > > da9062_rtc: rtc {                                                    
> > >     compatible = "dlg,da9062-rtc";                                   
> > >                                            
> > > da9062_onkey: onkey {                                                
> > >     compatible = "dlg,da9062-onkey";                                 
> > > watchdog {                                                           
> > >     compatible = "dlg,da9062-watchdog";                              
> > >     dlg,use-sw-pm;                                                   
> > > }
> > > ...
> > 
> > So, looking at the mfd_cells table, I see:
> > 
> >   static const struct mfd_cell da9061_devs[] = {
> >         {
> >                 .name           = "da9061-core",
> >                 .num_resources  = ARRAY_SIZE(da9061_core_resources),
> >                 .resources      = da9061_core_resources,
> >         },
> >         {
> >                 .name           = "da9062-regulators",
> >                 .num_resources  =
> > ARRAY_SIZE(da9061_regulators_resources),
> >                 .resources      = da9061_regulators_resources,
> >         },
> >         {
> >                 .name           = "da9061-watchdog",
> >                 .num_resources  = ARRAY_SIZE(da9061_wdt_resources),
> >                 .resources      = da9061_wdt_resources,
> >                 .of_compatible  = "dlg,da9061-watchdog",
> >         },
> >         {
> >                 .name           = "da9061-thermal",
> >                 .num_resources  = ARRAY_SIZE(da9061_thermal_resources),
> >                 .resources      = da9061_thermal_resources,
> >                 .of_compatible  = "dlg,da9061-thermal",
> >         },
> >         {
> >                 .name           = "da9061-onkey",
> >                 .num_resources  = ARRAY_SIZE(da9061_onkey_resources),
> >                 .resources      = da9061_onkey_resources,
> >                 .of_compatible = "dlg,da9061-onkey",
> >         },
> >   };
> 
> First of all, this is the wrong device. Further down is listed a second
> machine, the da9062, with more subdevices:
> 
> static const struct mfd_cell da9062_devs[] = { 
>  { 
>  .name = "da9062-core", 
>  .num_resources = ARRAY_SIZE(da9062_core_resources), 
>  .resources = da9062_core_resources, 
>  }, 
>  { 
>  .name = "da9062-regulators", 
>  .num_resources = ARRAY_SIZE(da9062_regulators_resources), 
>  .resources = da9062_regulators_resources, 
>  }, 
>  { 
>  .name = "da9062-watchdog", 
>  .num_resources = ARRAY_SIZE(da9062_wdt_resources), 
>  .resources = da9062_wdt_resources, 
>  .of_compatible = "dlg,da9062-watchdog", 
>  }, 
>  { 
>  .name = "da9062-thermal", 
>  .num_resources = ARRAY_SIZE(da9062_thermal_resources), 
>  .resources = da9062_thermal_resources, 
>  .of_compatible = "dlg,da9062-thermal", 
>  }, 
>  { 
>  .name = "da9062-rtc", 
>  .num_resources = ARRAY_SIZE(da9062_rtc_resources), 
>  .resources = da9062_rtc_resources, 
>  .of_compatible = "dlg,da9062-rtc", 
>  }, 
>  { 
>  .name = "da9062-onkey", 
>  .num_resources = ARRAY_SIZE(da9062_onkey_resources), 
>  .resources = da9062_onkey_resources, 
>  .of_compatible = "dlg,da9062-onkey", 
>  }, 
>  { 
>  .name = "da9062-gpio", 
>  .num_resources = ARRAY_SIZE(da9062_gpio_resources), 
>  .resources = da9062_gpio_resources, 
>  .of_compatible = "dlg,da9062-gpio", 
>  }, 
> };
> 
> > 
> > Not sure why "da9061-core" is even in there.  It looks like this would
> > be referencing itself (if this driver's name contained the "-core"
> > element).  So what from I can tell, I think this entry should actually
> > just be removed.
> > 
> > With regards to "da9062-regulators", this looks like an oversight at
> > best or a Linux hack at worst.  Device Tree is designed to be OS
> > agnostic.  It should describe the H/W as-is, which would include the
> > Regulator functionality.  Choosing to opt-out and instead use Linux
> > specific systems (i.e. MFD) for device registration is a hack.
> 
> I think you're right here. But this is design specific and has not much
> to do with my request.
> > 
> > I've always said we should not mix DT and MFD in this way.
> > 
> > > Since the driver iterates through the mfd_cells-struct tries matching
> > > compatibles in the devicetree MFD node, it throws a warning when
> > > there
> > > is no counterpart in the devicetree.
> > > 
> > > In fact, I could also evalutate oder devicetree's using MFD-devices
> > > not
> > > to it's full content.
> > >  
> > > > 
> > > > Probably worth popping that in the commit message too.
> > > 
> > > Yes, I will send a v2 ASAP. Thank you for the advice.
> > 
> > I think the current code is fine as it is.
> > 
> > It's the implementation that needs to change.
> > 
> > Maybe Steve would like to comment?
> > 
> 
> The problem I want to address lies in the mfd_add_device function in
> the mfd-core:
> 
>     if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell-
> >of_compatible) {          
>         for_each_child_of_node(parent->of_node, np) {                 
>             if (of_device_is_compatible(np, cell->of_compatible)) {   
>                 /* Ignore 'disabled' devices error free */            
>                 if (!of_device_is_available(np)) {                    
>                     ret = 0;                                          
>                     goto fail_alias;                                  
>                 }                                                     
>                                                                       
>                 ret = mfd_match_of_node_to_dev(pdev, np, cell);       
>                 if (ret == -EAGAIN)                                   
>                     continue;                                         
>                 if (ret)                                              
>                     goto fail_alias;                                  
>                                                                       
>                 break;                                                
>             }                                                         
>         }                                                             
>                                                                       
>         if (!pdev->dev.of_node)                                       
>             pr_info("%s: Failed to locate of_node [id: %d]\n",        
>                 cell->name, platform_id);                             
>     }
> 
> Interestingly, all subdevices defined in the driver are registered as
> platform devices from the MFD framework, regardless of a devicetree
> entry or not. The preceding code checks the subdevice cells with an
> additional compatible. In case a device has no devicetree entry, an
> irritating failed-message is printed on the display. I'm not sure if
> this was the intention but the framework somehow forces the users to
> describe all subdevices of an MFD. I think the info print is not
> needed. It makes more sense to set it as a debug print.

My current understanding is that; it's far more likely that the
driver's use of the API is incorrect than the print itself.  I need to
spend more time on this (time is no my friend at this present moment)
in order to fully understand what's happening though.  Please bear
with me.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F323A9F12
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhFPPar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhFPPaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:30:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F367C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:28:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m3so1509999wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EbhkjQ5j2OcdBaFI2dnpODCHVTEU+UUtKdmpqCWFJRE=;
        b=IrsFCOeRsye22mFWY64zEY/xcoZX1aX/aJs8wegxcX+91hdYXPwb5646PmscCeweMl
         tTrOkUWmMGPkb2ksYi88LKfv44fuCIi7YU96VTqfhMBC8NWdwWk34fRu9YQ7eHVexak1
         cAS6+nNpLh3pPIIe6UqWPqxx1OiJ/Wl6NMfy56J1fWp6MXNdL/Ys1xLwho2q7jvQ48HA
         mjs0JgAkCC9QxDF/P1ve9ZaGofj3dQdAsdCX9k2d0PmCdeOsJWee+ET+gAlpINZGXXUR
         vFA3ai4ENsW5SdgmfyJ33o88zms322CGNGZdASx4d8f2s3RLAEz9qDQJWrQRXJRwmbrh
         YmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EbhkjQ5j2OcdBaFI2dnpODCHVTEU+UUtKdmpqCWFJRE=;
        b=LQyzCqBah48uv/OvhkpX/5FLXmYHWQpVsG8ODJn1aEPQG6JLNP+Uyjj/6LHqOwoaR8
         3j9n2kUjPBztCkUO4ckeyx7/QgPg9wxocnU4KVKmgc12LzW8zHvnLMrJoCpq/WHZPDLq
         a9H9E/sM1q/U0yV5QP1qpDkij1vQ1j+CiGhCb8NiVporQV0C8mneH7wtyawf4ClWXBy0
         ePXp050iJiJoCinzGg5v3TBdka0dxsyYwa/X+DjHwWJM8fIVmcwlG/jbUolqFh2r9bSm
         D/agMwZgxKUAOM4aMwTQvmRHFHB3s1yNulXYckg3QkM1ZWMBztvNJseB/uDEaCptmYMz
         nwmw==
X-Gm-Message-State: AOAM530ZmOdoDN77VEW+ja1ljTHR+Ahft2GVuD1meuFvyEpLiwcVT9bP
        dtVjogz8w9GAox/X6dh2WDMqKQ==
X-Google-Smtp-Source: ABdhPJxdji89qsbTpaGF5exaCUoQ9EnsLGw3iVWl12yCnTnq2YZi903Vr7k222qcewg5OWRStI/C4A==
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr12312570wmk.64.1623857318677;
        Wed, 16 Jun 2021 08:28:38 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id w8sm2399999wmi.45.2021.06.16.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 08:28:38 -0700 (PDT)
Date:   Wed, 16 Jun 2021 16:28:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <YMoYpF13axL0EXFu@dell>
References: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
 <YMiwEYLkbKocs8ux@dell>
 <OS3PR01MB65939641C36B650A3B69DAADBA309@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YMmuz0EVjfEi6MJj@dell>
 <TYYPR01MB6603047A864DB37F111BDAD9BA0F9@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <YMoP7fdkyyYUrDf2@dell>
 <TYYPR01MB6603D0473CF72D7EFB599D2CBA0F9@TYYPR01MB6603.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYPR01MB6603D0473CF72D7EFB599D2CBA0F9@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021, Min Li wrote:

> > >
> > > Hi Lee
> > >
> > > The PHC driver already existed in the current tree as
> > > drivers/ptp/ptp_clockmatrix.c and ptp_idt82p33.c
> > >
> > > Right now, they act as i2c driver. I plan to change them as a normal
> > > platform device driver after this MFD change kicked in
> > >
> > > That is why I would prefer the name "phc" instead of "clock" since the
> > > driver is not a normal clk driver under drivers/clk but a ptp clock
> > > driver. And down the road, we will have our real clock driver and I wanna
> > reserve the name "clock" for the real clock driver.
> > 
> > I see.  To be honest, I wasn't aware of the PTP subsystem.
> > 
> > In which case, the name needs to match the one in the driver:
> > 
> >  static struct i2c_driver idtcm_driver = {
> >         .driver = {
> >                 .of_match_table = of_match_ptr(idtcm_dt_id),
> >                 .name           = "idtcm",
> >         },
> >         .probe          = idtcm_probe,
> >         .remove         = idtcm_remove,
> >         .id_table       = idtcm_i2c_id,
> >  };
> > 
> > So, "idtcm" in this case.
> > 
> > How else will it match?
> > 
> 
> Hi Lee
> 
> I actually like to comply with the mfd sub device naming convention by naming it 8a3400x-phc
> About the names in ptp clock driver, I will have to change them anyways down the road to
> make them work with the mfd driver
> 
> Another match doesn't exist in the current tree yet. It would be a normal platform device driver that I
> will submit to drivers/misc a little later after this mfd change is merged.

Okay, leave it as it is then.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

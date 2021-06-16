Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA3B3A9E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhFPOxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhFPOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:53:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCFAC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:51:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q5so3044246wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PO3bafkqYILWJqWytS8gUShKgfwibzvfh84wirCWy1s=;
        b=bNYdxkGO+wjRgDRieFSzyn8BVGnlO2jMlt1eMjYjfu9AqzoKcL/bY6C6MHP63cIYRR
         z2aF9F2dpjzPaKe6mgKittxuFMoQE+sRwEj7S9ViKIVkgLP1xz/KFxW2Cin8BdvYD9f0
         cbssyNEcAj7R9pymnM7nnMwIWckb1U8VpxycM+Agm2AI8XbM3SRoqfZEubeiACeb+xA0
         932QYj0TmtuJPPLUBKhjQvheDc+Fp8MeubxNkuJ0fkH6fiJfAuDZWm0mUWejCLPRJqDm
         6a1GUetsm1tIrPbUUdOCcf/HrNbuXBWBdP7wS+KbMb+vlIHpgmAYIzmNfa+96AayfCC0
         RuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PO3bafkqYILWJqWytS8gUShKgfwibzvfh84wirCWy1s=;
        b=hHBjU8TVskh+5ZqLYsSm3zqrfBiNY0+RZ51dYlauv6ju9niBpRh6/ZeFX+oX4MjyFP
         OiWdkDu48J4NoTyBTDf/ynFm0GciVrbyvsLzhHsPCJm66r0aVasVHdsnO/MPgFCJM+sf
         /Tri1MsvYiw26cqzB/P2Iv6VwVErYLETQ+KDpSGrUZfkS8QyBFnb+qzWsf3DQrIkYHEg
         ZFaL3U41UIarzfJo3keqytdixgo74XsigcaETfSvg41IWQSSYvqktI82Ge8GX6T/elnz
         E60/5B5dB1dS62b8dut69N0s3tfrVROee7bPMAysxIIGiAxKCNVuyPBzlvKcgjo5ssJ/
         l9lQ==
X-Gm-Message-State: AOAM532hltYkPK7BeKuZiatku2Zs/AQV0pSYXPr6Ctq0rZofHHiEAqwQ
        Wmj7Y0ok8LhIe0TiR8NzZnEWXCDM/WAukw==
X-Google-Smtp-Source: ABdhPJzk1KnTJA4gbt6PFE3FyAoZUcCPSje/BGsicS9oi0jkDqPQyN2CpT46kCnDnRtJzXZty+TEWA==
X-Received: by 2002:adf:9dd1:: with SMTP id q17mr5869188wre.402.1623855087572;
        Wed, 16 Jun 2021 07:51:27 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id x18sm2349887wrw.19.2021.06.16.07.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:51:27 -0700 (PDT)
Date:   Wed, 16 Jun 2021 15:51:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <YMoP7fdkyyYUrDf2@dell>
References: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
 <YMiwEYLkbKocs8ux@dell>
 <OS3PR01MB65939641C36B650A3B69DAADBA309@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YMmuz0EVjfEi6MJj@dell>
 <TYYPR01MB6603047A864DB37F111BDAD9BA0F9@TYYPR01MB6603.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYPR01MB6603047A864DB37F111BDAD9BA0F9@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021, Min Li wrote:

> > 
> > > >
> > > > > +static struct mfd_cell rsmu_cm_devs[] = {
> > > > > +	[RSMU_PHC] = {
> > > > > +		.name = "idtcm-phc",
> > > >
> > > > Can't you have a nicer name?
> > > >
> > > Hi Lee
> > >
> > > I wonder which part of the name that you don't like? PHC stands from PTP
> > Hardware Clock.
> > > I was following the name convention like tps65912-regulator.
> > > Do you accept "8a3400-phc"?
> > 
> > I think you're trying to put too much information into the device name.
> > 
> > Currently it's:
> > 
> >   idt <company name> cm <platform> - phc <exact device type>
> > 
> > Where usually we have, taking your example:
> > 
> >   tps65912 <chip> - regulator <subsystem>
> > 
> > So assuming the PTP HW Clock is just a clock it should be:
> > 
> >   8a3400 <chip> - clock <subsystem>
> > 
> > It's difficult to say without seeing the associated child device(s).
> > When do you propose to upstream those?  Maybe they should be part of
> > this initial set.  I think that would help a lot.
> > 
> 
> Hi Lee
> 
> The PHC driver already existed in the current tree as drivers/ptp/ptp_clockmatrix.c and
> ptp_idt82p33.c
> 
> Right now, they act as i2c driver. I plan to change them as a normal platform device driver
> after this MFD change kicked in
> 
> That is why I would prefer the name "phc" instead of "clock" since the driver is not a normal clk driver
> under drivers/clk but a ptp clock driver. And down the road, we will have our real clock driver and I wanna
> reserve the name "clock" for the real clock driver.

I see.  To be honest, I wasn't aware of the PTP subsystem.

In which case, the name needs to match the one in the driver:

 static struct i2c_driver idtcm_driver = {
        .driver = {
                .of_match_table = of_match_ptr(idtcm_dt_id),
                .name           = "idtcm",
        },
        .probe          = idtcm_probe,
        .remove         = idtcm_remove,
        .id_table       = idtcm_i2c_id,
 };

So, "idtcm" in this case.

How else will it match?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

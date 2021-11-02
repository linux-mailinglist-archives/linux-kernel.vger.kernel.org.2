Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C91442CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBLiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhKBLiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:38:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38ADC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:35:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d27so14813967wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iXMDpVo/VqxPDA0RVpwteprivF25APv9kHY1xfQB2HA=;
        b=bEeYjwGrd/B4EBJr1surlk88VeoJAauC5hKU/jOczSmaHNzxzzowdcFV0S9vr154WT
         lYy9Fc5idEH2PEt/8arvfEAabjUCZmS+rR+0zjhkxz4M305qOOfwL/AGFMdy7nJ+cJqy
         660GKg/D4PD5FHPKBUB8w/Td5UJsL306jON0HGcpUC4/I1I0W7biCA3bO741qak+dTy5
         jiyFixF8I5GVUOVxymFXZjFoxGBGM6NN9rNVrO66kc/GhogfUHPDJPlhQtvkZdv0nNIX
         5Q8iw/egCrHgrYJiaBFjUE+CrhLC+tGGvNmz1iuOaIMs3yFC3s0Leucf2Gsk7m45BK1l
         elhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iXMDpVo/VqxPDA0RVpwteprivF25APv9kHY1xfQB2HA=;
        b=S/PO9IY1KTgwcLDgX0wLhmF0EKQ7XyIO21LcdkOrQqQbWut4Zvn4BB2/9Q+CodANwR
         +4FDWu66kU8CnP3chqNmOqxWsEzzch4/0M/MaX8NuG2dsORQvj8DWPaklEZOhcXDfoly
         Yja/+JSBb3ojbFTI+noUxy4htbTGTgiNsY8+xFsUI84HDfsPp2UUED9OPIxKY5gRKBuH
         Yv3onLrfg9Fs0gDoX/5CLQaYqNm3egfv0GJpJB8mr8P23ci3AjNd5iv1ZpgsQB5xM/SW
         aC5llXbPjgzzy2A0UC0eCXHGEGTJXYjHqkt7QpLbzz1H/2Stp/fcC3TiHC8SCM+dBJy5
         wfUg==
X-Gm-Message-State: AOAM531ygdh0PDnbAtTvxY5G27nZjRPZj02TyjKOtEZyEp14ROIHS6Hx
        HeY1DZv71cRJoPWaZoXQohU7G4syL9p/mA==
X-Google-Smtp-Source: ABdhPJzSSFrD7C+9KNmNwI5RhdXZGmCZ4lFXZMNjxpMVbaXsfxPfG0OfvxXgHBoig//yQ2Rrgzpe4g==
X-Received: by 2002:adf:e984:: with SMTP id h4mr42420684wrm.149.1635852940353;
        Tue, 02 Nov 2021 04:35:40 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id u13sm17763294wri.50.2021.11.02.04.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 04:35:39 -0700 (PDT)
Date:   Tue, 2 Nov 2021 11:35:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Michael Walle <michael@walle.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Select MFD_CORE to fix build error
Message-ID: <YYEiijBp3dK92ep4@google.com>
References: <20211102100420.112215-1-robert.marko@sartura.hr>
 <YYEeS8gz8TBW63X8@google.com>
 <CA+HBbNHWV=+qDpOaD-ePz2yPpSjBOFEgdkuWBiqobBP9VN7W4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNHWV=+qDpOaD-ePz2yPpSjBOFEgdkuWBiqobBP9VN7W4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, Robert Marko wrote:

> On Tue, Nov 2, 2021 at 12:17 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 02 Nov 2021, Robert Marko wrote:
> >
> > > MFD_SIMPLE_MFD_I2C should select the MFD_CORE to a prevent build error:
> > >
> > > aarch64-linux-ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
> > > drivers/mfd/simple-mfd-i2c.c:55: undefined reference to `devm_mfd_add_devices'
> >
> > What is your use-case?
> >
> > How are you enabling this symbol?
> 
> Hi Lee,
> I am adding a symbol like MFD_SL28CPLD does that you can depend on and
> that simply
> selects the MFD_SIMPLE_MFD_I2C and I have hit this issue since the
> MFD_CORE is not selected.

That's interesting.

I wonder how MFD_SL28CPLD selects it?

> > > Fixes: 3abee4579484 ("mfd: Add simple regmap based I2C driver")
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > ---
> > >  drivers/mfd/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 61992edf6a4d..2de69892b631 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1204,6 +1204,7 @@ config MFD_SI476X_CORE
> > >  config MFD_SIMPLE_MFD_I2C
> > >       tristate
> > >       depends on I2C
> > > +     select MFD_CORE
> > >       select REGMAP_I2C
> > >       help
> > >         This driver creates a single register map with the intention for it
> >
> 
> 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

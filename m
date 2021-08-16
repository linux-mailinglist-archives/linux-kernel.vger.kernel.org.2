Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1776D3ECF3E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhHPHSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbhHPHS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:18:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40800C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:17:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a201-20020a1c7fd2000000b002e6d33447f9so2724179wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GTZF8j25gwET5PN4w+sszLnTw+kRD4U/DTQ4baFSPGk=;
        b=GSX0D+Y8punietmHlfz33VhHCEleHXp5sQy/NQBfXkY3XJCWAhlH9KemxTD60mcqV+
         i+j08SKOsqr1lpVMflGzsuB1Tz5hW1Le0oPMHmog1Z/m9sotwBArxM0yy4pMdDySQa1R
         7/PlRuyVEfDadsKqdIuHwqToJIUdEbDj+ecZupEIEwbirxswrH3bhHDxY7lUN6v4KesU
         XJjjiebDRWWaJg9UF3GtckwRWC0wiIzYAByzqUVcljvjPDKCBM9S/xYnuwigcy6IQ8mz
         ZOSrjP75kG8DeIwbIzMbC9cLJuspsGpO4ejtNL427FQLx6eii/6ZnnI7RP/GWMLpqJhi
         TfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GTZF8j25gwET5PN4w+sszLnTw+kRD4U/DTQ4baFSPGk=;
        b=lWSoGegECx5LQmvVGs8TRCINcDdpYnf4kU3yI4C6duF/8JSL10ztLbAiqWTbhoBYfH
         Dl9YHRMHGAjTpRAuEcHVrF1s/5UkUNeAy/0QuXcgJZn8KLx9slcOcxsvccRGwx7ygaFh
         9BYLiJc2OWIz44ENtl/o1jelTLuZ1+kE8DQmHLtQsUHTzNWL6AeLcIikLolrkyS8amHu
         qDV3bT1w+Y/gOOgdHzm9w//GF53vynFjCrPt3IaoBO4f8TAhKQrN+TCqIUevH3GN1vhq
         TFrRSeqHKHBXGpL3uaXcv7eJU4j4D2Zyf1wob8csfZTnSOxNz7ABBsiO2KkYCaL1VEIA
         Wrvg==
X-Gm-Message-State: AOAM530nVEQwwXmgjif1rknzzq0rAPfWsOeBpuJerUWRGF4lpKfttYdj
        D4E2Jqd5ACHormsuQEBBt6eMpg==
X-Google-Smtp-Source: ABdhPJz5+Cd5+Kiz7rt6SDHNZwQShccWmNbOM2zb55+Em6CCwo7OKkH4hIhwNQv3WNZMfhqZlCm6xg==
X-Received: by 2002:a7b:cf26:: with SMTP id m6mr13945153wmg.165.1629098275547;
        Mon, 16 Aug 2021 00:17:55 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id o125sm9888277wme.15.2021.08.16.00.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 00:17:54 -0700 (PDT)
Date:   Mon, 16 Aug 2021 08:17:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 3/4] mfd: intel_quark_i2c_gpio: Convert GPIO to use
 software nodes
Message-ID: <YRoRJNrmPg4xyGKS@google.com>
References: <20210804160019.77105-1-andriy.shevchenko@linux.intel.com>
 <20210804160019.77105-3-andriy.shevchenko@linux.intel.com>
 <YQubJ1s2YuEZk4lm@google.com>
 <YRPJ7Iws2Hb6pE6G@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRPJ7Iws2Hb6pE6G@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021, Andy Shevchenko wrote:

> On Thu, Aug 05, 2021 at 09:02:47AM +0100, Lee Jones wrote:
> > On Wed, 04 Aug 2021, Andy Shevchenko wrote:
> > 
> > > The driver can provide a software node group instead of
> > > passing legacy platform data. This will allow to drop
> > > the legacy platform data structures along with unifying
> > > a child device driver to use same interface for all
> > > property providers, i.e. Device Tree, ACPI, and board files.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Tested-by: Serge Semin <fancer.lancer@gmail.com>
> > > ---
> > > v2: added tag (Serge)
> > >  drivers/mfd/intel_quark_i2c_gpio.c | 70 ++++++++++++++++--------------
> > >  1 file changed, 37 insertions(+), 33 deletions(-)
> > 
> > For my own reference (apply this as-is to your sign-off block):
> > 
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Thanks!
> 
> Just for your information. I think due to spaces in front of your tag
> the `b4` tool can't catch this automatically.

Why would it need to?

This tag is "for my reference", for when I merge it.

Please add it to your sign-off block when you resubmit.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

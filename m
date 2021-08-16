Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3A3ED8D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhHPOTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhHPOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:19:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FFDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:19:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x10so17573998wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AKhG9J3ahU8JkCpxk+g+Q/1FWyyETrK/NptsIpsKfbc=;
        b=KGIkb0rXwfACZDeriTgTrMb+v/OdOVaOKQUwEBhF0Uuoi0Ps0ivcKP1OEZoD9CnRwc
         G003xTXm+nbqosZS3mibwmloTwRofCHtAO9ws5JR0Qvba4AMjOWNnlZryxVvzx+YSKia
         DiBh3PNQla7b2ixPyfiMBwHYHe/fyldqSPVvvj3OmsodZSQIQqlfI68H0Giprga1esxM
         koahSCMyr9HAXYvhoUlXNqQ72NVIib497ZsKb2bac/SCNJfEuvG7SW8rzT+gLadnYBSJ
         GBT4UsnLArNKPa1DbJGXXGo7KuPMgwE9AfOF/ZZyXM91oqaq0uDUUUyQqPogCnP+hFWD
         G3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AKhG9J3ahU8JkCpxk+g+Q/1FWyyETrK/NptsIpsKfbc=;
        b=EAX3eqvgjBxPP7J1fy2o00P18CKYHZaaINyTqH6r2c+ApqLLMmj/Y4z1G+LriEuVIt
         kfK95DMF0mC8yIuzsT9Wes3Y0DqiMxqTYKOPdPGx+hXDVmbwW01lj/w40c4zz3wdR4mY
         OLS1f8p1axXX5+OxTNBNADu5Y0+HilSDtZqv1kRRXKZhQvwbWzrgcYh7SdiCE94u7qfd
         bHsj993KzgbaWbM+Bk1zru2RMyWnWKBF4jTkqzkBVJiu7o5pDpYsxqkj1N4qhRngkLuH
         QZuwT5HKI53X7QuNbPWgjJT4lj0Q3aWmZd/+IE2gSp1z9k6+59/P012IiWrfsiWqr1cv
         9kgA==
X-Gm-Message-State: AOAM530SErxUIwlJpr13V+7mGF4hnVG3GWBq2jd32Jydk1kYvhpP5acf
        vJ/4NpBxHcqi7LPUIWdv63w1vQ==
X-Google-Smtp-Source: ABdhPJxDgPdFw3+oQn2JzBNxZg02cW3DX14/kTpXSNEiZ16yphRkOLIwxCsbnypCdfYxlNGQwKchQg==
X-Received: by 2002:adf:e4ce:: with SMTP id v14mr18665245wrm.21.1629123559951;
        Mon, 16 Aug 2021 07:19:19 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id d7sm12260166wrs.39.2021.08.16.07.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 07:19:19 -0700 (PDT)
Date:   Mon, 16 Aug 2021 15:19:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v1 3/4] mfd: intel_quark_i2c_gpio: Convert GPIO to use
 software nodes
Message-ID: <YRpz5UEDQbpewq5o@google.com>
References: <20210726125436.58685-1-andriy.shevchenko@linux.intel.com>
 <20210726125436.58685-3-andriy.shevchenko@linux.intel.com>
 <YRpihHP3kDz5nYV9@google.com>
 <CAHp75VdcWsNFervoU7e4_m7qVKAnWXzF2z2mUgKg06-qmwn-2A@mail.gmail.com>
 <YRppKOxp4Jya5iEI@google.com>
 <YRpva4gS1LfncPUj@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRpva4gS1LfncPUj@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021, Andy Shevchenko wrote:

> On Mon, Aug 16, 2021 at 02:33:28PM +0100, Lee Jones wrote:
> > On Mon, 16 Aug 2021, Andy Shevchenko wrote:
> > 
> > > On Mon, Aug 16, 2021 at 4:11 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > On Mon, 26 Jul 2021, Andy Shevchenko wrote:
> > > >
> > > > > The driver can provide a software node group instead of
> > > > > passing legacy platform data. This will allow to drop
> > > > > the legacy platform data structures along with unifying
> > > > > a child device driver to use same interface for all
> > > > > property providers, i.e. Device Tree, ACPI, and board files.
> > > > >
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > ---
> > > > >  drivers/mfd/intel_quark_i2c_gpio.c | 70 ++++++++++++++++--------------
> > > > >  1 file changed, 37 insertions(+), 33 deletions(-)
> > > >
> > > > Doesn't seem to want to apply.
> > > 
> > > Would it be okay for you to pull the immutable tag?
> > 
> > What immutable tag?
> 
> It's here:
> https://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git/tag/?h=intel-gpio-v5.15-1

My Ack can't be merged like that.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

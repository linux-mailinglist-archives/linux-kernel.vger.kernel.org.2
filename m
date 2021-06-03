Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613DD39A256
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFCNkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhFCNkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:40:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50A5C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 06:38:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so3728710wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UB1dC1x7Q5XtPI6WHq68XqQb5EV3n+latxacUpQ7G9o=;
        b=nPAgiVyjDr3TzJtnY8+nuNkgJZVoCZNO1GPiBIWGLuFqNEneWrUSeCCsQsmkFL2QnV
         dSGpRsSdwI3T7/CZ3joniHmjC4d2jigHbHawogUME22odgW8g7bvJj58sb3R9G2EZBK7
         4AKFHPAlWGjXfmUJ09QVfljc+goT5RRR9Qgv4yHaeUfollFjh82gW76MXSQo4pAYQ22F
         +NLBeuzpMqLCULWLB8KOAYEe2ke4u/227z3A4yhwfPdpsTapIgrjWPZVD7aVane0Xk34
         4nLrt7Js1/mMUMurHJF7UOoGRrvJ7NiSoDetEjnN+Ht2BjmpdKdNejRq9++b+z9GSylh
         wbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UB1dC1x7Q5XtPI6WHq68XqQb5EV3n+latxacUpQ7G9o=;
        b=AixTZMwfJcRvqMhnnbXDXJFFF8Lv5QL15iTDddC082zM/HkmCqhsdfXd6iNBRZyO9+
         SrygdJ7x4qrOjNXORhdULNG/aFPKXmkKzoP3vu7NwJzYum2tDB91xn8fac5PURD2C8hp
         gr4uinzq1hqGskLe194rkIluQhDRXnPRoT09nwMQ3uIfFgh4Ju4b7m5hJ2W038xCeKfS
         cNLkdIA8iTmxZm8/HZhNjOHTzWbwmlF0zxwLoOTh1COJlw2EGQG6rtdaPgTN1UnKq4Wx
         p2c4ieABVTceeJMt11gpQQZIDh367nFyfYr0MKqDRnUkg1oUvca6npYvX4ptIs5/TDLN
         0kJA==
X-Gm-Message-State: AOAM533Nkxp2iAh6Na510o7lux0LmkujXwAX9oEASWE/HVhBcot5AUYT
        nOZnRQ5ARY2hWRlcFaqHDNhFyX4mL3w88g==
X-Google-Smtp-Source: ABdhPJyxVtUdARI1Je7SkOj/06ZtIQnNA8NYDyPtW3w5xWJci//m8z3Q+DGa8IVLJt2haIQPGC+few==
X-Received: by 2002:a05:600c:8a6:: with SMTP id l38mr22994321wmp.108.1622727522521;
        Thu, 03 Jun 2021 06:38:42 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id l13sm3275956wrv.57.2021.06.03.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 06:38:42 -0700 (PDT)
Date:   Thu, 3 Jun 2021 14:38:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Russell King <linux@armlinux.org.uk>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stefan Agner <stefan@agner.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] ARM: xen: Register with kernel restart handler
Message-ID: <20210603133840.GB2435141@dell>
References: <20191015145147.1106247-1-thierry.reding@gmail.com>
 <20191015145147.1106247-3-thierry.reding@gmail.com>
 <CAF2Aj3hbW7+pNp+_jnMVL8zeSxAvSbV1ZFZ_4PAUj6J0TxMk7g@mail.gmail.com>
 <20210603131124.GA1040254@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603131124.GA1040254@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jun 2021, Guenter Roeck wrote:

> On Thu, Jun 03, 2021 at 01:43:36PM +0100, Lee Jones wrote:
> > On Tue, 15 Oct 2019 at 15:52, Thierry Reding <thierry.reding@gmail.com>
> > wrote:
> > 
> > > From: Guenter Roeck <linux@roeck-us.net>
> > >
> > > Register with kernel restart handler instead of setting arm_pm_restart
> > > directly.
> > >
> > > Select a high priority of 192 to ensure that default restart handlers
> > > are replaced if Xen is running.
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  arch/arm/xen/enlighten.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > 
> > This patch does appear to be useful.
> > 
> > Is this just being solved in downstream trees at the moment?
> > 
> > It would be nice if we could relinquish people of this burden and get it
> > into Mainline finally.
> > 
> 
> There must have been half a dozen attempts to send this patch series
> upstream. I have tried, and others have tried. Each attempt failed with
> someone else objecting for non-technical reasons (such as "we need more
> reviews") or no reaction at all, and maintainers just don't pick it up.

Looking at the *-by tag list above, I think we have enough quality
reviews to take this forward.

> So, yes, this patch series can only be found in downstream trees,
> and it seems pointless to submit it yet again.

IMHO, it's unfair to burden multiple downstream trees with this purely
due to poor or nervy maintainership.  Functionality as broadly useful
as this should be merged and maintained in Mainline.

OOI, who is blocking?  As I see it, we have 2 of the key maintainers
in the *-by list.  With those on-board, it's difficult to envisage
what the problem is.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

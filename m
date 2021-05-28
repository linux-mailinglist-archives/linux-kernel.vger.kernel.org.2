Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE4E39405F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbhE1J5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbhE1J5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:57:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92990C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:56:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x8so2661390wrq.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SKhaIkLqZtYFgXCRRaCO8bgrlTOnI3H4FDNq1vp7Ako=;
        b=KEMhq2ywvjOHtCt75f3xdHZNjLGbPITPrcQ1SZ5H8DeqA9at3PkEmlebloBrgxmG9T
         rPVCvTItVCgFrh9dW23pe9L4dmXIhv/iTNCjBryCuaQ5nQyXmMXngU9WH9sh47WArrCv
         DnyMdd9D673iFAutUpOQVS+d2X0qd1mDCyRCDj5/iBlOl3smVR2HEwlfCs4WgeDEgYST
         YivVO9PxQlutbGA/RcXOTsT8sEeVLRyrXVb8T44keZ+FANMIcZ7sVodaNvoZMNAIjFaE
         B8EV+AwX+quK34v86CsMRR9lExXzKwE77vHtdiBkaBUEIrvjcX2oMfntFF6eSc064C+P
         fbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SKhaIkLqZtYFgXCRRaCO8bgrlTOnI3H4FDNq1vp7Ako=;
        b=R1YYascBafQKqeaiq48Gl9A9Fgw+8UVpKRHxEPlHH83K4a+77xdgRzU5JeOQlYW8nz
         STNZlRKjJd1mXfON84O7zuCzaf8jedxgcdoHRwcIYi+h7y0rMiw7aGdXtsdRlouQPUBu
         fhUjh1FJpwB4Pup8WD5ItPGTPlYx5cKHjnJipSCVRcA6/4oDdXE8GTfKrC+5RPOErsve
         pHs/1F0eR2gPsmckwNiqEKLpdGkonAleqB0NpgWV2EZ4TGTKxMWl7HpsJkZByXr4XOHq
         JPHiwJgCc0eHXcu3ANgRVL3lFiNR1X6avbb+nBaC0gf8uO6gfRrYcgYsYCZ2zpHVYVjn
         tA7Q==
X-Gm-Message-State: AOAM533YmxM60132722VOa9Sc53ITstNQ6BNXnw2k6LhyZ3nIdEJpR8R
        FQk5kW2d8O8A0rc4lAsDvWnjEA==
X-Google-Smtp-Source: ABdhPJzZ/XVsduDpftFgMw6hi0yzlNKkh/soPNLBIwrQSiuVSRDLkbc9dOS8YzxinrLtpsxFyYy2YQ==
X-Received: by 2002:adf:bc07:: with SMTP id s7mr4963114wrg.301.1622195759186;
        Fri, 28 May 2021 02:55:59 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id x65sm8721045wmg.20.2021.05.28.02.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:55:58 -0700 (PDT)
Date:   Fri, 28 May 2021 10:55:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 05/15] leds: leds-as3645a: Fix function name
 'as3645a_set_current()'
Message-ID: <20210528095557.GP543307@dell>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
 <20210528090629.1800173-6-lee.jones@linaro.org>
 <20210528093150.GN3@paasikivi.fi.intel.com>
 <20210528094000.GB2209@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210528094000.GB2209@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021, Pavel Machek wrote:

> Hi!
> 
> > >  drivers/leds/leds-as3645a.c:198: warning: expecting prototype for as3645a_set_config(). Prototype was for as3645a_set_current() instead
> > > 
> > > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: linux-leds@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/leds/leds-as3645a.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/leds/leds-as3645a.c b/drivers/leds/leds-as3645a.c
> > > index e8922fa033796..c41937ff8fd33 100644
> > > --- a/drivers/leds/leds-as3645a.c
> > > +++ b/drivers/leds/leds-as3645a.c
> > > @@ -185,7 +185,7 @@ static int as3645a_read(struct as3645a *flash, u8 addr)
> > >   */
> > >  
> > >  /**
> > > - * as3645a_set_config - Set flash configuration registers
> > > + * as3645a_set_current - Set flash configuration registers
> > >   * @flash: The flash
> > >   *
> > >   * Configure the hardware with flash, assist and indicator currents, as well as
> > 
> > Thanks for the patch.
> > 
> > The entire comment could be removed. It's wrong and doesn't really tell
> > more than what you can read in the two functions below (the two are result
> > of splitting one the documentation was written for).
> 
> I just took the patch, I'll happily take a follow up.

I'll follow-up.  No problem.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

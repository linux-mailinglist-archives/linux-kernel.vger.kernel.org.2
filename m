Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646FA33380B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhCJJAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhCJI7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:59:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F9EC061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 00:59:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso10448524wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 00:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Numor//xklH37BH1apB8OWJTxrcnrW9V5SsOFLfaiS0=;
        b=C/ZuH1eryK9mb4HJf+c0Jss6Nk4Cr32zDnRnQsHusqPeZq/00fhMxgUI8gNpfMjMeR
         XxQ6aG5htj73IvULLG3i92OuMLnO8y33KUnGcAT9tVG+g94WWWdjnH/aK7X1rfmxjBg+
         g9M/hWFhKlR5MJUafzxQAe//C3+P8car6lQk/6gWhx86fAY4vQq+OFlPfUsxbdarrwrO
         n7RUfeDA0E3sPwu0pi4Po6KOEr95nbZzll8VvcN7SX/EFrbwkAHmFwLfZAilAkBBgMv4
         JvMn0PalYHRjVVDBPENIjvoDsabqGE8KZhuXzhIdNhKAnvDyiSfvOP1TFpnRvrcV8cDZ
         Jksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Numor//xklH37BH1apB8OWJTxrcnrW9V5SsOFLfaiS0=;
        b=stGO4SWT8wc5paRFtfaEfLvB5MCOdbQRbnOxSibBrzQhFj3Ac2MY/PCsCFjqkRIwEH
         LZIdB2tXLHwwo9F+AybZULrh6QxGeaiNSVsnCRE5QdBrMiJ+/Nis4s868k+JmbPlPjjS
         xTk6QUeognDYpUHNOLWR837pPt5YWaw2Mm297G5IbdPhRWpa97+xJHppbfE2lylaLvZD
         ACt5vf41FyeauosRnGE53sgP/NtymjHU9yBZy5vcM8hnz1CD1W/OyUXsZmdULGIzkRkR
         o8vuXNWJTzedrJdXP77Ip8F/4mJEUvJBMi6PEYwwiW05U8G7LUbmaROCkP8luK7DIh/A
         W68w==
X-Gm-Message-State: AOAM531NdGgOXqupptIW7WpPNcBVJ3c8o223xZIivekHBD+JCb9Fr0cA
        aJq+8wuNEa0SW2HrbOl1QamjYA==
X-Google-Smtp-Source: ABdhPJxcuOIPUhMTUvr75q0rGDKEEBQHgxwWTHrS1arnd6JQKcQs+QGdoqcE3fNdGGMvy9ZGv+qnnQ==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr2219008wmc.161.1615366779478;
        Wed, 10 Mar 2021 00:59:39 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id h20sm7942228wmm.19.2021.03.10.00.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 00:59:38 -0800 (PST)
Date:   Wed, 10 Mar 2021 08:59:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>, arnd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 08/21] clk: clkdev: Ignore suggestion to use gnu_printf()
 as it's not appropriate here
Message-ID: <20210310085937.GF4931@dell>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
 <20210126124540.3320214-9-lee.jones@linaro.org>
 <161307142704.1254594.1986201109191269158@swboyd.mtv.corp.google.com>
 <20210212093620.GG4572@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210212093620.GG4572@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021, Lee Jones wrote:

> On Thu, 11 Feb 2021, Stephen Boyd wrote:
> 
> > Quoting Lee Jones (2021-01-26 04:45:27)
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  drivers/clk/clkdev.c: In function ‘vclkdev_alloc’:
> > >  drivers/clk/clkdev.c:173:3: warning: function ‘vclkdev_alloc’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> > > 
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/clk/clkdev.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> > > index 0f2e3fcf0f19f..5e5f25d568724 100644
> > > --- a/drivers/clk/clkdev.c
> > > +++ b/drivers/clk/clkdev.c
> > > @@ -153,6 +153,11 @@ struct clk_lookup_alloc {
> > >         char    con_id[MAX_CON_ID];
> > >  };
> > >  
> > > +#pragma GCC diagnostic push
> > > +#ifndef __clang__
> > > +#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
> > > +#endif
> > 
> > Can this be some macro banished to compiler.h?
> 
> This is probably a question for Arnd.

UPDATE: Arnd and I are working on a solution for this.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

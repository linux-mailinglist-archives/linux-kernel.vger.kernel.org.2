Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87019347BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhCXPLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhCXPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:10:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0D8C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:10:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id e14so15252652ejz.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/j9PEEh4R8Qp4EDM0hjxJTIthQEU1yC7y8OZZJlS35E=;
        b=c28W0QmcCyorrh1sjLJz0z7tZQK1EbSURZWoBwl5fqV1FGPVD+v9EqV0hvPLR+8un9
         kqVwqSK9DRYC5bxTC9wzH54Xm7BxddZ3Pjaf6DYETzyJ7dtWj+lNQJqwpFBql1rl3iSy
         85r//uXe+9UtaR5kTdwPBoqk1kXKRLD17B2khf6i3KRDfS9S6S/lN03hHegB+L/vMACg
         rAgCaF+tnyJZ4lFCYh8tI+NHwU/u2u/geEXI1m62e/46QZmzoMvhdo69binGpgScLGn3
         cRU1xTvGTpoAkgF7MCD39PtfCiPAJhjPxMnGshwBWreTZD0+c25yF6KHwdPC8HcqeM2f
         pV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/j9PEEh4R8Qp4EDM0hjxJTIthQEU1yC7y8OZZJlS35E=;
        b=K/ExCcd8A6Yf9HaNmnXUyMJod9ARJ1wITsZlHWMnADXdk8c277aWhI+MypokPy1OBV
         o3iHzzzedBQ0IXU+8BTdkwUfqUUu5KrUoA76F7JaXd1Jeb+BcIATQD37+EwWuG9M8dbY
         xpNnL9cBErzpbZCWe4PLI6XeQGUjGTrLCqgflH834nJgI33Gk2hMCsFe4QQjlLc2uNoW
         zHdJc/42FS4/yjN39unvp5swSbohndsKjktk5Bz88JhQ+PN6Z8GezlpfWsTE+D53l+u9
         QoClG/H0jKaUHWD+RX2F+ZMgYM2oNM40Mu1agf0ehZIQA8/xtECQ8rlmsaU+pfv2aXxD
         NCSQ==
X-Gm-Message-State: AOAM53205vqATR4JmZNw1zkSqaGraQGuKE9NnxPOwZbOpmljW9dXEjyR
        2UgACRG4/7yUwJr/Vf0Zs3BuSxfMuLdrjA==
X-Google-Smtp-Source: ABdhPJxTRi6uOEx9Ujb/0Z7C32+4MI+ltxVhdKbNXhkR8bRKV7Tzaid74UWYhGmf/DNXl7REvK4Dgw==
X-Received: by 2002:a17:906:aac5:: with SMTP id kt5mr4295517ejb.548.1616598637538;
        Wed, 24 Mar 2021 08:10:37 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id wr20sm1043863ejb.111.2021.03.24.08.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:10:37 -0700 (PDT)
Date:   Wed, 24 Mar 2021 15:10:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <20210324151035.GO2916463@dell>
References: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
 <20210323123433.45371-2-andriy.shevchenko@linux.intel.com>
 <20210324102931.GH2916463@dell>
 <YFsW26BH1LZM9ZBs@smile.fi.intel.com>
 <20210324104729.GL2916463@dell>
 <YFsgf9J+hQjfrZCb@smile.fi.intel.com>
 <20210324115033.GM2916463@dell>
 <YFsv6DijMMiv3D10@smile.fi.intel.com>
 <20210324130723.GN2916463@dell>
 <YFtKo4IrOGWoX6O3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFtKo4IrOGWoX6O3@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Andy Shevchenko wrote:

> On Wed, Mar 24, 2021 at 01:07:23PM +0000, Lee Jones wrote:
> > On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> > 
> > > On Wed, Mar 24, 2021 at 11:50:33AM +0000, Lee Jones wrote:
> > > > On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> > > > 
> > > > > On Wed, Mar 24, 2021 at 10:47:29AM +0000, Lee Jones wrote:
> > > > > > On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> > > > > > > On Wed, Mar 24, 2021 at 10:29:31AM +0000, Lee Jones wrote:
> > > > > > > > On Tue, 23 Mar 2021, Andy Shevchenko wrote:
> > > > > 
> > > > > ...
> > > > > 
> > > > > > Also, past acceptance does not guarantee ideal/correct usage.
> > > > > 
> > > > > In this case it's hardly can be misused. But I heard you.
> > > > > 
> > > > > ...
> > > > > 
> > > > > > > The semantic is min-max range and having two defines (*) here for these seems
> > > > > > > to me as an utter overkill.
> > > > > > > 
> > > > > > > Of course, if you insist I may do it.
> > > > > > > 
> > > > > > > *) since value is the same, we might have one definition, but it will be even
> > > > > > >    more confusion to have it as a min and max at the same time.
> > > > > > 
> > > > > > It's just tricky to decypher for people who do not know the API, which
> > > > > > is most people, myself included.  For APIs like usleep_range() et al.,
> > > > > > obviously this makes no sense at all.
> > > > > 
> > > > > Seem like you are insisting. Okay, I will define them. What do you prefer one
> > > > > or two definitions?
> > > > 
> > > > Actually I'm not.  I'm just trying to get my head around where the
> > > > data comes from and what the values actually mean.
> > > > 
> > > > > ...
> > > > > 
> > > > > > What defines a vector?
> > > > > 
> > > > > The combination is solely of the driver-hardware. Driver explicitly tells that
> > > > > how many vectors it may consume (taking into account the range asked) and API
> > > > > returns amount given or an error.
> > > > 
> > > > So, where does the information actually come from?
> > > > 
> > > > Information that comes from a datasheet is usually defined.
> > > > 
> > > > Information that comes from the F/W is usually read and popped into a
> > > > variable.
> > > 
> > > It's a two way road:
> > > a) driver states that it needs only 1 vector and it's enough to it
> > > b) hardware must provide at least 1 vector to be served by this driver.
> > > 
> > > Look again into grepped output. Most of drivers that define it as an variable
> > > may dynamically adapt to the different amount of IRQ vectors. When it's static,
> > > usually drivers just hard code those values.
> > > 
> > > I'm really don't see a point to define them _in this driver_.
> > 
> > That's fine.  I just felt like I had to ask.
> > 
> > Would you consider a comment that lets people unfamiliar with the API
> > what the values mean?
> > 
> > Something to the tune of:
> > 
> >   "This driver requests 1 (and only 1) IRQ vector"
> 
> 
> Rather
> 
>     "This driver requests only 1 (and it's enough) IRQ vector"

 "This driver only requires 1 IRQ vector"

> or something like this.
> 
> Should I send a patch with the comment included? If so, please suggest if it's
> good from English grammar/style perspective.
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB693106D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBEIf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhBEIfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:35:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAD5C061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 00:34:20 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a16so7397966wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 00:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HHfAd0jRqxl9Kf+Um9ET57/jEyDsj3IKhyTUCMrpEZU=;
        b=CTDnrnQM7qmmnnZvHQPCdGrpgM/joh0kwHoiGqQN3K7HvYA5M7wPDDJeovg1fl+Zn2
         3Lg94szTZ7VrXAb0CgkcbqrHYOmhX5e12lNNCCE7ruWJ/UitZthWhS4y+S0hHkJKgH/T
         A7vIFAbEgka0i9LYWguUIC9rfUWMJ9t0EvwrnQqhcKTA+BI7Kw/LQC5370GUt0VQGlIf
         yZR6fO37+siVbiu2souUX3kW/rF9LLfDyDCJwypUCF/83EyJhjW2WQD4On0uVzdZamND
         5sHNemVh2o/ASn78BzXK/PoYo1VQq16aCqCHlQB7EFwvCQ4N2G8IM0OkTyqwyuKwuLim
         mong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HHfAd0jRqxl9Kf+Um9ET57/jEyDsj3IKhyTUCMrpEZU=;
        b=qZTf2Avxb4zegBs8ljAAWu2d1zzRZesJCBY/hXFkyYl2m2bup0Ku+mSpoO6Ty0uK1M
         wj/ccyYqoEO4itdCtUbwprsyfyKUyaeu7WYCI86E0HHTV5fuZTFeMjoJDCJmEgiBqwvz
         Cye1teO6X7uYttc5lpwgdmVvpCArJT33l95q59H+e0B+IwUq3J3t9ld7zm3digdbs5x1
         sYTgB4FonAVnqcyMExMyBRxeTnPvTWZFuEEWxEri/xwjm5dbJdRsk3Qp3eAR2K0Cqj1M
         vYF0F0ZyTX9NL4JY8yFjKIWLrfJ80BHTz1BpCkUF3HPjZjj1Cvd+uNWam3nkUSDgx0vV
         3fow==
X-Gm-Message-State: AOAM5303WJkx36cbpyTSUXwIrGHmGic5rLEQDrrRDXFCN/oPKgndlMt1
        gqYblVItRUWlCp9ElCbSL3U6Bg==
X-Google-Smtp-Source: ABdhPJz17JjsWyci4e4xB1qYeMq8I1U9C4tvNzbHDmfHrivo4QRg3R2AccWKsjN6ESqU/VF+NvlE4g==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr2616892wmc.65.1612514058703;
        Fri, 05 Feb 2021 00:34:18 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u4sm10921969wrr.37.2021.02.05.00.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 00:34:18 -0800 (PST)
Date:   Fri, 5 Feb 2021 08:34:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 4/5] ASoC: Intel: Add DMI quirk table to
 soc_intel_is_byt_cr()
Message-ID: <20210205083416.GR2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
 <20210204140515.GC4288@sirena.org.uk>
 <20210204150456.GN2789116@dell>
 <20210204151139.GE4288@sirena.org.uk>
 <20210204154058.GP2789116@dell>
 <20210204194213.GG4288@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204194213.GG4288@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Feb 2021, Mark Brown wrote:

> On Thu, Feb 04, 2021 at 03:40:58PM +0000, Lee Jones wrote:
> > On Thu, 04 Feb 2021, Mark Brown wrote:
> > > On Thu, Feb 04, 2021 at 03:04:56PM +0000, Lee Jones wrote:
> 
> > > > This set has all the Acks we need to proceed.  What's blocking?
> 
> > > There's the subsystem maintainer...
> 
> > I assume that was a question and you meant "where's"?
> 
> > Pierre is listed as the Maintainer.
> 
> I'm fairly sure you can see what I meant here and why there might be a
> concern.

So that should be a Reviewed-by and not an Acked-by then.  That's fine.

What do you want to happen with this set then?

You want it broken up?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

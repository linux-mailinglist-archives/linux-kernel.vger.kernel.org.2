Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF02312BF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhBHIhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhBHIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:34:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76127C061756
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 00:33:54 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a1so16044189wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 00:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dzjEN7YVqtaqujbmGYSzD3fjsYLPescY0ifkDBXkqLg=;
        b=xRoKiOu2+Jjnk8RdzCfADbsl30nmGTuZ25PnHaVNy9IPtE+SMpyLz05zta/V+TXk2L
         3Snk9K1/beMrfzFOmEGycXni6ruIfzt2A229bO0/ZS6tQXnO/GhQSzhsdsiFJK9E2VBz
         wQ4BCB9Y66TgNvHI+oUt+w879mPpRFGQe4RRjAwR+rrv9vUqy0VtEmRoYePZ4Xngos+D
         oSjF9KHPmbPIIih+toMXyIPOc0eSokDNhtP45NuUJnIZc+4m61nRJSRclrxvzykvYX/n
         F5ydFlQGMWh1pFfQSaFQy1E/hNfpsQuuMQdS66Rvu1GJQHOgz+LHcYNUmfDKCF+wjgLZ
         zjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dzjEN7YVqtaqujbmGYSzD3fjsYLPescY0ifkDBXkqLg=;
        b=oMzH/YVcCVQX6SYTXfiXHLrqSXRFDP3x/ci17NBKZqAbfNcI/ohG3hp6m1pjspx9r+
         0K406tULh4p++XtUGE4yh17DILbEPznsT9JwOGL66JludyWmWjFNNP05mNDUsRaUjR34
         w8m70bDmpITdCBpdiHjrEnWFTaUXTcOtnRGc0UrsO8OXCTsWT3r1VpnY8XsC1NrHHrY8
         knrea9cfUDvjH1jL6oK3wPotOhbr5qMyne1aGnVNs4OlSjr1bl76V2XwDa3W1f5HL+Et
         6cqLPB8UYQPAf3huTQOZTuKydBf0pVrzC+jCAT3pfeYy/8UbHUVxzqQs7pB6hvuXDYF7
         KX+Q==
X-Gm-Message-State: AOAM532Uix6a9t6mhrmi6nq2B+d7UfbeogBxnmc9ZHzaNWeb95+3NVgs
        FWcsoufxLxt8DsqZ1GFCByZaOg==
X-Google-Smtp-Source: ABdhPJwZGtkWXy3XxqyySRsvK8yAbf1VqsSaowxqAHFyvXDRFGKSdrHBj876+06i47XwvXOOK4AuXQ==
X-Received: by 2002:adf:8b47:: with SMTP id v7mr18339833wra.133.1612773233172;
        Mon, 08 Feb 2021 00:33:53 -0800 (PST)
Received: from dell ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id l11sm26193998wrt.23.2021.02.08.00.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 00:33:52 -0800 (PST)
Date:   Mon, 8 Feb 2021 08:33:50 +0000
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
Message-ID: <20210208083350.GA4766@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
 <20210204140515.GC4288@sirena.org.uk>
 <20210204150456.GN2789116@dell>
 <20210204151139.GE4288@sirena.org.uk>
 <20210204154058.GP2789116@dell>
 <20210204194213.GG4288@sirena.org.uk>
 <20210205083416.GR2789116@dell>
 <20210205211101.GL4720@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210205211101.GL4720@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Feb 2021, Mark Brown wrote:

> On Fri, Feb 05, 2021 at 08:34:16AM +0000, Lee Jones wrote:
> > On Thu, 04 Feb 2021, Mark Brown wrote:
> > 
> > > On Thu, Feb 04, 2021 at 03:40:58PM +0000, Lee Jones wrote:
> > > > On Thu, 04 Feb 2021, Mark Brown wrote:
> > > > > On Thu, Feb 04, 2021 at 03:04:56PM +0000, Lee Jones wrote:
> 
> > > > > > This set has all the Acks we need to proceed.  What's blocking?
> 
> > > > > There's the subsystem maintainer...
> 
> > > > I assume that was a question and you meant "where's"?
> 
> > > > Pierre is listed as the Maintainer.
> 
> > > I'm fairly sure you can see what I meant here and why there might be a
> > > concern.
> 
> > So that should be a Reviewed-by and not an Acked-by then.  That's fine.
> 
> No, it's that there's plenty of drivers like this that are listed in
> MAINTAINERS but still generally go through subsystem trees - this is
> also true of for quite a few MFD drivers, you tend to get a bit annoyed
> (quite reasonably) whenever I mistakenly pull MFD changes for them into
> one of my trees without syncing with you.

Driver Maintainers in MFD don't sent Acks.

> > What do you want to happen with this set then?
> 
> > You want it broken up?
> 
> I guess, or at least a pull request so it's in my tree and I'll notice
> any coverage issues.

Okay, I'll process it.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

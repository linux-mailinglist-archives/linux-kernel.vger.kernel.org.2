Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA930F6A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhBDPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbhBDPln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:41:43 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76567C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:41:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a1so4049210wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dOiRiQ9oHUZ7TVaPDhFx1L3SPFp6id1hbOQ7qHtfF0Q=;
        b=Z/zB5uJnxrsopt//QvpTD9g6mM8lgWfSZYCbMfgBtPFI13huRpsQXbvjpNBz1kqGo7
         yD0M2i2ywa8zJ3ZJ6DAq2V+Tyv0E5i8QOYb30N1BlY0gyjpCPbRRAYAhaMKzh2fOSISp
         QdxOJcz72OkWYSrZ7Jr6CN+RxpsJu1hricNzLTKXsKpjLMyGHBHq2XdAgYkz/NLYWgKT
         Tw4Q1QgNH22jI1oXKR1gGQwgzW3uiKnq4b/YCxEg3BCu8ITSwbc3b5B5mmSqiNXgDW3c
         VctzYl2LAIkHhYmW+qAje3XCkdfMGNaUePndPUXFCfSKulH/4AD6+lsATCFTLsQwv4wg
         08ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dOiRiQ9oHUZ7TVaPDhFx1L3SPFp6id1hbOQ7qHtfF0Q=;
        b=ojXS/1uwT116VUUwht/4pL+iYnK7a2vgdVFhLpC9rFx/5mxuq5K7gFxIimu2xJkFm5
         /ZZ42esiyPYe0uz6tfU8PaBNv7fFf7CsjzgJhUTADhAX0rgrJkOEe+RGiya7yQ6UYzW0
         RU1cZABAWAyA+vE7UcuCbNdH/EbtwaPCEwT8iwa8Ckiab3kQ9m1hODv8Fi0xq/HuJbch
         UZQfv24Y/lM1kisWrv2aB8Rm2B40SXUNjrsiSQr6vM7VplkIE3JqCiZhJxGiYNLlLfwK
         fX14JPlPdEt8ocxdl77mqE0Q9rcTL3ovKw/smmCGLV2b06CmIQjAvZsBxWA02hviWurB
         bkpg==
X-Gm-Message-State: AOAM531O+sDiC3Ert+Lw5SPibvpqn2BWWSWAw3Yrr33Cgh6vZw9Us0h+
        Avcz8+cS49L43S+Oyp+HTXpWEw==
X-Google-Smtp-Source: ABdhPJzBm2W2BJMxu5DIvoNWvy5QIvZS8Si6KmkT/C/WupGvJ0j2eB7yrbUaANwc84Gx0e2xC89ORQ==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr10054615wrw.255.1612453261248;
        Thu, 04 Feb 2021 07:41:01 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id x9sm6947710wmb.14.2021.02.04.07.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:41:00 -0800 (PST)
Date:   Thu, 4 Feb 2021 15:40:58 +0000
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
Message-ID: <20210204154058.GP2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
 <20210204140515.GC4288@sirena.org.uk>
 <20210204150456.GN2789116@dell>
 <20210204151139.GE4288@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204151139.GE4288@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Feb 2021, Mark Brown wrote:

> On Thu, Feb 04, 2021 at 03:04:56PM +0000, Lee Jones wrote:
> > On Thu, 04 Feb 2021, Mark Brown wrote:
> > > On Thu, Feb 04, 2021 at 01:56:16PM +0000, Lee Jones wrote:
> 
> > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> > > > Applied, thanks.
> 
> > > While we we were just having a discussion about what to do about this
> > > stuff...
> 
> > We were?
> 
> > This set has all the Acks we need to proceed.  What's blocking?
> 
> There's the subsystem maintainer...

I assume that was a question and you meant "where's"?

Pierre is listed as the Maintainer.

What is a Subsystem [0] anyway? ;)

[0] https://lwn.net/Articles/844539/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

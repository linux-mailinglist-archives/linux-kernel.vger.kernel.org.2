Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BEB30F15F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhBDK6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbhBDK6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:58:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71DEC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 02:57:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u14so2985818wri.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 02:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nocxNX1m/RmA6R84CLxOUSJCE+/r8BYx+U1OCnvydU0=;
        b=Gnt4JV0GxJ1vbcUCH/UT+8kOIyaCBPKS4C1FCFPOEho7+3g889pjnLpaXAgHiy9TKs
         SjeWaUtBp7FTtLzUg47knpAZhhUvOgy3hNUPHNqCG1DZYlAWvJYet/QouFveffmpVuMU
         vLUlidxRLXrUO0Wnbixs+T+zr2cj4YXcI4dp5112q3jny/dF/iWvCKvj6Fd2THnVW13n
         UcEuTgyniZ1LoniSe9hCyMYz+ANb6z4q5YZolF1bsWdu6DN5OeFH++5EylcYULDOsyDd
         ISwqvcJy4DElz339yuKbPNVNy74adJQ0gnyLT5pJhNxqBnJZXN6pQH82p/TKhc4GNKhF
         djDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nocxNX1m/RmA6R84CLxOUSJCE+/r8BYx+U1OCnvydU0=;
        b=lJjpFY19Wt43b29AqYfdrUVn9eJfhmotcXIgocLT3bNzA6Dy9RqKpoG+AFNq2LkLjh
         hMSvR85S7j/p+ASAw0vuBL1Z4rlCNFOU86Xp5x8d4SPijwLgl4wTbzuJg8LODr3dVrWW
         3bz6wqs61sMqSdo2mftxaqck+wHFEpw52fPEauCwebdVOyBF0BtO1BdzbUHFK3P2zkgS
         6zTfQ/4EpNV0jaIlvve3eIcIggcq2lSODIq9+vTAylO9VURerIFQ0LDjQ54alrV2MY45
         5lQzRqnLlm8CT+0Zcx65S5h1LdYTitFj1fQikSgZiZVdGGty9iFAq+J75KiVzDMGY+2J
         GmRg==
X-Gm-Message-State: AOAM531NGYzbBKB+3lo7RHfT+/O4ZCTX+1JKvSkEX9cdrj+kjTr7OU7v
        20N/N5ks+ylAV/aEx/5kHy4mMg==
X-Google-Smtp-Source: ABdhPJyPrp1TNZvAIM6xnfQzKB+NJLudNAYIGYbk6dBD3LYfnADWLY2wVrqxESzEld1Mkr2tXBePWg==
X-Received: by 2002:a5d:6510:: with SMTP id x16mr8388898wru.175.1612436270633;
        Thu, 04 Feb 2021 02:57:50 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id k15sm5688943wmj.6.2021.02.04.02.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 02:57:50 -0800 (PST)
Date:   Thu, 4 Feb 2021 10:57:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards
 with WM5102 codec
Message-ID: <20210204105748.GD2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Feb 2021, Hans de Goede wrote:

> Hi all,
> 
> On 1/20/21 10:49 PM, Hans de Goede wrote:
> > Hi All,
> > 
> > Here is v4 of my series to add support for Intel Bay Trail based devices
> > which use a WM5102 codec for audio output/input.
> > 
> > This was developed and tested on a Lenovo Yoga Tablet 1051L.
> > 
> > The MFD and ASoC parts do not have any build-time dependencies
> > on each other. But the follow-up jack-detect series does have
> > patches depending on each-other and on this series. So IMHO it
> > would be best if this entire series would be merged through the
> > MFD tree to make merging the follow-up series easier.
> > 
> > Mark, if that is ok with you (and you are happy with the ASoC
> > changes) can you please Ack this ?
> 
> I believe that this series and the follow-up:
> 
> "[PATCH v4 00/13] MFD/extcon/ASoC: Rework arizona codec jack-detect support"
> 
> series are both ready for merging. All patches have Reviewed-by and/or
> Acked-by tags now.

I don't think they do.  You're missing ASoC and Extcon Acks.

Not sure why *this* set fell through the cracks though.  However, it's
now on my to-review list.

If I can work fast enough, maybe this series can get into 5.12, but
the follow-up still needs reviews.

It might be best to collect the *-bys you do have and [RESEND].

> I guess it is too late for 5.12, but it would be nice to at least formulate
> a plan for getting this merged after 5.12-rc1 is out. Given the
> interdependencies I still believe that it is best to merge all the patches
> through the mfd tree and then have Lee provide an immutable branch for the
> other subsystems to merge.

Yes, that's fine.

> Mark and extcon-maintainers (for the follow-up series) may we have your ack
> for merging these through the MFD tree ?

Ah, you noticed that too!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

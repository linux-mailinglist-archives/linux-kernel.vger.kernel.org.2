Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D835130F473
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhBDOA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbhBDN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:56:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D69C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:55:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m1so3072049wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4lmQaGfHzcMwGXIZmc8Kdp166D/+3+SPGhElADZc+zU=;
        b=hfB2odMRJ/nQQOZXAWUWi4CnlyDrbOsYjUyCux2E4iQWi6/saISmFsSly4xM56718L
         8jlfJxPTZBXcqLkSDYSwM8U+FD94NayvxXgET1Ly9JSmdBTac4VbQNhsPn/Q/xn+luLG
         vfD8oQRrmBBNArlVsMvSpW30Ov1g9s96jQcPUf5PQcRnjuFzsz+4rUdp5PbguE3pmch3
         8p+eZO65gUrJdJJnthhRKqTUgpe0wB1zDXR78bRC+T4s9FLnt+dPgOzbKOAAI3bGuf9j
         LO9zLdcW7/VeYooRjbmdnVJQNXy1SXQVrL/fF6ppDNuxPJwr/bFmYvodaVHZZoP60+C8
         NcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4lmQaGfHzcMwGXIZmc8Kdp166D/+3+SPGhElADZc+zU=;
        b=e1lH24V8BfUw9F8fuGkISYFh8FYqMxke0ngRvBlKcBfzFdVTcKcw60AyX1mXGhDNAM
         2PARkPd2PlMTdHi90lSMa60+1H+j9uwgzaG6b9I8MVAojXdkWK7xGQ3wmOz5M/CFB/kz
         RByRHnlwrOM/J02/lrglrTaZ7QC3ySs2EWDUUSg7Z5N39uT4ig4xArPGwb1CM/Nku3oJ
         4OjW9k9lGhZfCncuaLfKwULaPVClMKbAnGHz8I98OkKJGM49xP97Rr42hNbJJOaRJFU/
         CXLOhGUkxa8FnlUDxWuCKUlr6hqHWksKJrvH9GL4gaetN4qrpolQxNf35VaY9sfqQTH8
         oDRg==
X-Gm-Message-State: AOAM530FKD7zIeR+uMMQ/+dpvaUyVCjckhU/bsRiMTLLZENfBeVLpl2J
        Hm9rXDIS5GMz6ITqZXTYhGvxxQ==
X-Google-Smtp-Source: ABdhPJz5DJ0+mbJg+bLCflgpSdIpVUfIHXnDHuI1F85rL98t01knyk7lbiguRXYZ2wBmk02Jd5s+DA==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr7652875wmc.39.1612446952095;
        Thu, 04 Feb 2021 05:55:52 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y14sm8245541wro.58.2021.02.04.05.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 05:55:51 -0800 (PST)
Date:   Thu, 4 Feb 2021 13:55:49 +0000
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
        alsa-devel@alsa-project.org,
        Christian Hartmann <cornogle@googlemail.com>
Subject: Re: [PATCH v4 3/5] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
Message-ID: <20210204135549.GK2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120214957.140232-4-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021, Hans de Goede wrote:

> The Intel Bay Trail (x86/ACPI) based Lenovo Yoga Tablet 2 series use
> a WM5102 codec connected over SPI.
> 
> Add support for ACPI enumeration to arizona-spi so that arizona-spi can
> bind to the codec on these tablets.
> 
> This is loosely based on an earlier attempt (for Android-x86) at this by
> Christian Hartmann, combined with insights in things like the speaker GPIO
> from the android-x86 android port for the Lenovo Yoga Tablet 2 1051F/L [1].
> 
> [1] https://github.com/Kitsune2222/Android_Yoga_Tablet_2-1051F_Kernel
> 
> Cc: Christian Hartmann <cornogle@googlemail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v4:
> - Add a comment to the irq-flags override explaining that theoretically
>   DSDTs using IRQF_TRIGGER_FALLING could be correct on boards where the
>   IRQ controller does not support active low level interrupts
> 
> Changes in v3:
> - Fix compilation error when CONFIG_ACPI is not set
> 
> Changes in v2:
> - Minor coding style tweaks
> - Use memcpy instead of for loop to copy gpiod_lookup-s
> - Log a warning when the ACPI "CLKE" call fails
> - Drop addition of acpi_device_get_match_data() call, as the code was
>   moved over to use the generic device_get_match_data() helper in a
>   (new in v2) preparation patch
> ---
>  drivers/mfd/arizona-spi.c | 127 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

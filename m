Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2292430F476
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhBDOBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbhBDN40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:56:26 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EEAC06178C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:55:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y187so3061780wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+zWXPoMWro9z8YmAH2sD5hl0vnIUc9rVzm7BOffQpxc=;
        b=m7Ec2oyeRYSUEI0DX38UiaNVijd0iI1QiTiChQCQm5Xvcwptz40gsINlaEFJi+0RWp
         0Quw5xqzhOJ7ifiayJlOJWMmHIaL3Q0jwjXl/VvvCPrZeEDEObSiUgMBcQjnmVW0wWrN
         Ub07GT5giot2k5sR9hxkYjycUjCNi0+rV4dUQm1rJJ2iVRiejiapEAPkcAnJ3S2ZFMxi
         uLBkNbq79CWniMwmOjryIutYK79xFxIRIVwlcvUEhvGEbb35yOnFvIhhaswc4g/m7cjx
         CLON7I3WIXU7Qy2thvi7X+mPKgkNSGAKuUYYyrNFjyKcRSFyrDOirMRi+izqaUMuPmec
         FpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+zWXPoMWro9z8YmAH2sD5hl0vnIUc9rVzm7BOffQpxc=;
        b=anDmLYeLoB1Uwkihqmv430K6ClFuo8rBSmlhmHMm2qmq0OPSZIu9MsYzx8WG5GeP6e
         mw5FlxmpFstpXdzUwz9X6E9mRoysvcnZTXIzHQm5fQU33/1CKncmKNkOvldIKXWWZEiJ
         hobfVYP/0ojOglX3nOvc5x6CCni8ZJFceSIFn9xU5GbnVuzPByL1Yr6z0Vf+V8ZJCURD
         7fbqVmjwn4hgqxpOZ/ttI3PYa8HWuz4ajR6d7hnpDhq+c57RrDlLX8kPxKJ2rdFMSYUx
         vuRIyUDvuH0Kw0NYQe/IcAEMBqdOm1YzStPRwWJ37RhYq2zCL/dplbvxJSGt7QOCQ/wS
         bRZg==
X-Gm-Message-State: AOAM533oGOj8uzPxXTY2Fe2lYQxt3EJQLtrKMXUZPy4dIiY7L85SO22r
        kDsjGSzuOWogW43yzwAckYqwLw==
X-Google-Smtp-Source: ABdhPJzcQL5JyoVR8CeS1RAcBqswo1ZPxXP5b1mnWO7335qavWdyOdHHkdriZYbHAmaSLHb6abh7PA==
X-Received: by 2002:a1c:9c01:: with SMTP id f1mr7325353wme.159.1612446927456;
        Thu, 04 Feb 2021 05:55:27 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id 13sm5464521wmj.11.2021.02.04.05.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 05:55:26 -0800 (PST)
Date:   Thu, 4 Feb 2021 13:55:25 +0000
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
Subject: Re: [PATCH v4 1/5] mfd: arizona: Add MODULE_SOFTDEP("pre:
 arizona_ldo1")
Message-ID: <20210204135525.GJ2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120214957.140232-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021, Hans de Goede wrote:

> The (shared) probing code of the arizona-i2c and arizona-spi modules
> takes the following steps during init:
> 
> 1. Call mfd_add_devices() for a set of early child-devices, this
> includes the arizona_ldo1 device which provides one of the
> core-regulators.
> 
> 2. Bulk enable the core-regulators.
> 
> 3. Read the device id.
> 
> 4. Call mfd_add_devices() for the other child-devices.
> 
> This sequence depends on 1. leading to not only the child-device
> being created, but also the driver for the child-device binding
> to it and registering its regulator.
> 
> This requires the arizona_ldo1 driver to be loaded before the
> shared probing code runs. Add a softdep for this to both modules to
> ensure that this requirement is met.
> 
> Note this mirrors the existing MODULE_SOFTDEP("pre: wm8994_regulator")
> in the wm8994 code, which has a similar init sequence.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/arizona-i2c.c | 1 +
>  drivers/mfd/arizona-spi.c | 1 +
>  2 files changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

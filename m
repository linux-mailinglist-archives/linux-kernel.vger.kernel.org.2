Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F0830F421
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbhBDNqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbhBDNo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:44:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB564C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:44:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u14so3024911wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lRYvK8OMCHMkGJ2UxDzBQw4RlWR868ddrnX7Z1FGiaE=;
        b=pLL+20zrB9hl28++h/IR1o2YCSmZmIf5uu53yfbCqmTn/GZq1rYk3NXwhAgyCeDGMz
         R409AufnzRdZR4WCxmB2ee4unGmyIRglDmFztvuGFFiIFt2L3P3F7dOqMkaPRyaUSqab
         Pkw4P1nrlPS7PZsfftUX+MDdPClggErzmSBDWJEtKONddf2Q6uTi1KUC7T3jGFyJZxwF
         Ekm84/ShbsXU9wiR6mhxBnMQJSKkLvzNtOvYfwUbh2KUN0fmGkF1g0hLalY6g9UPZA6B
         U3elBRmhyNZQG3jsNj2V4E4I6Pf+AWCXfsxYQhbq9UFfLfhDoPV3WoV9J649PZa5Wdkc
         Et+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lRYvK8OMCHMkGJ2UxDzBQw4RlWR868ddrnX7Z1FGiaE=;
        b=mf1zyPoEAsyoHPMWEHn7mgn8ZhvI1CFHH9W7eUBUmD5VqfR5dQ8vPWyOvCIvMlOF6u
         ORL6rSmV1t1O0voTnM7mJCTRKSQgr9dVrCZQmhll/iJoHwh80aeO46L5+u0B3yxk/8GZ
         5PMgtqk8AhhUgirNq5mhuSV7YYjijwC4vsynhMrQ5n+5q0pQQZA4Ah0vQIBD9rJN0yOc
         owAS0s9BwbbKPL05xmSkUfiIyr/BxFPVnswBxUt+A7S0AbuVPCpXYaYvQIe/bnZ2c4Nn
         8QNsu2FtzouEumIbV2v3Ru/7Fuf4pdczJgxJZr5dSyvdigNuUDoBMqFZRLdTNnKitDMr
         Hteg==
X-Gm-Message-State: AOAM532QWTlWs2MBWf4/RbdkAjTiTk+6ZrmpbdUDgs36j0tV4KrkFl3C
        vVSsDD1yD3UJ5jizGnYey8cVHQ==
X-Google-Smtp-Source: ABdhPJwV2CZpAqZ/stq0i/AuZHm4dX3DgAU4MuOT1GRlwq81uLSdldL7Plrh4nNTmdTSYpm7nIg+uA==
X-Received: by 2002:a1c:46c5:: with SMTP id t188mr7500875wma.170.1612446254671;
        Thu, 04 Feb 2021 05:44:14 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id f7sm7580855wre.78.2021.02.04.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 05:44:14 -0800 (PST)
Date:   Thu, 4 Feb 2021 13:44:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 resend 01/13] mfd: arizona: Drop arizona-extcon cells
Message-ID: <20210204134412.GG2789116@dell>
References: <20210204112502.88362-1-hdegoede@redhat.com>
 <20210204112502.88362-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204112502.88362-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Feb 2021, Hans de Goede wrote:

> The arizona jack-dection handling is being reworked so that the
> codec-child-device drivers directly handle jack-detect themselves,
> so it is no longer necessary to instantiate "arizona-extcon"
> child-devices.
> 
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/arizona-core.c | 20 --------------------
>  1 file changed, 20 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

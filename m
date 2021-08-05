Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775113E1408
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbhHELkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbhHELkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:40:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B8FC0613C1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 04:40:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k4so6164611wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 04:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+nlth2m2/8vEMrI+L6F6FH19lBWEC80x5zsmEulcRdg=;
        b=S59FAiqlqHkiyKe+HX/Y/AwMG03IFpd+AoQDLucqSXzXwnHWZ/iC0VztQ7OIZWFher
         K93Pc2O5O/jTdRON3ndmTxnbzUZ9mcRHvTl2EmnDez4bIlcdRbIPDLySFvFN530iaapU
         FE4vZHhEoaGO/hbZ09VaEXxQQp/oG+4t6Qpe+dTwph2VdtT+vRcl2O0kAwWlB6duk8Ty
         hcWzLBoIbHMOiTbq9Diix/vBTx+yaPK3oy3APIPjcc3QKrAqxqiL9LE/Z/9XbXp/2KPg
         XKzv7VbE8qrn1iJZVzNc/ZCZj6sRqOIrmVkpVY4bqSwSUKnO2S/jnNecvLeCo1PvwCVF
         PIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+nlth2m2/8vEMrI+L6F6FH19lBWEC80x5zsmEulcRdg=;
        b=kAnrthD+MgncGM9iGFPa4QkBQUEe2ViWNP6BYLJJCCjgrOf9HLLGPj66gPb0zG020X
         qEo/lnjOVSwh8oymLjKyyhz5NKPh2S8Z8XxtbGqRBRQ+WN1A5vJEQPqKoAPnmlLOcjvT
         tIh1yCrJ06sGBowlTTyXElE59+Q8i/b5e4mVE6FEWgyhDRAehGVDJKA7H5tsgQxdItUQ
         BjKUGUvcAuIC1cG7CUz/oDJK/1dcxUwns6fzIoWx8KNrg/9Dn1U8oni1BDr3UpZSpcm/
         p4AIKaxC1m+qG5XMcRUxhy03GiuYZihO/E13l/jUZGigD/PiMhXaGng/1nJTT6f37skx
         G+ww==
X-Gm-Message-State: AOAM532Fbw0LyYoQhXo704U8qTJGSlYM+6KXLEMGKhecFiie0hA/dkI2
        DbJxQ9ofPWW9KLrZgpgLt/l/MQ==
X-Google-Smtp-Source: ABdhPJzSmpuPIP2d34jUR2jqTDBFOBvYKrEVvvPQKSyNt2dSiaVP/k3rv6EG6BE3se58Rqfv/meEbw==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr4775150wrp.54.1628163615719;
        Thu, 05 Aug 2021 04:40:15 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id y197sm9290958wmc.7.2021.08.05.04.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 04:40:15 -0700 (PDT)
Date:   Thu, 5 Aug 2021 12:40:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH v3 1/3] mfd: da9063: Add HWMON dependencies
Message-ID: <YQvOHWAwG2xTIWMy@google.com>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jul 2021, Vincent Pelletier wrote:

> From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
> 
> Dependencies required for DA9063 HWMON support.
> 
> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> 
> Moved temperature offset reading to hwmon driver.
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>


Nit: Please remove the empty lines between tags.

And format like this please:

[vincent: Moved temperature offset reading to hwmon driver]

> ---
> Changes in v3:
> - moved temperature offset reading to hwmon driver
> 
> Changes in v2:
> - registers.h changes moved from patch 2
> 
> Originally submitted by Steve Twiss in 2014:
>   https://marc.info/?l=linux-kernel&m=139560864709852&w=2
> 
>  include/linux/mfd/da9063/registers.h | 34 ++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Once fixed:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

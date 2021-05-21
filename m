Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70A238C062
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhEUHI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbhEUHIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:08:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53837C061345
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:06:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso6258843wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x+nL5LLHhNX0KskY/LJ/8akA4byj0CUbulG2JAsB6Ek=;
        b=Hz45ZUlIBoW8tDP5zp4dhxoGg0s3nVc29H6kX7Wxs3mn8T3hEY5DXS7rzdYcRZVaMO
         +MPIYBtuFIqf3G4YmaRpRLkmmRxraX3NP+M0WI4Hh0ifqSixT9jzm9wVKoBgu3sq8GWx
         qG/mgWdg9/M5/1F3RugvAz3VaKisDf9knLnyYaRiv076xz5ibyU2rODoZjEjucnawCM/
         WSL4Uez73892RUPB2x7iPjhEznm11hPaezSBsVDfsdOldc4OCnU89ouUj42MOkhRJSi4
         XmzW9d7TgXEauWJC29rcnqt608IWkSVXfqME3SrlPIq4TdQSxqPqpsCM2UyevfL5Y3x5
         78+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x+nL5LLHhNX0KskY/LJ/8akA4byj0CUbulG2JAsB6Ek=;
        b=OoeGeKGUQAcParOnoDQiwxtNA572wS2C9Wgm+/0w6cVKHkWw3KejBUCZ2GAGhEfA8X
         Iu2lyVSPDQHWwZTg1K3Y2R+U/8SM57/3soGJIw/Nhtp/iJf5mCMTuah4tEBT35zS+lzb
         g+OaWsXpYY5bxeoi86hxABIYqojATBUKD212rtmMdqL+1313uWb/8L3/kwKVgAptISvp
         jrWo3T+obKHHdIN3SG2yUGaxXHv8LG/kz0JK7Gd3WPMQ+QwNga6wG50UVq6oBNVxRt34
         HOar9gkkOH9mhv4PDUakOyPwdfGQbh8OL9BmJGHG8YEA+uHd3WgfPildmebttUrP9C7G
         5nQg==
X-Gm-Message-State: AOAM5333SDOumSHsW6VWeCtOy8dVk7yOwnOOIWQPQipazmCSJBKHSW0a
        D3zMxOr/WSQeQ34Tqf+9EYCKZw==
X-Google-Smtp-Source: ABdhPJy+Vf8I9qnmkQFJUrIdmApI0Hx2cKvcF9Oh0JuD8VS2ypmv8EOLP6OkO5UkhB00hmCxi6fLqg==
X-Received: by 2002:a1c:4e09:: with SMTP id g9mr7337523wmh.134.1621580802852;
        Fri, 21 May 2021 00:06:42 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id e20sm11427912wme.26.2021.05.21.00.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:06:42 -0700 (PDT)
Date:   Fri, 21 May 2021 08:06:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: Re: [PATCH 31/39] mfd: Bulk conversion to generic_handle_domain_irq()
Message-ID: <20210521070640.GR2549456@dell>
References: <20210520163751.27325-1-maz@kernel.org>
 <20210520163751.27325-32-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520163751.27325-32-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021, Marc Zyngier wrote:

> Wherever possible, replace constructs that match either
> generic_handle_irq(irq_find_mapping()) or
> generic_handle_irq(irq_linear_revmap()) to a single call to
> generic_handle_domain_irq().
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/mfd/db8500-prcmu.c    |  2 +-
>  drivers/mfd/fsl-imx25-tsadc.c |  4 ++--
>  drivers/mfd/ioc3.c            | 10 +++-------
>  drivers/mfd/qcom-pm8xxx.c     | 10 ++++------
>  4 files changed, 10 insertions(+), 16 deletions(-)

If the premise is solid, the code looks fine, so:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

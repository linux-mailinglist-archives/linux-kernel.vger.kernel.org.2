Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0C30D55A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhBCIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhBCIiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:38:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6043EC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 00:37:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f16so4619418wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 00:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FIABt9DVQ8ZOl3zMzYQ20KeOAcNPveGzfpV/9oPligM=;
        b=moQlEcLc9lP+fLmoAuE9OxAJP3vZ+XhN9+E1vN3aac6/WYpXhUNizBH0DuRQIXJAZX
         mnnXBSvMHA7yovJwn2o4EW0CfbCoqW75l2/eHn2DE8KPgE5KDQefm5ddX9mEjYvMSbnI
         27yUGQos+BCR8yDp5KOX6eu8yXXKJEgzagYe0iePBAege4iAe88Yti8WTbyX98wuMwCc
         OsD9X5jBXFK69GH16F4mVG9vZs+G4HCm3rStJ4eMNMmBlKq41M4YGQ1OkI0dt7JpvDSP
         cOxvmjDeZt8OidzadAXZoGXgiszNmKwRlcMlhRFT+JdfOQ0UCV48QLr8hifSbmVVsaku
         nfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FIABt9DVQ8ZOl3zMzYQ20KeOAcNPveGzfpV/9oPligM=;
        b=XVbB1eJZAXSKkYSlMln+fpB4u0MaA+6J/pg9QnSrFDmnXriQh/WjNlDv60ze1yDVzE
         vIgoZBHRdgTzbu3UAOK5uPqyNpbgcg09Mj3YWK/DSUwLrU+rYS1HSCslgyKkGqNAK0iq
         ut6voCF8IYEPbgxMBqNiIT0VdhyV/fGq0eklnTKYc4sn3mT/5rXGVfxudcBXIyDPNaAS
         DEKAKuP0zB8jAr2EhO8wE505itz8jocWbKIsPmzD+QuXFaz7yW97QrmQGJYhIdBSSNIj
         TfJB3bpnfjQP/XMN+E+y1rGwc1cCeTi+I0vcNTEl9oIoaieNhYa/aT/T39qz/NyMDoxj
         FfQg==
X-Gm-Message-State: AOAM533azBIIa5AsLe+O9rwqhvg/gONT+Rt+f4tCoF5qv8BdCln+6V5k
        lGIexybR7Qo+dI2TwL9A4/tylGBMlWZC7g==
X-Google-Smtp-Source: ABdhPJwtbOw06f2bSVGf75N2MCFftuTP1t5+QiY/L06gHEb3V2rPe/XU483i7on22lLEtTbvfdDQhw==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr1740921wmj.54.1612341458825;
        Wed, 03 Feb 2021 00:37:38 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:b982:c986:40fa:94a3? ([2a01:e34:ed2f:f020:b982:c986:40fa:94a3])
        by smtp.googlemail.com with ESMTPSA id s6sm1041927wmh.2.2021.02.03.00.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:37:38 -0800 (PST)
Subject: Re: [PATCH 0/4] clocksource: remove obsolete drivers
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>
References: <20210120131559.1971359-1-arnd@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1043ab52-d493-8982-0706-f4c9ed48c2e4@linaro.org>
Date:   Wed, 3 Feb 2021 09:37:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210120131559.1971359-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Applied, thanks

On 20/01/2021 14:15, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A few Arm platforms are getting removed in v5.12, this removes
> the corresponding clocksource drivers.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/
> 
> 
> Arnd Bergmann (4):
>   timer: remove u300 driver
>   timer: remove tango driver
>   timer: remove sirf atlas driver
>   timer: remove sirf prima driver
> 
>  .../timer/stericsson-u300-apptimer.txt        |  18 -
>  drivers/clocksource/Kconfig                   |  27 --
>  drivers/clocksource/Makefile                  |   4 -
>  drivers/clocksource/timer-atlas7.c            | 281 -----------
>  drivers/clocksource/timer-prima2.c            | 242 ----------
>  drivers/clocksource/timer-tango-xtal.c        |  57 ---
>  drivers/clocksource/timer-u300.c              | 457 ------------------
>  7 files changed, 1086 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt
>  delete mode 100644 drivers/clocksource/timer-atlas7.c
>  delete mode 100644 drivers/clocksource/timer-prima2.c
>  delete mode 100644 drivers/clocksource/timer-tango-xtal.c
>  delete mode 100644 drivers/clocksource/timer-u300.c
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

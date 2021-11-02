Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21191442AFC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhKBJxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:53:30 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60446
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231853AbhKBJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:52:32 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A54503F1AA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635846597;
        bh=H4PRgtqYnlG+AxvXi78i+Kv6j0hX3gecOQeQHgsvRvQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=JkRgX9/7rmGOgYdYlyoBKqcXtwqGfUUzBm1iwVmrR7zfAaQudv0VjDjqCmfGz+6CE
         AxJUtebapskw4vFJJgDH3NpLADjXz+UwNflCLQ2SjtGjrgQqh1wTPkhB07TkWNe+IX
         10gGpabAUZ+kPTJg+yAnjFamZhw4S5oXM/59yEZIwvAn9tczD3p/2B0zipZSk+sZqi
         PrzyT0WRRsLgx5tO3pbfxDLvPWOXPtzKEwiyMyEhh/0iE8GQy+s18rnsPBaCOc9IRE
         KiTEnoS0C8qtcMBveZOjrqE23TKoFl2/o8tR+DdF9x9Q3YI8j88nzIuwi1VrYg7kXw
         aXXZqEYrlkf3g==
Received: by mail-lj1-f198.google.com with SMTP id 73-20020a2e054c000000b0021668f13ce2so1337762ljf.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 02:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H4PRgtqYnlG+AxvXi78i+Kv6j0hX3gecOQeQHgsvRvQ=;
        b=N2Ar+jnxLTd9mhceSgR0kwN26MJcg1tDAzw1Vo77TFJ5IbBn+avX2lQJBTJnJwoj75
         Rujh4iPIlVB22pygcJ83Y7vXrquQLd8s06g0bWZLz4ExtEC955YeCphpL87/du+Vr+kh
         ChBkPY3hoG8zt6mnWTTqQLXUu2FZLNd1T61ZFdLxzLOaFuCYRwfS7t/YF2yCngF8gAuw
         3WVTy/xBdRP8//0cbKth5K2lTMczkr9gaP9JLx9BTJCnKveN3UtojFOK792wyqjDVYrB
         MrUiPAHr2bBplwvKY4Bd7lLVT5iuu62JLUQK14PPOZOstGfo2VXo7KG+ZGzoNylKXMHB
         JtvQ==
X-Gm-Message-State: AOAM532i0MVlQVYKHpclIlyUMI78SON7jwcHGRawoVMpojPM9Bp0SN8Z
        hITENJ4/ObHQI2qr2LIQ1P/BbvYQ5ZDEqKx41yaSXyQD3mpzyT0gVi8VRt4OsTYAgwyzn2LZ5x9
        yjmoTfV2opKbHxHYYITBllIHp99ykn/gG0cBQMWr5tw==
X-Received: by 2002:a05:6512:553:: with SMTP id h19mr13615721lfl.113.1635846597092;
        Tue, 02 Nov 2021 02:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzlgvzofJuAAE8dNqBMYnyvIkBrMqxjncCeUi48MRldl6QE9k2xwTc7MDmkRTJvyHkahXTpQ==
X-Received: by 2002:a05:6512:553:: with SMTP id h19mr13615700lfl.113.1635846596921;
        Tue, 02 Nov 2021 02:49:56 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm1633602lfr.286.2021.11.02.02.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 02:49:56 -0700 (PDT)
Message-ID: <c7d88f99-f370-da6b-5328-58f294f8386d@canonical.com>
Date:   Tue, 2 Nov 2021 10:49:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 04/12] watchdog: s3c2410: Let kernel kick watchdog
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211031122216.30212-1-semen.protsenko@linaro.org>
 <20211031122216.30212-5-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211031122216.30212-5-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2021 13:22, Sam Protsenko wrote:
> When "tmr_atboot" module param is set, the watchdog is started in
> driver's probe. In that case, also set WDOG_HW_RUNNING bit to let
> watchdog core driver know it's running. This way watchdog core can kick
> the watchdog for us (if CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED option is
> enabled), until user space takes control.
> 
> WDOG_HW_RUNNING bit must be set before registering the watchdog. So the
> "tmr_atboot" handling code is moved before watchdog registration, to
> avoid performing the same check twice. This is also logical because
> WDOG_HW_RUNNING bit makes WDT core expect actually running watchdog.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Added explanation on moving the code block to commit message
>   - [PATCH 03/12] handles the case when tmr_atboot is present but valid
>     timeout wasn't found
> 
>  drivers/watchdog/s3c2410_wdt.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBF238CFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhEUVSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:18:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56306 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEUVSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:18:09 -0400
Received: from mail-oo1-f69.google.com ([209.85.161.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lkCVh-0000Vo-1X
        for linux-kernel@vger.kernel.org; Fri, 21 May 2021 21:16:45 +0000
Received: by mail-oo1-f69.google.com with SMTP id i14-20020a4ad08e0000b029021ea73c87beso2952807oor.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i+JSzZ2rQGhQ29lBpKI4z1aCnxDb2tJ3Kzl1YaAxEnI=;
        b=r75jT4wJVc0awD2JZ6N3dMuXkIrRf35wxT8AL3ZIk5x4h6ro7zTYGU9DOZBxPJU2Dg
         gHsZfeTfHOHj5iZsnXlPQrxWPDFcoVgMpmdRXmhzQEAXSATqviafCWhJd1sqkbrzJomD
         qDS/B0aS9aPlNGUKb2BKAsGgPnahhZNK6NnOL+pr/bhSoAL5EYVVa8Q6vV0tOctg/3BY
         bTR095Oc3SQZu7pmiGKtuq/ay3RXyGF/8G3X2IEf0cYDt/X/T9/3RwXHg8qLvXMR8UxN
         HUcuT9wUbP50zzJpq3i+NXG/shL1jpbMG4ofiJcTFdSgm+xxrZbGAciBS+Sc02x3NtIv
         WHQw==
X-Gm-Message-State: AOAM5324I3zjLlY1/3gMi54rFwgffPXPNUgYehQbQGqmcE6PdLDFKnBU
        4qKTXgvnUu7S0+tFb3kwSFGSEik3YOCdgEfWyijapXwdrmqy2UXD7GTsLcnZpHbPMzFWr0n24uY
        Ssv1CPLGQaovdUMszZSYN1zIl+bpQGO6Yg+P4S+NnWg==
X-Received: by 2002:a9f:2084:: with SMTP id 4mr13122159uaa.139.1621631793342;
        Fri, 21 May 2021 14:16:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyhN4wTdUof6F1sg/xJm++pN1pGYmxpPtJuqD3wp7zu0v1bi2AZJLW+728z0SQBJ+GflIVWQ==
X-Received: by 2002:a9f:2084:: with SMTP id 4mr13122140uaa.139.1621631793176;
        Fri, 21 May 2021 14:16:33 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id j20sm107844vsm.20.2021.05.21.14.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 14:16:32 -0700 (PDT)
Subject: Re: [PATCH 29/39] pinctrl: Bulk conversion to
 generic_handle_domain_irq()
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
References: <20210520163751.27325-1-maz@kernel.org>
 <20210520163751.27325-30-maz@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d4f11dda-6009-20d1-6c87-5cd3397272fb@canonical.com>
Date:   Fri, 21 May 2021 17:16:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520163751.27325-30-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2021 12:37, Marc Zyngier wrote:
> Wherever possible, replace constructs that match either
> generic_handle_irq(irq_find_mapping()) or
> generic_handle_irq(irq_linear_revmap()) to a single call to
> generic_handle_domain_irq().
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---


>  drivers/pinctrl/samsung/pinctrl-exynos.c   | 15 ++++++-------
>  drivers/pinctrl/samsung/pinctrl-s3c24xx.c  | 25 +++++++++-------------
>  drivers/pinctrl/samsung/pinctrl-s3c64xx.c  | 17 ++++++---------
For Samsung:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

I cannot provide you testing at the moment.

Best regards,
Krzysztof

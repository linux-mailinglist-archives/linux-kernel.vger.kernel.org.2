Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6687438CFB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhEUVSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:18:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56323 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhEUVSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:18:53 -0400
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lkCWP-0000bi-11
        for linux-kernel@vger.kernel.org; Fri, 21 May 2021 21:17:29 +0000
Received: by mail-vs1-f70.google.com with SMTP id b24-20020a67d3980000b029022a610fc6f2so7406441vsj.22
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ZeN/TFs1hL5IYc4vZwtut7wRee84Fl+5pk36OFXyaQ=;
        b=LvosoMFxIznzdEWfdxaX+TB1JXZehewhfeIcDj1vZJDDpowZVnzarebV+y6fnyBc7E
         LqnFsD4BfS9RvE5pY7lLnI5KHEyT+pbMckohBJk5VbE6HDf7U+ligOOwYHxYJIAWnroU
         hJ6jJh5ptJNth1fcUaGS/P37J1ZMGr6Ezmv29+0bUzQR2MqigJtmU5Wx0yRJc5FaUO8g
         MWwFpSQW3UzGD7LwwH0seV2F/Ist7ez8kqGhKSlVTIaM575vN5trdmvD5gQusG279+Zm
         cgMX2uJwNA7EX8bMkHKH5WpLSZf7WCIQVrtc3V9yIpoyd9DezkkuKw6m5AXGCCajFn9k
         9DYw==
X-Gm-Message-State: AOAM531uydgC3aEqKDqum7XNuMRFUTmahftfl6aGCsw8i5Df31wRqa6D
        tZvz7nRsonMFeXc9u1V2Y9u2WlZWB0xkDEMxGPZDAQxHqBhia7TBkQwnZ9o72Ag/ijRLFETfRQF
        LMEdZNdjmmUcT43Ns8s9eJ3CKvpa6FVChvq5Ttzh2sg==
X-Received: by 2002:a67:ffc8:: with SMTP id w8mr12199895vsq.20.1621631848216;
        Fri, 21 May 2021 14:17:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHNnn/RMLUuzu4EwGwxVjsmxXpOHYz1Bn9gh1Q4LXgiakKu7X5xuSWyTQVAEwAI2mL4jxQzg==
X-Received: by 2002:a67:ffc8:: with SMTP id w8mr12199876vsq.20.1621631848049;
        Fri, 21 May 2021 14:17:28 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id o72sm98698vka.30.2021.05.21.14.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 14:17:27 -0700 (PDT)
Subject: Re: [PATCH 34/39] ARM: Bulk conversion to generic_handle_domain_irq()
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
 <20210520163751.27325-35-maz@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <69b28c45-7ef6-d910-9505-c28169d984f9@canonical.com>
Date:   Fri, 21 May 2021 17:17:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520163751.27325-35-maz@kernel.org>
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
>  arch/arm/mach-pxa/pxa_cplds_irqs.c | 6 ++----
>  arch/arm/mach-s3c/irq-s3c24xx.c    | 5 ++---

For S3C:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983FE437E62
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhJVTPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbhJVTPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:15:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B20CC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:12:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso6459168pjm.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5tIPrVGLvZ4zbsrHTfPISMt4tsDkqU6wE41WhsoyZJw=;
        b=CEmbDg9QiaXBc2H6V/Fj47bCBLlw35wqWgiaEkQ+VYfGuEibWjGHqn/6Ox6ItcpZjk
         db7wC23bF80sG500zhGe3DMcf7XMEPUaJKFpTs5y0M9Zlk7OO1ua/2UbZqIO8Ae71ybH
         5nIXd5xizDAI+Jl+K/19ItXXWO/tnhL6V5lon1KktOsTQAs7eyVJ6zQ1u8Q+E7vOGqRA
         wI2SW3LWgU6CjIv3XnA65dpk1onUOwyc0V5hS2VZeutaSPG7T3OMF69ujBNVolgwRDaF
         E505Aztgmelmtmgq2CAh/2YE/LyUV1QYWMneVwkqvTM5V/HV+/SCDP8HIC+XV0+71190
         7c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5tIPrVGLvZ4zbsrHTfPISMt4tsDkqU6wE41WhsoyZJw=;
        b=fmUQnQJguqByCdklfsi5VWc3pn+zI8RqL8bXsuNH9hO5zvWthGnJN61VUJuoNXOX+v
         IKuyFHu6lvn1vrAeG6DLCgJLvBX6yCsUJQqDdgUoOG1NnNK0CgnJJaTrcd98ZKneL9rp
         e7POM73YngavdHLhTmLvNVZYbm0Rb6mzrS+2knmm67OeHs+fgzpQOIVamymZfoAhUUO4
         etvcpgK0yQS1StsC1H7iFUWr6X5/Zof8rItShCSrl8Wnu+42+Xkvoi1GlSgf2JdwicHw
         7LF9N8E99iqUsSxb1Fn1EdoYYqIPu3lFVVXAWT+v5bdwU+vMPIghkYaT3OVm2ME7UrF9
         kEzQ==
X-Gm-Message-State: AOAM531OeSmJ//s4qdX8zGpAfCO3yNc86OJX72TUJpip+hWBYvbh2w6s
        6KuEPPIYLA9UexlpqwOClOmLHxIX860=
X-Google-Smtp-Source: ABdhPJykKphGbI08jQxRCakQdGMmVTmvyUtve3z2a0Jm+6mKk3JmNB00yE0IF1TPn2tbycj+D2YVZA==
X-Received: by 2002:a17:902:748c:b0:140:e3a:cc5c with SMTP id h12-20020a170902748c00b001400e3acc5cmr1647137pll.16.1634929968416;
        Fri, 22 Oct 2021 12:12:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fh3sm13472757pjb.8.2021.10.22.12.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 12:12:47 -0700 (PDT)
Subject: Re: [PATCH] irqchip: fix compile-testing without CONFIG_OF
To:     Arnd Bergmann <arnd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20211022154927.920491-1-arnd@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <44f5f437-cd54-5881-e988-fcb9df8adea9@gmail.com>
Date:   Fri, 22 Oct 2021 12:12:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211022154927.920491-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/21 8:49 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Drivers using the new IRQCHIP_PLATFORM_DRIVER_BEGIN helper
> fail to link when compile-testing without CONFIG_OF,
> as that means CONFIG_IRQCHIP is disabled as well:
> 
> ld.lld: error: undefined symbol: platform_irqchip_probe
>>>> referenced by irq-meson-gpio.c
>>>>               irqchip/irq-meson-gpio.o:(meson_gpio_intc_driver) in archive drivers/built-in.a
>>>> referenced by irq-mchp-eic.c
>>>>               irqchip/irq-mchp-eic.o:(mchp_eic_driver) in archive drivers/built-in.a
> 
> As the drivers are not actually used in this case, just
> making the reference to this symbol conditional helps
> avoid the link failure.
> 
> Fixes: f8410e626569 ("irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

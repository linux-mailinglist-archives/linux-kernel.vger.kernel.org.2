Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EAE38CFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEUVMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:12:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56120 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhEUVMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:12:01 -0400
Received: from mail-vk1-f199.google.com ([209.85.221.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lkCPj-0008P0-OV
        for linux-kernel@vger.kernel.org; Fri, 21 May 2021 21:10:35 +0000
Received: by mail-vk1-f199.google.com with SMTP id e8-20020ac5c7c80000b02901fc7f94b3a7so2982895vkn.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8fU1wyWIbdomLV856cxm0ypQVrDLecGbYa8JDydMbH4=;
        b=VkfC+Dok6MArgxjCIwRB4iJd9K2bDUZDltvGfTx+A36a+RiKz6YPVCv/co6c8MLB0n
         /H6lToYYPcPI3X554jSRSASF1kiYF1fVad9a8tBqM1LJBiGClPly0MzACj1GEmY+XFul
         Trca9o7Vx+2BSsmLIjl+XDdZw1mZBhjCZR9e+d1Qz9qqAWOKQ7jEdkIxxqJOZi/WC2hs
         gtZBckQ9BTmN1BTy1onJBsNMRYBHGysLzxJGppeUKyHlHDnUOLveCqCJvXen1GRzQWA0
         YiAR8ZKJY2rbCM1qOm7jG8rLV4vhSGT3DlWrd/bBTsQel3cGswZi4+v6ALnuVv5pIkRl
         jdgw==
X-Gm-Message-State: AOAM5309V2gG8XvwbJN4vslLQHkpXFVc/9oPtB55zc+/fyh2bc2Qcnf/
        3TFfhy0QaItya1M6qudqoRV8ZdOpd4mhsDPvzalgrL8U6lj330Z336i/zJx03zowYgGTwOnQkvq
        a2k87XA7UPcjPMa01S55xKZl3HfE1p3G7rcPd7aMpjg==
X-Received: by 2002:ab0:4507:: with SMTP id r7mr12945488uar.28.1621631434922;
        Fri, 21 May 2021 14:10:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqYUT+PB99emJDjJDWRaxULm46a3fedaffg02huB4nNDaYQV+HTAFxmOLrMXURrLAuYe39AQ==
X-Received: by 2002:ab0:4507:: with SMTP id r7mr12945463uar.28.1621631434765;
        Fri, 21 May 2021 14:10:34 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id x184sm103812vsc.9.2021.05.21.14.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 14:10:34 -0700 (PDT)
Subject: Re: [PATCH 27/39] irqchip: Bulk conversion to
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
 <20210520163751.27325-28-maz@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d480ef86-9bc3-591f-9473-3cd5db0f05dc@canonical.com>
Date:   Fri, 21 May 2021 17:10:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520163751.27325-28-maz@kernel.org>
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
>  drivers/irqchip/exynos-combiner.c      | 10 ++++------

For Exynos:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof

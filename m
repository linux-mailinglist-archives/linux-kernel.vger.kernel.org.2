Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3963A3B8968
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 22:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhF3UCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 16:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233942AbhF3UCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 16:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625083203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kpbCmymIfNMu/sLXKm+zPCIGsHXk+XoDrOjYWyu1pFU=;
        b=ZHv2dqBscC+oHisACQT3MD44gZu/m6weRc7eRyxwz5W7i+Rz2xnhNxdC/drM1QVYyV8gnM
        apRlLnubDIPiSjBJogJONcpvzFfGc+Oyr7u1iUoPZ8+W4PnA5afrblZtYPT4O8lD+wxvsl
        IPuQVjCr8M07QfPPBkjofEokSFR1ZWA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-48Nwv1yQPwWVf3wAr08F2A-1; Wed, 30 Jun 2021 16:00:02 -0400
X-MC-Unique: 48Nwv1yQPwWVf3wAr08F2A-1
Received: by mail-wm1-f69.google.com with SMTP id o3-20020a05600c5103b02901aeb7a4ac06so3396735wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 13:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kpbCmymIfNMu/sLXKm+zPCIGsHXk+XoDrOjYWyu1pFU=;
        b=HRlLthM+AwW8l/JummX9glOFQfHhejWqLMUoBxcjWhleIz93/5i7A7NEYos2c0hgpz
         VKfcT2C6w4EQ0STGtdOf6PHZY68Jka3mQZOSO2jtkR+ZpADGCE4tByfjmo3Gx+3v6pdK
         QhKp/SU/cVhrXobrano5cIb+cM45oCWGY7l2TVCrQYAMbtQZXhhROkWIL+ZoywJbIS3f
         60jLHpYv3xEQajoWfVDxzfgKaNgmjP2nHsTL5Dt/PjrPGIB4tYtqUHJQqNHDufp9xX43
         F/JhNOOhS4g9CJgF85YDbzNG4nmbmrgJuaZ1Lz+rWXqFgpnH8xniYPpvPHRYVt+QYZ37
         H8vA==
X-Gm-Message-State: AOAM530mB087w2O/VTUjGeCzgh+qSsdM68FNvbqd/5ZQgdUsVc94H7t7
        81gidLMH2pWUzm1aiZ8uly4zrWbZZJ2oAOb5P9TRbL/JDhmphKWR+kTTwNjYNnaYyfx296C6i1F
        Mm9ndbt2K4q2+qiK+4KZsyb6B
X-Received: by 2002:adf:8061:: with SMTP id 88mr41122175wrk.233.1625083200887;
        Wed, 30 Jun 2021 13:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbZIKlGNykgS5LTjJzUuKd9t2lLDnL4kgF750pVyY2IVUV5P2R2ti+aPzbVcp/wpfbkYiwhA==
X-Received: by 2002:adf:8061:: with SMTP id 88mr41122158wrk.233.1625083200692;
        Wed, 30 Jun 2021 13:00:00 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id o14sm25399wmq.1.2021.06.30.12.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 13:00:00 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20210630185922.GA4170992@bjorn-Precision-5520>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <e7f3bd28-8e5e-362d-11a9-43a60ff79dd2@redhat.com>
Date:   Wed, 30 Jun 2021 21:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630185922.GA4170992@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/21 8:59 PM, Bjorn Helgaas wrote:
> [+cc Michal, Jingoo, Thierry, Jonathan]

[snip]

> 
> I think the above commit log is perfectly accurate, but all the
> details might suggest that this is something specific to rockchip or
> CONFIG_DEBUG_SHIRQ, which it isn't, and they might obscure the
> fundamental problem, which is actually very simple: we registered IRQ
> handlers before we were ready for them to be called.
> 
> I propose the following commit log in the hope that it would help
> other driver authors to make similar fixes:
>
>     PCI: rockchip: Register IRQ handlers after device and data are ready
> 
>     An IRQ handler may be called at any time after it is registered, so
>     anything it relies on must be ready before registration.
> 
>     rockchip_pcie_subsys_irq_handler() and rockchip_pcie_client_irq_handler()
>     read registers in the PCIe controller, but we registered them before
>     turning on clocks to the controller.  If either is called before the clocks
>     are turned on, the register reads fail and the machine hangs.
> 
>     Similarly, rockchip_pcie_legacy_int_handler() uses rockchip->irq_domain,
>     but we installed it before initializing irq_domain.
> 
>     Register IRQ handlers after their data structures are initialized and
>     clocks are enabled.
> 
> If this is inaccurate or omits something important, let me know.  I
> can make any updates locally.
>

I think your description is accurate and agree that the commit message may
be misleading. As you said, this is a general problem and the fact that an
IRQ is shared and CONFIG_DEBUG_SHIRQ fires a spurious interrupt just make
the assumptions in the driver to fall apart.

But maybe you can also add a paragraph that mentions the CONFIG_DEBUG_SHIRQ
option and shared interrupts? That way, other driver authors could know that
by enabling this an underlying problem might be exposed for them to fix.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5944F131
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 05:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhKME3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 23:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbhKME3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 23:29:18 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB4EC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 20:26:26 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso9252278pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 20:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a8tq8/rGUt4iJhEk4ctvcJeQppYEsm/E9muAYaJHQW8=;
        b=o3v517VZMgHlOz+MkCBxVKmrK4FGjZ/lMH+Gb3HEnJKJUWmjuFd6XUW2G7X5wu5X3Y
         44GIsAGWji4smRtQe6rd55cKERPdpxZPsf7bGqd/Lk4Nte44+JG7AOFVNgO3dr8OYxSr
         fTOsVpXZDwioicPlh1ff+5cI8XcS24TyLaLky9FrWovWYcxRn34y//3fMH8nbghfYc1u
         2bSwVFA1LIPQhG5bFioBeb1XCAN+QJyjJqXzrowd96q0+EieuJhCMEtZfNymyF0BJcfM
         Xmi9v1lWcWjXvZc4loaKMn2IKK2lRSVDgWbzMw250xzUWunHH20HDtGsE+hqA6QDaOaE
         rJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a8tq8/rGUt4iJhEk4ctvcJeQppYEsm/E9muAYaJHQW8=;
        b=yz8Amiqg6ZKswB66CECGOb++6ZVJyAUXdYp/MZs4Ur6swO7YZDN3QLipuJ7pCi39ol
         zxeGhW74JgA04tFfoQLKR6LPJkKWDacR9gQeyxvn0RDQo0yhmKTJjh83/Aw/CSjn4sp5
         p2vY0BPIZwPnTFCY38zsaZlIyOmwf1tlmttcECiHlEjrLU0t7kYp5gQLgwF/Br4kDGXL
         h3kxt4snvuF48YUBw64+iw0ZrpfGkb30sXnwc7fUI8DT/i++GstmBu+iZiQK8BXW690Q
         NkU+kJ3l4gTdN8BVu72iGDoJ5wrFcz8Z4h1Cperq5swDcTAioul0XuhOVKA7FpI9lPmK
         HmeQ==
X-Gm-Message-State: AOAM533JP6p/R94df6iVNWK+0KYx5C5kzwjIAL8pU8DEse8ZAS2jj04H
        bZh1ydxqnayVRpAnjITfOoc=
X-Google-Smtp-Source: ABdhPJzJhSqvJg/J1jgFKi8xsdRU7/fz4C4JIyIL8ie2NuHnl8E/d2wptZjYl+uwmUqmPsYB/KREFQ==
X-Received: by 2002:a17:902:db12:b0:142:3ac:7ec3 with SMTP id m18-20020a170902db1200b0014203ac7ec3mr14114201plx.2.1636777586078;
        Fri, 12 Nov 2021 20:26:26 -0800 (PST)
Received: from [10.230.0.248] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id bt2sm6270489pjb.57.2021.11.12.20.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 20:26:25 -0800 (PST)
Message-ID: <f3203445-0950-fa2d-a21e-3e349b0a4a2a@gmail.com>
Date:   Fri, 12 Nov 2021 20:26:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] ARM: multi_v7_defconfig: Enable BCM23550 and BCM53573
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Joel Stanley <joel@jms.id.au>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211030025715.13296-1-f.fainelli@gmail.com>
 <20211030025715.13296-2-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211030025715.13296-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2021 7:57 PM, Florian Fainelli wrote:
> Enable the BCM23550 and BCM53573 SoCs to have all of the ARM 32-bit SoCs
> enabled.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to defconfig/next.
-- 
Florian

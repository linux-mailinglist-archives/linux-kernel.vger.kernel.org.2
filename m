Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385604428E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhKBH4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:56:03 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41590
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229720AbhKBH4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:56:01 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E539A3F19B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635839605;
        bh=4VeAqz3jSwIuxpiAMz+s1A17LIRDINxx7QefFsdrbvc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=q4Vg41lXTwL2aDVGYfpbvjOUqzprnxoOwiGLsOFNs4TNKJPSvHNvWZgXArgXqLTOa
         7mCBfOYBvZr27I7Sv6HxvyxSsE+jw49kwwa4lte0jmB7NaJrd7TM9OzcH60x4vyFmU
         uYvyb06RAGyg+MHMZdqlwbe5hpdvBIHc2CZk8tQhhQh4kRGo7r9VQzl0cZ2f30YYiA
         EJNSc4kq8q2Vuo88Ce62m7yWiQQk854kAbrXQiQG7xaCO5L+0ME/jc2GwK2N8VDnt6
         xev8548f6oRXwyfDSR3Za2yPZPN0Mid/xmCGHKFrcb9JcAwmNKJn1ESxg/EQZepJFG
         vW52Xs9c5JvxQ==
Received: by mail-lj1-f197.google.com with SMTP id v23-20020a2e87d7000000b0021768392240so71893ljj.23
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 00:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4VeAqz3jSwIuxpiAMz+s1A17LIRDINxx7QefFsdrbvc=;
        b=jWfBRsX2PtTsEanZkKcL1qCbZT/uEgvSiSudG5/G7Nw/zRh+G2EvoLplrwf0umWlb5
         UdD8rDhFO8R//ukgi2zyrl/fBgwm27GKly1W9R3UjEmNtC34QN+6Ioxv15o+ejr8oetl
         2/fB4VgNuSTEMU8lVTjUDM9zi49lv5twvkNy4gf1bd9JfzyogtlvfuKuh/EqHRrBavnz
         sdV/tzaZXk4TWyYUcYKjfJbDYVDJPoWRQmNj/xXZObp2fWYTJYqRm6CIovkWA4JtlMXz
         eT34Y/HSokJOzHI08oMk5wvXir/fle8xbMYUsgnSKvKv8KJbnnn/Zme2Ab7PKZf0CUSA
         sUTA==
X-Gm-Message-State: AOAM530gersUh3PoE9NSz70q/fCc6PpbC3U6ISrJQ24iU+VlTEpjC5H9
        koTB7w3ft1BM5+qTeEtHn2oQ+IjwB4WqrU+h3feI8MESNLeBtVNmKffsWbLJ06k81roBT1QVStp
        94t3jbmxKhP6srDkzUASigmCTy9cnbzY4rl6lKHsQug==
X-Received: by 2002:a2e:391b:: with SMTP id g27mr37424591lja.126.1635839605405;
        Tue, 02 Nov 2021 00:53:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywtLecTXbvt/DmqUThsqiYEapd5wq5piKqf14nTC+WAQVrWN89kNfMyfjFoZlxRCLA8cq3fg==
X-Received: by 2002:a2e:391b:: with SMTP id g27mr37424575lja.126.1635839605264;
        Tue, 02 Nov 2021 00:53:25 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id z17sm687463ljk.97.2021.11.02.00.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 00:53:24 -0700 (PDT)
Message-ID: <59b76525-079d-f672-5355-20d92ecd4d98@canonical.com>
Date:   Tue, 2 Nov 2021 08:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 1/2] ARM: dts: exynos/i9100: Fix BCM4330 Bluetooth
 reset polarity
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20211031234137.87070-1-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211031234137.87070-1-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2021 00:41, Paul Cercueil wrote:
> The reset GPIO was marked active-high, which is against what's specified
> in the documentation. Mark the reset GPIO as active-low. With this
> change, Bluetooth can now be used on the i9100.
> 
> Fixes: 8620cc2f99b7 ("ARM: dts: exynos: Add devicetree file for the Galaxy S2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/arm/boot/dts/exynos4210-i9100.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Looks good, thanks. I'll take it after the merge window.


Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF35143F848
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhJ2H6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 03:58:33 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51654
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232281AbhJ2H6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:58:32 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6DAF33F198
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635494161;
        bh=LyyBRaeBvGMAnLsFN/eJuaykDGWSSKpKnsQjNh6rDIk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=GyCZ7ZC60+Km16be+ADFcNX4LoEhwUoHYI4LEml4EyWvmRXzWjn/z90KbO04iZJfM
         lWNILUoqaDGRhWFrZSkSg6ACt5542NM8e6hIPmoW6xybhsUIdsEn8ZjGWs0vEH/tLf
         ZtiJRPsAPaWkTVOTIkrWqEiFDLb+NOtZcB/kMk4dDK0/4iGlwmLFDRAfE7a1k9hTrz
         hzKRz8iWtzu1pAjhVoFCxBVvBsc/LwJWOvF1LHG7iRRtZmH4h1Fkgq64Li2tipjaRC
         Gv0AwR+09QpfxAwMu4jXXeveZsYxfjI8+27yC+r6AQeu9sosve4p/tIlfp1yedTtPc
         Q0mO1uBbPJ1XQ==
Received: by mail-lj1-f198.google.com with SMTP id v17-20020a2e7a11000000b002118bb7d585so2784604ljc.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 00:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LyyBRaeBvGMAnLsFN/eJuaykDGWSSKpKnsQjNh6rDIk=;
        b=YXOGHgDm9Ddc73ocqQeuewHGfXziJzTIuZ0J6oXoNMMyixjEK6Sl+4r/AfUzNUYPFH
         XuBCTa+AE+b3o+glfBCQYwYIW24e3cvrqHelTckgdyyBhcGJzC4JScI/Sq/ESfa/i4Qg
         4bdZMQm9LC87Z8K4UJVi1e7IsG7fCUsmyFFbOTWsXPVR0ioeu/duLeZn0cY3pIfTB0VF
         KWa0avbdNkaCVzj3eYE+5Xw1u5t/UlTMainA7g9Cn6MaPsN05FEF30gag6kY+MoPSJep
         VaQnK786fcivMNUuydO5OW1d65DHJhRUurpORuCxzf33XU2xuuB6IJbe3DY/LQTSh1VI
         AOSQ==
X-Gm-Message-State: AOAM533ON8c8g/EpUpw2QpNQEqaQkcUZ+tBYpGOsY8hsv2lzdX7/UOyR
        kL8KJ/pinHa57d8LX/aqCdKFGab1Q1e986ItiXi3nUNFeSByCukVafxQUcr3KiUOQxJZX33JeVF
        RW6Vdkyo37LEaoKNF9T8v0oMDAW2nXpeEqfl95jL7iw==
X-Received: by 2002:a05:651c:88d:: with SMTP id d13mr9891252ljq.399.1635494160832;
        Fri, 29 Oct 2021 00:56:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjD+ZyZDA5TH1MYDJvmel7PgaO0VMDmzw3+uqvozcCuzMQMxxuuiC2S7FaeIi+F7wLIc61Fw==
X-Received: by 2002:a05:651c:88d:: with SMTP id d13mr9891235ljq.399.1635494160646;
        Fri, 29 Oct 2021 00:56:00 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o1sm533211lfk.159.2021.10.29.00.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 00:56:00 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: watchdog: Require samsung,syscon-phandle
 for Exynos7
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211028183527.3050-1-semen.protsenko@linaro.org>
 <20211028183527.3050-2-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <99f7e45d-7c27-1ad9-edf5-a5075e8e323b@canonical.com>
Date:   Fri, 29 Oct 2021 09:55:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028183527.3050-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2021 20:35, Sam Protsenko wrote:
> Exynos7 watchdog driver is clearly indicating that its dts node must
> define syscon phandle property. That was probably forgotten, so add it.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Fixes: 2b9366b66967 ("watchdog: s3c2410_wdt: Add support for Watchdog
device on Exynos7")

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof

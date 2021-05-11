Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9237A6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhEKMi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:38:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51132 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhEKMiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:38:15 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgRdM-0002ga-DK
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 12:37:08 +0000
Received: by mail-ua1-f71.google.com with SMTP id r26-20020ab058da0000b02901e9245a03f1so2429908uac.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 05:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dESI6UIanP9SYP+dA0R2Z+/ifRMzMVAqstkYDnBKva8=;
        b=uITNbkRLHLW9coN4IX31riqweaxuMpWVQSsLurEq6VrNod55Amb3wFHKl1P5ocTtWa
         wltZ6er7cbTcDXfmTCh9wLIYnH8oteA5KHlSRJCn1SMDlkDuKGQk0u3ygAuKFeWJxTBG
         nF+E87E9nw+2WQYH2iDHRNOBZeL1uT+jMlbDujU9aDlgt5b//YQjx1tCSjjt9EkuiIXm
         vTfXXeMPEecrJS20ibpsawLPihfYx77wFEuFx43nrTYvO5d6zKESNQ4rMa9a79BOYBfJ
         KNVl2HPVz8o+odnhXsY3mFprohFrFQuVlL0xcgt8BGt7XeqN9gp5RJ4f6EP6F4fyiAUr
         /ovg==
X-Gm-Message-State: AOAM530m2XMGDbFjD3YsVpfNUk2iNZ9WPL7QXhhQrPzVDr+VXt214H6q
        oa90rs4EvrzJIqgIAzst4MIpIELoKD1YoN8FJza5NB/qn9agnk0MIFDPru9ROxYQSlSqWKABfkP
        aVzscYZEkBsKytDVLpxG/EgAMV5fiUEGz0Z3amjpElA==
X-Received: by 2002:a67:c897:: with SMTP id v23mr24621288vsk.21.1620736626436;
        Tue, 11 May 2021 05:37:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsstqrCGPGwKQw+E8kDi6fNgrHq+JiyfOabiP5XD6/NP0Hvfu2ryEsA4NoNofSlOZVMSQCBg==
X-Received: by 2002:a67:c897:: with SMTP id v23mr24621263vsk.21.1620736626294;
        Tue, 11 May 2021 05:37:06 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id r12sm2039148uao.6.2021.05.11.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:37:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] ARM: dts: exynos: align Broadcom WiFi with dtschema
Date:   Tue, 11 May 2021 08:36:53 -0400
Message-Id: <162073661213.12308.14891342719817203465.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505135941.59898-1-krzysztof.kozlowski@canonical.com>
References: <20210505135941.59898-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2021 09:59:37 -0400, Krzysztof Kozlowski wrote:
> The Broadcom BCM4329 family dtschema expects devices to be compatible
> also with brcm,bcm4329-fmac:
> 
>   arch/arm/boot/dts/exynos3250-rinato.dt.yaml: wifi@1: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['brcm,bcm4334-fmac'] is too short
>     'brcm,bcm4329-fmac' was expected

Applied, thanks!

[1/5] ARM: dts: exynos: align Broadcom WiFi with dtschema
      commit: cc29e39412b9a78b43f7dfa09d739f8ba9fa7984
[2/5] ARM: dts: exynos: replace legacy MMS114 touchscreen x/y properties in GT-N7100
      commit: 8bceb2a490bb8e1048e9c73520f49a65823108a4
[3/5] ARM: dts: exynos: fix PWM LED max brightness on Odroid XU/XU3
      commit: 75121e1dc9fe4def41e63d57f6a53749b88006ed
[4/5] ARM: dts: exynos: fix PWM LED max brightness on Odroid HC1
      commit: a7e59c84cf2055a1894f45855c8319191f2fa59e
[5/5] ARM: dts: exynos: fix PWM LED max brightness on Odroid XU4
      commit: fd2f1717966535b7d0b6fe45cf0d79e94330da5f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

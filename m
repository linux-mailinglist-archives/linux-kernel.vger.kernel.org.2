Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496BE40C0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhIOHw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:52:27 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51224
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236725AbhIOHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:52:25 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B53740197
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631692266;
        bh=yfmyLGLaZHO2X3SIp2h1tQ0oSU6KsOx2ug/7Y4ecG1Y=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=GcSj10tYJ8+Z1OPk/51Elz8W7vfte/kCNMUqyRQML9yIUfv2Ywptkg+nBoDb0Lvw7
         3hlCVNaaQK/clFgOe3uOgiFRle86o/ii4ufCv8CtHtfFoR79US4ltbUnPr1PwVBT9O
         mVGMZMtD7+B1epDAVhVXLiPCy/NV8xQ2tGmGpQlG7gXUoC8mZqvvJV1VCS9NZ6HzGW
         aMpb/GbiqCQ/7ZcmraPgC1oU97ZTZLzQndIPlpLcMUmAkIDkeXtSOosuIPPKwQtSJk
         2VzdRNJlWE/FMyVWrwSYT0ZQNNJifWZld7fZzMKSDM+eP6U0lhyzfqS08EQ6ISFT+R
         Xgrhyn981HWtw==
Received: by mail-ed1-f70.google.com with SMTP id x14-20020a50ba8e000000b003d5a565de3aso164798ede.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfmyLGLaZHO2X3SIp2h1tQ0oSU6KsOx2ug/7Y4ecG1Y=;
        b=Bl1iNEEbNVAl6gL2QrHQUeSJAMZ7N46PfAy8STIsyoAgiAQlAWbf/aTEYZ/+kucwJz
         ujWOA2SQap0z/+Y1S+odTgtEt4I91gS2cTbNB3Cjen9YaiJK3GC51jSNYOTj+ggOetuy
         0x96orbB0ab/uRFqHn3r0W+QrtEkYDKfhuEbNEA02RnPncPbp+O/sDoE559ncFM4c+Rw
         /W6cJpeeRstsB+dv3B9Z/cSWQRqoT0RiccJzuKP0dlDvKslozB3JZZyHZ29uZgZKAhqS
         upjjF7hjBVFKJGLOI8yFtAr/VKV9+fY2eGBDeKMLj7+b6iIKXdAvsIyU9nsDQn8QcVIs
         HZUQ==
X-Gm-Message-State: AOAM5338EFfIGLtn9ARsNky5JQ8BwEEP4Vt9qL+kDN3aUdMSanX9DGqH
        Ays+MeSh6UD9V1nGhMaEiebypj9RaW/DNouD3TBoWxS8l9JGNgaKaBXzlAvm8hvKSNv+v27olCY
        7FSwJfqwVuQ3WSk8wPyyA1LO6R7F28EQk8LCDBFtzpg==
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr23446553ejc.72.1631692266014;
        Wed, 15 Sep 2021 00:51:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOUoG/3APcqCn+ZeMkj7rfrYeSKawWs4kMluxJlwRm1ZVOU1UXmVKC+P6dzqxBWLZzMUXm7g==
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr23446537ejc.72.1631692265892;
        Wed, 15 Sep 2021 00:51:05 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n11sm591922edr.51.2021.09.15.00.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 00:51:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 2/2] ARM: dts: exynos: drop undocumented samsung,sata-freq property in Exynos5250
Date:   Wed, 15 Sep 2021 09:50:57 +0200
Message-Id: <163169222223.16372.5968468091067814422.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811083859.28234-2-krzysztof.kozlowski@canonical.com>
References: <20210811083859.28234-1-krzysztof.kozlowski@canonical.com> <20210811083859.28234-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 10:38:59 +0200, Krzysztof Kozlowski wrote:
> The samsung,sata-freq property is not used (and not documented by
> generic AHCI platform bindings), so can be safely dropped.
> 
> 

Applied, thanks!

[2/2] ARM: dts: exynos: drop undocumented samsung,sata-freq property in Exynos5250
      commit: 06cf9e0b1aae8ff4f4cee39126a415b2b173b986

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

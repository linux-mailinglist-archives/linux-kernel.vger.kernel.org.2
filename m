Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096CD452EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhKPK22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:28:28 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56120
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234053AbhKPK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:27:53 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2F4F1405F5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637058295;
        bh=JerYnhBtmUHH6NV+ceFOnnCD6DdLB6fVmNfeeL5PvIQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=jlRRX7YMRMRrh1nCL8zq2xYDY/M62XYnegcEd9GeY1edsEteA8f+Zqca7CEz0N0yi
         Fki6NHgq9F0V36iu6PyvGUFvpjPktbM47OCVghOZslgaO7TZQrCy0GZFVvAJG6i2SO
         FU8B3ehUyAi2WgPGcp1PTbdI5s2jTqqeaK5ImpmVZpQxUgSLN8iNl0SS/Qjv4JYCS6
         MuuuDiXtG5ueVRKAq33OHC3XcZ7EzTPW5OCtMkaLxMqR32BW2/gmEahIhydN/bh4gz
         sFtUd0K0vD6/QePbDOmNCzaJ8NGdFahAEtBRu/9k3FpXjCEL0hjoj5Y4mnGVqrSPcQ
         JJn4iMpDi3c0g==
Received: by mail-lj1-f200.google.com with SMTP id b14-20020a05651c0b0e00b0021a1a39c481so2044754ljr.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:24:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JerYnhBtmUHH6NV+ceFOnnCD6DdLB6fVmNfeeL5PvIQ=;
        b=F3I57Dd+TwebqU4KHn7+9B/Fmmb0WJuov+v5Nzue8hVBv5Zyxud5CEEtfNgjQvexE5
         PDG+Q8EpBAP6lvcGeVraAi58gsAUqc8rpzvm1IAW6aG+LP0cpVpFC/kHH/vwEnMVU7F/
         FTUkQswXlBbvCfeoKk/NTa/w/Z/Gnwb7R37VeXzkAlSUYKIWYThEIKvzpJdFY26E4bqX
         sITWW0jXOBlkCnNmWmkJ4aHH9oOpYfiRglGtZsLhYRL265LC3+AVhxndsyuaXCNhPakV
         uM4ect8U0no87QMqkN/0lDDDCSkZZGOhowIVdrP9g5jVwaIQ5Y17lFHig3NHHQ3NS9E8
         H1VA==
X-Gm-Message-State: AOAM531tA5ScfcF03s+QYpAT9GYkuHNtmrD1IpBHZwerqR+hK3K7/zZK
        rpWGz+IMA+5/SgaYoQVkhdnLBhlUNpBNGINLvXE4A6ujol4+bKk1btMdfEiHZ/Lv7QNNttZzZvl
        oNDrfF+u+am2UpjRfj19RLAqfCSwG4qt23iGwPH9S7g==
X-Received: by 2002:a19:6741:: with SMTP id e1mr5857739lfj.459.1637058294618;
        Tue, 16 Nov 2021 02:24:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0JWBN83XgyVZpj2dlf8sWnAvkVHESkVCe/dwdAFUXtak/4mFas74xyOKFYFvKJsZe/rciYA==
X-Received: by 2002:a19:6741:: with SMTP id e1mr5857722lfj.459.1637058294465;
        Tue, 16 Nov 2021 02:24:54 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l28sm429000lfj.240.2021.11.16.02.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 02:24:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 2/2] arm64: platform: Enable Exynos Multi-Core Timer driver
Date:   Tue, 16 Nov 2021 11:24:15 +0100
Message-Id: <163705825120.25687.5616659207045424814.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211101193531.15078-3-semen.protsenko@linaro.org>
References: <20211101193531.15078-1-semen.protsenko@linaro.org> <20211101193531.15078-3-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 21:35:31 +0200, Sam Protsenko wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Some ARM64 Exynos SoCs have MCT timer block, e.g. Exynos850 and
> Exynos5433. CLKSRC_EXYNOS_MCT option is not visible unless COMPILE_TEST
> is enabled. Select CLKSRC_EXYNOS_MCT option for ARM64 ARCH_EXYNOS like
> it's done in arch/arm/mach-exynos/Kconfig, to enable MCT timer support
> for ARM64 Exynos SoCs.
> 
> [...]

Applied, thanks!

[2/2] arm64: platform: Enable Exynos Multi-Core Timer driver
      commit: ddb0fc6f055d12518b724fd1ee00669e07f03b96

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

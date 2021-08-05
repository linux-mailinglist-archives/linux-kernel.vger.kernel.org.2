Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C883E0F24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbhHEH0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:26:22 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:43198
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238564AbhHEH0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:26:20 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 322333F22F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 07:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628148366;
        bh=g9qBqxkhsVrwTaR51E6CfuBSIwrS5M1PgyyXHDx+vl4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Zz0+i8Bd+AmF4pBukb+CxwQJLKOss25NPFOCmXKuO2wva0uhFGZWm1Ee6HbTjoYHO
         jl0tE1acbR0dA8orYIPGDWIP3S9Ay+iG6hM7jVdAPDkfx0t4oI/+214MwsWoq+1Qtl
         Wd6S0/BqoMK2jm+eHfcP/qfsbXODwRCfzfEaCspiFUJSlFRugDtDv4WZZDZGtJDJ6a
         V50Qwp8NPruJNJ6SemuEDkIdRvHrbB4wmT7T2JO4IW6Sq7IqWeHbPs7YSw0kfEbjff
         ONwm4lTj6Sx5Ntc/jz5E+Yt/SDdZzRLxHU/0/hKzDLsaJMDWfJuCQ1YzpDKyy+SfOG
         xCpVmowKr8HYA==
Received: by mail-ed1-f71.google.com with SMTP id k14-20020a05640212ceb02903bc50d32c17so2726718edx.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 00:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9qBqxkhsVrwTaR51E6CfuBSIwrS5M1PgyyXHDx+vl4=;
        b=drx7Ip/iJ+XvJox6tmu/Qkk9jRnuwhHoOpO++ssy3ezySKA03gcAiWgGkk/8YTxiAc
         j9tnfJXp4UoLue3Ni5+7LYrR3BfSW7PqdWZ0ZaY96Enebf1wrFoM/+R+aCAzj+3J12Fx
         +ZcXNGCxg0/g90cNnV/JiH/rWPFj5S31cJPOCYXrBfBp7qy56Y/y4tUUOvAxCSqWtfqD
         xjMIH+HlDjilNO02bRhEGTpMVJlH2y0HbgQAfmDm7gH77mPWLs3Z0ygYWGh6+OTsv++e
         94d+H9WfyljjBYELEk+7NtOtZST3lhkCGurUoJzG4x0XoduV35DEZCvbiH8Rlf+I7mir
         PRtw==
X-Gm-Message-State: AOAM531qOfnRpbi+5rXvbc3F2PznZgcJe6xZQzAVFfqfD4tlumlrKF5z
        6AvQoFtccKOwxvoOafPVdHdIv/saYcD9SJEU1Vv5OS+0XMIL+bTJub89jI2U24b2ppDBwAuzQ1X
        MYPwNUJCKCi3VVu/TmpHO2zMTC58VmrRuGCwBgEIsqg==
X-Received: by 2002:a50:be81:: with SMTP id b1mr4735903edk.295.1628148365327;
        Thu, 05 Aug 2021 00:26:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+pEeF0AYkyWCT4YC0tcD+JhvhWIIsPWvWkaXRRVc3F27jZY8cg94BFy4gyubfS81YcRMbvg==
X-Received: by 2002:a50:be81:: with SMTP id b1mr4735896edk.295.1628148365185;
        Thu, 05 Aug 2021 00:26:05 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id la23sm1399073ejc.63.2021.08.05.00.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 00:26:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/8] ARM: dts: exynos: add CPU topology to Exynos3250
Date:   Thu,  5 Aug 2021 09:25:25 +0200
Message-Id: <162814831970.6166.12328372184939604484.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
References: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2021 11:24:02 +0200, Krzysztof Kozlowski wrote:
> Describe Exynos3250 CPU topology.

Applied, thanks!

[1/8] ARM: dts: exynos: add CPU topology to Exynos3250
      commit: a2798e309f3c67ab69073582dc4b8102a9013e25
[2/8] ARM: dts: exynos: add CPU topology to Exynos4210
      commit: 900dd07d13e46b2937522ac7cc46a9ceb49284b6
[3/8] ARM: dts: exynos: add CPU topology to Exynos4412
      commit: 1fb5b5b0dc491613eaa42bc39457589bfcb2b2b9
[4/8] ARM: dts: exynos: add CPU topology to Exynos5250
      commit: fc6d5c9953757c61042676db9bb32ecd7af958f3
[5/8] ARM: dts: exynos: add CPU topology to Exynos5260
      commit: fa0c56dbc3a1b116d280c3a3a97052ea38e4ea2b
[6/8] ARM: dts: exynos: add CPU topology to Exynos5420
      commit: a73d3069f6f7717bbd31a2fcfe8ddb3d98076b1d
[7/8] ARM: dts: exynos: add CPU topology to Exynos5422
      commit: 6cad6db75231a18f25dc7d610d5a0683160ac545
[8/8] arm64: dts: exynos: add CPU topology to Exynos5433
      commit: 0cdcca7ec37cfe54cd2f0668eddcf5aef87a05e3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

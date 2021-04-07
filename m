Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039C13564A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349278AbhDGG6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:58:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59009 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbhDGG6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:58:50 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lU29A-0000ef-5L
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 06:58:40 +0000
Received: by mail-wr1-f70.google.com with SMTP id a6so1592786wro.15
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 23:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGp9cCtQeuvZ4dDU3lNFYxtK3g+aG0STXiLOrxikwkU=;
        b=oEV+FKskY8hM4ygaNNvK1BBMfeNwD/fqEGmRepBGDp0Dm+SbiXX3xmBbKathVMJXlt
         UJX1elWQfPPHpC0L6RmxzP6gPl8EKiowuQyUB3jJf5IaptahHd6lbNCwN0kEwoxwlzkh
         KZIu4RO55pKoEcyFqMw5Ww8BAlyjfanXFAoWS8sLkPvO/JD5jOz40BYbtBNkPN0Zhmm1
         nYC2THmha/txlvMBia8pF5H8qrHszWYkaPehkJjub3MNCzwOCa47H8nU+PNl4Ww42dUh
         TnrG+uO9YQqmPITnnLzMa+JhfMHsduVJ99PDQ3H2nSII+hhiRS0CYzrr79zo1zEfhcjC
         di8g==
X-Gm-Message-State: AOAM532a8dcWIorGSwkk9TudzLRy2G3JWCrZimLGimxTHLHikGrGS+w4
        NCWJQMQ3ugEcTxUOnaItE8moOGyC/oougdz+K10dCqpBuUfT0JUR/hNe58/qkWLsmhuolIFbZAp
        0vSC893vHO0WLTR/UiypYfoawdVUdTV5U43yzzAa1hA==
X-Received: by 2002:a05:6000:1803:: with SMTP id m3mr2459251wrh.258.1617778719957;
        Tue, 06 Apr 2021 23:58:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2chc2TVWpQSi3GSuDDxdkbpVm4TczJXiGWLWQEGOjPsmLj4qrqZWc1VSc39QEy+uL9LpD7A==
X-Received: by 2002:a05:6000:1803:: with SMTP id m3mr2459243wrh.258.1617778719852;
        Tue, 06 Apr 2021 23:58:39 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id c16sm2410506wrx.46.2021.04.06.23.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:58:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/3] arm64: dts: exynos: Pull for v5.13
Date:   Wed,  7 Apr 2021 08:58:27 +0200
Message-Id: <20210407065828.7213-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407065828.7213-1-krzysztof.kozlowski@canonical.com>
References: <20210407065828.7213-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.13

for you to fetch changes up to 7d2636e9d6dd884ae2ec6127f29963d4da0dfe6e:

  arm64: dts: exynos: white-space cleanups (2021-03-19 11:34:55 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.13

Two cleanups in DTS without expected impact.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      arm64: dts: exynos: re-order Slim SSS clocks to match dtschema
      arm64: dts: exynos: white-space cleanups

 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi            | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

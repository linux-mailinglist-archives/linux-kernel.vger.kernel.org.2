Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D9A43AF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhJZJuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:50:11 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40092
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234374AbhJZJtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:49:45 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1FFDD3F170
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635241640;
        bh=sbYrCs8J0Q0Rz6cp+rkJ/lhh0zXOz8q9lqlVQx/f+TQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=oSUyqdjSFPWbKqjYHTQOPhgq1OfgbyJtFHp9J4lQ+zmmUoSSeSYwszSthnfkwjZRf
         Ink2K78bwqR3oCywgNX4G0ANBcKBDTjCoEIBAM0NQkBHUofOQGmG155jwCgjq74fb0
         3ySjWJzHWEi3V/h5UpEPhNaFVKPW3rKx/dQ7+EEYS9AT1cIigJYrjytGb3Lm0KtVZ+
         dVD07q0QI5iuLgUo2nXBojfHPvJSCRUf/+U2Q+1tBAVvwHASkfjSUVX/pZAHkAZGNO
         sUM5SxSfI+J/gPbOW2qyVTHKUHs334MsDCiQxaK9d/JN3c50xWstiawuZtQvDjn08W
         lrmmgLK+J0wGg==
Received: by mail-lj1-f198.google.com with SMTP id t7-20020a2e7807000000b00210dad8b167so4069153ljc.22
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 02:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sbYrCs8J0Q0Rz6cp+rkJ/lhh0zXOz8q9lqlVQx/f+TQ=;
        b=BnC7FFH4FLltWNhsSSkx2h5jIn/zA1vYFRE61hAlSbquMV9ZBwctzbCm4auZzQHWll
         0ewstcqkfCAtoaqAD2gKR0Q5wZXHn24mO8eZzR7nl7+mvbcHAJMCnYspfALQoNZxb5i4
         NJDoEA7fRd2g7AYy8qmcBcZdTWTi/LjpI16D1QNT8p9EjaBTAQw86tgaPTVcJ6X2KwLx
         w+Nx4tpsX/DKR6sCcdWqKzpcYa3csei5eA9ohVgDq/WU9KUAMCKg87c3XKYsgyY42TXP
         AIKt5Un4VMNn+R7eZ8o/opCp52TTE1vhfN+Ue5wlIASWCOx0LP8hqDiACGiIXLFpci2m
         6tQA==
X-Gm-Message-State: AOAM530eNFx94omuqt5SLfMIxuofOgwO8GzjhJjkwPMFHG7Ti+aGuFaU
        WGUd4KSjLW3Oj+jFN/6Z5txvQmPNhTxKUq0n9BoiXq4FT3A5Q9iCY9Ffv3jyqmm7sxcNJKzCsVD
        G5CwlK2wzTJWz178GY3gquzYtXrQB7R3Oz1ZJbxbUyw==
X-Received: by 2002:a2e:7304:: with SMTP id o4mr886883ljc.385.1635241636727;
        Tue, 26 Oct 2021 02:47:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKSsLVNoJZPREVg5VqEAatQtzjWaBPxJNdTK1B4zkn7s0ddrcueJak0ah7O3ADQwivq+qDAQ==
X-Received: by 2002:a2e:7304:: with SMTP id o4mr886837ljc.385.1635241636293;
        Tue, 26 Oct 2021 02:47:16 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v17sm113794lfo.167.2021.10.26.02.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 02:47:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] arm64: dts: samsung: exynos for v5.16
Date:   Tue, 26 Oct 2021 11:47:08 +0200
Message-Id: <20211026094709.75692-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211026094709.75692-1-krzysztof.kozlowski@canonical.com>
References: <20211026094709.75692-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull.

Best regards,
Krzysztof


The following changes since commit 2b663ae7152f785732d35ce38ad20ad10aca3116:

  arm64: dts: exynos: add minimal support for exynosautov9 sadk board (2021-10-12 14:20:57 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.16-2

for you to fetch changes up to b2f217cc7fbd3e6a097021b8b663328a649ea232:

  arm64: dts: exynos: add chipid node for exynosautov9 SoC (2021-10-26 09:17:42 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.16, part two

1. Add chassis-type property.
2. Add ChipID node to ExynosAutov9 DTSI.

----------------------------------------------------------------
Chanho Park (1):
      arm64: dts: exynos: add chipid node for exynosautov9 SoC

Krzysztof Kozlowski (1):
      arm64: dts: exynos: add 'chassis-type' property

 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts  | 1 +
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 1 +
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi   | 5 +++++
 3 files changed, 7 insertions(+)

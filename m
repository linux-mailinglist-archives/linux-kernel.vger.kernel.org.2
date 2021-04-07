Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60173564AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349295AbhDGG6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:58:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59013 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346039AbhDGG6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:58:51 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lU29C-0000fB-1A
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 06:58:42 +0000
Received: by mail-wr1-f70.google.com with SMTP id z6so11209406wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 23:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LchvM2u0iW5KufEGKbahHHtTCv2rOtXQ3p5uFrGxVE8=;
        b=qsvNvr0c+3Y1avRwB1C5XGENuTdqpWKTFQaLYCIdrYrn135dfkTylehgIehhmlmP5E
         Oj/hKSru5rZANJ7PN+1qEm19WEFaYsh1Xqwh0OwTdanYWdyoMnRKKg142UlicSk0TAO7
         CFBo6NIXtyU7IDLSJxNu3Q2RIwlqhgH9NnXOEmXfPj3zWYj1S9XMsScoSnpK37wbopZM
         VtpujO89xRdw/qsKmnRF8W2KWaSZGwufO2WTc21G4WqjqZvvBRX423iA2141WVlqdizV
         Cr78hPHtoNDXCKWgax1WqmtfagM/RLoI6Qz6099NjDFbbZHMTTYAP0QYc6OywGv/5dtU
         iWIQ==
X-Gm-Message-State: AOAM530E4D7JWLjFPJ68CoijopE0QsWOJgb3pfS6UIgcA3Zb7fHWILbC
        5V79rfFxdFfrnRof9bCwb6nOCyDITAjiGkLxkvVX8h5D7UNYtlBuMPPjoW+9atLydQjnAxqP4zi
        ArC8w3opXH2qaqJrC4V9PZoFzXXdNgaC0IMsoc17PGQ==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr2442783wrt.255.1617778721598;
        Tue, 06 Apr 2021 23:58:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb0GNMb9BXI0hktJMyfEscPsHyz/GoH02QCojLY9kbR3X8bjEYRVjpos/mCtzqKkygNyE8ug==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr2442766wrt.255.1617778721479;
        Tue, 06 Apr 2021 23:58:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id c16sm2410506wrx.46.2021.04.06.23.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:58:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/3] ARM: samsung: mach/soc pull for v5.13
Date:   Wed,  7 Apr 2021 08:58:28 +0200
Message-Id: <20210407065828.7213-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407065828.7213-1-krzysztof.kozlowski@canonical.com>
References: <20210407065828.7213-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.13

for you to fetch changes up to 6031008780efaada18087eba7ec84fe149f124a9:

  ARM: exynos: correct kernel doc in platsmp (2021-04-06 22:30:02 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v5.13

1. Update Krzysztof Kozlowski's email address in Maintainers.
2. Replace deprecated pwm_request() with pwm_get() in S3C24xx.
3. Correct kerneldoc.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      MAINTAINERS: use Krzysztof Kozlowski's Canonical address
      ARM: exynos: correct kernel doc in platsmp

Uwe Kleine-König (1):
      ARM: s3c: Use pwm_get() in favour of pwm_request() in RX1950

 MAINTAINERS                     | 24 ++++++++++++------------
 arch/arm/mach-exynos/platsmp.c  | 28 +++++++++++++---------------
 arch/arm/mach-s3c/mach-rx1950.c | 11 ++++++-----
 3 files changed, 31 insertions(+), 32 deletions(-)

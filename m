Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D133A25A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFJHnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:43:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41142 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhFJHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:43:00 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrFJH-0001ZH-Q6
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 07:41:03 +0000
Received: by mail-wr1-f70.google.com with SMTP id n2-20020adfb7420000b029010e47b59f31so477825wre.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKFgI/XB09fK9EatvqSa+BvVfDN0LbVVk60PnCcv8+M=;
        b=mSE+XXvhbZbkor30YYF9C3bG8Rv5LcRJzl7TkQ/Jp06j1OMPHvCxvF3vuN6zV9VYYA
         qMSmIZCPsGuUjcCgSLovBKXG1B9NjWylm0Ew7vJAClAPMFpEqB0YvWN0lKmkmheVKXtG
         sA+R71z+IQeArer1lJRfKKB+3q9yItFfFFZKdSPmPyEt8zfJzUiT5mP/7R8WZil5y4DS
         Ylc5R9fq7D6YA0fJny8pwxlCchVwMAFd4oSSkIiYSbg6IsfY8f8oyaOMKUgvsHN/1xFh
         Wl7exycf8LKyGgbB1FC8Fp/TyjW4r5yDObLVmbOT2OJnAihOpgdyxk86+T4MsLYj5j/Z
         AlTg==
X-Gm-Message-State: AOAM5306sGQCDxHJypovLjDgn8n6imLLEer54HaYxAbsxs6LJsdW8KP0
        D1BsJent4T3RsaFClYmAnEDk6WjHukDbVHMNqDSOKQ1NlNRWdFyvfUqZJLeMbB4yEjTRS6O3Sbn
        9i3z3SXdsMPMKJN+1oBMNNzQDVdi81MER8w7BGUQ+vA==
X-Received: by 2002:a5d:6405:: with SMTP id z5mr3739150wru.39.1623310863445;
        Thu, 10 Jun 2021 00:41:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVxKzzDYrUeVcjhdd9+2Z+ibNjojMlpPJWvTPtnCppc/0gdckdpbdXOxJdd1bHuCaxQPU7Jg==
X-Received: by 2002:a5d:6405:: with SMTP id z5mr3739117wru.39.1623310863233;
        Thu, 10 Jun 2021 00:41:03 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id k11sm8417229wmj.1.2021.06.10.00.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:41:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/2] ARM: samsung: mach/soc for v5.14
Date:   Thu, 10 Jun 2021 09:40:55 +0200
Message-Id: <20210610074055.12474-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610074055.12474-1-krzysztof.kozlowski@canonical.com>
References: <20210610074055.12474-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.14

for you to fetch changes up to a6419e53c779302f8d5dd409eccf5b41ffa184a4:

  MAINTAINERS: Include Samsung PWM in Samsung SoC entry (2021-05-27 11:59:48 -0400)

----------------------------------------------------------------
Samsung mach/soc changes for v5.14

1. Fix: add missing of_node_put.
2. Extend Samsung maintainers entry to cover Samsung PWM driver files,
   because they do not have a dedicated entry.
3. Minor cleanups.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      ARM: exynos: add missing of_node_put for loop iteration
      soc: samsung: pmu: drop EXYNOS_CENTRAL_SEQ_OPTION defines
      MAINTAINERS: Include Samsung PWM in Samsung SoC entry

Wan Jiabing (1):
      ARM: s3c: Remove unnecessary break in RX1950

 MAINTAINERS                                 | 3 +++
 arch/arm/mach-exynos/exynos.c               | 2 ++
 arch/arm/mach-s3c/mach-rx1950.c             | 1 -
 include/linux/soc/samsung/exynos-regs-pmu.h | 6 ------
 4 files changed, 5 insertions(+), 7 deletions(-)

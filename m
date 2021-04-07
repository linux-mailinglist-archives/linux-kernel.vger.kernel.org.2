Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3ECD3571F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbhDGQNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:13:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47195 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhDGQNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:13:48 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUAoC-0001qi-UX
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 16:13:37 +0000
Received: by mail-wm1-f71.google.com with SMTP id h7so578531wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCaQ4X0i1Zh2bf+++rMGXv8cMwAxvbSBKfO/usQt79g=;
        b=bldxoM9A1/b0SiwFwCPKG1mQZ7uHSpDHhnYFskPqOqCRmZ8FOb3i1auzl8GB5FQ06N
         GFH5wUnhQdgC9JVAPANUtagyK4KkMAEu8HXN31Q+3M7MAEcE6gS1ulKOOAg3Rol+967U
         ZXMZmlj6aCElzkD55wn9t/Ay0uYk/NfDm/fnKTgYfvVzY2BHMCXT8wAV81pk/eQJj1js
         y0N9NlajOKziZNrvfGZMx8zo2kTASPdXNyVjKD833YC1R3ymSciO5xx+NO+m/ORgQgQ9
         mWyoCzilGFbNiYvqDkNsZZY9LaIFRdSnBXER1aitsm9C7HF2xoK/tcCvTAQAMWfR7LkD
         mPXg==
X-Gm-Message-State: AOAM533+k+4U+TizNvIYdz85I2r1JQXB9ZwNYgSRUY24uuQy8RuBI9B0
        tZ/25kEjq7g5nvftf2mO2xVMs4rTe5U87e4OnKo3iv8L5TnSSV7+HHqZrJzID1VZE/pniZv36hB
        W5Az+FuqVXmJfiVanOhuvnVozVrdMVrH1sVs+PxHnRQ==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr5159996wro.129.1617812016684;
        Wed, 07 Apr 2021 09:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzStNBdG4/Um9qP4P2r3AXJim8xMhu/B9k05GyAyYX9QtekqyznyOJpI4nqeSYbJB3JRwfhsA==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr5159987wro.129.1617812016501;
        Wed, 07 Apr 2021 09:13:36 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id k16sm20856105wrl.47.2021.04.07.09.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:13:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] memory: drivers for v5.13
Date:   Wed,  7 Apr 2021 18:13:32 +0200
Message-Id: <20210407161333.73013-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.13

for you to fetch changes up to 25dcca7fedcd4e31cb368ad846bfd738c0c6307c:

  memory: pl353: fix mask of ECC page_size config register (2021-04-05 16:15:58 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.13

1. OMAP: fix unlikely but possible out of bounds read.
2. PL353: fix mask used in setting ECC page_size in config register.
3. Minor cleanup: Freescale Corenet.

----------------------------------------------------------------
Colin Ian King (1):
      memory: gpmc: fix out of bounds read and dereference on gpmc_cs[]

Qiheng Lin (1):
      memory: fsl-corenet-cf: Remove redundant dev_err call in ccf_probe()

gexueyuan (1):
      memory: pl353: fix mask of ECC page_size config register

 drivers/memory/fsl-corenet-cf.c | 4 +---
 drivers/memory/omap-gpmc.c      | 7 +++++--
 drivers/memory/pl353-smc.c      | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

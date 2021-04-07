Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BADD3571F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344049AbhDGQNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:13:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47204 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbhDGQNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:13:48 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUAoE-0001rD-5I
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 16:13:38 +0000
Received: by mail-wr1-f69.google.com with SMTP id a6so2337731wro.15
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Srw9aPFAfT6trVNtgydDAxzyZ1eybVMpNyRiKQWc/rY=;
        b=P13cIHCpMMxVCAEIqiF47LovRm7Q3Xilaicd0e+z4pdtjMWWZwv3zLkrQBhxuAFlO6
         OnFWknwqLGiFHsXRqrGRXFFRw01xetEAunm3WxVO2ggZdRJ+if/HNZoB8SmJbZRKcckX
         dzY9/db2zqlG7vlkZ7nWZXVY6Ym9muWzAw6U7FZ+c5FfxqIY7K9JMqML3gyQo8ks/UjY
         InAHMGMd4ulGT8ZRiUoWgyv7ZYjaD6faLet4SeZ8eErEneWH3Rh2vKfaTDN5vrU+s1ac
         rr1sjX0oEnyrdrqdfoD8emZ9zKjDynFUyXQliCWRDcbXyvdmlDbs+zWeiaE7PU41dcxH
         vx7A==
X-Gm-Message-State: AOAM530dPP58szI54prvMcRYQKOrBov7QmeBo3QFcPcmTlo1nQrzGQ74
        HQtei+xA/mIVXPEvrqnX5q0d1OtVabcgDNAnuRSp7H94v6jGg+fRSjnc66ox7qKZDTIcIqCeT+C
        Zu60bO8B6ZQbVlM98U5HtAtF15rF3ewp8tTWQAQWbrQ==
X-Received: by 2002:a7b:c04d:: with SMTP id u13mr3768756wmc.83.1617812017841;
        Wed, 07 Apr 2021 09:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTXNUbV0m3g0bqClRZwiW2bxwFUmfJ0xhpYtI9EgCRAx0pK9haRiCu12aENJwkmhwA2CmZ6w==
X-Received: by 2002:a7b:c04d:: with SMTP id u13mr3768737wmc.83.1617812017569;
        Wed, 07 Apr 2021 09:13:37 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id k16sm20856105wrl.47.2021.04.07.09.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:13:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [GIT PULL 2/2] memory: tegra for v5.13
Date:   Wed,  7 Apr 2021 18:13:33 +0200
Message-Id: <20210407161333.73013-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407161333.73013-1-krzysztof.kozlowski@canonical.com>
References: <20210407161333.73013-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-tegra-5.13

for you to fetch changes up to d8d5cbc619e86b8f2167ae40d029a9d07e97b303:

  dt-bindings: memory: tegra20: mc: Convert to schema (2021-04-01 19:58:22 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.13 - Tegra SoC

1. Few cleanups.
2. Add debug statistics to Tegra20 memory controller.
3. Update bindings and convert to dtschema.  This update is not
   backwards compatible (ABI break) however the broken part was added
   recently (v5.11) and there are no users of it yet.

----------------------------------------------------------------
Dmitry Osipenko (8):
      memory: tegra20: Add debug statistics
      memory: tegra20: Correct comment to MC_STAT registers writes
      memory: tegra20: Protect debug code with a lock
      memory: tegra: Print out info-level once per driver probe
      dt-bindings: memory: tegra20: emc: Replace core regulator with power domain
      dt-bindings: memory: tegra30: emc: Replace core regulator with power domain
      dt-bindings: memory: tegra124: emc: Replace core regulator with power domain
      dt-bindings: memory: tegra20: mc: Convert to schema

Yang Li (1):
      memory: tegra: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE

 .../memory-controllers/nvidia,tegra124-emc.yaml    |   7 +-
 .../memory-controllers/nvidia,tegra20-emc.txt      |   4 +-
 .../memory-controllers/nvidia,tegra20-mc.txt       |  40 ---
 .../memory-controllers/nvidia,tegra20-mc.yaml      |  79 +++++
 .../memory-controllers/nvidia,tegra30-emc.yaml     |   7 +-
 drivers/memory/tegra/mc.c                          |   9 +
 drivers/memory/tegra/mc.h                          |   4 +-
 drivers/memory/tegra/tegra124-emc.c                |  16 +-
 drivers/memory/tegra/tegra20-emc.c                 |  20 +-
 drivers/memory/tegra/tegra20.c                     | 332 +++++++++++++++++++++
 drivers/memory/tegra/tegra30-emc.c                 |  18 +-
 include/soc/tegra/mc.h                             |   7 +
 12 files changed, 466 insertions(+), 77 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.yaml

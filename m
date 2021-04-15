Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B053602C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhDOG4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:56:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34812 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhDOG4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:56:09 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWvuk-0001lA-Nj
        for linux-kernel@vger.kernel.org; Thu, 15 Apr 2021 06:55:46 +0000
Received: by mail-ed1-f69.google.com with SMTP id r4-20020a0564022344b0290382ce72b7f9so4653044eda.19
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 23:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jW5ksZJL5w6HMjRF02e9r52MndUZOjt+ECOTfix66Mo=;
        b=suJ4GclnxeFThO3g/1gRBdLVvHwRQSw6e9XKah4kiu3Ti3LKNR2mZoN4Jonr1nOMxO
         Syaspm2L29pz0R23VzA0tLHmJwuSd/axSUQMYQ4ZIGFrxg7OYED8pBqAkbTvqqbysnK/
         3VoNxKMACV/4WEGjjnu2nrvy2t9mLwnx0NQjiJj9Id/2iiiMbLulEVUfGQTpw/L/QJ8J
         YixcLAOejS8BVYxOxdhVhO//6WGXsyH1uLC4ueiuaoi/5UAwqvIe03+4RBbLX6E+MvAa
         GHUkMfzCQ7irn1KKDrxjpFH1A7mfrETnNbB52yEUXsDLOAVx+LamWc4ki2AL8KrHkrFH
         1wtg==
X-Gm-Message-State: AOAM532pcXABaQXaZGc6yeHVOiKr4OSBPkXzMqUxJO3cO18uLbh+QtV8
        C8ywGnVMh9ARjdguyxuetLDqeL0eyK3CwA/0nvSSb4evpuZCvP5w6O7fMj3zelKb+GiANDDIkA3
        q/GzzswdIKT3UpS0ZBSVAi983QK493FOS3Y6k+t+Glw==
X-Received: by 2002:a17:906:1749:: with SMTP id d9mr1845227eje.12.1618469746453;
        Wed, 14 Apr 2021 23:55:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZZpiRats6JlqAzERLcvThQ/1Bvbg8u4Oo8oDQSgbgDgrnQpDMqGMikyN2SEpgOVvxMDYVfA==
X-Received: by 2002:a17:906:1749:: with SMTP id d9mr1845209eje.12.1618469746265;
        Wed, 14 Apr 2021 23:55:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id m14sm1526561edd.63.2021.04.14.23.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 23:55:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: Second pull for v5.13
Date:   Thu, 15 Apr 2021 08:55:14 +0200
Message-Id: <20210415065514.7385-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request - few remaining minor fixes.

Best regards,
Krzysztof


The following changes since commit 25dcca7fedcd4e31cb368ad846bfd738c0c6307c:

  memory: pl353: fix mask of ECC page_size config register (2021-04-05 16:15:58 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.13-2

for you to fetch changes up to 6ce2c05b21189eb17b3aa26720cc5841acf9dce8:

  memory: mtk-smi: Add device-link between smi-larb and smi-common (2021-04-13 16:56:31 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.13, part two

1. Renesas RPC: fix possible NULL pointer.
2. Exynos5422 DMC: add proper error checking for clk_prepare.
3. Mediatek SMI: use device-links instead of explicit PM runtime calls.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      memory: renesas-rpc-if: fix possible NULL pointer dereference of resource
      memory: samsung: exynos5422-dmc: handle clk_set_parent() failure

Yong Wu (1):
      memory: mtk-smi: Add device-link between smi-larb and smi-common

 drivers/memory/mtk-smi.c                | 19 ++++++++++---------
 drivers/memory/renesas-rpc-if.c         |  2 +-
 drivers/memory/samsung/exynos5422-dmc.c |  4 +++-
 3 files changed, 14 insertions(+), 11 deletions(-)

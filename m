Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93503BBB43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhGEKfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhGEKf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:35:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01221C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 03:32:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r26so14171233lfp.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYZpVwbfMVbx6/fArrYjrJ15D0k3jdBPYEWHCYqTbjo=;
        b=U7C1hslnJQyOfy306sXVLA+OS9YyZH+ctC0OqDgCzZLbWD3UmAiJQUUAs9zSPrJSRW
         NlJ6eTJRMGvxxb9dqQaCFGOTQMH/u7sJrJ/dQjidVJuXSGz8W+Epq6DE/36OAdNIkz3k
         tRX7RX7+o5zD+PBIGbXybl3/o7Zz0QiyVXovwWH42rJf6ifoNVAkfUioQXgLxa+dVoSL
         yAM7NTyff5sFoogkLx1xSefMnC5kcnana6CgLvUR/h05qFmgBIK90CKao8ktxO8Ja4KS
         u2I6td6gh2q9FdRbr8FSvMjnN8hIG+KVbRTrsVIhdnvr2MyfSY6GUsIvwgJCwzxkSpKL
         h/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYZpVwbfMVbx6/fArrYjrJ15D0k3jdBPYEWHCYqTbjo=;
        b=SZwX+S7C8hyXN1vfrwdY8Ha2+FpfMZAn5QVbB/seii5vwSagC12fu5vgNzSQyYHLIF
         tG2yeTwjzDibP+Fl/gTRItqwIL3Em3wT+i1CCQjTTuacBE4yAKTkyjg20XMIn2tgwNco
         zlDGPg7BPjJabAW7xmYkkXNFyKV20Y34SMqeUOG7xorfPqfP+A5+ZmCd4UOSO9XMQv49
         XVIvGdVEPIlCIG+i+Zw8i1TxItEN1OAF3CmbYdlrjCvmPH6gQs3Cg/JkjASKELgxhTL3
         KRm06/3uRDy1FrUsgEEAohyhU+Uw7wRUjks/callfkDwfCQhlsBYKKE23XCaIdwBE3G6
         XhVQ==
X-Gm-Message-State: AOAM530q2GxuttxqN7jS/uBcwteZf1fcGU5J0UGbYWqCwqVQXP/idXMY
        HdWyfmiLuzOlo7nG4I656W16YhFxD1Sk+o2o
X-Google-Smtp-Source: ABdhPJzVMP+7krxZlOZ0s0aPMV4he6kHPqvw4QgGuPeFhb+EjLSfLWUKhYesSggPN5ACyFLTuYiqlA==
X-Received: by 2002:a05:6512:b92:: with SMTP id b18mr10141323lfv.11.1625481170316;
        Mon, 05 Jul 2021 03:32:50 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id e4sm1276031ljn.100.2021.07.05.03.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 03:32:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.14-rc1
Date:   Mon,  5 Jul 2021 12:32:48 +0200
Message-Id: <20210705103248.7811-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a pull-request with a few updates/fixes for MMC for v5.14-rc1. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c54b245d011855ea91c5beff07f1db74143ce614:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace (2021-06-28 20:39:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-2

for you to fetch changes up to d0244847f9fc5e20df8b7483c8a4717fe0432d38:

  mmc: sdhci: Fix warning message when accessing RPMB in HS400 mode (2021-07-02 14:59:51 +0200)

----------------------------------------------------------------
MMC core:
  - Clear flags before allowing to retune

MMC host:
 - sdhci: Clear unused bounce buffer at DMA mmap error path
 - sdhci: Fix warning message when accessing RPMB in HS400 mode
 - sdhci-of-arasan: Use clock-frequency property to update clk_xin
 - mtk-sd: Fixup compatible string for MT8195

----------------------------------------------------------------
Al Cooper (1):
      mmc: sdhci: Fix warning message when accessing RPMB in HS400 mode

Rashmi A (2):
      mmc: sdhci-of-arasan: Use clock-frequency property to update clk_xin
      phy: intel: Fix for warnings due to EMMC clock 175Mhz change in FIP

Takashi Iwai (1):
      mmc: sdhci: Clear unused bounce buffer at DMA mmap error path

Wenbin Mei (1):
      dt-bindings: mmc: change compatiable string for MT8195 mmc host IP

Wolfram Sang (1):
      mmc: core: clear flags before allowing to retune

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml |  2 ++
 drivers/mmc/core/core.c                           |  7 +++++--
 drivers/mmc/host/sdhci-of-arasan.c                | 14 ++++++++++++--
 drivers/mmc/host/sdhci.c                          | 10 +++++++++-
 drivers/mmc/host/sdhci.h                          |  1 +
 drivers/phy/intel/phy-intel-keembay-emmc.c        |  3 ++-
 6 files changed, 31 insertions(+), 6 deletions(-)

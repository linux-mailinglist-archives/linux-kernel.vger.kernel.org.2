Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3A2324489
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 20:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhBXTSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 14:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhBXTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 14:18:37 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16F7C06178B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:17:34 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d9so3215252ote.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nB6G31ifHs1XRqYmtnHDEje7sHPajlmEoehYS5A3DUc=;
        b=VZOx7qUR+7mJXqJ9iqn6paTOVJxuWYZc0sdvlthC4ugg5fZ0nAT2WWqSGeEzVkbjVk
         65HrpZVjIhUuwAYReB+iN7NdX53zBhBW50vRqlZNFO6kHsdUmNZbEgR5g27S9LLgK5yK
         D9E7bb6k/X8AynTPcRS+HMYwjmxhjo/5uF7IYE9q9SKcLfDBFqaj7/tVd9i1qvsT7S+s
         P0SAVbZTSfDw7nDTHTBot1dfwQiZDFnesiGnTMEGr0ZfN1Kfl5zJwd3nlUkNgi27QbHu
         HOsP/yLV1O7PoAkunpBddf2Z6BWB9/8tjZq3nSQpY+5ClJ2YwSUYozuuHl+J90I1JAf5
         +uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nB6G31ifHs1XRqYmtnHDEje7sHPajlmEoehYS5A3DUc=;
        b=U9DnIb/fz2Z7IFyLB0qmLiH1kQjdkX86Jm1234Yp9Kf2BV0tDkZdn2F8EWGUVh/7x0
         Z4y3nLMz3udgEQ93XdJ6VvnXbv1Jy/zvp+HTH2onCMmWpNPjsOoTGeQV8c863aeIpOzI
         e6UG2yKde3oEd7oHST38+gjglliPYO73MPR+OVhkZNXVDkHcnpRymaEZ+WszEtxNiFFW
         yz3s6XxoDzAPzUa4O6Pvi33oRAsUHqq4tkSPbXkWkw7heRi1ycJJnjaOstosi5NyyDA/
         kKh9n0nSEGAAYS2kV+Q5v2dfqj40iatY7xd8wae1w3oAcW4szv55/N5k1CX4/S79xraB
         K59A==
X-Gm-Message-State: AOAM530cyyHEM4QisbPLgJrhXZ+35qFCtmzrOWhPS9gHAN36JOR3G6T2
        pA9lSobRjfQm1OFSIQoOjp8FZY3MqJI3kQ==
X-Google-Smtp-Source: ABdhPJxPMUQBuUeHbRa1hG6opY8bKdFANOOrneclwF3w8TQpazZD8r47t2+LLG86KBoAGoZU0Nsc8g==
X-Received: by 2002:a9d:65c2:: with SMTP id z2mr26217258oth.288.1614194254274;
        Wed, 24 Feb 2021 11:17:34 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k21sm559297ood.13.2021.02.24.11.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:17:33 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss-st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [GIT PULL] remoteproc updates for v5.12
Date:   Wed, 24 Feb 2021 13:17:32 -0600
Message-Id: <20210224191732.192685-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.12

for you to fetch changes up to e8b4e9a21af77b65ea68bd698acf4abe04afd051:

  remoteproc: qcom: pas: Add SM8350 PAS remoteprocs (2021-02-11 12:52:18 -0600)

----------------------------------------------------------------
remoteproc updates for v5.12

This adds remoteproc support for the audio, compute, sensor and modem
remoteprocs on the Qualcomm SM8350 platform, it adds Qualcomm WCN3660b
support, Mediatek MT8192 SCP driver support for MPU and L1TCM memory,
STM32 driver adopts dev_err_probe() and the Qualcomm Kconfig
help texts are revamped.

----------------------------------------------------------------
Arnaud Pouliquen (1):
      remoteproc: stm32: improve debug using dev_err_probe

Arnd Bergmann (1):
      remoteproc: qcom: fix glink dependencies

Daniele Alessandrelli (1):
      remoteproc: core: Fix rproc->firmware free in rproc_set_firmware()

Paul Cercueil (1):
      remoteproc: ingenic: Add module parameter 'auto_boot'

Shawn Guo (1):
      remoteproc: qcom: add more help text qcom options

Stephan Gerhold (2):
      dt-bindings: remoteproc: qcom,wcnss: Add qcom,wcn3660b compatible
      remoteproc: qcom_wcnss: Add qcom,wcn3660b compatible

Tzung-Bi Shih (5):
      remoteproc/mediatek: acknowledge watchdog IRQ after handled
      remoteproc/mediatek: use devm_platform_ioremap_resource_byname
      remoteproc/mediatek: enable MPU for all memory regions in MT8192 SCP
      dt-bindings: remoteproc: mediatek: add L1TCM memory region
      remoteproc/mediatek: support L1TCM

Vinod Koul (2):
      dt-bindings: remoteproc: qcom: pas: Add SM8350 remoteprocs
      remoteproc: qcom: pas: Add SM8350 PAS remoteprocs

Yang Li (1):
      remoteproc: qcom_wcnss: remove unneeded semicolon

 .../devicetree/bindings/remoteproc/mtk,scp.txt     |  8 +--
 .../devicetree/bindings/remoteproc/qcom,adsp.txt   | 12 ++++
 .../bindings/remoteproc/qcom,wcnss-pil.txt         |  1 +
 drivers/remoteproc/Kconfig                         | 25 +++++--
 drivers/remoteproc/ingenic_rproc.c                 |  7 ++
 drivers/remoteproc/mtk_common.h                    |  7 ++
 drivers/remoteproc/mtk_scp.c                       | 82 ++++++++++++++++++----
 drivers/remoteproc/qcom_q6v5_pas.c                 | 63 +++++++++++++++++
 drivers/remoteproc/qcom_wcnss.c                    |  2 +-
 drivers/remoteproc/qcom_wcnss_iris.c               |  1 +
 drivers/remoteproc/remoteproc_core.c               |  2 +-
 drivers/remoteproc/stm32_rproc.c                   | 23 +++---
 12 files changed, 198 insertions(+), 35 deletions(-)

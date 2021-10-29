Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4986543FC07
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhJ2MJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhJ2MJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:09:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0B9C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:07:12 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 17so13364026ljq.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eirQQDFGLnuOBylNysB2OPO3DM0CiT5s5esxUOxGBw=;
        b=lqTKm2lv4z205Qp89xJiLSTdgPD7+cbtM+/QE+QRN/gUlp1OmplLRredwuByu6Al/P
         Wo71Zho7LNfYeOnoSlPX4hcM+Jdyel5sH2cgJGFzOK5hYaNr2nVqMIlRwDS5sRKEtZDy
         xmwTJsedlGE/cJ36KHirqKd4wL6gw2f9OVCwev+yOE/G9PbN7tTn3HLFFn4gQuXPCtkl
         W6/Td2LmBPjYvT3DBBUixDzG75AyTHYhO5CWTObXim/QTV3EO213oaxYhzsV87B53aVA
         skdLHHpMsmstX9qKt4wIeZckp+rfRga7dYhR57l1DidaRpt9OmXSz0tyMhgWwcEW+x+g
         YliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eirQQDFGLnuOBylNysB2OPO3DM0CiT5s5esxUOxGBw=;
        b=iAGOV1w1h1LscFUQ/+G7VdXzc/xEJmDKQ1EchRLEiBYaWJWgYvEh5B62T6p8GqZkRB
         sNPMyzFyNWBfjaFauQBRNWCqj2LaW8FOrUo+jWFQXSTcEHfc7X/054ofAAUyD3BmXtQz
         jz5OXXTpE2OisqLay3aCsNWSnFtVRGnrlTf4BGuBW9y8l4W22q+nZYYkR+DSsHPV0Y0z
         Bv8hX94LLcSisI5W1IntPJGKfwWdaosThc0NyxXfShexD//ZLNWHwVnwa1dmuoqqnJHe
         RjynHzZvTraHR3DZYfvpXWFf+eV1qtXFFpw0otM1vuTOkk2gFuuIkaEJ0FDdMkaJm2Cq
         MZ+Q==
X-Gm-Message-State: AOAM530M2CLDFzpvnP/0DuAIXHH+TQyEytwXaHwERTBaMnfmmax+kMGa
        g72AE+fAbFXYLouGEjEoFS4eMA==
X-Google-Smtp-Source: ABdhPJyzLo62tQdRTxyLQ9J4EAJXL52ZopoxaBT7MrOT9ts4P2uBgR1n0cJbehD4Tklkq/Bp6bPmgA==
X-Received: by 2002:a2e:5344:: with SMTP id t4mr11017960ljd.294.1635509230709;
        Fri, 29 Oct 2021 05:07:10 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id m3sm303935lfr.203.2021.10.29.05.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:07:09 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.15-rc8
Date:   Fri, 29 Oct 2021 14:07:09 +0200
Message-Id: <20211029120709.79366-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.15-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15-rc5

for you to fetch changes up to 90935eb303e0d12f3d3d0383262e65290321f5f6:

  mmc: tmio: reenable card irqs after the reset callback (2021-10-28 23:19:32 +0200)

----------------------------------------------------------------
MMC host:
 - tmio: Re-enable card irqs after a reset
 - mtk-sd: Fixup probing of cqhci for crypto
 - cqhci: Fix support for suspend/resume
 - vub300: Fix control-message timeouts
 - dw_mmc-exynos: Fix support for tuning
 - winbond: Silences build errors on M68K
 - sdhci-esdhc-imx: Fix support for tuning
 - sdhci-pci: Read card detect from ACPI for Intel Merrifield
 - sdhci: Fix eMMC support for Thundercomm TurboX CM2290

----------------------------------------------------------------
Andy Shevchenko (1):
      mmc: sdhci-pci: Read card detect from ACPI for Intel Merrifield

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: clear the buffer_read_ready to reset standard tuning circuit

Jaehoon Chung (1):
      mmc: dw_mmc: exynos: fix the finding clock sample value

Johan Hovold (1):
      mmc: vub300: fix control-message timeouts

Randy Dunlap (1):
      mmc: winbond: don't build on M68K

Shawn Guo (1):
      mmc: sdhci: Map more voltage level to SDHCI_POWER_330

Wenbin Mei (2):
      mmc: cqhci: clear HALT state after CQE enable
      mmc: mediatek: Move cqhci init behind ungate clock

Wolfram Sang (1):
      mmc: tmio: reenable card irqs after the reset callback

 drivers/mmc/host/Kconfig           |  2 +-
 drivers/mmc/host/cqhci-core.c      |  3 +++
 drivers/mmc/host/dw_mmc-exynos.c   | 14 ++++++++++++++
 drivers/mmc/host/mtk-sd.c          | 38 +++++++++++++++++++-------------------
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++++++
 drivers/mmc/host/sdhci-pci-core.c  | 29 ++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.c           |  6 ++++++
 drivers/mmc/host/tmio_mmc_core.c   | 17 ++++++++++++-----
 drivers/mmc/host/vub300.c          | 18 +++++++++---------
 9 files changed, 104 insertions(+), 39 deletions(-)

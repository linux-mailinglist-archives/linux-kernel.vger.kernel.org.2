Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C0392F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhE0NS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbhE0NSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:18:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA805C061574;
        Thu, 27 May 2021 06:16:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gb17so7969071ejc.8;
        Thu, 27 May 2021 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3TKX6UNfeQq3WZk8B3GWpeEI9lZ4hogpPt1mzI6b/B8=;
        b=Y/dktLEgafQ1yisGN5JQY4g+/sBKCpKIsJ7Y6eIfX3esJO3osva49CIhhDqbCo5s59
         WB5QLcPJe60vPsB+ex4yFoqZpg5YyZV7WsVLwBgyNly3llcLKRTHzK6cTrL4gSbGyHus
         fK7JDLdYGHh87Y10M9SYgeDleTmv+G3p26UPoOAowX4/ROg0AscWET3NzVr3Ol+d6+ef
         CJWN03f1xWNhPOiwCm2rvK/90Zxw3931w/aP3aFQtdiFunkJHQZsqoZPe5xS8qvY5Has
         o2CKtakT9b5uw56l2s/lLDutkc03KFDZL3+GBYKlPYQIRKtTfeU4HiEuspBVngFU7dow
         dpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3TKX6UNfeQq3WZk8B3GWpeEI9lZ4hogpPt1mzI6b/B8=;
        b=XTb5rKrFIRXDnhBgnIm4Dhzzfj8cABlQgCrsidZ9FrcpUtmmYpbO1B1UZLqFWKkO5k
         lssRjGEh4X/YLDhfBiUhdHLp93uwlMxKhZVTe2+vd/Fr4oYyp6CPBvyaKna1Zn7B5VQi
         flfIox+g0+i2gHscnkaBjmot6trB8nxtt5F2GR40LUKl0+2X5dIWjbHH/Gj8SGeMwf9H
         gGfHMaISvFb/xj6q6T5KSFJtwiEoK8ejpOouiYlzAQJwBMqxHG+Ze6Mq1SIUaU9YvxKY
         Xf2wGJ7l0iNc0xzfMglBX+B0bXuWndZdbuQdsq9KRl5gmcT2iQg8/7gAMqtwt7apxLb8
         bIjg==
X-Gm-Message-State: AOAM532dJK6F6kQubZiB4KGDs4eD64+0oczUPqA45pcdhaPLnfOhxw0N
        gpwAeAQ8+MQ6IczqU02a0c4=
X-Google-Smtp-Source: ABdhPJwBVB9+hl2sioh4pL46AM9iKCqMLQa0H3gAXYKW2Szd632xngaLhF46xSoMTLP6IWTG/8X6ag==
X-Received: by 2002:a17:906:949a:: with SMTP id t26mr3752351ejx.475.1622121407365;
        Thu, 27 May 2021 06:16:47 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id r23sm1104206edq.59.2021.05.27.06.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 06:16:46 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/6] Improve clock support for Actions S500 SoC
Date:   Thu, 27 May 2021 16:16:38 +0300
Message-Id: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on a driver to support the Actions Semi Owl Ethernet MAC,
I found and fixed some issues on the existing implementation of the S500
SoC clock subsystem and, additionally, I added two missing clocks.

Thanks,
Cristi

Changes in v2 (according to Mani's review):
- Re-added entry "{ 24, 1, 25 }" to sd_factor_table, according to the
  datasheet (V1.8+), this is a valid divider
- Re-added OWL_GATE_HW to SENSOR[0-1], according to the datasheet they
  are gated, even though the vendor implementation states the opposite
- Reverted the addition of the clock div table for H clock to support the
  '1' divider (according to the datasheet), even though the vendor
  implementation marks it as reserved
- Reordered "nic_clk_mux_p" after "ahbprediv_clk_mux_p" to follow the reg
  field ordering
- Rebased patch series on v5.13-rc3

Cristian Ciocaltea (6):
  clk: actions: Fix UART clock dividers on Owl S500 SoC
  clk: actions: Fix SD clocks factor table on Owl S500 SoC
  clk: actions: Fix bisp_factor_table based clocks on Owl S500 SoC
  clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl S500 SoC
  dt-bindings: clock: Add NIC and ETHERNET bindings for Actions S500 SoC
  clk: actions: Add NIC and ETHERNET clock support for Actions S500 SoC

 drivers/clk/actions/owl-s500.c               | 92 +++++++++++++-------
 include/dt-bindings/clock/actions,s500-cmu.h |  6 +-
 2 files changed, 65 insertions(+), 33 deletions(-)

-- 
2.31.1


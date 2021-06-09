Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78653A1586
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhFINZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236287AbhFINZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623245015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GMoGoh2HRdMM9sJwX6YN1+PVxLx5DD2e1fp3oIQPxak=;
        b=gWcvEVuxQvyaftW9FAGXcYg6Fdt2bDSmV5SZu7roPkCcxilDAask2jjkGCHMkEXdaKY9O9
        cIhBYbf8cJ9dkiQv4Q1uocFLtQmvsVYjiZAjnfJoxiJFd2POcN22tJs9ECSVdHR4usLPck
        ns+FlQY9fPR2TDrz8BGBi5brUGRBKT8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-fIzKNrHuMq2j3N2AqnqrAA-1; Wed, 09 Jun 2021 09:23:32 -0400
X-MC-Unique: fIzKNrHuMq2j3N2AqnqrAA-1
Received: by mail-oi1-f197.google.com with SMTP id w9-20020a0568080d49b02901f3febe5739so4117084oik.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMoGoh2HRdMM9sJwX6YN1+PVxLx5DD2e1fp3oIQPxak=;
        b=RnbLg2BN+k+8ih6ffzPlxXb1DP1HFWCYbUc/+wI9Sn+jB9YB0XZEuvGb+zjr9hpUGP
         /0FV87tRlBK69aacDzL4gHqD4ynpjeA6ecJekTNgYhKY55MdkvjWh/Jnfm0Vbcg7w6SE
         hPIoVGY7RmiQ823EW2zWzPJLIkoA5m2dhAc/75QYP35hDKUP3FUYWYHnTK49mXZ2VNhE
         tK5WqKUlAQP7rPWXwdlDzapABu9FGB84gBDgiWOmMXKbXVdr2lf0mHdredN0vnHKLoG2
         NOKElJujhYq3S1n8n6ecyxLOcUUAirrIBObXNoHXSeYEMd26TA4CoCEx7/Jz6BbND5RB
         FayA==
X-Gm-Message-State: AOAM533NSdp1Mpc+0+F+TTEoQgA2AhpZhhccNFQRzLfXI6vJHp2WnX1G
        TR6cx76dNGZ2rkq3pSkn2A9jTbifeac+W7m7jNQNxDvdsTURNn7ZwqnkLE2Olb+X7q4vi7+J6nY
        NHcUoF/KgvGmf+Ix2iN5qFrgA
X-Received: by 2002:a9d:1d21:: with SMTP id m30mr23363354otm.145.1623245010292;
        Wed, 09 Jun 2021 06:23:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydARdiHq8phH1rVCd2rtPnu21b5nt/oM27/i7eYYIcqaQSBvNa5sJkdoPzOFhOlfjHs69E/w==
X-Received: by 2002:a9d:1d21:: with SMTP id m30mr23363338otm.145.1623245010121;
        Wed, 09 Jun 2021 06:23:30 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 21sm3165654otd.21.2021.06.09.06.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:23:29 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 7/7] fpga: altera: remove altera- prefix on files
Date:   Wed,  9 Jun 2021 06:21:51 -0700
Message-Id: <20210609132151.3081379-9-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210609132151.3081379-1-trix@redhat.com>
References: <20210609132151.3081379-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

It is not necessary to have an altera- prefix on a file
when the file is in an altera/ subdir.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/altera/Makefile                         | 12 ++++++------
 drivers/fpga/altera/{altera-cvp.c => cvp.c}          |  0
 .../altera/{altera-fpga2sdram.c => fpga2sdram.c}     |  0
 .../{altera-freeze-bridge.c => freeze-bridge.c}      |  0
 .../fpga/altera/{altera-hps2fpga.c => hps2fpga.c}    |  0
 .../{altera-pr-ip-core-plat.c => pr-ip-core-plat.c}  |  0
 .../altera/{altera-pr-ip-core.c => pr-ip-core.c}     |  0
 drivers/fpga/altera/{altera-ps-spi.c => ps-spi.c}    |  0
 8 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/fpga/altera/{altera-cvp.c => cvp.c} (100%)
 rename drivers/fpga/altera/{altera-fpga2sdram.c => fpga2sdram.c} (100%)
 rename drivers/fpga/altera/{altera-freeze-bridge.c => freeze-bridge.c} (100%)
 rename drivers/fpga/altera/{altera-hps2fpga.c => hps2fpga.c} (100%)
 rename drivers/fpga/altera/{altera-pr-ip-core-plat.c => pr-ip-core-plat.c} (100%)
 rename drivers/fpga/altera/{altera-pr-ip-core.c => pr-ip-core.c} (100%)
 rename drivers/fpga/altera/{altera-ps-spi.c => ps-spi.c} (100%)

diff --git a/drivers/fpga/altera/Makefile b/drivers/fpga/altera/Makefile
index 4d725c72fcbef..c2d626cd1f540 100644
--- a/drivers/fpga/altera/Makefile
+++ b/drivers/fpga/altera/Makefile
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_ALTERA_FREEZE_BRIDGE) += altera-freeze-bridge.o
-obj-$(CONFIG_ALTERA_PR_IP_CORE) += altera-pr-ip-core.o
-obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT) += altera-pr-ip-core-plat.o
-obj-$(CONFIG_FPGA_MGR_ALTERA_CVP) += altera-cvp.o
-obj-$(CONFIG_FPGA_MGR_ALTERA_PS_SPI) += altera-ps-spi.o
+obj-$(CONFIG_ALTERA_FREEZE_BRIDGE) += freeze-bridge.o
+obj-$(CONFIG_ALTERA_PR_IP_CORE) += pr-ip-core.o
+obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT) += pr-ip-core-plat.o
+obj-$(CONFIG_FPGA_MGR_ALTERA_CVP) += cvp.o
+obj-$(CONFIG_FPGA_MGR_ALTERA_PS_SPI) += ps-spi.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA) += socfpga.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10) += socfpga-a10.o
 obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC) += stratix10-soc.o
 obj-$(CONFIG_FPGA_MGR_TS73XX) += ts73xx-fpga.o
-obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE) += altera-hps2fpga.o altera-fpga2sdram.o
+obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE) += hps2fpga.o fpga2sdram.o
diff --git a/drivers/fpga/altera/altera-cvp.c b/drivers/fpga/altera/cvp.c
similarity index 100%
rename from drivers/fpga/altera/altera-cvp.c
rename to drivers/fpga/altera/cvp.c
diff --git a/drivers/fpga/altera/altera-fpga2sdram.c b/drivers/fpga/altera/fpga2sdram.c
similarity index 100%
rename from drivers/fpga/altera/altera-fpga2sdram.c
rename to drivers/fpga/altera/fpga2sdram.c
diff --git a/drivers/fpga/altera/altera-freeze-bridge.c b/drivers/fpga/altera/freeze-bridge.c
similarity index 100%
rename from drivers/fpga/altera/altera-freeze-bridge.c
rename to drivers/fpga/altera/freeze-bridge.c
diff --git a/drivers/fpga/altera/altera-hps2fpga.c b/drivers/fpga/altera/hps2fpga.c
similarity index 100%
rename from drivers/fpga/altera/altera-hps2fpga.c
rename to drivers/fpga/altera/hps2fpga.c
diff --git a/drivers/fpga/altera/altera-pr-ip-core-plat.c b/drivers/fpga/altera/pr-ip-core-plat.c
similarity index 100%
rename from drivers/fpga/altera/altera-pr-ip-core-plat.c
rename to drivers/fpga/altera/pr-ip-core-plat.c
diff --git a/drivers/fpga/altera/altera-pr-ip-core.c b/drivers/fpga/altera/pr-ip-core.c
similarity index 100%
rename from drivers/fpga/altera/altera-pr-ip-core.c
rename to drivers/fpga/altera/pr-ip-core.c
diff --git a/drivers/fpga/altera/altera-ps-spi.c b/drivers/fpga/altera/ps-spi.c
similarity index 100%
rename from drivers/fpga/altera/altera-ps-spi.c
rename to drivers/fpga/altera/ps-spi.c
-- 
2.26.3


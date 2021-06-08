Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FFE39FC82
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhFHQ22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231474AbhFHQ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623169591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GMoGoh2HRdMM9sJwX6YN1+PVxLx5DD2e1fp3oIQPxak=;
        b=DMH4wsv5CU+2Go4G58DmTZmKqnCHwjkRezJIjgYNziIopV3RFfpszipmcDCuVuMHeeWkv+
        A7rqGW0/XAe/fXtcSUsUzp8+nsOpVbieLYmm3pa+p5+ZY9t6BIeGyuqoxf6HGgtX0PCqZF
        YZwauNR8XUsZk+ieEatN3Quj/dG51n4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-T4JWPHwmMwKkctrl4HR8WA-1; Tue, 08 Jun 2021 12:26:29 -0400
X-MC-Unique: T4JWPHwmMwKkctrl4HR8WA-1
Received: by mail-oo1-f71.google.com with SMTP id l13-20020a4aa78d0000b0290245c8f11ac2so13596241oom.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GMoGoh2HRdMM9sJwX6YN1+PVxLx5DD2e1fp3oIQPxak=;
        b=Oq05SvUH0MHI5Z5pZxhEgxYcxjGsfk5j0lHr8e2/wNRUuspeVg1Z3VPpW72MS0zuNN
         YM3lwXWjT/3YYNiYBbDauuOP5baR3kfywcMrVBH1IWrnGyudCjH+Zs2EzWf3T/wlSp7X
         hwQ6THd8QDalTlVPBC1DnWSmuxm/mnI7J3m9Xk3JGRgH1Vc9dEFVahKvk2kyWoOkhskS
         xGUOFS65iWERVY4za6VVfK2m6koZy9ARovbsPOb9oKpIGKgpqxFNHEsKPsFsXblfPREe
         fXd71e9GbsAaKnLTClN7hU2tZdxn3VOosVvSfhCLo2qJKh8p9l1slVvMNZGtaLhHAckD
         xTdg==
X-Gm-Message-State: AOAM530p8bI02TLaOPD0cUGCX7gt0Ggh2nCDGNK87Taoz/SzCVSEdQrK
        Oqb0QOAMBFUpRRo7C31czFc6wvMH+kylzy8HN1KrzkLcFnyntpnObRyVdTxxYYx5Bni4wY1Asck
        r81pGqx1uRyiGK0mmZMir7DZj
X-Received: by 2002:aca:db46:: with SMTP id s67mr3305697oig.42.1623169587274;
        Tue, 08 Jun 2021 09:26:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9n4hvPaztcd6hSoy6zw5fuAdVUK8+k9iGgUYp8X8lcdjpV7RkpIpcqFrv43ITWqN+CM4Hww==
X-Received: by 2002:aca:db46:: with SMTP id s67mr3305691oig.42.1623169587106;
        Tue, 08 Jun 2021 09:26:27 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q1sm2944185oog.46.2021.06.08.09.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:26:26 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, fpacheco@redhat.com, gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 7/7] fpga: altera: remove altera- prefix on files
Date:   Tue,  8 Jun 2021 09:26:23 -0700
Message-Id: <20210608162623.3010726-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
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


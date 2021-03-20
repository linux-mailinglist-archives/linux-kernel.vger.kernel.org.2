Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A75B3429C6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhCTB4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCTB4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:56:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75AAC061760;
        Fri, 19 Mar 2021 18:56:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h3so7092103pfr.12;
        Fri, 19 Mar 2021 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WyQQkX5CJUcVfPMGz7goUlkQcRufENry584EI8E5M4A=;
        b=a7pjcF34qFWFXuESzlXzPnx5XFh/9wNJfJQ7Vdn3fbFAKFMMVvS9VfemyOoaxVg9rJ
         HKHS1FqDEqkOz9MhfG67qU/kQCKOWqSpbU/99IXTrCDxQqD0zYDkxUZu9x8EVLKWBuPv
         6bgyoYZmtnRNTzDGM6MPniRPV17sWSGWnYEJql2+YzlQ4WpYE++CFmr4jpcoKlC1asgJ
         M4iL6Wf2zZ4YhgIaCntb9imWyJGPCG2RS+DgdeP+1e6E6LfzowRbVr0OJOhwEPV6h4Rq
         9fyFhWz1TEmqJI8wxrQK4BY4yB0KvQsHYx+7gRzMaolNu/vH6lBMhW2EsnIH9+HtP41T
         M+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WyQQkX5CJUcVfPMGz7goUlkQcRufENry584EI8E5M4A=;
        b=bMlEMnFTmFzAJBsijlVVUBTf0Uho6gjwGVSfT1x52OHAT7CYnB83x4A1qtL4OLkNQx
         dLEiuARQXkN1BnhfrWCbjoj6FEW0W7D/TDYPiTkv6LkCt9l46N+m1eQtEpZagBJsxB9Z
         1YOT+4dWbb8K/MiftrvCEkXLMrFr9RIk+TNwRdce5H2AVUX6yILxybAfjRmvNyWhIIHj
         XP/7XVSbLEoGN4Oj4IfAKbpTHeeOK/y7gcgAkThBoL+5FuH04WXglsB+yKeVFSRdhKhE
         lWrYeBxfoYcLZ+Us+k3KtU1jrAHNRToQjkRhVCS9FWCsvcx3e1gDA8TrJRPjZjYk2+0W
         Pu8Q==
X-Gm-Message-State: AOAM530oYigPMQ9yi7VLsOrMoAro9ECvM565gYznXiW3sZHNOAyTdEtv
        AeVuOyvcAm99dvNz6oTKFVvn/gjLcPEVw81/
X-Google-Smtp-Source: ABdhPJzg+2CHcrhWDOfcOasIhwJmhJVp4zr7tS3o29OD7oivdj1Cb3f2+mFH/MJ8DJFNtrlFOyU5MA==
X-Received: by 2002:a62:92cc:0:b029:1fa:515d:808f with SMTP id o195-20020a6292cc0000b02901fa515d808fmr11558510pfd.43.1616205397558;
        Fri, 19 Mar 2021 18:56:37 -0700 (PDT)
Received: from localhost.localdomain ([204.44.111.4])
        by smtp.gmail.com with ESMTPSA id y7sm5755904pgp.23.2021.03.19.18.56.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 18:56:37 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        robh+dt@kernel.org, a.fatoum@pengutronix.de,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, linux-serial@vger.kernel.org,
        lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v4 1/9] Documentation: arm: stm32: Add stm32h750 value line doc
Date:   Sat, 20 Mar 2021 09:56:17 +0800
Message-Id: <1616205383-24114-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
References: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset add support for soc stm32h750, stm32h750 has mirror
different from stm32h743

item            stm32h743     stm32h750
flash size:     2MiB          128KiB
adc:            none          3
crypto-hash:    none          aes/hamc/des/tdes/md5/sha

detail information can be found at:
https://www.st.com/en/microcontrollers-microprocessors/stm32h750-value-line.html

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v4: no changes

 Documentation/arm/index.rst                    |  1 +
 Documentation/arm/stm32/stm32h750-overview.rst | 34 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst

diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index b4bea32472b6..d4f34ae9e6f4 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -52,6 +52,7 @@ SoC-specific documents
    stm32/stm32f746-overview
    stm32/overview
    stm32/stm32h743-overview
+   stm32/stm32h750-overview
    stm32/stm32f769-overview
    stm32/stm32f429-overview
    stm32/stm32mp157-overview
diff --git a/Documentation/arm/stm32/stm32h750-overview.rst b/Documentation/arm/stm32/stm32h750-overview.rst
new file mode 100644
index 000000000000..0e51235c9547
--- /dev/null
+++ b/Documentation/arm/stm32/stm32h750-overview.rst
@@ -0,0 +1,34 @@
+==================
+STM32H750 Overview
+==================
+
+Introduction
+------------
+
+The STM32H750 is a Cortex-M7 MCU aimed at various applications.
+It features:
+
+- Cortex-M7 core running up to @480MHz
+- 128K internal flash, 1MBytes internal RAM
+- FMC controller to connect SDRAM, NOR and NAND memories
+- Dual mode QSPI
+- SD/MMC/SDIO support
+- Ethernet controller
+- USB OTFG FS & HS controllers
+- I2C, SPI, CAN busses support
+- Several 16 & 32 bits general purpose timers
+- Serial Audio interface
+- LCD controller
+- HDMI-CEC
+- SPDIFRX
+- DFSDM
+
+Resources
+---------
+
+Datasheet and reference manual are publicly available on ST website (STM32H750_).
+
+.. _STM32H750: https://www.st.com/en/microcontrollers-microprocessors/stm32h750-value-line.html
+
+:Authors: Dillon Min <dillon.minfei@gmail.com>
+
-- 
1.9.1


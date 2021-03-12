Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50323385CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCLGYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhCLGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:24:43 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE9C061574;
        Thu, 11 Mar 2021 22:24:43 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id j12so1140036pfj.12;
        Thu, 11 Mar 2021 22:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qjbDTQ7WcmhFUnalAhXH6DnuMDJuzq69+97XUCv4p4c=;
        b=MuibLYrsntGNyTt1r0LoAiJ0PeMM5UtNUeKFiSWUnai8Hqzuz/pRRpc02BrtWxCWqh
         9K9v2iNQ8Mc86j1tyXxtuc1EAYT/4vyUIWzFgugQZArNO+T1WWfKSvcRoZ9/JP3gJ8oN
         jvmRE5lNwr0qRDTB9MccAd1BmoTNk9f/frQ3TRsLUJWUS9kw6kTXyfLqR5YqTX/KQ6bS
         dkmo8nf8lsM6u4n7m18sqpzsM0ednU0+GPyGLSrv6Qjy7VB08Ezvm+dch3YTjuvlIwSs
         up7o3C2yQtQbUNv8JDv1X3OC2D0J9anQVcbEpRUFhZs96zMOGqCUETzRfx82p8K1Lgow
         7lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qjbDTQ7WcmhFUnalAhXH6DnuMDJuzq69+97XUCv4p4c=;
        b=G2IbHoHWt31+KI27dUIEscpgtjqhKqJcHkmd6uBn8FXd0RFM/jKNTagVkqHj5CFmg0
         CfaO9sDRqSZ81PPW/kDZBMa0S4a+j1Zz1sxj4BhtfNNerHiU2wJOG2kJBNU8Ot5V4ADT
         1sBoYOctD3pt/6WfuFYE69W/L1sP0FfNaSHs52m1uDNTGEvS2IQVvZSZcYW5TzlX8wZh
         SpUqr/xrV78PKDxI+sEHT+4R5ZkaWLRf19yvrQcXf41RTwdzIVfXe0iI00I4tIRg0z84
         3FH115UYhGOJhKYoRH6Medo7OMPvvLVqFIBByQmdV4NlPUafvRj6Jz6hxZkMOtHocxxk
         RmrA==
X-Gm-Message-State: AOAM532oibQiZzvHucqETF47mjzCZNb4Cka5yWhPnr1cFSl7MWn9kak4
        KCq1kKlxz8ncwvp7KcuFsIY=
X-Google-Smtp-Source: ABdhPJxbjZ6qUg1ngRlB/TqgKbzFMVXYniLRutnx43Y0LYhqvskb9Ii9TQVogb2tc/H1c8FuhA3F2Q==
X-Received: by 2002:a63:4420:: with SMTP id r32mr10289694pga.25.1615530282930;
        Thu, 11 Mar 2021 22:24:42 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm4048406pfb.157.2021.03.11.22.24.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 22:24:42 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 1/8] Documentation: arm: stm32: Add stm32h750 value line doc
Date:   Fri, 12 Mar 2021 14:24:27 +0800
Message-Id: <1615530274-31422-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
References: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
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
v2: just add more commit message description

 Documentation/arm/index.rst                    |  1 +
 Documentation/arm/stm32/stm32h750-overview.rst | 33 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
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
index 000000000000..c8ce59ec3bd1
--- /dev/null
+++ b/Documentation/arm/stm32/stm32h750-overview.rst
@@ -0,0 +1,33 @@
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
-- 
2.7.4


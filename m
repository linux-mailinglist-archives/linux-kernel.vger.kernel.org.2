Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32FA32BB9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhCCMkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842516AbhCCIGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:06:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6139FC0617AA;
        Wed,  3 Mar 2021 00:05:29 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u12so3835375pjr.2;
        Wed, 03 Mar 2021 00:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9WScLp0r/W/RtBKCNK4NfA69nZ1jc+w0DJEtDPB+5ZA=;
        b=G2sBQX2WzFpA0aIID9mW1OQxfj8VMxagsUZzSO5d1I7/9o+JXnYm/btZiGyJEMD6L9
         mZxLQR9LaiL8cWT6vHN8XLzaaPbmekOv496xeqdb9Wyhdk7Q6+DgbXu/JrR+fNGsb4/e
         2hxUBwLsdZ07GW99aHOO4GFGPxlUAV72YYbgA3Rc29AMkq7dXwtvLzU63NxVlapdrHav
         fUaqx6SDqwAlJH11Bv+eJzRb4vZvCmC6Yd7BxYHA41W8zFRJp5wIPYT405Zq6KTtvpNF
         uDWAvjJKWLutrDW9GlUprtz/dBWvku3E/5FcqsmuI0TdqN7pjyF0NBuUxxe3VcArBMel
         rwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9WScLp0r/W/RtBKCNK4NfA69nZ1jc+w0DJEtDPB+5ZA=;
        b=BHnrudtaE15GIkx2HtXUlWvFo3X5DkIg8exgs1l30W0rZWWr0nDCL5jY+e9tK0WuKu
         +kfjh46SBVYfqlRS7KiF4nagaqgzLpdzbyfevtCv23sFoVzLKPPC8i2y4s+uALJwf245
         pdWABYR9owxk0giTXQFWrXQlHz0hNmvMnpJ+ZPiCezYUDtmsb1fFXXr56PPk/rC9Xa/X
         zl69nJxf1ynL9u/57UFk30dxg0XmgzCl3dSlXKSawYlmzHBuHRD1DuR8Z88IJokrJOx+
         RMAhD7lUf9VKg57pxZ7MYuhV0OPAsViGu+VxCBKIFBAIgH5mtaxWqtyw9iYiiT1bcuNI
         yEdg==
X-Gm-Message-State: AOAM5313+MwREn9avrpHLSR2BPEUM62dsVXBk0S6/9ZQeK7SFIZYTM4t
        8Xs9jdxFkkOkMv76LVdsoLo=
X-Google-Smtp-Source: ABdhPJw/74XRKn9gtPqd/4A4o6JVg8qNeZl7jtS4ti4dkif0WXV7VgBD8JZsIRDG6m+IoEHO013ZQQ==
X-Received: by 2002:a17:90b:3886:: with SMTP id mu6mr8324229pjb.153.1614758729036;
        Wed, 03 Mar 2021 00:05:29 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm22260887pfv.84.2021.03.03.00.05.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 00:05:28 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 2/8] Documentation: arm: stm32: Add stm32h750 value line
Date:   Wed,  3 Mar 2021 16:05:11 +0800
Message-Id: <1614758717-18223-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

detail information can be found at:
https://www.st.com/en/microcontrollers-microprocessors/stm32h750-value-line.html

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B3F3E28A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245111AbhHFKc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245080AbhHFKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:32:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4232C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:32:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hw6so14361011ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NzqyjrYIBeWCGp4vCGl3UI9o/hw+FXbMB/HbH1LcnCo=;
        b=H74jU4I4/FFYziWvg3BJKRxIrH+pkgr0yg6YrmexFLaE2qjlVPFyvNUCPkGwNyHDWb
         IsUFph0SEVNJP6Yi9JVme6Zpl5xQcSYSL43qNcEwzkQWvD6F+ezP/AStSc2TbTL9T/yq
         ruyWuxPUhMH7mTYlnqsWO4fdakfZnX/Pt4gPhb3aBJv86wPuvP6rY2c2JtngiCmu4JFV
         lYEEmLqHSrV1fLw91o73o6MqF5IvQXe6ZsGDP85lgS2+f4R7FLqDJpvy/PlkRZGaOgTX
         2aA1Ancot6hdPtn6XbgaI5dOsDwfv4jC1KNFQBFL1onHam/8q1wYj6CeS6e9IxUipITi
         D32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NzqyjrYIBeWCGp4vCGl3UI9o/hw+FXbMB/HbH1LcnCo=;
        b=anJ8lDA4AZ2k9KJqjRujsTXBW3Trw32AI3RNh5Ngcr/Q01WR0i0rwshXEZvBV52vGU
         2xQqW90HiC8txb2AYaAdnPujvKZ6B8gwd6MD8KRKYcURa04yOCJzxQ8QDbWMUi7+TR8I
         5zDlAtciEJ9kfXMp73kDbDvwMhEfANc/OIVxwNYY6LK4J9YowDqjEt2LThEuq5V3MPmz
         wqsuoLdH8DA39OuIFd+P+HHv7rDWJyPCY0AbMyw8Gz/tkcS303+RxYOI4rW2wfF9M7e+
         /nJuYFyZXctXyTx5TU2Byskl5q6Hv3o6YBEzMLiQ1vRRuw++pm7WbyIM5NZqXR9V12hh
         jJPg==
X-Gm-Message-State: AOAM5306UnXnXt9x0jtADmijwIyVIU3vUy6HbpmfpwbcE/1FQiUXT//l
        HrFmd/o1kCnfH8f4fCk7LMYxzB4KQNeDTGJ2
X-Google-Smtp-Source: ABdhPJwGNUYk3CQLuKeTTNIFOzV7Vh7UtM0ic2MpZ7OaH/qmkeiKrVQurhSstkF3y3lNOgcYO2CadQ==
X-Received: by 2002:a17:906:ecf7:: with SMTP id qt23mr9135127ejb.64.1628245958124;
        Fri, 06 Aug 2021 03:32:38 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id e14sm3659432edr.59.2021.08.06.03.32.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Aug 2021 03:32:37 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Zou Wei <zou_wei@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] firmware: xilinx: Fix incorrect names in kernel-doc
Date:   Fri,  6 Aug 2021 12:32:36 +0200
Message-Id: <a81edd4fc6cff4bd7e4984fceda941b9e9ab01bf.1628245954.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some c&p issues reported by kernel-doc as:
drivers/firmware/xilinx/zynqmp.c:676: warning: expecting prototype for
zynqmp_pm_write_ggs(). Prototype was for zynqmp_pm_read_ggs() instead
drivers/firmware/xilinx/zynqmp.c:710: warning: expecting prototype for
zynqmp_pm_write_pggs(). Prototype was for zynqmp_pm_read_pggs() instead
drivers/firmware/xilinx/zynqmp.c:1023: warning: expecting prototype for
zynqmp_pm_aes(). Prototype was for zynqmp_pm_aes_engine() instead

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/firmware/xilinx/zynqmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 15b138326ecc..a9849e298d7f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -664,7 +664,7 @@ int zynqmp_pm_write_ggs(u32 index, u32 value)
 EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
 
 /**
- * zynqmp_pm_write_ggs() - PM API for reading global general storage (ggs)
+ * zynqmp_pm_read_ggs() - PM API for reading global general storage (ggs)
  * @index:	GGS register index
  * @value:	Register value to be written
  *
@@ -697,7 +697,7 @@ int zynqmp_pm_write_pggs(u32 index, u32 value)
 EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
 
 /**
- * zynqmp_pm_write_pggs() - PM API for reading persistent global general
+ * zynqmp_pm_read_pggs() - PM API for reading persistent global general
  *			     storage (pggs)
  * @index:	PGGS register index
  * @value:	Register value to be written
@@ -1012,7 +1012,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
 
 /**
- * zynqmp_pm_aes - Access AES hardware to encrypt/decrypt the data using
+ * zynqmp_pm_aes_engine - Access AES hardware to encrypt/decrypt the data using
  * AES-GCM core.
  * @address:	Address of the AesParams structure.
  * @out:	Returned output value
-- 
2.32.0


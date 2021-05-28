Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054AA39407B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbhE1KAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbhE1KAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:00:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED905C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:58:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t193so2156140pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxnYXihzWSlNMunKon9kZXOZGSnwpNQuuueXN520jxk=;
        b=JnbrvxL5hY2XFcBaGaaJske9IFvKE/RCvfoIUcNBkrYN4fXNET4BRWMEPja06pd9Hh
         eg+goSGXLhipxNJJB9SJY5NDxMPD6uMN0DhnGdsj+uXtBXZr/OY29V3gQ7dm2QIxXBQ6
         mo5nZcjFrsoYkMSOf4TU7bhsQ2ieQ+2ulrLXflCiuLqy4e5mtYvbWLAoaiCOHTTP8iNL
         tZYNZfZRTaHZNlufRh6OlZaj/SFdoWkV6C1VHm53az90A7UcKA/VJQ2EH6kh6oVXTGA5
         uGnjaJ8vyyaTLBmSEd4P1gpLyPkgrIccrytO3vRDVARrQVW8M8Nu2eOkjNKM4DmQ71AA
         9I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxnYXihzWSlNMunKon9kZXOZGSnwpNQuuueXN520jxk=;
        b=i26Ytpo9bNWLa3QvUQ9+PmBlxVbjHYBpgaGYnTcUx6PLmgXRnLXo+WQhXoGyHy5XIP
         e1UN1YrPckCqJoujIXu7E4QrxBdbpdYXeH3wpC9WJkUPm2CkCIULRKM/bha7UP+UzhBX
         janAJmDXTK2/R0f3ITb16nnt9vaq/aHFhhTQrmmVOhBZDFdpd5c8K2k7lOaJfVubRVpa
         oGUjnh2acsWpzp9NRHXwdmMjtVJ6iMENKN7J2O/75NJkr9BIjuOMfHKDNP0s5ygjrwKn
         /lGRTSdmxYc5YF6e09kGMK+633TE2ldJ2FiCtGKR8jgw+GS44DVU5IXXH2QoCamqN344
         lRbg==
X-Gm-Message-State: AOAM533SpM7VpQMOXx8ujKLSshfEMNso4EYJunsB03DcbpdFKUxYfcGO
        6dC+trDCrz6Oe7poyEa3XQQ=
X-Google-Smtp-Source: ABdhPJyS4avuZPoWjPTojcqYmzCEM8BQFpjyBJ/c4eSt6LVxrWlwQC8b72Q+28tapv6fnBytGaJIJg==
X-Received: by 2002:a63:fe53:: with SMTP id x19mr8215707pgj.372.1622195916459;
        Fri, 28 May 2021 02:58:36 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id q23sm4085722pgt.42.2021.05.28.02.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:58:35 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, Morris Ku <saumah@gmail.com>
Subject: [PATCH] mfd:Add supprt for SUNIX mfd & PCIe driver
Date:   Fri, 28 May 2021 17:58:14 +0800
Message-Id: <20210528095814.6939-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add support for SUNIX mfd & PCIe driver

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 Kconfig  | 12 ++++++++++++
 Makefile |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/Kconfig b/Kconfig
index 17d0ad2..25b7db5 100644
--- a/Kconfig
+++ b/Kconfig
@@ -2012,6 +2012,18 @@ config RAVE_SP_CORE
 	  Select this to get support for the Supervisory Processor
 	  device found on several devices in RAVE line of hardware.
 
+config MFD_SUNIX_SDC
+	tristate
+	select MFD_CORE
+	select SERIAL_8250_SDC
+
+config MFD_SUNIX_SDC_PCI
+	tristate "SUNIX SDC PCIe multi-function board support"
+	select MFD_SUNIX_SDC
+	depends on X86 && PCI
+	help
+	  Selecting this option will add support for SUNIX SDC PCIe
+	  multi-function board.
 
 endmenu
 endif
diff --git a/Makefile b/Makefile
index a1872e4..52fa8be 100644
--- a/Makefile
+++ b/Makefile
@@ -256,4 +256,8 @@ obj-$(CONFIG_MFD_ROHM_BD70528)	+= rohm-bd70528.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 
+obj-$(CONFIG_MFD_SUNIX_SDC)		+= sdc_mfd.o
+obj-$(CONFIG_MFD_SUNIX_SDC_PCI)	+= sdc_pci.o
+
+
 
-- 
2.20.1


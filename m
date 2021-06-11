Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620343A3F60
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhFKJsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:48:09 -0400
Received: from router.aksignal.cz ([62.44.4.214]:58820 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhFKJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:48:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 28ED341790;
        Fri, 11 Jun 2021 11:46:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 0WOPoFG7nrNX; Fri, 11 Jun 2021 11:46:05 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 2C6E5415FD;
        Fri, 11 Jun 2021 11:46:05 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v10 1/4] nvmem: prepare basics for FRAM support
Date:   Fri, 11 Jun 2021 11:45:58 +0200
Message-Id: <20210611094601.95131-2-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210611094601.95131-1-jiri.prchal@aksignal.cz>
References: <20210611094601.95131-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added enum and string for FRAM (ferroelectric RAM) to expose it as file
named "fram".
Added documentation of sysfs file.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
v2: no change here
v3: resend and added more recipients
v4: resend
v5: no change here
v6: changed commit subject
v7: no change here
v8: changed subject
v9: no change here
v10: moved documentation to here
---
 Documentation/ABI/testing/sysfs-class-spi-eeprom | 8 ++++++++
 drivers/nvmem/core.c                             | 4 ++++
 include/linux/nvmem-provider.h                   | 1 +
 3 files changed, 13 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom

diff --git a/Documentation/ABI/testing/sysfs-class-spi-eeprom b/Documentation/ABI/testing/sysfs-class-spi-eeprom
new file mode 100644
index 000000000000..7447e242d415
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-spi-eeprom
@@ -0,0 +1,8 @@
+What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fram
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
+Description:
+	Contains the FRAM binary data. Same as EEPROM, just another file
+	name to indicate that it employs ferroelectric process.
+	It performs write operations at bus speed - no write delays.
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 177f5bf27c6d..01ef9a934b0a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -180,6 +180,7 @@ static const char * const nvmem_type_str[] = {
 	[NVMEM_TYPE_EEPROM] = "EEPROM",
 	[NVMEM_TYPE_OTP] = "OTP",
 	[NVMEM_TYPE_BATTERY_BACKED] = "Battery backed",
+	[NVMEM_TYPE_FRAM] = "FRAM",
 };
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -359,6 +360,9 @@ static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 	if (!config->base_dev)
 		return -EINVAL;
 
+	if (config->type == NVMEM_TYPE_FRAM)
+		bin_attr_nvmem_eeprom_compat.attr.name = "fram";
+
 	nvmem->eeprom = bin_attr_nvmem_eeprom_compat;
 	nvmem->eeprom.attr.mode = nvmem_bin_attr_get_umode(nvmem);
 	nvmem->eeprom.size = nvmem->size;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index e162b757b6d5..890003565761 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -25,6 +25,7 @@ enum nvmem_type {
 	NVMEM_TYPE_EEPROM,
 	NVMEM_TYPE_OTP,
 	NVMEM_TYPE_BATTERY_BACKED,
+	NVMEM_TYPE_FRAM,
 };
 
 #define NVMEM_DEVID_NONE	(-1)
-- 
2.25.1


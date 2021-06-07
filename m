Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C421139DC4E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFGM2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:28:44 -0400
Received: from router.aksignal.cz ([62.44.4.214]:45896 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFGM2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:28:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id D26DD4811F;
        Mon,  7 Jun 2021 14:26:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id vHWf6K2AqXIW; Mon,  7 Jun 2021 14:26:45 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id B27BB4811A;
        Mon,  7 Jun 2021 14:26:45 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v7 1/5] nvmem: eeprom: at25: prepare basics for FRAM support
Date:   Mon,  7 Jun 2021 14:26:36 +0200
Message-Id: <20210607122640.143582-2-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
References: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added enum and string for FRAM to expose it as "fram".

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
v2: no change here
v3: resend and added more recipients
v4: resend
v5: no change here
v6: changed commit subject
v7: no change here
---
 drivers/nvmem/core.c           | 4 ++++
 include/linux/nvmem-provider.h | 1 +
 2 files changed, 5 insertions(+)

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


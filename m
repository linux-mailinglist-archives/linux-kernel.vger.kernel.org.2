Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC84435A268
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhDIPy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:54:26 -0400
Received: from router.aksignal.cz ([62.44.4.214]:36878 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhDIPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:54:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 002204120E;
        Fri,  9 Apr 2021 17:47:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id KWdKoq8o6wpL; Fri,  9 Apr 2021 17:47:25 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 1678D4120F;
        Fri,  9 Apr 2021 17:47:25 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH 1/3] nvmem: add things for FRAM
Date:   Fri,  9 Apr 2021 17:47:18 +0200
Message-Id: <20210409154720.130902-2-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409154720.130902-1-jiri.prchal@aksignal.cz>
References: <20210409154720.130902-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added enum and string for FRAM to expose it as "fram".

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386EB34EAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhC3OsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbhC3Ori (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:47:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB4DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 07:47:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b16so18527751eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p958/KgSVdF5+9QpbHuTIEsCC6E24Ycmg43m5LKY0o4=;
        b=TijfAYCV9yntgSN/zpB4NqshxbZFEgPMvpo6bQnDNJenVWSFlXYCDW5B7GD/pPU1EZ
         e1PnMb1qRT3KM/JmPorV7rQQFFR10NzUOUjQk3FSITerXhbD+t98MYD791dndRthzCDK
         UxaMM5CyIjEphTUUWlydQDAv/oSzcbFw4+5IhCLrhFu14+gJB3I2Y3ScqiR5zsg1w9yt
         chPtx8zuQxg3U1TpWAiiKB1cQ04ito8ghvAe7ta274P9FXr2cXlV15x2t56CYdMOiWeJ
         OdSrh4cfNQdwONHa6IvIh05sQaOJu48JGQZpMPQKadVCQdJTUAz3fzF6Eyiec+Z78N92
         QfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p958/KgSVdF5+9QpbHuTIEsCC6E24Ycmg43m5LKY0o4=;
        b=Dych8R1bbdEc2bhGQqo9t4h1Lu0+uWS+SUBlv+tMPtcmIXY2qoW/U4hSeyEZ8GYzHe
         l838CephxjIITpvwdtYUp/HqTZoDlmwukWsrB8JTevRTdXLFpUYDlRpjsKU+Ucxxxs8K
         Del4vtXvQ2M2extCKAjEZpMZjM508c/z+PpPon729WZfVy8hH4mo7v0HPWkmfkadz2NU
         2pR+qC+/75pdbImFDiIyex+cCAUxdDWkU1NLvbqCpG2gtt3ecTueYS4mnZwWPmf1qs8d
         emFjdsfhdGQ0Tu2uUAPItVBMXIeC8pd6GshMJvEfHVk0sOwmi/uEs0X9QQWmi8+/KADP
         qx9w==
X-Gm-Message-State: AOAM533I5NtMSHFFopM84zg5ah1HJQLbZMB3rXWzktrGyFlxRgNWZRLb
        uv2sWNKs/U6qbOr8ZMZptYVxSw==
X-Google-Smtp-Source: ABdhPJzIHvntJkZ9WV5oSDo3ZFuqPz9D9jEZRRnTk/jw9MFc4rQZbkPeJhwBvErP//sZ08l6DNe1LA==
X-Received: by 2002:a50:e80c:: with SMTP id e12mr34395379edn.229.1617115656985;
        Tue, 30 Mar 2021 07:47:36 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n16sm11520383edr.42.2021.03.30.07.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 07:47:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6 7/9] soundwire: export sdw_compare_devid, sdw_extract_slave_id and sdw_slave_add
Date:   Tue, 30 Mar 2021 15:47:17 +0100
Message-Id: <20210330144719.13284-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
References: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exporting these three functions makes sense as it can be used by
other controllers like Qualcomm during auto-enumeration!

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/bus.c       | 4 +++-
 drivers/soundwire/slave.c     | 1 +
 include/linux/soundwire/sdw.h | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 9bd83c91a873..a9e0aa72654d 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -603,7 +603,7 @@ static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
 	return NULL;
 }
 
-static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
+int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
 {
 	if (slave->id.mfg_id != id.mfg_id ||
 	    slave->id.part_id != id.part_id ||
@@ -614,6 +614,7 @@ static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
 
 	return 0;
 }
+EXPORT_SYMBOL(sdw_compare_devid);
 
 /* called with bus_lock held */
 static int sdw_get_device_num(struct sdw_slave *slave)
@@ -698,6 +699,7 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
 		"SDW Slave class_id 0x%02x, mfg_id 0x%04x, part_id 0x%04x, unique_id 0x%x, version 0x%x\n",
 		id->class_id, id->mfg_id, id->part_id, id->unique_id, id->sdw_version);
 }
+EXPORT_SYMBOL(sdw_extract_slave_id);
 
 static int sdw_program_device_num(struct sdw_bus *bus)
 {
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 112b21967c7a..0eed38a79c6d 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -88,6 +88,7 @@ int sdw_slave_add(struct sdw_bus *bus,
 
 	return ret;
 }
+EXPORT_SYMBOL(sdw_slave_add);
 
 #if IS_ENABLED(CONFIG_ACPI)
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 350436db6ddb..5ff9a8f37e91 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1039,5 +1039,7 @@ int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
 int sdw_read_no_pm(struct sdw_slave *slave, u32 addr);
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
 int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
+int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
+void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
 
 #endif /* __SOUNDWIRE_H */
-- 
2.21.0


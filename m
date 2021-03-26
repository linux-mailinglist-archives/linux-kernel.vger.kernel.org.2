Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABE434A210
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhCZGmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhCZGlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:41:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF947C0613B1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b16so5063398eds.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8VaQolGFCOR51eNrv/jk6ZLBrbbZ7X7Ltpf1LoAnjQ=;
        b=r/SymDirP7YsfplabAthL2rjNIEsp2UpQhJ6IQeQAt3/I84Eynq5qj3dKhWsBQR25L
         EBBsBag5vV+/5jRLbAvlnNuKJfLDGFuctI6aeFt8PvZSCh6r1xcAO2czt/JbOeomouuc
         aW0dptOiPwQYDJiYCZkgHXSdkJpNqoGgQxnldzOvvj0NGKKnn0Qg1Po74+7FMe5YbLCv
         tNCDYWEdxvXieEB0EVWMuDx/nh11yG+8tnj58Q639qX0mSHLMcVe4XYVLMQ52Uob4PuR
         rrJS+hycvoLfGbgY6Gr4k/vE3013BDdBejvCU0kPC2go8TstO2TooFkSAiHnmL5aRvw1
         5Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8VaQolGFCOR51eNrv/jk6ZLBrbbZ7X7Ltpf1LoAnjQ=;
        b=jfYM63lxGhr+bkN0RxnpOS67b9JFWf3N3Ppm8Kc0YdgB/QCEQIkBGIHO3oVN7ODhLF
         UydnCpAF+EV1NaPLAn741GWMZVf+eoIduEmA6DKDq5HRwbSZEHgKDQHkp7HLJK17V9FS
         Pzs30YzR5w7Uu/PhdwTeksw2qyE0yv5R0TEDu9hjgZWE6PMvN7XZVi75BSRDAT1Q2X5w
         O8HPW9Zyr0BX12pNoY5iyMI+t9EeHbgsvIDdG+hslKRNW2aMs2inzRbmPSuGkOnCD8Yn
         Ia6GC516l7PhGY2m62N1fYXymxoUvU4zpEuwXadDm+7bYDiKHKnGyrataCzoy6DhrpdP
         lYdQ==
X-Gm-Message-State: AOAM531gLjvSdkryoe9v+1SiEkcQ/v0Ekk5Lm+EpHpyiqGOnBynNQckO
        oWF0ZD2RKPmEN0i3C6nQbdRvtY4TcGF+BQ==
X-Google-Smtp-Source: ABdhPJw0rOE3qXvEVF6WI9EL9K/FwKG5NOBkx2tZumsUnD+MCA3hyDs5WB9yIpydUIEdhMFsax2CNA==
X-Received: by 2002:a05:6402:2695:: with SMTP id w21mr13146872edd.99.1616740883626;
        Thu, 25 Mar 2021 23:41:23 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id ci22sm125325ejc.54.2021.03.25.23.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 23:41:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5 7/9] soundwire: export sdw_compare_devid, sdw_extract_slave_id and sdw_slave_add
Date:   Fri, 26 Mar 2021 06:39:42 +0000
Message-Id: <20210326063944.31683-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
References: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
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
index 46885429928a..6d7708964735 100644
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
index 180f38bd003b..92850e150d36 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -88,6 +88,7 @@ int sdw_slave_add(struct sdw_bus *bus,
 
 	return ret;
 }
+EXPORT_SYMBOL(sdw_slave_add);
 
 #if IS_ENABLED(CONFIG_ACPI)
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 2f52d6609076..f9003ba056ba 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1011,5 +1011,7 @@ int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
 int sdw_read_no_pm(struct sdw_slave *slave, u32 addr);
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
 int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
+int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
+void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
 
 #endif /* __SOUNDWIRE_H */
-- 
2.21.0


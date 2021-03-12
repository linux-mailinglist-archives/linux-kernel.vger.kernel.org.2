Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB1338C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhCLMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhCLMAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:00:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDAEC061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:00:32 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e10so4646941wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ns+tspE3TpNVqG5EYUwkfh0nuT4Nkt3p2sWFNFRFG3w=;
        b=P6+peZvDODkplKd7B975gw81MJr7jqWIWBOCgEwcQ6jwIjBbL1A4fSfPMJubO9u/HI
         klsjbXDAggxVo9agrb0jMULcytEzWovafXLqeTCJPvnRVuG451MUOen4ZgTsVM2xkmPx
         DP9VCq/2rpA3kT9bLXvhQb/qWsKgd860Kvp4RuYkjt82c9UgfGZHbDma2ONT3f5uiqjL
         Pwj//Vr/Sac6hv2F4v3XuEZEVPoDILbXRZzgFSDFcTzf49sp9XrwfQ4NBP6fpT2Cs8IF
         hIS8V8ZOPlc4RmjO3OSHfUKRPmjyHP8VyroNx0+sTrQT0WluViH1T5wWPBQy0ZEpZsNU
         feew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ns+tspE3TpNVqG5EYUwkfh0nuT4Nkt3p2sWFNFRFG3w=;
        b=PMt3VbbT+ja7KizckywCY24QvtFF7q/Y8+Xg8qkker15KQVpFdBW01ag5WNRTXj+pK
         yDXu9H0MaOAfEvZc9QVHmP50qi30SZEqN+1RC9HYwc8TIr3yTYBAfFFaWR0bqHV6eCpN
         JN5y7Nem1TkACYXKTcfCE2+yiLkcYh9D0aPwdFT29w6OV6C9rJZiRXfE5+DS1jd1aEYU
         KTqYCk/nM/9jPMoPx1JB61jsbIGIzrKOEj+Tl8pamaLEZjVKx/VLo6VKrDsvkyzcTdfw
         KDQBGHQjFx5gNxfRA1+kgXLr6M2BQtfZInmXOylIEhvSPOGQ6bVJmC0fVM+ynpqzBfzA
         Us4A==
X-Gm-Message-State: AOAM533uphVCmwU3kgqbzwQNFePXNAFmaC3vydWtzwkzFvSV2exwFxaz
        pZZC5WOqUZ/f/5qdS38zehP7IA==
X-Google-Smtp-Source: ABdhPJzSUeK2qRXfZNTLJGfilhw5GBIt689/i+iQfv9UnkTEj5vCg6xatpfddnC7X66twH0g4f5VAg==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr13403133wrs.135.1615550430888;
        Fri, 12 Mar 2021 04:00:30 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h25sm2268315wml.32.2021.03.12.04.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:00:30 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 7/9] soundwire: export sdw_compare_devid() and sdw_extract_slave_id()
Date:   Fri, 12 Mar 2021 12:00:07 +0000
Message-Id: <20210312120009.22386-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
References: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exporting these two functions makes sense as it can be used by
other controllers like Qualcomm during auto-enumeration!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/bus.c       | 4 +++-
 include/linux/soundwire/sdw.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

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
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index b032d6ac0b39..c677ab1013ab 100644
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


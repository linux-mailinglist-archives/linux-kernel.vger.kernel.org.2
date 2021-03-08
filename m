Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F71330FFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhCHNuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCHNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:50:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC91C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:50:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so8058497wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLW7TG6PQ/0kvCqPaH5WN248jwpEuDggns1w04ucp9A=;
        b=oZZbpzSCpnqJ1jIlW5MuZ1cSOGKMldFFJr93/JW41dLUh65I46zQkLtkapmwUGuZBI
         1wWJnGqnLp4/UtSElrpgRfZYuwVBiQXWFvaA/hvAPos0JuROOjsfDif9OGjTY4lwL7Qy
         w+CZoQIk9eVkFs0EBrPV1MgxPCoZtYBhoWXWnyG6zOmqEDHsH6VyuIWFs6fCdMOOyOem
         sgHzLC66sP0hhUt/QfYlVG2frDDbQvsHRN12GM7Oh7cEwATZEkZlVPF0+SI3PDDnBqs2
         mcUrYvtsi/LKKxwt6V6Ekdmvi56ttH6n52XmSgjcLdJh03sqQ54XiwSiNDPIRtWwA3/e
         gFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLW7TG6PQ/0kvCqPaH5WN248jwpEuDggns1w04ucp9A=;
        b=A60TO81ESHsbUi49lzAh2fL6PYhpyMDaeeWAcptdw8tSfdfT/7Sxp+9tgy5TB/nDkl
         SvupsVcXvEYpx/HjsCfludEE6VQwocMLWs9BlFAVwS3HklyrJrBwhXkdNynoHXDRYNjD
         5ZmeYHHg17TVNXsRpbaeW9l36Z8x+R3+Z/Ts1MhcRK2FuBlPBup6wG+FcOjpe3f0QGmp
         H2za9W9mLKsTHoYpAhY0zJ4tf8I8GC7dGHtfChfblIgZyTTIHNV/ZjQWcHFjK3VnI5Qw
         rxw4CPFvjp7aDR05+cf+P8IeThVU7hZyDGaZC42PzccM5EnDZd6avcVyRqsuF8N/Yv72
         VXqg==
X-Gm-Message-State: AOAM53124tsnxU0n1rZjjCZlpxq6te4RlgtJx4TkNYFfHqFGwNrxZBaV
        xpi4UBz4M7U660dD7aCSBtEwTQ==
X-Google-Smtp-Source: ABdhPJx0qSyvt5qX3+yogFUxNbqoey5sNyKo2gst1GwnoK9XypLSsEJ5udmUhhzBQWLvRrjudZzOQw==
X-Received: by 2002:a05:600c:47d7:: with SMTP id l23mr22683917wmo.155.1615211413109;
        Mon, 08 Mar 2021 05:50:13 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h22sm19490589wmb.36.2021.03.08.05.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:50:12 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 7/9] soundwire: export sdw_compare_devid() and sdw_extract_slave_id()
Date:   Mon,  8 Mar 2021 13:49:55 +0000
Message-Id: <20210308134957.16024-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
References: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
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
index 48577b78f282..46d3407c097f 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -608,7 +608,7 @@ static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
 	return NULL;
 }
 
-static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
+int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
 {
 	if (slave->id.mfg_id != id.mfg_id ||
 	    slave->id.part_id != id.part_id ||
@@ -619,6 +619,7 @@ static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
 
 	return 0;
 }
+EXPORT_SYMBOL(sdw_compare_devid);
 
 /* called with bus_lock held */
 static int sdw_get_device_num(struct sdw_slave *slave)
@@ -703,6 +704,7 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
 		"SDW Slave class_id 0x%02x, mfg_id 0x%04x, part_id 0x%04x, unique_id 0x%x, version 0x%x\n",
 		id->class_id, id->mfg_id, id->part_id, id->unique_id, id->sdw_version);
 }
+EXPORT_SYMBOL(sdw_extract_slave_id);
 
 static int sdw_program_device_num(struct sdw_bus *bus)
 {
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index d08039d65825..8478a1f5f833 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1009,5 +1009,7 @@ int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
 int sdw_read_no_pm(struct sdw_slave *slave, u32 addr);
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
 int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
+int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
+void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
 
 #endif /* __SOUNDWIRE_H */
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F8432660A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhBZRFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhBZREv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:04:51 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F26C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:04:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o16so8426365wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLW7TG6PQ/0kvCqPaH5WN248jwpEuDggns1w04ucp9A=;
        b=DhVCpG1b3UIO7vBqa299+9V3CVzR+D2K8X0luCS83Fpzq3cIZT4QIf+hMGusbsJllV
         rH3xaEu4TzO7/3quut3Vnw76bQtOs7YPIiBsvn1jmbT64UBAkXhcFBE3cyGgbg8sUA6N
         QgsnlCsdXDlOJoNNZBbnAavcBHnh/PN+c+YvmiJqjorMBuL/ABM+WVi6RC3hfFQnJVRg
         iIZSsA9yyxPQNMCbtTE9y1PI0dzKhez4zH9bOlYY5WIgG+opDFfqxKuCBTshONza1xei
         SvAiNH0+pXyU6TC3PiEpei8jp1kREzd0D3GGdlx6iDwKx0hzxEzSroo2yfRZa1Rk98Qx
         YSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLW7TG6PQ/0kvCqPaH5WN248jwpEuDggns1w04ucp9A=;
        b=oS06qPqlgwn3cUDR7bdf9ZyftOmmXRLdcWhmIM5Hjy2VeUvWXpmYImK97VXXKLaRwk
         AfBwCorMyorszolMy3kJB9spRXnmi13BClPJ+DwWAlgIbVAoTyGqBHzv12+MQsic7fzY
         08Wujj9k9U+/x94Vu232h5WCeexZ7Ej2obphmz0OhEL8YyWq3J5eTg0Tdmyi68lZY6Pf
         ajK4290PNGQ7ALJMRK5ZcfIYk/xuiHpERPC45olVwl3nz8kyABhkKMOjhuel+pWewFzr
         EZF5lKvtVsr0Ep2ktFYM4XzWw5BE9iXgSirLIBNR7Qo2hCiKL6TeVGgMZvPZ1Z1oG6BN
         uLiw==
X-Gm-Message-State: AOAM533VY4P0KDYox7r4ogiOd3pnViQHp/uUpPi+DFJuFk8ljNdQlKyn
        t5aLtnS2XxbLfjx21xfiTTKwjA==
X-Google-Smtp-Source: ABdhPJyUXSITxg36zpAW/xYF0AI81gVx9H48Rv/wd7mnuryjH/YPlLYBY9l2jnWcCivpj4MfTxDcog==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr3876434wmb.31.1614359049269;
        Fri, 26 Feb 2021 09:04:09 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id w13sm15962972wre.2.2021.02.26.09.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:04:08 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] soundwire: export sdw_compare_devid() and sdw_extract_slave_id()
Date:   Fri, 26 Feb 2021 17:02:48 +0000
Message-Id: <20210226170250.9067-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210226170250.9067-1-srinivas.kandagatla@linaro.org>
References: <20210226170250.9067-1-srinivas.kandagatla@linaro.org>
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


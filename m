Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7008133234C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCIKqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCIKqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:46:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A47C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 02:46:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h98so14626301wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 02:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hgVWZEqabwtY8oTbHl56afq/3bLl+c8areS1KZJWAVI=;
        b=yXGd7BRWOQStzPiUrhWp/J4pka8r0eqo7SiwvqWMZaZWkCJcDqZMlYA3XcBk+pUOi4
         jHZF20WowwZNBnBW9ZwsM/cjpsKU6chmSP3LHtoizaMoQG52n5UoFRsaZbsBtz8wzmKy
         JkGmB9W94LpfWV3Fgd7t676/FptJrtL3X9MYEi69cyglpf50KVXXvZmqNPoEDD4rcT5d
         fciJa4JKuNq22HN0PLi3H3GQeJe61LpFdy43/LYFpfTnst9scIn+Avv/wzdOdZ+ck55L
         RXOsduQNtTzcHSoeEt1P9bZMg0o5gWQvuDPwzmrXRBFOng7KX/8YwHXxW23UECUHBPU4
         jGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hgVWZEqabwtY8oTbHl56afq/3bLl+c8areS1KZJWAVI=;
        b=bCVmjqY61159hJ4UFJCivI75jQqAVj6CU3mH6mZIJKu3/1mitegXL+5TGsYjtTJPVw
         AwX3rMDmby5MIe96vXlO7WQZCcTWAKiX8C3Orkqle3v3smwQZk2zbb/yIFEuMkEbNW37
         5ArexEeOvdyLtMrvtRuq4+tJO2Qq+YSLulhsTbsdMcM5jVJIsHZlcrOZAL6FsV7bTD4y
         OkrO/NTBAaRk2VMbCq0vwctUEunBrpdyX4rurMIEA81RC4cKMSFSNWY8s26VRLoXv+Gk
         jQAO+3FyJi/IiVxXETynu0D3M9insqkCAqJZzIQiN8iiIzIthXwuldLde4ETb//DsPF5
         uQkw==
X-Gm-Message-State: AOAM533A05z9GK0w7OjMmtxLHQ2yj3NW06/5NZy8+MUFB8K+A6TJ9pdt
        iB0gWzow5FAdwPMFz7CEMfmW4w==
X-Google-Smtp-Source: ABdhPJyZ6smkiEJ5ukOwUoQuvdOIpzbEyMiThIZMwtxk/GP3xroQFuPBgcypzFLYrqqozmu1C1gT+w==
X-Received: by 2002:a05:6000:23c:: with SMTP id l28mr14121211wrz.251.1615286776262;
        Tue, 09 Mar 2021 02:46:16 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id j12sm23228298wrx.59.2021.03.09.02.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 02:46:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] soundwire: bus: Fix device found flag correctly
Date:   Tue,  9 Mar 2021 10:46:08 +0000
Message-Id: <20210309104608.19067-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

found flag is used to indicate SoundWire devices that are
both enumerated on the bus and available in the device list.
However this flag is not reset correctly after one iteration,
This could miss some of the devices that are enumerated on the
bus but not in device list. So reset this correctly to fix this issue!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index a9ab4a6264e0..188e391c5a83 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -712,7 +712,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 	struct sdw_slave *slave, *_s;
 	struct sdw_slave_id id;
 	struct sdw_msg msg;
-	bool found = false;
+	bool found;
 	int count = 0, ret;
 	u64 addr;
 
@@ -744,6 +744,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 
 		sdw_extract_slave_id(bus, addr, &id);
 
+		found = false;
 		/* Now compare with entries */
 		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
 			if (sdw_compare_devid(slave, id) == 0) {
-- 
2.21.0


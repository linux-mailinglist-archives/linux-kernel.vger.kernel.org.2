Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B31332351
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhCIKsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhCIKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:48:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5447FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 02:48:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so5676774wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 02:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+dOe7qqGADyTHvXYPJam0BAUL8HHo8ONmP3uU3g+NA=;
        b=R1/XwJB29aodPHns+iAOiEvLf/bDRHI+RtO3GFJGLmzuMlcrjThtNhsri50BBhU+vD
         BX8GVi2XqXlshi+sQbfgK3bCWo7rENlBIFwC0Gp7Cg1H2pD0Gvj5sFVQ6fmPMVrJBWzY
         WYKtNyQ2czFqgFHhws6gxDvQ5/JBt0Edwf8843Uz8ycyxBYGWtRG2bscxyDzCDFdtnvs
         7mR3+3kbw0oMen21hPmZDkp5AW3wnmQzVjeLOvp4N2S3xNa+wHMBxIQ0BkIKax+U93nB
         9TGWfptnjoFQF0sYARsR5r60E+cUkehPkhaj+dP58iEkzt41E5asx7vBOysVUGh1cy/z
         VrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+dOe7qqGADyTHvXYPJam0BAUL8HHo8ONmP3uU3g+NA=;
        b=YfSmNpQQEZCit/06VQw7dD3HxaBG+1iwqNqN8LZ478UYCJZ1OLli9dOquhjrPQVVjP
         ytZgA1iVZBy+SlnHanpWNjOah+Vh5Hw3QEtoRoIuqr2eK+4RKHJ56Xo62eKDa7YMjLEU
         VR+8o5lvO0kZGRk+1tr8aKxJNTftU0hmjmLQbso4rQ0AiE366l0sQ1IOf+UFAH3+gj3j
         2mCU7rT23TCR6BN1lZc6UEKhyEHqe5wBGLqUcIla72gL9ksIgHewGab9auXMMvIPqys4
         4TSCfpDfiRpx8Swrkp/XLTyfthwAelLVRerQ+3YTJBt8OE8IC9VoBS4BnqKeYBmBkmXT
         fyAg==
X-Gm-Message-State: AOAM532JzrUcZ8UUsN7l/ONCWWrUR5OfsIVjooQcFQ59iyCsg6iXplD+
        IGOHqFoB7TsKOW4V6mjerEJ7jA==
X-Google-Smtp-Source: ABdhPJz+lHXmJhbhL2RIdUBaCEF3gJnahgXfhOirnUrrEWQB8LpPRGdRGx8zfZNPPBQvwDa8v7125Q==
X-Received: by 2002:a05:600c:2cb9:: with SMTP id h25mr3356223wmc.110.1615286900145;
        Tue, 09 Mar 2021 02:48:20 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o11sm24747758wrq.74.2021.03.09.02.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 02:48:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH v2] soundwire: bus: Fix device found flag correctly
Date:   Tue,  9 Mar 2021 10:48:16 +0000
Message-Id: <20210309104816.20350-1-srinivas.kandagatla@linaro.org>
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

Fixes: d52d7a1be02c ("soundwire: Add Slave status handling helpers")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
For some reason I ended up deleting Fixes tag so resending with it!

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


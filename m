Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B4033C2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhCOQ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbhCOQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:56:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E18C061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b18so9051523wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qgWiq0fpW1Ao1ReNyBWnVsZYnSiuoBY4LWY+fyyXN+8=;
        b=DvVmN0K4XDY3htV9Bkl3qmU9Rm69lhS1NtKvpdnnh6nJxKA4m/q3cf6WHrrgbG8+x2
         tvjlkie8aIW7mZYYfH1DT+pxwJJ+HJ6vJ6sw9f8sa68G4g9llVGHL30HcJVjXC7g0b+0
         7IqazsE1TMdnG5L/+7588THq+lREaDEVTtmWx59liQ+GCmAbsoocdQX9OiEUe9wGs4MS
         CO1mdTpBWjLLIYn8wSLJhXyoJVVkeje156i+q7ZMvxQkdFzTp5N/gEQwEVSxxoBCExEu
         uNJ30LA/1ltGByLOid8utVjMo52TEeoEGH2R1PhTV6UubBuUkySQMlXbPEYn2qElVpni
         UqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qgWiq0fpW1Ao1ReNyBWnVsZYnSiuoBY4LWY+fyyXN+8=;
        b=PwuOxzN5yBxze5cmqQN+JAAvuXvxNZvX2Buv3ydKehI3sbMJcaViGjwgGWDS1nJL7C
         CquwnrzY1x0NJVHv3JHhH8RG/STqMd+AuIAFRYcCMTeJh4Rpdbaj3snbkaDc0e2Wacn3
         1uHYYr2eF3OS7bV0SKm7fWgoqYxg8CjY8JCpETQrrN8mrGxXmnr+8llWruzocSHmVJ1F
         0HNmXPchSSxe4EdLueQvV10576fEYxILM4jkBaXHEl1GbPLMEtrkebPA1+6dijdhjwfu
         dKNZWTRcWATSzvOtgc4vBxOYhcqdiaCt7T/b/hBuYXcBEH+etaK3rdxE75/q4g7YzFN2
         3q9w==
X-Gm-Message-State: AOAM533AmDP7WzBnrOTfX+AXQmjz49z0aCDWWVj0SpiCiI71xEk+vmOQ
        AKZSLyS4af3UKezHd2ZiF14LPn5eLKzdsA==
X-Google-Smtp-Source: ABdhPJwv9bnsGMX5GXuYFAmFDI33GWoBNKv7Pgg+K85yqfRfH+JIkb7J+Cx/GjUTh1+99N0kTYj3BA==
X-Received: by 2002:a5d:42cb:: with SMTP id t11mr595569wrr.280.1615827414967;
        Mon, 15 Mar 2021 09:56:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o2sm227656wmc.23.2021.03.15.09.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:56:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 1/5] soundwire: add static port mapping support
Date:   Mon, 15 Mar 2021 16:56:46 +0000
Message-Id: <20210315165650.13392-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
References: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the SoundWire device ports are statically mapped to Controller
ports during design, however there is no way to expose this information
to the controller. Controllers like Qualcomm ones use this info to setup
static bandwidth parameters for those ports.

A generic port allocation is not possible in this cases!
So this patch adds a new member m_port_map to struct sdw_slave to expose
this static map.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/soundwire/sdw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index d08039d65825..2f52d6609076 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -614,6 +614,7 @@ struct sdw_slave_ops {
  * @debugfs: Slave debugfs
  * @node: node for bus list
  * @port_ready: Port ready completion flag for each Slave port
+ * @m_port_map: static Master port map for each Slave port
  * @dev_num: Current Device Number, values can be 0 or dev_num_sticky
  * @dev_num_sticky: one-time static Device Number assigned by Bus
  * @probed: boolean tracking driver state
@@ -645,6 +646,7 @@ struct sdw_slave {
 #endif
 	struct list_head node;
 	struct completion port_ready[SDW_MAX_PORTS];
+	unsigned int m_port_map[SDW_MAX_PORTS];
 	enum sdw_clk_stop_mode curr_clk_stop_mode;
 	u16 dev_num;
 	u16 dev_num_sticky;
-- 
2.21.0


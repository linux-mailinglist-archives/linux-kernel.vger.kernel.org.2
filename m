Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F7E332849
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCIOQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhCIOPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:15:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70D2C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:15:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h98so15854106wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gDmC37JxzQ5hGBDDct3/T0SwytsBBauAUrn0ZFgLOw=;
        b=VMfw2/F318b244pqC02hJYJaHUKyllWsXMoL96g5Bx3Exg5BpOWKfk396oEP6ylN6h
         Htuzw4Jb7IrefcX1arcdOlAxcp3FHx4SG6Vm9yRoboFzvTvQqx+auDxgKm66yNq6C9wK
         sFnQ92HhHYDwTwdbOUEI6JfWH7wU83fWUqXByEvXQTp1VgaSpZn1TpV6DhwWk7vDMsis
         QWltgCtEx4awHj0350HhRtv3mPIu3YT9AFda+jjqlKDLQDq32/XVDJPFuHclO6J49rV3
         fCGiBPfkiBvcLRzvc2ktHCGlUR1bNS9FH+0nk8Nm5FCDVS2Wr5m6NK0Y2B/8zs5LjjcY
         JQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gDmC37JxzQ5hGBDDct3/T0SwytsBBauAUrn0ZFgLOw=;
        b=ZQOsvcCQyrocs1MZ9k0iRSuCR6oeEZf9BaCRXINkNhyB4VfYmLGHz03srN/m84IaZr
         hY7veHmCym+jZmFhGCCdSLZqPp0LLEeYnX2f+rXq68Fh+rmZiQjgmQ05Ctm65dn4J+6y
         xmKxtlPBa86Ou642a7U7JlKSARA5zNGiq1t1E+6xhwB9PirSmAjPV3ZQYSeEbMrUSQiN
         AcsCJIX+/XeBzDGnXVzIQK4AEJLIOm2+Uqn1i7yEma9EEii6xjtXmKr0PhTUDJRpRAQX
         jHV/xcRO+ndKZ4itMfQ6MYFHIh+718j/b1GF9Rtwxm+uS44XGH+MfdCfyD8eeKm37ZR0
         lTMQ==
X-Gm-Message-State: AOAM530hWLV7by92jM1xhP4aZus5OMMIjTISBogEUHhNy4J9HFZVBCmz
        PY0QFtrVfvkE7suyXWQXzHhKMA==
X-Google-Smtp-Source: ABdhPJzeXxHYM4+hidJKnBfyZ6yLKrTkfVXOLtOIS2uC0k1nZ9CPT6fh3Kil1zaNtjFJAc39AkgJsw==
X-Received: by 2002:adf:e34f:: with SMTP id n15mr28566940wrj.224.1615299333563;
        Tue, 09 Mar 2021 06:15:33 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u20sm28007579wru.6.2021.03.09.06.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 06:15:32 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/5] soundwire: add static port mapping support
Date:   Tue,  9 Mar 2021 14:15:10 +0000
Message-Id: <20210309141514.24744-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
References: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the SoundWire device ports are statically mapped to Controller
ports during design, however there is no way to expose this information
to the controller. Controllers like Qualcomm ones use this info to setup
static bandwith parameters for those ports.

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


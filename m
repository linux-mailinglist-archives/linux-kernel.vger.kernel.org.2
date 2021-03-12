Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E4338BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhCLLj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhCLLji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:39:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6EEC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:39:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g25so3605657wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6S4oc3H/pGD3ohc32wC+7IuRuvb/2oR7Yf16M/iJXA4=;
        b=un9b6szDn8WtZw3vwLqnQuMB4nFKl5WiH8RPl6NXlTV5rMBuoEd+uvRZareK9f9nUl
         H1OM3HdQZwto8kDdYFqT5YZeEnsmQzK0QpJ5B3GEaB6kmmyw81iKMDL/AqITE6XOYdQT
         j8VgBR7YRBWOECbXyqvy5XkJVDEHM5vi7gwEoKeoy95gEU9AwVZSqV1IE1U2nq0L8yHT
         24si0axqGkv6z1IAQzkRAg/eEE9tHI+IqAdSFMeUoIUIzboH1McQC4hLS2QKboD0rCii
         8yda9dFBsW8hj4ED3PISLMUZJelAclSXRZN1ytTxQFTLrG7F9WmA1sgwa+1kkw4MSTIp
         1kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6S4oc3H/pGD3ohc32wC+7IuRuvb/2oR7Yf16M/iJXA4=;
        b=DKVp7qphBzuCShZfZpdg4m75Wmgx6kHNGPkmXIODnLAdzEG+L5YmRL9L+qQ3merDch
         Zs8hufMZJA9FqBVx9XMvzSnj4XQsxueq6hW1uBSLXdAdG6LRbughtqgcp0F90VhoMIA5
         Vh6q7ppr2SqQrEhlIG65P640hmJFmM705up2sfFARM3jDrECmAg7YzhaUD/QK7aqDJBm
         h30+N/ab6FYnWeYGOJ+ODNv3u/Tvj+MfVjzXoz7ChtaINJBIj1JjfPeWxR24YTah20UQ
         Vqz5zUjVJSO/QEVqSnN44KUCV35RHIaMbZecNck/c8Dsu3waiiqhHlZmvNjYmCxOAQ4P
         ZlNA==
X-Gm-Message-State: AOAM5334KIjj5L7kfCli2nY1xgDmiZgKmUH/TjLpTCKYID4kvlEnhmyV
        LtWEnSsjprhp4zx9XoSVfKWUOLA9oxvSYw==
X-Google-Smtp-Source: ABdhPJy3pNY62m493Z1ihaX6xg+os2R9k+sKZs9UDjxG5PKQ1Sipg4f5ROddTj82k/d2vlKmPmWWxQ==
X-Received: by 2002:a1c:2390:: with SMTP id j138mr12513940wmj.72.1615549176799;
        Fri, 12 Mar 2021 03:39:36 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z1sm7412458wru.95.2021.03.12.03.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:39:36 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 3/5] soundwire: qcom: add static port map support
Date:   Fri, 12 Mar 2021 11:39:27 +0000
Message-Id: <20210312113929.17512-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210312113929.17512-1-srinivas.kandagatla@linaro.org>
References: <20210312113929.17512-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoundWire device ports are statically mapped to Controller ports during
design. Add support to read these from SoundWire devices.
This controller uses static port map info to setup bandwidth
parameters for those ports.

A generic port allocation is not possible in this cases!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 9e70c53e2c7b..39222b04a2e0 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -460,6 +460,8 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 	struct sdw_slave_runtime *s_rt;
 	struct sdw_port_runtime *p_rt;
 	struct qcom_swrm_port_config *pcfg;
+	struct sdw_slave *slave;
+	unsigned int m_port;
 	int i = 0;
 
 	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
@@ -473,8 +475,14 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 		}
 
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+			slave = s_rt->slave;
 			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
-				pcfg = &ctrl->pconfig[i];
+				m_port = slave->m_port_map[p_rt->num];
+				/* port config starts at offset 0 so -1 from actual port number */
+				if (m_port)
+					pcfg = &ctrl->pconfig[m_port - 1];
+				else
+					pcfg = &ctrl->pconfig[i];
 				p_rt->transport_params.port_num = p_rt->num;
 				p_rt->transport_params.sample_interval =
 					pcfg->si + 1;
@@ -535,8 +543,10 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 	struct sdw_master_runtime *m_rt;
 	struct sdw_slave_runtime *s_rt;
 	struct sdw_port_runtime *p_rt;
+	struct sdw_slave *slave;
 	unsigned long *port_mask;
 	int i, maxport, pn, nports = 0, ret = 0;
+	unsigned int m_port;
 
 	mutex_lock(&ctrl->port_lock);
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
@@ -549,9 +559,15 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 		}
 
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+			slave = s_rt->slave;
 			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
+				m_port = slave->m_port_map[p_rt->num];
 				/* Port numbers start from 1 - 14*/
-				pn = find_first_zero_bit(port_mask, maxport);
+				if (m_port)
+					pn = m_port;
+				else
+					pn = find_first_zero_bit(port_mask, maxport);
+
 				if (pn > maxport) {
 					dev_err(ctrl->dev, "All ports busy\n");
 					ret = -EBUSY;
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD81D338C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhCLMXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhCLMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:23:02 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605CDC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:23:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 7so4709505wrz.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6S4oc3H/pGD3ohc32wC+7IuRuvb/2oR7Yf16M/iJXA4=;
        b=YRawz45LNtttk3HenoCONJFDTNNca+FzdessU2tg+yt1grzPilMT9kL/9Wh3yC/Ofe
         wpOC52qJcJSsHIbRBC4+CK/MUpraS78G8Ow2jtKaV6LjUWo7gzq535HIjhIhACv0A1z0
         U1VOs3A7KyrcGJdKpckT/As/AEtmgme9cg3AZ0NP6p2RJyjfT8YhtxLLne7UPuHC0cpC
         4MTVhMV+u6t7vPSVkCsHnjmVnsLMrgJIZUwsC5lXoVBQ0o/vjJu8dH3AGjtq2b0f9acM
         OiB4MkB2fPA6b/pl8NlLc2CNvMqZ/Cwi+ObLOWxvt3zwPL0+CWqRUCzBkDLYtqqQxXz7
         uyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6S4oc3H/pGD3ohc32wC+7IuRuvb/2oR7Yf16M/iJXA4=;
        b=T5u9t+VD604zqfCOuy1Kk019GsPJPeqJKZlyH0ZTA/BbOAslRK0oldDg31QIcFGS6I
         Hzn8ZKSP/jTit2SqjY+BL6AJ9waD10PVJ09U2fe6MeY2xbBJgJbhG8MxAGMnT7GR+S4T
         7Af7kEffnSPIp5pSOLz9WJ6HWfivrsq2UDr5wzqNGAh0DwSYscsdvp4QrCyRlt25iPrl
         kiTZwc5UmOewzB2pjpoTJF+tlUF0QiatEKPavYeG38Mc5+M/SCEoOmPnb941KCx5Bn95
         NRQp2N5XpIKqEuocYOj+6qwAd3d1SObcbuqZAJFQTJxlaZKgcbV/VW3J02dRaFqZ2nM9
         ZfXw==
X-Gm-Message-State: AOAM5332cY9gvqctPtNaA3NK1YzMdehd29PUVK5u+EuS5IrNp5uTFr2/
        /4E56r49RMzdAW4F0HGq0Zk+HA==
X-Google-Smtp-Source: ABdhPJyECcjI4bJaeKB5525lkzQWeGSZ7fhUMb/PSBwvy9RH+lOuu9IO1s7CygCdkUXDA58e6AU/kw==
X-Received: by 2002:a05:6000:2aa:: with SMTP id l10mr13737171wry.368.1615551781175;
        Fri, 12 Mar 2021 04:23:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id 3sm8804329wry.72.2021.03.12.04.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:23:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH v3 3/5] soundwire: qcom: add static port map support
Date:   Fri, 12 Mar 2021 12:22:53 +0000
Message-Id: <20210312122255.3143-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210312122255.3143-1-srinivas.kandagatla@linaro.org>
References: <20210312122255.3143-1-srinivas.kandagatla@linaro.org>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACD533C2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhCOQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbhCOQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:56:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D033C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:58 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso20718752wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6S4oc3H/pGD3ohc32wC+7IuRuvb/2oR7Yf16M/iJXA4=;
        b=KRguXn6v6qWoSKXlekTUoqzfznIkwnBZk388f10HNP0qDrHICvrjYs9zpA07T0bvJ6
         89p0lDFhapxhLq1535ZPsd2sRtkAxs27G7nMs/FG6YuNWkgR0+VqnhrfySnK9UgW10RV
         fzA+ELnQbNMT7oRP2BAxF28RzZvEW9GiV/zfv/HknWeAZIVLX+tFy9nDrtWp+P/xcZ74
         ITZhRtK78sLj79myS0GaSIuMBHRpkGNs8c+986iaYdGRrrbx47xaW9AmypyaZj2E5yQH
         nsXob37tOIjHrOj4r9z4JUg9BuI+1+WG9YAQcehdTgao+qff7BeQ2C1GjGUel2pbzgNb
         o9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6S4oc3H/pGD3ohc32wC+7IuRuvb/2oR7Yf16M/iJXA4=;
        b=Z+i6PiYP38H4n9+eMwjm1P+PP6NkGfs58xea5pL5Zj16ml6uor6fgnaREFfHRHc0uX
         5K9Tx4KlB9y+aLjzjNAw6dEvTkEIMV/DHWEHpjGaaEH70AKswlOotFTxfQL1SVJ/t9tJ
         uzhDHdYTOxwS+8oiN6EyO8LJKmPs0tlIxpLzMzY/2M/D3EJGcKc18PkLe9cDcz9P33Ik
         f3HKJwz5RPxlrfeXbw8Ou2aXqrEkEXeVMxKGfW6e23JnO4JI2lVgb+DuuyJobQ4rKHcz
         NUj0Zz4GfIOJAfxsomMOPoqyi+/WEcAJyzaP7QCplOvMxhiPPd9zL/2vI1UajLEmOE3W
         jv/A==
X-Gm-Message-State: AOAM532znIJ2Z6Qogs3jtIL38OBak331sBAF8gkFbbWizd+sqzwbM7fa
        FmEriWGI3oLMj/IK/ljfhx40qQ==
X-Google-Smtp-Source: ABdhPJwXtGhmGiGVxZL0Drm9x4U7zWV7DUR7M38RjkULKnSi/Ner2wIN08tGO2oYc6gp3Di4umW4iQ==
X-Received: by 2002:a1c:c904:: with SMTP id f4mr647858wmb.14.1615827417008;
        Mon, 15 Mar 2021 09:56:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o2sm227656wmc.23.2021.03.15.09.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:56:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 3/5] soundwire: qcom: add static port map support
Date:   Mon, 15 Mar 2021 16:56:48 +0000
Message-Id: <20210315165650.13392-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
References: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
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


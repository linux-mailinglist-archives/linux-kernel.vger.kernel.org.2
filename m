Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37BF33284D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhCIOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhCIOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:15:37 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC67AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:15:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u16so15879882wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ol6OkkC2nUnq8Y6A1v6xDdX14ho/H0K1X/8pX5FNFEo=;
        b=VS6jbPEBrW4C2FdnvkFOBPnTbV0uD/pIpsf1p+n3Eh2OqdKgSICyT5VXU2/IdSZ54f
         rYdTXRYRRhuhJW1X9+bIjk5EWynJCtJuAPkTRePPYK3v8FhgGgy4BKP1cCn3H05ioo2p
         1Xj/fZ17Br0/nUqpmPVkF0aSGAuGGKFc2WURtEbIaX+4yUH4hTBU5hYI0RC/KswRDXtP
         MsOPTqai2Vs4P/+xxasDuCQ7I2OZMSLjbaSQgzWqAczd/0nthktjo1z7mnwBqSceG7E1
         hWLAz4kdK8sieuhZtotcsL0XWJHXHUvofCpP4qNHXJQwqinUFddQ3oe5c/mF2kdYusSu
         or2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ol6OkkC2nUnq8Y6A1v6xDdX14ho/H0K1X/8pX5FNFEo=;
        b=fRLSqTEih/Hxuz1W/84EvnGwAkswlwqfd/H0o3lj421UB/zrHyxwDtJc3T9F31cfeK
         fASEC5ZV4GHGKG8GQVN7zHAz0yYOzbLRx1yMiHBWy1P2AbtwXTKrsev+p+jYWZB/pVHM
         w7wbrfcZK7NLg0HESP6TP4nmMtWoSLj0VA0H+vNLf/wrLQ/LLhxweGA/gEgllJyUwwoh
         fpODuKUxvyLD48kEPipIXyS/jF2TbvV1sRDOQdx+I41iFmQ6z35hS538qQLEM9jPZJ2N
         wPa0AhErM8LMtiGtLuPM+ds4orF3Usx/4stY6Q9TxoPH3qWtDsnMK8iFsxPrSqHjZ8Vy
         MEtA==
X-Gm-Message-State: AOAM53301cjodUcZvYfmta8CcJK3wkRdBn7zYikpx/xwhKC68kTiA/8w
        8bkVB+WbvmKID1qjkQLAGe0C3Q==
X-Google-Smtp-Source: ABdhPJyzj+WdvbxrL2gu0kgNza2MM26l6kL+4JccrryB4WRTmzZ/qKQ7QIr0Pnu6eykx/GUjTnNYDQ==
X-Received: by 2002:adf:f292:: with SMTP id k18mr28854329wro.335.1615299335594;
        Tue, 09 Mar 2021 06:15:35 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u20sm28007579wru.6.2021.03.09.06.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 06:15:35 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/5] soundwire: qcom: add static port map support
Date:   Tue,  9 Mar 2021 14:15:12 +0000
Message-Id: <20210309141514.24744-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
References: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
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
 drivers/soundwire/qcom.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index f4f1c5f2af0b..b4d1aaf535c5 100644
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
@@ -473,8 +475,13 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 		}
 
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+			slave = s_rt->slave;
 			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
-				pcfg = &ctrl->pconfig[i];
+				m_port = slave->m_port_map[p_rt->num - 1];
+				if (m_port)
+					pcfg = &ctrl->pconfig[m_port - 1];
+				else
+					pcfg = &ctrl->pconfig[i];
 				p_rt->transport_params.port_num = p_rt->num;
 				p_rt->transport_params.sample_interval =
 					pcfg->si + 1;
@@ -535,8 +542,10 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 	struct sdw_master_runtime *m_rt;
 	struct sdw_slave_runtime *s_rt;
 	struct sdw_port_runtime *p_rt;
+	struct sdw_slave *slave;
 	unsigned long *port_mask;
 	int i, maxport, pn, nports = 0, ret = 0;
+	unsigned int m_port;
 
 	mutex_lock(&ctrl->port_lock);
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
@@ -549,9 +558,15 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 		}
 
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+			slave = s_rt->slave;
 			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
+				m_port = slave->m_port_map[p_rt->num - 1];
 				/* Port numbers start from 1 - 14*/
-				pn = find_first_zero_bit(port_mask, maxport);
+				if (m_port)
+					pn = m_port;
+				else
+					pn = find_first_zero_bit(port_mask, maxport);
+
 				if (pn > (maxport)) {
 					dev_err(ctrl->dev, "All ports busy\n");
 					ret = -EBUSY;
-- 
2.21.0


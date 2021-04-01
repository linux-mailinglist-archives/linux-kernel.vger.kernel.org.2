Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E549335122E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhDAJZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbhDAJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:24:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6DFC061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:24:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hq27so1838958ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oOGfrAjnaHDyy1tyd/ITu7l8d1aLT0q9c434VgRCWEU=;
        b=Hcyf8uZ1S+AbwrUswcBEuo0hbJdidSJ3m55scMsQLn6YgcfRifwgdwX9lFIdR0/EwD
         sGhFr60G2F8wy8HLT6Fq5DhdGsBHMiuPlmytuu7EgzkSuqlo95gnVhKjzr1ar1reXWRy
         zFyQ/s7NNZEF2DY6cBUFD4LsxM57FCe1SKmiy823/oelgR+egUmQIK7uO3UEGLNNyiHV
         y+t6qvzdHTboH9aDRDUNYi0DYZsK6YNoYc5CDjo7AeQwjabpspIEd+IprIQHYt+yPhvS
         WReETkGNvh5uLj8sisd8E9GbdkynxeV6Sz2jOsz2Nxo0HTjfX8ZYuwb52ygiKLE07zbC
         Bj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oOGfrAjnaHDyy1tyd/ITu7l8d1aLT0q9c434VgRCWEU=;
        b=HAJ7R/6XgaXK3sVnAqbB8ST7nz1tLA9vDUtVlWBVle0avrMLMnDXr7go+qZM+YEG5Z
         Nwgix4wJGdOlxOvPyAXeYKPXaxzqRBUOUHBvWXMWWF+geTLCbdAhPgkWcHPC08HehmMC
         QdMwbnHnd/Vvz2EXXzHpsVjlRjhRV/WNRWVEDGQMvMOz4VkUNSXPjZuUQCiTglO7Rsx5
         Lwihg9IWOV7i54Ig5dkfmfsE2mFMrhWLjI3XsMo1UpJMRXp+YqduBxZcXtgYngGY7M2J
         nRh2/uJNKzNnwL7FlXBmEVspD5joHhjCu4XZ9jwGPLmWbYDLd73HZuD4S0VevU7PGaEc
         lK2g==
X-Gm-Message-State: AOAM533qkQer386gagjDFTHNyZGYOayLE3FlTxa4ifv6rBy7upaBmEfT
        qbyDymc5XzW0tNiUhsoCizZUyQ==
X-Google-Smtp-Source: ABdhPJzc8mO3rKu0OflJbxXCo6lNYZ1oXBNAu5JQfDr5Rx7+ZGLHFGAQPxX9JPUy+kSv8IfVBWKpyg==
X-Received: by 2002:a17:907:94cc:: with SMTP id dn12mr8188592ejc.177.1617269097400;
        Thu, 01 Apr 2021 02:24:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id cb17sm3221540edb.10.2021.04.01.02.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:24:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: qcom: cleanup internal port config indexing
Date:   Thu,  1 Apr 2021 10:24:54 +0100
Message-Id: <20210401092454.21299-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internally used portconfig array for storing port bandwidth
params starts from offset zero. However port zero is not really
used and we also copy the bus parameters to offset zero.
So basically we endup with a code which has to subtract 1 from port
number to get to port parameters.

This is bit confusing to the reader so, make this bit more obvious by only
copying the parameters to offset 1 instead of zero. This will avoid doing
-1 every time when we try to get port params.

Similar thing has been recently done with din/dout_port_mask.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 94fd58f9dda3..348d9a46f850 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -724,7 +724,7 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
 	int reg = SWRM_DP_PORT_CTRL_BANK((params->port_num), bank);
 	int ret;
 
-	pcfg = &ctrl->pconfig[params->port_num - 1];
+	pcfg = &ctrl->pconfig[params->port_num];
 
 	value = pcfg->off1 << SWRM_DP_PORT_CTRL_OFFSET1_SHFT;
 	value |= pcfg->off2 << SWRM_DP_PORT_CTRL_OFFSET2_SHFT;
@@ -811,11 +811,11 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 	struct qcom_swrm_port_config *pcfg;
 	struct sdw_slave *slave;
 	unsigned int m_port;
-	int i = 0;
+	int i = 1;
 
 	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
 		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
-			pcfg = &ctrl->pconfig[p_rt->num - 1];
+			pcfg = &ctrl->pconfig[p_rt->num];
 			p_rt->transport_params.port_num = p_rt->num;
 			if (pcfg->word_length != SWR_INVALID_PARAM) {
 				sdw_fill_port_params(&p_rt->port_params,
@@ -832,7 +832,7 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 				m_port = slave->m_port_map[p_rt->num];
 				/* port config starts at offset 0 so -1 from actual port number */
 				if (m_port)
-					pcfg = &ctrl->pconfig[m_port - 1];
+					pcfg = &ctrl->pconfig[m_port];
 				else
 					pcfg = &ctrl->pconfig[i];
 				p_rt->transport_params.port_num = p_rt->num;
@@ -1167,15 +1167,16 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	of_property_read_u8_array(np, "qcom,ports-lane-control", lane_control, nports);
 
 	for (i = 0; i < nports; i++) {
-		ctrl->pconfig[i].si = si[i];
-		ctrl->pconfig[i].off1 = off1[i];
-		ctrl->pconfig[i].off2 = off2[i];
-		ctrl->pconfig[i].bp_mode = bp_mode[i];
-		ctrl->pconfig[i].hstart = hstart[i];
-		ctrl->pconfig[i].hstop = hstop[i];
-		ctrl->pconfig[i].word_length = word_length[i];
-		ctrl->pconfig[i].blk_group_count = blk_group_count[i];
-		ctrl->pconfig[i].lane_control = lane_control[i];
+		/* Valid port number range is from 1-14 */
+		ctrl->pconfig[i + 1].si = si[i];
+		ctrl->pconfig[i + 1].off1 = off1[i];
+		ctrl->pconfig[i + 1].off2 = off2[i];
+		ctrl->pconfig[i + 1].bp_mode = bp_mode[i];
+		ctrl->pconfig[i + 1].hstart = hstart[i];
+		ctrl->pconfig[i + 1].hstop = hstop[i];
+		ctrl->pconfig[i + 1].word_length = word_length[i];
+		ctrl->pconfig[i + 1].blk_group_count = blk_group_count[i];
+		ctrl->pconfig[i + 1].lane_control = lane_control[i];
 	}
 
 	return 0;
-- 
2.21.0


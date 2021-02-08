Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4273313E38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhBHS4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbhBHRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:10:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7853C061794
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:10:07 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bl23so26070317ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3+IoLhlKF+WmYphxpLrWsQly31W73Rfh7xPPIk0bWk=;
        b=I+4CAsW7RRAH6QptCssC+ne7Jua0SxDUJPbkHz20qKy23YDfB9D42XBVkIBQ67ypOb
         PVpghU8WpHfe7bRx58r7usL6RsDJmppaHsEBjxZzDJtZptsSDLnKXl7pq5O06daj9PtA
         8rfp+ZWkJ91iKFeWq1sgSz9X1jq/JjqDAbw3ac6bKldxYl/CZraKqhlFC3mIR4B50HHy
         PzIxvddlkrDhz1RL4xOmoJlantmTc9QxxWasmdQbd8+KSYwc6Msvdps1ECI/TyZJRh6P
         oAs8b9pf4OIgkTvm0zsuTMwkCIHG+aludi/YUvO8Qy8q3Oo1d0WsuCizcrxQAW8g+SLt
         3qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3+IoLhlKF+WmYphxpLrWsQly31W73Rfh7xPPIk0bWk=;
        b=V78Qxk56ATijEUzPF4qZBGBRArZImZE46sjzFsrvM6rpvvOmkcjU+4BGp4UDEkmPQd
         dvnM4tspU6zqe+ozVGwvIXOP3aIUdUcfgHmQ7YhSx4VSgvEuesDMr9d/JAEsOhK5CeYl
         VmuuW71Jy/cC3zAyrn5mmr5eiJTd1nx13b1GWZ6dCl1Dm/T27Ug7lMog+YFq+523nWnW
         pwisv/Q4ocY9QjzNPUl7KKQ4iQI9C6uApkV1z4Zp8PTz6VvIWILDZ9ff8KKrfVVE9Vnl
         9T2Gg9qM9as8uIGO0W6H4iYvkkyVaVLB6MZnu2G2mJuB5Jozz2QN828CsNcMNIszU7On
         SCVw==
X-Gm-Message-State: AOAM530h5I4qNHasnvKqrou4H+2MnahpZljaIjHdDGkI32xi8jdzuU69
        le6fEvXWvK+6PeStkgY13oc=
X-Google-Smtp-Source: ABdhPJwmX2+crTM1Z2bwV6K+ZeffthvAcWhuqi9Ye7l/dkdyrFpkn5pMEulOSOBdwW3vSDjgABIeZg==
X-Received: by 2002:a17:906:4e4b:: with SMTP id g11mr17670540ejw.3.1612804206653;
        Mon, 08 Feb 2021 09:10:06 -0800 (PST)
Received: from yoga-910.localhost (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id m10sm9834479edi.54.2021.02.08.09.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:10:06 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/3] bus: fsl-mc: list more commands as accepted through the ioctl
Date:   Mon,  8 Feb 2021 19:09:49 +0200
Message-Id: <20210208170949.3070898-4-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208170949.3070898-1-ciorneiioana@gmail.com>
References: <20210208170949.3070898-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add some new MC firmware commands that can be received through the
userspace ioctl interface - *get_max_frame_length and *_get_counter.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-uapi.c | 50 ++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc-uapi.c
index bdcd9d983a78..9c4c1395fcdb 100644
--- a/drivers/bus/fsl-mc/fsl-mc-uapi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
@@ -60,6 +60,13 @@ enum fsl_mc_cmd_index {
 	DPNI_GET_PRIM_MAC,
 	DPNI_GET_STATISTICS,
 	DPNI_GET_LINK_STATE,
+	DPNI_GET_MAX_FRAME_LENGTH,
+	DPSW_GET_TAILDROP,
+	DPSW_SET_TAILDROP,
+	DPSW_IF_GET_COUNTER,
+	DPSW_IF_GET_MAX_FRAME_LENGTH,
+	DPDMUX_GET_COUNTER,
+	DPDMUX_IF_GET_MAX_FRAME_LENGTH,
 	GET_ATTR,
 	GET_IRQ_MASK,
 	GET_IRQ_STATUS,
@@ -261,6 +268,49 @@ static struct fsl_mc_cmd_desc fsl_mc_accepted_cmds[] = {
 		.token = true,
 		.size = 8,
 	},
+	[DPNI_GET_MAX_FRAME_LENGTH] = {
+		.cmdid_value = 0x2170,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 8,
+	},
+	[DPSW_GET_TAILDROP] = {
+		.cmdid_value = 0x0A80,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 14,
+	},
+	[DPSW_SET_TAILDROP] = {
+		.cmdid_value = 0x0A90,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 24,
+		.flags = FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+	[DPSW_IF_GET_COUNTER] = {
+		.cmdid_value = 0x0340,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 11,
+	},
+	[DPSW_IF_GET_MAX_FRAME_LENGTH] = {
+		.cmdid_value = 0x0450,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 10,
+	},
+	[DPDMUX_GET_COUNTER] = {
+		.cmdid_value = 0x0b20,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 11,
+	},
+	[DPDMUX_IF_GET_MAX_FRAME_LENGTH] = {
+		.cmdid_value = 0x0a20,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 10,
+	},
 	[GET_ATTR] = {
 		.cmdid_value = 0x0040,
 		.cmdid_mask = 0xFFF0,
-- 
2.30.0


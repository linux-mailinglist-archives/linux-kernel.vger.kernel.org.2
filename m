Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A579424060
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbhJFOtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbhJFOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:49:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E0C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:47:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e12so9635732wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8FsxkcadEsB0KvX5OVsbse2HvnnQsUaBCJfhIJAhFGE=;
        b=xaNyii8NWBMrYt0y7RytBqtx7mpDLu3DIUxxFb2gClMrfocpLaeqz8NgZHztKH7Cfm
         oZSCGAPxDSerTf+6ZyRxDbhSR7GDiBAnfOk33Guot4OOiNluxL05DQqosYXvpoMUvBgU
         /BKVvL18gx9uK2LiF/BSfSrNu8ySctgIrbRT3J3cg2LacVRJaGcnqaIuVn8Uutos0uAZ
         E95s5CriUQD+SJ9tI1SS3XBQvkNB6hnIS+0BHRtwX21aJLynvmLrVCsPWbxklpZrBPob
         +Tv4oIQD8XU1VqREP8McNI+n2VbR1AoqpEAZ/Gxjqa6mJSnK7reF7aAYx1dXf+IoMO7Y
         NzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8FsxkcadEsB0KvX5OVsbse2HvnnQsUaBCJfhIJAhFGE=;
        b=bS/R6+gv6nB7PTK2XXdqbtF6yG5Mma2zyes8u6v0JI7iBFpKyQo20XlQiH55kNeykF
         gRHAGKuY16/wbkLFOiHRjbsRIx0KPKCQwZ2PX11bolmtBqRgA1zoLJfOfPrnhDYHDYaq
         o2wT8Dd6cL6LlIKr3JRcftGNn4SbdWOKIqe0e5pMBtuj9hL9O2oQuRDrP8LxyVgbWWLy
         oqsjsU869i6yBA2qG9SAXJfS+IWe4MpXRc9ON2HdxQqbYgww1dsLJxL/16p1dgjrVoUH
         MC+qLXpletW1g1KJM1dn2eqLCgZCQRscpq0NkVKzrpjL8RCrGbHzMAVtXBDh8Qp2jo/F
         +b3w==
X-Gm-Message-State: AOAM531ic/b2YsBWyP/gUnAwRDTwhKLoRTW5iidQ0blLGvrVMRw2mqCS
        xcQmimn2HFpBlI6md2/X0I0UdA==
X-Google-Smtp-Source: ABdhPJy3B7iLzBZDlHmrllpB0xLpI0Y347lt3B3UrNn7oJyIntlM2yjFVQqAgQwlAxw6awUXyV1iXQ==
X-Received: by 2002:a05:6000:18aa:: with SMTP id b10mr1971598wri.270.1633531662509;
        Wed, 06 Oct 2021 07:47:42 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z18sm14589340wro.25.2021.10.06.07.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:47:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, qiangqing.zhang@nxp.com,
        linux-imx@nxp.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] nvmem: imx-ocotp: add support for post processing
Date:   Wed,  6 Oct 2021 15:47:29 +0100
Message-Id: <20211006144729.15268-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211006144729.15268-1-srinivas.kandagatla@linaro.org>
References: <20211006144729.15268-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add .cell_post_process callback for imx-ocotp to deal with MAC address,
since MAC address need to be reversed byte for some i.MX SoCs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 08f41328cc71..89fd4d3eb649 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -97,6 +97,7 @@ struct ocotp_params {
 	unsigned int bank_address_words;
 	void (*set_timing)(struct ocotp_priv *priv);
 	struct ocotp_ctrl_reg ctrl;
+	bool reverse_mac_address;
 };
 
 static int imx_ocotp_wait_for_busy(struct ocotp_priv *priv, u32 flags)
@@ -221,6 +222,25 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 	return ret;
 }
 
+static int imx_ocotp_cell_pp(void *context, const char *id, unsigned int offset,
+			     void *data, size_t bytes)
+{
+	struct ocotp_priv *priv = context;
+
+	/* Deal with some post processing of nvmem cell data */
+	if (!strcmp(id, "mac-address")) {
+		if (priv->params->reverse_mac_address) {
+			u8 *buf = data;
+			int i;
+
+			for (i = 0; i < bytes/2; i++)
+				swap(buf[i], buf[bytes - i - 1]);
+		}
+	}
+
+	return 0;
+}
+
 static void imx_ocotp_set_imx6_timing(struct ocotp_priv *priv)
 {
 	unsigned long clk_rate;
@@ -468,6 +488,7 @@ static struct nvmem_config imx_ocotp_nvmem_config = {
 	.stride = 1,
 	.reg_read = imx_ocotp_read,
 	.reg_write = imx_ocotp_write,
+	.cell_post_process = imx_ocotp_cell_pp,
 };
 
 static const struct ocotp_params imx6q_params = {
@@ -530,6 +551,7 @@ static const struct ocotp_params imx8mq_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
+	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mm_params = {
@@ -537,6 +559,7 @@ static const struct ocotp_params imx8mm_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
+	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mn_params = {
@@ -544,6 +567,7 @@ static const struct ocotp_params imx8mn_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
+	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mp_params = {
@@ -551,6 +575,7 @@ static const struct ocotp_params imx8mp_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_8MP,
+	.reverse_mac_address = true,
 };
 
 static const struct of_device_id imx_ocotp_dt_ids[] = {
-- 
2.21.0


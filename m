Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880D342C141
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhJMNWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhJMNWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:22:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5A2C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:20:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y3so8421121wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7d4kJDbZh0Pm8SFG3aAQTFWSp0lxAWNKEuG3AGksVAI=;
        b=GPUQcjm4WGCVsumcfQqR0GI9OtmMERPL8eZ0MS3nMJvAnvjWUc9nHs84fqVI0czSix
         T3PRta2pDeRlbxcKy64Fe+kcsFFyyelGio5+Mh7vkNMxg9gjDSZm8noy4o/3utRgFHB+
         /vS+HZxzdjfmKlYWSfEg+p9iCXNkuxsxjLhl2xGy10to0GfANABcihTNsiDSIEPFhaJv
         W/MhMQ3fzhRgKMLd3YZbpdcQIp8E6fBsDC6YB9IIXoDUo1CBPp5lp+R+a9VfcLnYVkVz
         e5da4V/7hntakFh51NUzZrRLRG1iwGz1SYxSu6DY0YHvuAv6mGz2c32Qf0X+QhC72ti4
         NatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7d4kJDbZh0Pm8SFG3aAQTFWSp0lxAWNKEuG3AGksVAI=;
        b=hpu7tAkLKeL3SfDaa9J+uP2mHxIICuTRf1lfBENBCKMRLUtZmMKK+hzAv74CCnNf/A
         0qRcXdhWZWvkZpN4cOCf5bVGLhRdZhEM0HXKU/ZoqF+WZaCZF6Fo1JiDO2vtTO1Uj7VO
         HK6vPbzDAIgukJX0c4h8X6vZ2LZKokUW3FuFJ7DdHJbcHuEe3rQ8LKWFbSAPrDe26aai
         yvyFyPHOi6PSo/ICRPXU08WQx9wOEAl1SYJSGWwgzFMwPJZWZ9IrKt6qFnt8O/Rixq1J
         G8duaVHjDUQ62IzFyZQ0oz5AeVtcp2ozCOwwAQ3AKnwQuVGiuJblbbywegaB9dlKDAWN
         rk9w==
X-Gm-Message-State: AOAM532sNh2k0NOnWfhhsNpdKCU5GA71tjjkUS/ZgZxCz1tQRYd5AbSU
        z8r2S0oix0bYTh9eHxx95oGOQA==
X-Google-Smtp-Source: ABdhPJyuyFMuuy1bUATKTUEL1jZT6AjwY40l5ROwzdZzsCP/wWwNafNouSHvTimJoUarZSz3+dEveg==
X-Received: by 2002:a1c:1dcb:: with SMTP id d194mr12358049wmd.161.1634131229583;
        Wed, 13 Oct 2021 06:20:29 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r4sm2281367wrz.58.2021.10.13.06.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:20:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 3/3] nvmem: imx-ocotp: add support for post processing
Date:   Wed, 13 Oct 2021 14:19:57 +0100
Message-Id: <20211013131957.30271-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211013131957.30271-1-srinivas.kandagatla@linaro.org>
References: <20211013131957.30271-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add .cell_post_process callback for imx-ocotp to deal with MAC address,
since MAC address need to be reversed byte for some i.MX SoCs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 08f41328cc71..14284e866f26 100644
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
+	if (id && !strcmp(id, "mac-address")) {
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C9F442881
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhKBHef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:34:35 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:31476 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhKBHe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:34:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635838314; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=EMG0lON7OvsiFIv2D+95jSk3PKzFdvdECBnX6ODhf1E=; b=aOGtSLUHG2PiGXxOcqQZcQJ5CrVaU/pIhCYOIdA/PTqXWGtPwaMZtn/Czze5B+nafWoPZCI9
 2bUrJEO27aSU6tvMMIJw6BKyty8kgY9crYSu8qp5cZV0IPnX+B5EJTzjd5ZmNzzKgNa4tHaz
 8astN6zsm7qByPRINekKMom/yCU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6180e95cfd59e9ce78b797bd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Nov 2021 07:31:40
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79581C4361C; Tue,  2 Nov 2021 07:31:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7CFBC43460;
        Tue,  2 Nov 2021 07:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D7CFBC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Venkata Prasad Potturu <potturu@codeaurora.org>
Subject: [PATCH v4 03/10] ASoC: qcom: Add register definition for codec rddma and wrdma
Date:   Tue,  2 Nov 2021 13:00:58 +0530
Message-Id: <1635838265-27346-4-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635838265-27346-1-git-send-email-srivasam@codeaurora.org>
References: <1635838265-27346-1-git-send-email-srivasam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds register definitions for codec read dma and write dma
lpass interface.

Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
---
 sound/soc/qcom/lpass-lpaif-reg.h | 103 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/lpass-lpaif-reg.h b/sound/soc/qcom/lpass-lpaif-reg.h
index 2eb03ad..697a11f 100644
--- a/sound/soc/qcom/lpass-lpaif-reg.h
+++ b/sound/soc/qcom/lpass-lpaif-reg.h
@@ -74,6 +74,16 @@
 #define LPAIF_IRQSTAT_REG(v, port)	LPAIF_IRQ_REG_ADDR(v, 0x4, (port))
 #define LPAIF_IRQCLEAR_REG(v, port)	LPAIF_IRQ_REG_ADDR(v, 0xC, (port))
 
+/* LPAIF RXTX IRQ */
+#define LPAIF_RXTX_IRQ_REG_ADDR(v, addr, port, dai_id) \
+		((dai_id == LPASS_CDC_DMA_RX0 || dai_id == LPASS_CDC_DMA_TX3) ? \
+		(v->rxtx_irq_reg_base + (addr) + v->rxtx_irq_reg_stride * (port)) : \
+		(v->va_irq_reg_base + (addr) + v->va_irq_reg_stride * (port)))
+
+#define LPAIF_RXTX_IRQEN_REG(v, port, dai_id) LPAIF_RXTX_IRQ_REG_ADDR(v, 0x0, port, dai_id)
+#define LPAIF_RXTX_IRQSTAT_REG(v, port, dai_id) LPAIF_RXTX_IRQ_REG_ADDR(v, 0x4, port, dai_id)
+#define LPAIF_RXTX_IRQCLEAR_REG(v, port, dai_id) LPAIF_RXTX_IRQ_REG_ADDR(v, 0xC, port, dai_id)
+
 
 #define LPASS_HDMITX_APP_IRQ_REG_ADDR(v, addr)  \
 	((v->hdmi_irq_reg_base) + (addr))
@@ -139,12 +149,93 @@
 		(LPAIF_INTFDMA_REG(v, chan, reg, dai_id)) : \
 		LPAIF_WRDMA##reg##_REG(v, chan))
 
-#define LPAIF_DMACTL_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, CTL, dai_id)
-#define LPAIF_DMABASE_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, BASE, dai_id)
-#define	LPAIF_DMABUFF_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, BUFF, dai_id)
-#define LPAIF_DMACURR_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, CURR, dai_id)
-#define	LPAIF_DMAPER_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, PER, dai_id)
-#define	LPAIF_DMAPERCNT_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, PERCNT, dai_id)
+#define LPAIF_DMACTL_REG(v, chan, dir, dai_id)  \
+	(((dai_id == LPASS_CDC_DMA_RX0) || \
+	(dai_id == LPASS_CDC_DMA_TX3) || \
+	(dai_id == LPASS_CDC_DMA_VA_TX0)) ? \
+	__LPAIF_CDC_DMA_REG(v, chan, dir, CTL, dai_id) : \
+	__LPAIF_DMA_REG(v, chan, dir, CTL, dai_id))
+#define LPAIF_DMABASE_REG(v, chan, dir, dai_id) \
+	((dai_id == LPASS_CDC_DMA_RX0 || \
+	dai_id == LPASS_CDC_DMA_TX3 || \
+	dai_id == LPASS_CDC_DMA_VA_TX0) ? \
+	__LPAIF_CDC_DMA_REG(v, chan, dir, BASE, dai_id) : \
+	__LPAIF_DMA_REG(v, chan, dir, BASE, dai_id))
+#define LPAIF_DMABUFF_REG(v, chan, dir, dai_id) \
+	((dai_id == LPASS_CDC_DMA_RX0 || \
+	dai_id == LPASS_CDC_DMA_TX3 || \
+	dai_id == LPASS_CDC_DMA_VA_TX0) ? \
+	__LPAIF_CDC_DMA_REG(v, chan, dir, BUFF, dai_id) : \
+	__LPAIF_DMA_REG(v, chan, dir, BUFF, dai_id))
+#define LPAIF_DMACURR_REG(v, chan, dir, dai_id) \
+	((dai_id == LPASS_CDC_DMA_RX0 || \
+	dai_id == LPASS_CDC_DMA_TX3 || \
+	dai_id == LPASS_CDC_DMA_VA_TX0) ? \
+	__LPAIF_CDC_DMA_REG(v, chan, dir, CURR, dai_id) : \
+	__LPAIF_DMA_REG(v, chan, dir, CURR, dai_id))
+#define LPAIF_DMAPER_REG(v, chan, dir, dai_id)  \
+	((dai_id == LPASS_CDC_DMA_RX0 || \
+	dai_id == LPASS_CDC_DMA_TX3 || \
+	dai_id == LPASS_CDC_DMA_VA_TX0) ? \
+	__LPAIF_CDC_DMA_REG(v, chan, dir, PER, dai_id) : \
+	__LPAIF_DMA_REG(v, chan, dir, PER, dai_id))
+#define LPAIF_DMAPERCNT_REG(v, chan, dir, dai_id) \
+	((dai_id == LPASS_CDC_DMA_RX0 || \
+	dai_id == LPASS_CDC_DMA_TX3 || \
+	dai_id == LPASS_CDC_DMA_VA_TX0) ? \
+	__LPAIF_CDC_DMA_REG(v, chan, dir, PERCNT, dai_id) : \
+	__LPAIF_DMA_REG(v, chan, dir, PERCNT, dai_id))
+
+#define LPAIF_CDC_RDMA_REG_ADDR(v, addr, chan, dai_id) \
+	((dai_id == LPASS_CDC_DMA_RX0 || dai_id == LPASS_CDC_DMA_TX3) ? \
+	(v->rxtx_rdma_reg_base + (addr) + v->rxtx_rdma_reg_stride * (chan)) : \
+	(v->va_rdma_reg_base + (addr) + v->va_rdma_reg_stride * (chan)))
+
+#define LPAIF_CDC_RDMACTL_REG(v, chan, dai_id) LPAIF_CDC_RDMA_REG_ADDR(v, 0x00, (chan), dai_id)
+#define LPAIF_CDC_RDMABASE_REG(v, chan, dai_id) LPAIF_CDC_RDMA_REG_ADDR(v, 0x04, (chan), dai_id)
+#define LPAIF_CDC_RDMABUFF_REG(v, chan, dai_id) LPAIF_CDC_RDMA_REG_ADDR(v, 0x08, (chan), dai_id)
+#define LPAIF_CDC_RDMACURR_REG(v, chan, dai_id) LPAIF_CDC_RDMA_REG_ADDR(v, 0x0C, (chan), dai_id)
+#define LPAIF_CDC_RDMAPER_REG(v, chan, dai_id) LPAIF_CDC_RDMA_REG_ADDR(v, 0x10, (chan), dai_id)
+
+#define LPAIF_CDC_RDMA_INTF_REG(v, chan, dai_id) \
+	LPAIF_CDC_RDMA_REG_ADDR(v, 0x50, (chan), dai_id)
+
+#define LPAIF_CDC_WRDMA_REG_ADDR(v, addr, chan, dai_id) \
+	((dai_id == LPASS_CDC_DMA_RX0 || dai_id == LPASS_CDC_DMA_TX3) ? \
+	(v->rxtx_wrdma_reg_base + (addr) + \
+	v->rxtx_wrdma_reg_stride * (chan - v->rxtx_wrdma_channel_start)) : \
+	(v->va_wrdma_reg_base + (addr) + \
+	v->va_wrdma_reg_stride * (chan - v->va_wrdma_channel_start)))
+
+#define LPAIF_CDC_WRDMACTL_REG(v, chan, dai_id) \
+	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x00, (chan), dai_id)
+#define LPAIF_CDC_WRDMABASE_REG(v, chan, dai_id) \
+	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x04, (chan), dai_id)
+#define LPAIF_CDC_WRDMABUFF_REG(v, chan, dai_id) \
+	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x08, (chan), dai_id)
+#define LPAIF_CDC_WRDMACURR_REG(v, chan, dai_id) \
+	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x0C, (chan), dai_id)
+#define LPAIF_CDC_WRDMAPER_REG(v, chan, dai_id) \
+	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x10, (chan), dai_id)
+#define LPAIF_CDC_WRDMA_INTF_REG(v, chan, dai_id) \
+	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x50, (chan), dai_id)
+
+#define __LPAIF_CDC_DMA_REG(v, chan, dir, reg, dai_id)  \
+		((dir ==  SNDRV_PCM_STREAM_PLAYBACK) ? \
+		(LPAIF_CDC_RDMA##reg##_REG(v, chan, dai_id)) : \
+		LPAIF_CDC_WRDMA##reg##_REG(v, chan, dai_id))
+
+#define LPAIF_CDC_INTF_REG(v, chan, dir, dai_id) \
+		((dir ==  SNDRV_PCM_STREAM_PLAYBACK) ? \
+		LPAIF_CDC_RDMA_INTF_REG(v, chan, dai_id) : \
+		LPAIF_CDC_WRDMA_INTF_REG(v, chan, dai_id))
+
+#define LPAIF_INTF_REG(v, chan, dir, dai_id) \
+		((dai_id == LPASS_CDC_DMA_RX0 || \
+		dai_id == LPASS_CDC_DMA_TX3 || \
+		dai_id == LPASS_CDC_DMA_VA_TX0) ? \
+		LPAIF_CDC_INTF_REG(v, chan, dir, dai_id) : \
+		LPAIF_DMACTL_REG(v, chan, dir, dai_id))
 
 #define LPAIF_DMACTL_BURSTEN_SINGLE	0
 #define LPAIF_DMACTL_BURSTEN_INCR4	1
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


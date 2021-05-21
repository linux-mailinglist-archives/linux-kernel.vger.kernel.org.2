Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201F538C724
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbhEUMym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235118AbhEUMwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:52:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F988613DE;
        Fri, 21 May 2021 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621601470;
        bh=VAT+6TRJEy5p0xfa5NF7lAjHEvfhUuINzi99UFg1nws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8O9zxzzqcVkrceHF1QQ7lUyOOIQ3/UO3b+ofCxLgjbpBSwrJjyrYCiBsMaK1GtGy
         wqR6MB60CNfHqvN2Hn+LkUBOUeG9zHp11zOvgOM8hNKLKLB9NueARrqs/WEjW9W7c/
         xNt8gFm1l6evsvj/lRNbkieAphJ3BzcucWhL9HOBr7Ozo85EQhVsxf0UAOsujYjWa4
         CIv7rZPhk1kbYlG10oRUFMbeLYu5odGzqLQ7OMugPnLW3oFNC9CKN4Lo79WuFuioMR
         myP13sivRYBMcnrjwlhD7Aq7YnAsq3D8O14G0ecovFs5pziMtP+c+4lm5INLDlQbu0
         SN24pwojeUbSw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [RFC PATCH 12/13] drm/msm/dsi: Add support for DSC configuration
Date:   Fri, 21 May 2021 18:19:45 +0530
Message-Id: <20210521124946.3617862-17-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210521124946.3617862-1-vkoul@kernel.org>
References: <20210521124946.3617862-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DSC is enabled, we need to configure DSI registers accordingly and
configure the respective stream compression registers.

Add support to calculate the register setting based on DSC params and
timing information and configure these registers.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi.xml.h  |  10 +++
 drivers/gpu/drm/msm/dsi/dsi_host.c | 118 ++++++++++++++++++++++++++---
 2 files changed, 118 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/dsi/dsi.xml.h
index 50eb4d1b8fdd..b8e9e608abfc 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
@@ -2310,4 +2310,14 @@ static inline uint32_t REG_DSI_7nm_PHY_LN_TX_DCTRL(uint32_t i0) { return 0x00000
 
 #define REG_DSI_7nm_PHY_PLL_PERF_OPTIMIZE			0x00000260
 
+#define REG_DSI_VIDEO_COMPRESSION_MODE_CTRL			0x0000029c
+
+#define REG_DSI_VIDEO_COMPRESSION_MODE_CTRL2			0x000002a0
+
+#define REG_DSI_COMMAND_COMPRESSION_MODE_CTRL			0x000002a4
+
+#define REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2			0x000002a8
+
+#define REG_DSI_COMMAND_COMPRESSION_MODE_CTRL3			0x000002ac
+
 #endif /* DSI_XML */
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 864d3c655e73..e26545fc82e0 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -954,6 +954,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_dual_dsi)
 	u32 va_end = va_start + mode->vdisplay;
 	u32 hdisplay = mode->hdisplay;
 	u32 wc;
+	u32 data;
 
 	DBG("");
 
@@ -972,7 +973,69 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_dual_dsi)
 		hdisplay /= 2;
 	}
 
+	if (msm_host->dsc) {
+		struct msm_display_dsc_config *dsc = msm_host->dsc;
+
+		/* update dsc params with timing params */
+		dsc->drm.pic_width = mode->hdisplay;
+		dsc->drm.pic_height = mode->vdisplay;
+
+		/* Divide the display by 3 but keep back/font porch and
+		 * pulse width same
+		 */
+		h_total -= hdisplay;
+		hdisplay /= 3;
+		h_total += hdisplay;
+		ha_end = ha_start + hdisplay;
+	}
+
 	if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
+		if (msm_host->dsc) {
+			struct msm_display_dsc_config *dsc = msm_host->dsc;
+			u32 reg, intf_width, slice_per_intf, width;
+			u32 total_bytes_per_intf;
+
+			/* first calculate dsc parameters and then program
+			 * compress mode registers
+			 */
+			intf_width = hdisplay;
+			slice_per_intf = DIV_ROUND_UP(intf_width, dsc->drm.slice_width);
+
+			/* If slice_per_pkt > slice_per_intf, then use 1
+			 * This can happen during partial update
+			 */
+			if (dsc->slice_per_pkt > slice_per_intf)
+				dsc->slice_per_pkt = 1;
+
+			dsc->bytes_in_slice = DIV_ROUND_UP(dsc->drm.slice_width * 8, 8);
+			total_bytes_per_intf = dsc->bytes_in_slice * slice_per_intf;
+
+			dsc->eol_byte_num = total_bytes_per_intf % 3;
+			dsc->pclk_per_line =  DIV_ROUND_UP(total_bytes_per_intf, 3);
+			dsc->bytes_per_pkt = dsc->bytes_in_slice * dsc->slice_per_pkt;
+			dsc->pkt_per_line = slice_per_intf / dsc->slice_per_pkt;
+
+			width = dsc->pclk_per_line;
+			reg = dsc->bytes_per_pkt << 16;
+			reg |= (0x0b << 8);    /* dtype of compressed image */
+
+			/* pkt_per_line:
+			 * 0 == 1 pkt
+			 * 1 == 2 pkt
+			 * 2 == 4 pkt
+			 * 3 pkt is not supported
+			 * above translates to ffs() - 1
+			 */
+			reg |= (ffs(dsc->pkt_per_line) - 1) << 6;
+
+			dsc->eol_byte_num = total_bytes_per_intf % 3;
+			reg |= dsc->eol_byte_num << 4;
+			reg |= 1;
+
+			dsi_write(msm_host,
+				  REG_DSI_VIDEO_COMPRESSION_MODE_CTRL, reg);
+		}
+
 		dsi_write(msm_host, REG_DSI_ACTIVE_H,
 			DSI_ACTIVE_H_START(ha_start) |
 			DSI_ACTIVE_H_END(ha_end));
@@ -991,19 +1054,50 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_dual_dsi)
 			DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
 			DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
 	} else {		/* command mode */
+		if (msm_host->dsc) {
+			struct msm_display_dsc_config *dsc = msm_host->dsc;
+			u32 reg, reg_ctrl, reg_ctrl2;
+			u32 slice_per_intf, bytes_in_slice, total_bytes_per_intf;
+
+			reg_ctrl = dsi_read(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL);
+			reg_ctrl2 = dsi_read(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2);
+
+			slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->drm.slice_width);
+			bytes_in_slice = DIV_ROUND_UP(dsc->drm.slice_width *
+						      dsc->drm.bits_per_pixel, 8);
+			dsc->drm.slice_chunk_size = bytes_in_slice;
+			total_bytes_per_intf = dsc->bytes_in_slice * slice_per_intf;
+			dsc->pkt_per_line = slice_per_intf / dsc->slice_per_pkt;
+
+			reg = 0x39 << 8;
+			reg |= ffs(dsc->pkt_per_line) << 6;
+
+			dsc->eol_byte_num = total_bytes_per_intf % 3;
+			reg |= dsc->eol_byte_num << 4;
+			reg |= 1;
+
+			reg_ctrl |= reg;
+			reg_ctrl2 |= bytes_in_slice;
+
+			dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL, reg);
+			dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2, reg_ctrl2);
+		}
+
 		/* image data and 1 byte write_memory_start cmd */
-		wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
+		if (!msm_host->dsc)
+			wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
+		else
+			wc = mode->hdisplay / 2 + 1;
+
+		data = DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
+		       DSI_CMD_MDP_STREAM0_CTRL_VIRTUAL_CHANNEL(msm_host->channel) |
+			DSI_CMD_MDP_STREAM0_CTRL_DATA_TYPE(MIPI_DSI_DCS_LONG_WRITE);
 
-		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
-			DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
-			DSI_CMD_MDP_STREAM0_CTRL_VIRTUAL_CHANNEL(
-					msm_host->channel) |
-			DSI_CMD_MDP_STREAM0_CTRL_DATA_TYPE(
-					MIPI_DSI_DCS_LONG_WRITE));
+		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL, data);
 
-		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_TOTAL,
-			DSI_CMD_MDP_STREAM0_TOTAL_H_TOTAL(hdisplay) |
-			DSI_CMD_MDP_STREAM0_TOTAL_V_TOTAL(mode->vdisplay));
+		data = DSI_CMD_MDP_STREAM0_TOTAL_H_TOTAL(hdisplay) |
+			DSI_CMD_MDP_STREAM0_TOTAL_V_TOTAL(mode->vdisplay);
+		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_TOTAL, data);
 	}
 }
 
@@ -2111,6 +2205,7 @@ int msm_dsi_host_modeset_init(struct mipi_dsi_host *host,
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	const struct msm_dsi_cfg_handler *cfg_hnd = msm_host->cfg_hnd;
 	struct platform_device *pdev = msm_host->pdev;
+	struct msm_drm_private *priv;
 	int ret;
 
 	msm_host->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
@@ -2130,6 +2225,9 @@ int msm_dsi_host_modeset_init(struct mipi_dsi_host *host,
 	}
 
 	msm_host->dev = dev;
+	priv = dev->dev_private;
+	priv->dsc = msm_host->dsc;
+
 	ret = cfg_hnd->ops->tx_buf_alloc(msm_host, SZ_4K);
 	if (ret) {
 		pr_err("%s: alloc tx gem obj failed, %d\n", __func__, ret);
-- 
2.26.3


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E0D3EAC05
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhHLUmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhHLUm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:42:29 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D66C0617AD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:42:04 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id m3so3989018qvu.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4fH6A/BcmiXnSJNIz36CupSiUjhhUBPUWUzzeHlruOE=;
        b=egHFOLfly8AjKOqcXJyLVExDLf6LQcj/wgdtZZlG5HWIU+cPfiscKiz0rCyST76G8o
         R29ekx00ati+bx0XNynb2U9MyzPCgFER6DrNzBCe6sx/4JmE0BzGTabFbGP5POS1kmdG
         sRFtNYWNtS2yP9Q9bMekpEjPMEb7VsysanYbWDUQE5LjXew+VClPpizjFVE20Zn+q7OL
         ygoF7ioTB1CcezHpNHEQqB6ZU17m5K6EEtO2sIp0+RarAbhJRdF7B3hYIIQiPlvi8Uqn
         AjREhqExwBJMw02IxVR3Ewz6TBNy/Jf6zIZ2I4/gPIZjqaU/21pyGuV5gjL4WQ82k1YA
         ge/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fH6A/BcmiXnSJNIz36CupSiUjhhUBPUWUzzeHlruOE=;
        b=uTYMuBcnupx1olGW1QK++NXYB6tz3EsIMvGT6lyXzDoDayZa8EOt5ZLp4zW0FmIBVU
         T3cOaUQIx64AtonpUCiqoJVak8mJlAwnzpmaJtXYF5zTGwZx7fGkuMtBVKcNwgjryLCU
         fmJr7nmtqL5lfbDmZ+nFpxdmH+01195/zkknxEO7jhO6WhuEQaMazN5/+NzJfdxBduM0
         emRWHYrFdDrGu0MT851YIyCRtyFg0nT/1IdcUSIg7jcZzEg6b8LrSYKXKxJuLgfElJPO
         3Fb1JT/08OxmnobFwHQl5RWczYxca2ueh1s+4bNUbfX03EtOFfz0KiU8Ob7FXoutZPeM
         nAcQ==
X-Gm-Message-State: AOAM530OayArjv9XPhogQyLY0WyiNC6X/qPKMDsoKnA8jkdjxhaeNWj5
        HGYanFzREgRFlRcsWz6/3u8=
X-Google-Smtp-Source: ABdhPJwO8BKYR3rqA3vonlPaweauwBXBAV9qhXKsuNnD9drM/Byn6GLIlelcDUcBbLDmR3/VIErhxg==
X-Received: by 2002:a05:6214:dce:: with SMTP id 14mr5852702qvt.34.1628800923135;
        Thu, 12 Aug 2021 13:42:03 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:e89f:d077:9161:1bd7])
        by smtp.gmail.com with ESMTPSA id m16sm1940361qki.19.2021.08.12.13.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:42:02 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] phy: phy-rockchip-inno-usb2: add rk3568 support
Date:   Thu, 12 Aug 2021 16:41:14 -0400
Message-Id: <20210812204116.2303617-7-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812204116.2303617-1-pgwipeout@gmail.com>
References: <20210812204116.2303617-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3568 usb2phy is a standalone device with a single muxed interrupt.
Add support for the registers to the usb2phy driver.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index fdeb2e7c937a..74420c439a07 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1100,6 +1100,7 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	if (ret) {
 		dev_err(rphy->dev, "failed to init irq for host port\n");
 		goto out;
+	}
 
 	if (!IS_ERR(rphy->edev)) {
 		rport->event_nb.notifier_call = rockchip_otg_event;
@@ -1509,6 +1510,69 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
+	{
+		.reg = 0xfe8a0000,
+		.num_ports	= 2,
+		.clkout_ctl	= { 0x0008, 4, 4, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0000, 8, 0, 0, 0x1d1 },
+				.bvalid_det_en	= { 0x0080, 2, 2, 0, 1 },
+				.bvalid_det_st	= { 0x0084, 2, 2, 0, 1 },
+				.bvalid_det_clr = { 0x0088, 2, 2, 0, 1 },
+				.utmi_avalid	= { 0x00c0, 10, 10, 0, 1 },
+				.utmi_bvalid	= { 0x00c0, 9, 9, 0, 1 },
+			},
+			[USB2PHY_PORT_HOST] = {
+				/* Select suspend control from controller */
+				.phy_sus	= { 0x0004, 8, 0, 0x1d2, 0x1d2 },
+				.ls_det_en	= { 0x0080, 1, 1, 0, 1 },
+				.ls_det_st	= { 0x0084, 1, 1, 0, 1 },
+				.ls_det_clr	= { 0x0088, 1, 1, 0, 1 },
+				.utmi_ls	= { 0x00c0, 17, 16, 0, 1 },
+				.utmi_hstdet	= { 0x00c0, 19, 19, 0, 1 }
+			}
+		},
+		.chg_det = {
+			.opmode		= { 0x0000, 3, 0, 5, 1 },
+			.cp_det		= { 0x00c0, 24, 24, 0, 1 },
+			.dcp_det	= { 0x00c0, 23, 23, 0, 1 },
+			.dp_det		= { 0x00c0, 25, 25, 0, 1 },
+			.idm_sink_en	= { 0x0008, 8, 8, 0, 1 },
+			.idp_sink_en	= { 0x0008, 7, 7, 0, 1 },
+			.idp_src_en	= { 0x0008, 9, 9, 0, 1 },
+			.rdm_pdwn_en	= { 0x0008, 10, 10, 0, 1 },
+			.vdm_src_en	= { 0x0008, 12, 12, 0, 1 },
+			.vdp_src_en	= { 0x0008, 11, 11, 0, 1 },
+		},
+	},
+	{
+		.reg = 0xfe8b0000,
+		.num_ports	= 2,
+		.clkout_ctl	= { 0x0008, 4, 4, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0000, 8, 0, 0x1d2, 0x1d1 },
+				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
+				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
+				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
+				.utmi_ls	= { 0x00c0, 5, 4, 0, 1 },
+				.utmi_hstdet	= { 0x00c0, 7, 7, 0, 1 }
+			},
+			[USB2PHY_PORT_HOST] = {
+				.phy_sus	= { 0x0004, 8, 0, 0x1d2, 0x1d1 },
+				.ls_det_en	= { 0x0080, 1, 1, 0, 1 },
+				.ls_det_st	= { 0x0084, 1, 1, 0, 1 },
+				.ls_det_clr	= { 0x0088, 1, 1, 0, 1 },
+				.utmi_ls	= { 0x00c0, 17, 16, 0, 1 },
+				.utmi_hstdet	= { 0x00c0, 19, 19, 0, 1 }
+			}
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rv1108_phy_cfgs[] = {
 	{
 		.reg = 0x100,
@@ -1558,6 +1622,7 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
 	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
 	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
+	{ .compatible = "rockchip,rk3568-usb2phy", .data = &rk3568_phy_cfgs },
 	{ .compatible = "rockchip,rv1108-usb2phy", .data = &rv1108_phy_cfgs },
 	{}
 };
-- 
2.25.1


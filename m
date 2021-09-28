Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC341A5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 04:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbhI1DAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 23:00:04 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:12559 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbhI1C77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 22:59:59 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18S2aUKk072690;
        Tue, 28 Sep 2021 10:36:30 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Sep 2021 10:57:11 +0800
From:   tommy-huang <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 4/6] HACK: drm/aspeed: INTR_STS hadndling
Date:   Tue, 28 Sep 2021 10:57:01 +0800
Message-ID: <20210928025703.10909-5-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210928025703.10909-1-tommy_huang@aspeedtech.com>
References: <20210928025703.10909-1-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18S2aUKk072690
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

The 2600 uses this register differently. THis is a TODO to come up with
a method of handling that.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index ea9cb0a4f16c..33095477cc03 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -126,7 +126,8 @@ static irqreturn_t aspeed_gfx_irq_handler(int irq, void *data)
 
 	if (reg & CRT_CTRL_VERTICAL_INTR_STS) {
 		drm_crtc_handle_vblank(&priv->pipe.crtc);
-		writel(reg, priv->base + CRT_CTRL1);
+		/* TODO */
+		writel(CRT_CTRL_VERTICAL_INTR_STS, priv->base + CRT_STATUS);
 		return IRQ_HANDLED;
 	}
 
-- 
2.17.1


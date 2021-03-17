Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94533ED69
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCQJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:49:59 -0400
Received: from m12-17.163.com ([220.181.12.17]:47646 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhCQJtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NQRZn
        WXsBa44aCkWDCH+ENfuI2B82mvYTVNLXxgVA7U=; b=ngc47QqNRkVX61NPKJBig
        22MPVNuj6P4vY+skcjKrvR9obvTY3Rg8y5ds6HCdcDG2dANabGHBxl/OnQbW8QD6
        yY2fkaFLSfQgT9AwSsEYCsrwSALDEx6OLk3Nc6GLVFrmzwrOCDLSUJHmotLmc3c0
        5kR7L9qyf9uPO1DX8bNqGA=
Received: from COOL-20200911ZP.ccdomain.com (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowADHzJyM0FFgU67lqQ--.19405S2;
        Wed, 17 Mar 2021 17:49:08 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        sebastian.reichel@collabora.com, laurent.pinchart@ideasonboard.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        tangchunyou@yulong.com
Subject: [PATCH] omapdrm/dss/dsi.c:modify 'u32'->'int'
Date:   Wed, 17 Mar 2021 17:48:52 +0800
Message-Id: <20210317094852.424-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowADHzJyM0FFgU67lqQ--.19405S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr43Kw4rZry7uFWfGF13twb_yoWxtFg_uF
        1IqrsxXr4avF98Zr1ayay2vryFyF17ZF40yr18tFWfAw4avrn8X34DZry7Zw1vkr42qF95
        C3WDXryFvF4xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8CD73UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiHhRYUVSItTcNmQAAsJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangchunyou <tangchunyou@yulong.com>

1.the type of mipi_dsi_create_packet id int
2.u32 can not < 0

Signed-off-by: tangchunyou <tangchunyou@yulong.com>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 8e11612..11c502d 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2149,7 +2149,7 @@ static int dsi_vc_send_short(struct dsi_data *dsi, int vc,
 			     const struct mipi_dsi_msg *msg)
 {
 	struct mipi_dsi_packet pkt;
-	u32 r;
+	int r;
 
 	r = mipi_dsi_create_packet(&pkt, msg);
 	if (r < 0)
-- 
1.9.1



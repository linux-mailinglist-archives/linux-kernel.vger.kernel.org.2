Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9526331D174
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBPUSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:18:48 -0500
Received: from smtp-17.italiaonline.it ([213.209.10.17]:32929 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229572AbhBPUSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:18:44 -0500
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id C6n9lYZr1lChfC6nIldwZ7; Tue, 16 Feb 2021 21:18:02 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1613506682; bh=E6mT1eLy2BbvLR20EYpVVGUzTe4X8rj8sSx2cY7U1BQ=;
        h=From;
        b=Syk1io4d3Z645NJYJYZmITmczoU6ZfK5Gisxywo5C1ApjO1QDGJ16t4taOOPdS+Nh
         uFzb3xfKhiCMBgRPdXnMbFJeUaYfLBOuX6HMnTPYX4ERRLWNIAu9NIamWd15+u/o/s
         r5CEl5KU33W45yXVSYVIl4oP+M6UPm+FXq6h4GCBAn+YFhCcgslQSP3ceaFgw4tgjr
         c0iwB3GH2dfubBEqqD/lueqd3X12+NWW7DFSvJRzv5vXsXPtfDQuImXwnSMR36bqmE
         as6GqT+kSSFzTwDqIA0nt+1lk2+jo7ZiblrPozd8CzJGcrJJew1nooYbURqZN0l1zi
         N+IxnaRBiyYfw==
X-CNFS-Analysis: v=2.4 cv=S6McfKgP c=1 sm=1 tr=0 ts=602c287a cx=a_exe
 a=AVqmXbCQpuNSdJmApS5GbQ==:117 a=AVqmXbCQpuNSdJmApS5GbQ==:17
 a=toUk0IfjeMrTqMqL6ioA:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND PATCH] drm/tilcdc: fix raster control register setting
Date:   Tue, 16 Feb 2021 21:17:38 +0100
Message-Id: <20210216201738.11946-1-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4xfP8GmNc6lqtNCx9AjdaZ6CT32yIdeq+RBmhw1tSqvBDTixLFsbu+OzjxxIiTE2+sUIzwho6mk1P5VIhmwYZ7EVGWKE0j4GR3lo1wn6o/JN+JsYJ3PA0y
 9eMEgBt0CHyDKEF74hm9UyUWsQNanESrpCta5XHmZfoM4N5WtHjs9jxDgSHiKdMqfWs02vmqoh6B7KJDZF4VEf14pNFkNMwRVzesgEhbc373TtOgOb6couTd
 VRlJLqR9M/wzEYHGRGD8AknuU3ssduvrqgeeuBt7WN7l2acUB8Ew9ybPVJyoIUsEFBfN0eLFGtN1bLweycpRHI/Xytv6kQCeZa7OU7vkQ1Nw1MhXleXgRk/S
 4ReprtnPVFF/RXZs+q2JawbojElQznifi27/OhHN3dZcdPFkFzKZNswtpEk0TfT3ALOgAW1ok+Ltj4i0IOxyw5s6uKPodA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fdd property of the tilcdc_panel_info structure must set the reqdly
bit field  (bit 12 to 19) of the raster control register. The previous
statement set the least significant bit instead.

Signed-off-by: Dario Binacchi <dariobin@libero.it>

---

 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 30213708fc99..238068e28729 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -393,7 +393,7 @@ static void tilcdc_crtc_set_mode(struct drm_crtc *crtc)
 			return;
 		}
 	}
-	reg |= info->fdd < 12;
+	reg |= info->fdd << 12;
 	tilcdc_write(dev, LCDC_RASTER_CTRL_REG, reg);
 
 	if (info->invert_pxl_clk)
-- 
2.17.1


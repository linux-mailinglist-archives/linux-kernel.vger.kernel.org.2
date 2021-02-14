Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FA531B087
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 14:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBNNY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 08:24:26 -0500
Received: from smtp-17.italiaonline.it ([213.209.10.17]:39339 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229741AbhBNNYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 08:24:22 -0500
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Feb 2021 08:24:22 EST
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id BHGzlGzOglChfBHH2lSOc0; Sun, 14 Feb 2021 14:17:18 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1613308638; bh=E6mT1eLy2BbvLR20EYpVVGUzTe4X8rj8sSx2cY7U1BQ=;
        h=From;
        b=ZpAmYi+IKCWgHyj28z6lIn5HVGK9sxHytuyDiudYb43ITPihegRI1MRIRM6maa9Bh
         G6HjbgVTEtUX72n0XTVEBXRZ/igelUyzADGaKGFzKaylFr0ODvv6A0krtp4Rgacwnq
         uByYETt7a33t3e7vMhI7xZw0hIrlHOdK4iFh9pvzrdw4GXJIsKGxxydJ0DAVOnOQAZ
         +/NxqqeprMWMoGHI1Z07AySxQ6bhRbbzqik2lClJYBbaaI3pVjWjG6SxzquyfydkPV
         QI63zqXI/JhAAAF2ZJQFmwRup+B+WSEQizn7CO92CkDsF1H5GOQb9Uy//62GqQJbjM
         rFODGn0aQ3T+w==
X-CNFS-Analysis: v=2.4 cv=S6McfKgP c=1 sm=1 tr=0 ts=602922de cx=a_exe
 a=AVqmXbCQpuNSdJmApS5GbQ==:117 a=AVqmXbCQpuNSdJmApS5GbQ==:17
 a=toUk0IfjeMrTqMqL6ioA:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/tilcdc: fix raster control register setting
Date:   Sun, 14 Feb 2021 14:16:33 +0100
Message-Id: <20210214131633.8742-1-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4xfMWdaqhQ+nSGvZCap5fuCPf8jL9YHqt+DWi5pPLGDMgmPnom2IIJHhAhuxJSRQZJmBSK2X3uzoM7Qmktkqz0w7y1AmIsrLflB2ipm2vuEsbsNyYTJ/vp
 5tV6EgywFwK0mibn6E+Ey77YTfpCyNr0s1hzC15RekyHEBqHm/kOZzgfvUhHjMJMRHF1XLM0vMIqGDPrn2A4RswurykyjdR4PvictSH6FoKyZu3bcp+ejMsS
 0OZCGPQ9pwEi0ulA3BoZI5qKse7C1QS9F29QWzQOz8SMw1QvZ53VcCE8ZImPdbmXdKdThVhMomCecDKXPNCzs6UgiAiWcGbIzezeMEqP3xm8UbyxGUFnX1Kf
 RxxejY4AKuoY78Id2sL7gJRlc/Ah2TLOlMPZotJyN/LLPJDY50gNSRg/tM6deA0PwIU/s9bi
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


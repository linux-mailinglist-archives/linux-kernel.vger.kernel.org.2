Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B161739B0F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFDDgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:36:54 -0400
Received: from m12-17.163.com ([220.181.12.17]:42635 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhFDDgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cfv9t
        BQ6dxOcn/QL0KKer8Pxu4ep0/itbLN5AEtgeyY=; b=SBNnypAqnERksqvz6BBZp
        Nj3KI5rTHL3a8H8tZRpM0E464fliCGvF5fZUpfnkCICA8tKhCW88iX2od0MM51v2
        PNt2Xhya/2GJMiHbX8C6foGtnTrC3dFPnE8gKP7ZvXEN+ccuAdLpE7joojtICUGv
        a8pucbf3tpQy35cUJE8a34=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowAD31m5mn7lg4L705A--.57063S2;
        Fri, 04 Jun 2021 11:35:03 +0800 (CST)
From:   lijian_8010a29@163.com
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: aty: mach64_gx: Removed unnecessary 'return'
Date:   Fri,  4 Jun 2021 11:34:02 +0800
Message-Id: <20210604033402.152596-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAD31m5mn7lg4L705A--.57063S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4DZw43KryUWr18AFyUAwb_yoW8Cw4xpF
        WFyFyqqFs8tw4F93W5GwsrAryYkrnrK342ya4DGa43G3WFvFWrWa1UJFy2k3Z5G348XFyD
        Z3yjv3y5Arn3WrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bbwZcUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiRQenUFl9181h0gAAs4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lijian <lijian@yulong.com>

Removed unnecessary 'return' in void functions.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/aty/mach64_gx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/video/fbdev/aty/mach64_gx.c b/drivers/video/fbdev/aty/mach64_gx.c
index 9c37e28fb78b..9619661b7843 100644
--- a/drivers/video/fbdev/aty/mach64_gx.c
+++ b/drivers/video/fbdev/aty/mach64_gx.c
@@ -58,7 +58,6 @@ static void aty_StrobeClock(const struct atyfb_par *par)
 
 	tmp = aty_ld_8(CLOCK_CNTL, par);
 	aty_st_8(CLOCK_CNTL + par->clk_wr_offset, tmp | CLOCK_STROBE, par);
-	return;
 }
 
 
@@ -423,7 +422,6 @@ static void aty_ICS2595_put1bit(u8 data, const struct atyfb_par *par)
 		 par);
 
 	aty_StrobeClock(par);
-	return;
 }
 
 static void aty_set_pll18818(const struct fb_info *info,
@@ -480,7 +478,6 @@ static void aty_set_pll18818(const struct fb_info *info,
 	mdelay(50);		/* delay for 50 (15) ms */
 	aty_st_8(CLOCK_CNTL + par->clk_wr_offset,
 		 ((pll->ics2595.locationAddr & 0x0F) | CLOCK_STROBE), par);
-	return;
 }
 
 const struct aty_pll_ops aty_pll_ati18818_1 = {
@@ -596,7 +593,6 @@ static void aty_set_pll_1703(const struct fb_info *info,
 
 	(void) aty_ld_8(DAC_REGS, par);	/* Clear DAC Counter */
 	aty_st_8(CRTC_GEN_CNTL + 3, old_crtc_ext_disp, par);
-	return;
 }
 
 const struct aty_pll_ops aty_pll_stg1703 = {
@@ -718,8 +714,6 @@ static void aty_set_pll_8398(const struct fb_info *info,
 
 	(void) aty_ld_8(DAC_REGS, par);	/* Clear DAC Counter */
 	aty_st_8(CRTC_GEN_CNTL + 3, old_crtc_ext_disp, par);
-
-	return;
 }
 
 const struct aty_pll_ops aty_pll_ch8398 = {
@@ -866,7 +860,6 @@ static void aty_set_pll_408(const struct fb_info *info,
 
 	(void) aty_ld_8(DAC_REGS, par);	/* Clear DAC Counter */
 	aty_st_8(CRTC_GEN_CNTL + 3, old_crtc_ext_disp, par);
-	return;
 }
 
 const struct aty_pll_ops aty_pll_att20c408 = {
-- 
2.25.1



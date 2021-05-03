Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9F23714FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhECMDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233942AbhECMCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:02:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C25361369;
        Mon,  3 May 2021 12:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043275;
        bh=bFZH5Wvhc2cF0gXWbmzW/UeKcRjcXWb02hgTLQwsN/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KAuYq6ZGqyJMqefCmqzW0w1W/ib520kIbqzn1j4tXF0VSaCJeB05hg7NeDHn6k+BZ
         pABbqwriYO2rz5AKhhjeOccSTkrr6EoYGhnhUPidew96K1zUPbLvJKCXXJAhfD6H7j
         6Q4X/yPbJyYI2WKJgfmHTxkKPX9Vp/CAIFr0DroE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 67/69] video: imsttfb: check for ioremap() failures
Date:   Mon,  3 May 2021 13:57:34 +0200
Message-Id: <20210503115736.2104747-68-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should check if ioremap() were to somehow fail in imsttfb_probe() and
handle the unwinding of the resources allocated here properly.

Ideally if anyone cares about this driver (it's for a PowerMac era PCI
display card), they wouldn't even be using fbdev anymore.  Or the devm_*
apis could be used, but that's just extra work for diminishing
returns...

Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Rob Herring <robh@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/imsttfb.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index e04411701ec8..16f272a50811 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1469,6 +1469,7 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct imstt_par *par;
 	struct fb_info *info;
 	struct device_node *dp;
+	int ret = -ENOMEM;
 	
 	dp = pci_device_to_OF_node(pdev);
 	if(dp)
@@ -1504,23 +1505,37 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		default:
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
-			release_mem_region(addr, size);
-			framebuffer_release(info);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto error;
 	}
 
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
 					    0x400000 : 0x800000);
+	if (!info->screen_base)
+		goto error;
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
+	if (!par->dc_regs)
+		goto error;
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
+	if (!par->cmap_regs)
+		goto error;
 	info->pseudo_palette = par->palette;
 	init_imstt(info);
 
 	pci_set_drvdata(pdev, info);
 	return 0;
+
+error:
+	if (par->dc_regs)
+		iounmap(par->dc_regs);
+	if (info->screen_base)
+		iounmap(info->screen_base);
+	release_mem_region(addr, size);
+	framebuffer_release(info);
+	return ret;
 }
 
 static void imsttfb_remove(struct pci_dev *pdev)
-- 
2.31.1


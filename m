Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F8D31C3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 22:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBOVzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 16:55:55 -0500
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:54162 "EHLO
        1.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBOVzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 16:55:53 -0500
X-Greylist: delayed 4201 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2021 16:55:52 EST
Received: from player798.ha.ovh.net (unknown [10.108.54.72])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 97A811F4459
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 18:08:59 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player798.ha.ovh.net (Postfix) with ESMTPSA id F06BF1B2BA2CF;
        Mon, 15 Feb 2021 17:08:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G0039a594b61-676e-43c5-8ca7-d80a602cbb63,
                    C16AD3286F4283AA50684BE431D994343DAE27DC) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] vgacon: drop unused vga_init_done
Date:   Mon, 15 Feb 2021 18:08:37 +0100
Message-Id: <20210215170837.1599706-1-steve@sk2.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12297923209508638069
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrieekgdelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucfuphgrmhfkphfpvghtfihorhhkpeekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 973c096f6a85 ("vgacon: remove software scrollback support")
removed all uses of vga_init_done, so let's get rid of it entirely.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/video/console/vgacon.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 17876f0179b5..36bded9c9876 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -79,7 +79,6 @@ static struct uni_pagedir *vgacon_uni_pagedir;
 static int vgacon_refcount;
 
 /* Description of the hardware situation */
-static bool		vga_init_done;
 static unsigned long	vga_vram_base		__read_mostly;	/* Base of video memory */
 static unsigned long	vga_vram_end		__read_mostly;	/* End of video memory */
 static unsigned int	vga_vram_size		__read_mostly;	/* Size of video memory */
@@ -360,8 +359,6 @@ static const char *vgacon_startup(void)
 	vgacon_xres = screen_info.orig_video_cols * VGA_FONTWIDTH;
 	vgacon_yres = vga_scan_lines;
 
-	vga_init_done = true;
-
 	return display_desc;
 }
 

base-commit: f40ddce88593482919761f74910f42f4b84c004b
-- 
2.29.2


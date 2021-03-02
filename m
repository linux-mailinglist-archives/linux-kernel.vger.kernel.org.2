Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE5932A1EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347947AbhCBHM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:12:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:39060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577483AbhCBGW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:22:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C566FAF87;
        Tue,  2 Mar 2021 06:22:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 04/44] vgacon: comment on vga_rolled_over
Date:   Tue,  2 Mar 2021 07:21:34 +0100
Message-Id: <20210302062214.29627-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long time ago, I figured out what this number is good for and documented
that locally. But never submitted, so do it now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/console/vgacon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 962c12be9774..0d26e821e73b 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -96,7 +96,7 @@ static bool 		vga_is_gfx;
 static bool 		vga_512_chars;
 static int 		vga_video_font_height;
 static int 		vga_scan_lines		__read_mostly;
-static unsigned int 	vga_rolled_over;
+static unsigned int 	vga_rolled_over; /* last vc_origin offset before wrap */
 
 static bool vgacon_text_mode_force;
 static bool vga_hardscroll_enabled;
-- 
2.30.1


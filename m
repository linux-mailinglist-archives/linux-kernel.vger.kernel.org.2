Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD853BC614
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 07:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhGFF3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 01:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhGFF3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 01:29:49 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CC48C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 22:27:11 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id AB5EB92009D; Tue,  6 Jul 2021 07:27:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A45B492009B;
        Tue,  6 Jul 2021 07:27:09 +0200 (CEST)
Date:   Tue, 6 Jul 2021 07:27:09 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jean Delvare <jdelvare@suse.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firmware: dmi: Log board vendor if no system vendor has
 been given
In-Reply-To: <alpine.DEB.2.21.2107051831260.33206@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2107060655210.33206@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107051831260.33206@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems do not provide any names with System Information, e.g. the 
Tyan Tomcat IV S1564D mainboard reports:

Legacy DMI 2.0 present.
DMI:  /i430HX, BIOS 4.51 PG 05/13/98

This is not unreasonable given that it was retailed as a bare mainboard 
rather that a complete system, so no information could have been known 
about the integrator.  It does have the manufacturer correctly recorded 
with Base Board Information though:

Handle 0x0001
	DMI type 1, 8 bytes.
	System Information
		Manufacturer:
		Product Name:
		Version:
		Serial Number:
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: Tyan Computer Corp
		Product Name: i430HX
		Version:
		Serial Number:

Resort to logging the board manufacturer then if none has been given for 
the system.  Also refrain from including the separating slash if no name 
has been given for the system.

Output is now:

Legacy DMI 2.0 present.
DMI: Tyan Computer Corp i430HX, BIOS 4.51 PG 05/13/98

for said board, surely more informative (of course a better name could 
have been chosen for the product than just "i430HX", but there you go).

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/firmware/dmi_scan.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

linux-dmi-board-vendor.diff
Index: linux-macro-ide-tty/drivers/firmware/dmi_scan.c
===================================================================
--- linux-macro-ide-tty.orig/drivers/firmware/dmi_scan.c
+++ linux-macro-ide-tty/drivers/firmware/dmi_scan.c
@@ -535,17 +535,23 @@ static int __init print_filtered(char *b
 static void __init dmi_format_ids(char *buf, size_t len)
 {
 	int c = 0;
+	const char *vendor;
 	const char *board;	/* Board Name is optional */
+	const char *name;
 
-	c += print_filtered(buf + c, len - c,
-			    dmi_get_system_info(DMI_SYS_VENDOR));
+	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
+	if (!vendor || !*vendor)
+		vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
+	c += print_filtered(buf + c, len - c, vendor);
 	c += scnprintf(buf + c, len - c, " ");
-	c += print_filtered(buf + c, len - c,
-			    dmi_get_system_info(DMI_PRODUCT_NAME));
+
+	name = dmi_get_system_info(DMI_PRODUCT_NAME);
+	c += print_filtered(buf + c, len - c, name);
 
 	board = dmi_get_system_info(DMI_BOARD_NAME);
 	if (board && *board) {
-		c += scnprintf(buf + c, len - c, "/");
+		if (name && *name)
+			c += scnprintf(buf + c, len - c, "/");
 		c += print_filtered(buf + c, len - c, board);
 	}
 	c += scnprintf(buf + c, len - c, ", BIOS ");

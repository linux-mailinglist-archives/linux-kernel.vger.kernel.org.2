Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE33BC613
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 07:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhGFF3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 01:29:42 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60340 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGFF3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 01:29:41 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5AA2092009D; Tue,  6 Jul 2021 07:27:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5814192009C;
        Tue,  6 Jul 2021 07:27:02 +0200 (CEST)
Date:   Tue, 6 Jul 2021 07:27:02 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jean Delvare <jdelvare@suse.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firmware: dmi: Prevent empty board name from being
 logged
In-Reply-To: <alpine.DEB.2.21.2107051831260.33206@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2107060439390.33206@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107051831260.33206@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems do provide DMI entries for Base Board Information, however 
the strings supplied are null, e.g:

Legacy DMI 2.0 present.
DMI: /, BIOS 4.51 PG 09/11/97

Do not log the slash along with the empty board name in that case as it 
carries no real information.  If it's important to tell an inexistent 
and an empty board name apart, then all DMI information can be retrieved 
from sysfs and/or with `dmidecode'.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/firmware/dmi_scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-macro-ide-tty/drivers/firmware/dmi_scan.c
===================================================================
--- linux-macro-ide-tty.orig/drivers/firmware/dmi_scan.c
+++ linux-macro-ide-tty/drivers/firmware/dmi_scan.c
@@ -544,7 +544,7 @@ static void __init dmi_format_ids(char *
 			    dmi_get_system_info(DMI_PRODUCT_NAME));
 
 	board = dmi_get_system_info(DMI_BOARD_NAME);
-	if (board) {
+	if (board && *board) {
 		c += scnprintf(buf + c, len - c, "/");
 		c += print_filtered(buf + c, len - c, board);
 	}

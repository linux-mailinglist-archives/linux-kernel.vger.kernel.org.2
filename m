Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C934346D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhCUT42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCUTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:55:31 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0502C061574;
        Sun, 21 Mar 2021 12:55:30 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2D41C92009C; Sun, 21 Mar 2021 20:55:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 274C992009B;
        Sun, 21 Mar 2021 20:55:27 +0100 (CET)
Date:   Sun, 21 Mar 2021 20:55:27 +0100 (CET)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] pata_platform: Document `pio_mask' module parameter
In-Reply-To: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2103212023190.21463@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_PARM_DESC documentation and a kernel-parameters.txt entry.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 Documentation/admin-guide/kernel-parameters.txt |    7 +++++++
 drivers/ata/pata_platform.c                     |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

linux-pata-platform-parm-desc.diff
Index: linux-dolch/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-dolch.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-dolch/Documentation/admin-guide/kernel-parameters.txt
@@ -3640,6 +3640,13 @@
 			By default set to 1 if CONFIG_PATA_WINBOND_VLB_MODULE,
 			0 otherwise.
 
+	pata_platform.pio_mask=	[HW,LIBATA]
+			Format: <int>
+			Supported PIO mode mask.  Set individual bits to allow
+			the use of the respective PIO modes.  Bit 0 is for
+			mode 0, bit 1 is for mode 1, and so on.  Mode 0 only
+			allowed by default.
+
 	pause_on_oops=
 			Halt all CPUs after the first oops has been printed for
 			the specified number of seconds.  This is to be used if
Index: linux-dolch/drivers/ata/pata_platform.c
===================================================================
--- linux-dolch.orig/drivers/ata/pata_platform.c
+++ linux-dolch/drivers/ata/pata_platform.c
@@ -24,6 +24,8 @@
 #define DRV_VERSION "1.2"
 
 static int pio_mask = 1;
+module_param(pio_mask, int, 0);
+MODULE_PARM_DESC(pio_mask, "PIO modes supported, mode 0 only by default");
 
 /*
  * Provide our own set_mode() as we don't want to change anything that has
@@ -233,8 +235,6 @@ static struct platform_driver pata_platf
 
 module_platform_driver(pata_platform_driver);
 
-module_param(pio_mask, int, 0);
-
 MODULE_AUTHOR("Paul Mundt");
 MODULE_DESCRIPTION("low-level driver for platform device ATA");
 MODULE_LICENSE("GPL");

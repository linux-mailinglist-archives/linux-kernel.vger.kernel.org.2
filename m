Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED3C32A20A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376294AbhCBHQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:16:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:39624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835876AbhCBGYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3224B02C;
        Tue,  2 Mar 2021 06:22:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 26/44] tty: vcc, drop version dump
Date:   Tue,  2 Mar 2021 07:21:56 +0100
Message-Id: <20210302062214.29627-26-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The version number is artificial, no need to dump it to logs during
initialization.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <sparclinux@vger.kernel.org>
---
 drivers/tty/vcc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 50bf9011a0c4..31b8a9a77375 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -14,16 +14,9 @@
 #include <asm/vio.h>
 #include <asm/ldc.h>
 
-#define DRV_MODULE_NAME		"vcc"
-#define DRV_MODULE_VERSION	"1.1"
-#define DRV_MODULE_RELDATE	"July 1, 2017"
-
-static char version[] =
-	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")";
-
 MODULE_DESCRIPTION("Sun LDOM virtual console concentrator driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_MODULE_VERSION);
+MODULE_VERSION("1.1");
 
 struct vcc_port {
 	struct vio_driver_state vio;
@@ -1066,8 +1059,6 @@ static int vcc_tty_init(void)
 {
 	int rv;
 
-	pr_info("VCC: %s\n", version);
-
 	vcc_tty_driver = tty_alloc_driver(VCC_MAX_PORTS, VCC_TTY_FLAGS);
 	if (IS_ERR(vcc_tty_driver)) {
 		pr_err("VCC: TTY driver alloc failed\n");
-- 
2.30.1


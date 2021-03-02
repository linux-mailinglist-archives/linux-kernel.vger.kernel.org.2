Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFED532A20B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376314AbhCBHRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:17:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:39622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835875AbhCBGYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9A35B02B;
        Tue,  2 Mar 2021 06:22:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 25/44] tty: vcc, make globals static
Date:   Tue,  2 Mar 2021 07:21:55 +0100
Message-Id: <20210302062214.29627-25-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used only in this unit, so make them static.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vcc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index e2d6205f83ce..50bf9011a0c4 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -66,9 +66,9 @@ static struct tty_driver *vcc_tty_driver;
 static struct vcc_port *vcc_table[VCC_MAX_PORTS];
 static DEFINE_SPINLOCK(vcc_table_lock);
 
-int vcc_dbg;
-int vcc_dbg_ldc;
-int vcc_dbg_vio;
+static unsigned int vcc_dbg;
+static unsigned int vcc_dbg_ldc;
+static unsigned int vcc_dbg_vio;
 
 module_param(vcc_dbg, uint, 0664);
 module_param(vcc_dbg_ldc, uint, 0664);
-- 
2.30.1


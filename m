Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C6C32A21B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577112AbhCBHSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:18:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:39620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835902AbhCBGZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:25:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE136B062;
        Tue,  2 Mar 2021 06:22:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 43/44] tty: make everyone's chars_in_buffer return >= 0
Date:   Tue,  2 Mar 2021 07:22:13 +0100
Message-Id: <20210302062214.29627-43-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tty line disciplines don't expect tty_operations::chars_in_buffer to
return negative values. Fix the two drivers which violate this.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 2 +-
 drivers/tty/vcc.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 7e1d19805aa4..da10e975829f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3056,7 +3056,7 @@ static int gsmtty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
-		return -EINVAL;
+		return 0;
 	return kfifo_len(&dlci->fifo);
 }
 
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 04a792749816..3106df98558a 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -896,7 +896,7 @@ static int vcc_chars_in_buffer(struct tty_struct *tty)
 	port = vcc_get_ne(tty->index);
 	if (unlikely(!port)) {
 		pr_err("VCC: chars_in_buffer: Failed to find VCC port\n");
-		return -ENODEV;
+		return 0;
 	}
 
 	num = port->chars_in_buffer;
-- 
2.30.1


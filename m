Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680203F2BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbhHTMUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbhHTMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:20:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422A9C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m26so8432294pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UIjtZnfqX78cSTj1tAzAA3UGoUKsEdOkprTsp1IzXvw=;
        b=GiXWLASP6dxF0qTc15ixomWmFpECXE2qrPXvu35picOAjYbniUO1QMZYqga4pDGkTT
         cUh3+EuikaDBpAiiL0i1ngC5Y5vzWsV2zjpdiGl7DOfZ8nbE+LR5xM8RAIVgSI0Ygl1c
         0lf0VJFHHmd6bhpLbOstibtzJAk0uI/jYrITBFQql7pOKiJUhakM7qASUKBOSjm/H/Iy
         AytFqzkr0o/AD/rZczr+oZxpoqHbcQq2UXKT1DsV94+3VkLYGznIARij51wn0kEaKCAp
         Pm7LOR2q/otU0NFwOuf48VF0N5XKqGaD5sr38g7z9L5fZWckUOLrcurNwyES8qWVkIt4
         dJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UIjtZnfqX78cSTj1tAzAA3UGoUKsEdOkprTsp1IzXvw=;
        b=SgvlCJEo0jGACXwn1ILkNsOpOZxGAimDE1Gk1J2hh94rUV5I5NGaGCyysCE6b5gEH4
         m0Wk6XyZ3ZA99ElycCKLNOJoU2InHTukrdlPlGJOA/kzqhTnoOmNLdx+BtQJDDw5GMJQ
         xDsCbBzBrfM3lQ1PiN8xTOzv1HefqfGx8/kOUSGdhdSpijgkiIvfcLbxCsBHp060ZZ3k
         CgNGVRk3MLTqrm9Rpf/AVAKwq4pncsBYFbla6ar90vPwTuxLQHvpNgI/5tveqF9SYkeP
         37Qm1RtZ9mkaF1g8YQQq81kxHGylbg0hmUcP0imo19A+TGXpP1GZdTtUdDoR+CPPWipo
         l47g==
X-Gm-Message-State: AOAM5314jJQlf9OmWCufLd6UC5IePYRbJHWIDxLpJzcmAVJOnpYtw23f
        3ySJZeLKzuEU/0FraFD8qlPGwEozyhnShQ==
X-Google-Smtp-Source: ABdhPJxKnbXNrh4N7Xsh939IigCn5MKwbhYgMEySbWNdG2hXPeDQw6lbd0nyDK2Yve2VYL5WnOfmiA==
X-Received: by 2002:a63:134e:: with SMTP id 14mr18148448pgt.312.1629461962904;
        Fri, 20 Aug 2021 05:19:22 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t18sm6629554pfg.111.2021.08.20.05.19.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:19:22 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] tty: n_gsm: Modify gsmtty driver register method when config requester
Date:   Fri, 20 Aug 2021 20:17:51 +0800
Message-Id: <1629461872-26965-7-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
References: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

As requester,because n_gsm has no uevent report for application,the
application can't know dlci connect or disconnect.

The application will control every dlcl dev by uevent,when application
receive gsmtty0 dev remove uevent,it will close mux function,and change to
normal mode.

Example:

Before modify:

gsmld receive DLC0 DISC,no event report to application
gsmld receive DLC1 SABM,no event report to application
gsmld receive DLC1 DISC,no event report to application

After modify:

Receive DLC0 DISC,report "/devices/virtual/tty/gsmtty0" remove uevent

Receive DLC1 SABM,report "/devices/virtual/tty/gsmtty1" add uevent
Receive DLC1 DISC,report "/devices/virtual/tty/gsmtty1" remove uevent

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 8d56d3d..9001805 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1433,6 +1433,8 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 		kfifo_reset(&dlci->fifo);
 	} else
 		dlci->gsm->dead = true;
+	/* Unregister gsmtty driver,report gsmtty dev remove uevent for user */
+	tty_unregister_device(gsm_tty_driver, dlci->addr);
 	wake_up(&dlci->gsm->event);
 	/* A DLCI 0 close is a MUX termination so we need to kick that
 	   back to userspace somehow */
@@ -1454,6 +1456,8 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 	dlci->state = DLCI_OPEN;
 	if (debug & 8)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
+	/* Register gsmtty driver,report gsmtty dev add uevent for user */
+	tty_register_device(gsm_tty_driver, dlci->addr, NULL);
 	wake_up(&dlci->gsm->event);
 }
 
@@ -2388,17 +2392,19 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	else {
 		/* Don't register device 0 - this is the control channel and not
 		   a usable tty interface */
-		base = mux_num_to_base(gsm); /* Base for this MUX */
-		for (i = 1; i < NUM_DLCI; i++) {
-			struct device *dev;
+		if (gsm->initiator) {
+			base = mux_num_to_base(gsm); /* Base for this MUX */
+			for (i = 1; i < NUM_DLCI; i++) {
+				struct device *dev;
 
-			dev = tty_register_device(gsm_tty_driver,
+				dev = tty_register_device(gsm_tty_driver,
 							base + i, NULL);
-			if (IS_ERR(dev)) {
-				for (i--; i >= 1; i--)
-					tty_unregister_device(gsm_tty_driver,
-								base + i);
-				return PTR_ERR(dev);
+				if (IS_ERR(dev)) {
+					for (i--; i >= 1; i--)
+						tty_unregister_device(gsm_tty_driver,
+									base + i);
+					return PTR_ERR(dev);
+				}
 			}
 		}
 	}
@@ -2420,8 +2426,10 @@ static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	int i;
 
 	WARN_ON(tty != gsm->tty);
-	for (i = 1; i < NUM_DLCI; i++)
-		tty_unregister_device(gsm_tty_driver, base + i);
+	if (gsm->initiator) {
+		for (i = 1; i < NUM_DLCI; i++)
+			tty_unregister_device(gsm_tty_driver, base + i);
+	}
 	gsm_cleanup_mux(gsm);
 	tty_kref_put(gsm->tty);
 	gsm->tty = NULL;
-- 
1.9.1


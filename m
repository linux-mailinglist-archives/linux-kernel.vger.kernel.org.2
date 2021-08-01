Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A983DCDC9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 22:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhHAUdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 16:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhHAUda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 16:33:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9408BC06175F;
        Sun,  1 Aug 2021 13:33:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b6so22480519pji.4;
        Sun, 01 Aug 2021 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fBZqElFDWoJRba//NR2LkUGnReQMVCu2fGdHFbNTSAA=;
        b=W9GRiK75FflUy+E6dFVTj5BSu4ZsbqxJvPwtta00h+zyQ3xELbzLhMnsPIpJQVM3x0
         JAMtpysJnSPU5gV/6eKz7UTFYIRyXQIU+RRmy6atjfK+YPQV89eNqaB/AbnyMDNzEmxC
         QjvI0uraRpb+sekb7qITDOTUAWb+CY4pB53md0H4uUjp1wpRC5M6XvS3I6ioVsdZOdgH
         DJ//wYpuXlxWdln3uIZmlvY1NtZPiXNkVPHu4SIYvoceq/FmmpWi9DUFifCGJj2NulyS
         nM2EYkDs0mVpksAkl2LWP1e80VfvOlP5PWZ1NyeHmCdAQ9qeXTTcEN84j470nzqxJWSO
         IjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fBZqElFDWoJRba//NR2LkUGnReQMVCu2fGdHFbNTSAA=;
        b=tT5+arST16B6LHAsu0nvdMGz8kOMUAV4AsDsBOsOCxrFA0ECcyBFEuYK53g6VD42zn
         O8J/2vwSN27eBWSIKENs3zn4QTRq8rO7yJ6yG/2B6C6dJ5wj8W5TJ9sjpvWMT6znTCAF
         uBoaCrTai0TL8cSDY6Ulg3LkVxVZeVlmMsX8cQfnukWGMAM5EPvRg+A/gkaBEDkz3NfS
         HTXW9FwxCne1phNKGqQ068gdNJoVy6/8AwN9U4d703/cPXrMefPP33OHmcsP4SId9Bnc
         jnS9E0D2y5rMF0A5ySf2gHqPWUOGd4EF27+pTblUQh21BhJZNFK8U3JvKj047xVRmEzv
         wcYw==
X-Gm-Message-State: AOAM5310E3e0Vt12gHkjcdHd11csTKIDktu2f4iCFexFOifwtJpVr42y
        AiDkHybIDLlN7sLWEowRIYM=
X-Google-Smtp-Source: ABdhPJz13ephTgXqUM+UA4TNO69iRYovunNJ91G6lEVq9z9+l6sFos6sysWM6KLFb8PBzO0QEnt7Cw==
X-Received: by 2002:a63:48c:: with SMTP id 134mr9440077pge.122.1627850001180;
        Sun, 01 Aug 2021 13:33:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:15b3:589:f07d:5386:a3c2:3056])
        by smtp.gmail.com with ESMTPSA id k10sm8897974pfc.169.2021.08.01.13.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:33:20 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH v2 6/6] USB: serial: kl5kusb105: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Mon,  2 Aug 2021 02:01:22 +0530
Message-Id: <20210801203122.3515-7-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210801203122.3515-1-himadrispandya@gmail.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrappers usb_control_msg_send/recv eliminate the need of allocating
dma buffers for usb message. They also impose proper error checks on the
return value of usb_control_msg() to handle short read/write. Hence use
the wrappers and remove dma allocations.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
Changes in v2:
 - Fix the caller of klsi_105_chg_port_settings()
 - Drop unnecessary use of the wrappers
---
 drivers/usb/serial/kl5kusb105.c | 79 ++++++++++++++-------------------
 1 file changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index f1e9628a9907..72d3920c9c48 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -124,16 +124,18 @@ static int klsi_105_chg_port_settings(struct usb_serial_port *port,
 {
 	int rc;
 
-	rc = usb_control_msg(port->serial->dev,
-			usb_sndctrlpipe(port->serial->dev, 0),
-			KL5KUSB105A_SIO_SET_DATA,
-			USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_INTERFACE,
-			0, /* value */
-			0, /* index */
-			settings,
-			sizeof(struct klsi_105_port_settings),
-			KLSI_TIMEOUT);
-	if (rc < 0)
+	rc = usb_control_msg_send(port->serial->dev,
+				  0,
+				  KL5KUSB105A_SIO_SET_DATA,
+				  USB_TYPE_VENDOR | USB_DIR_OUT |
+				  USB_RECIP_INTERFACE,
+				  0, /* value */
+				  0, /* index */
+				  settings,
+				  sizeof(struct klsi_105_port_settings),
+				  KLSI_TIMEOUT,
+				  GFP_KERNEL);
+	if (rc)
 		dev_err(&port->dev,
 			"Change port settings failed (error = %d)\n", rc);
 
@@ -167,28 +169,21 @@ static int klsi_105_get_line_state(struct usb_serial_port *port,
 				   unsigned long *line_state_p)
 {
 	int rc;
-	u8 *status_buf;
+	u8 status_buf[KLSI_STATUSBUF_LEN];
 	__u16 status;
 
-	status_buf = kmalloc(KLSI_STATUSBUF_LEN, GFP_KERNEL);
-	if (!status_buf)
-		return -ENOMEM;
-
 	status_buf[0] = 0xff;
 	status_buf[1] = 0xff;
-	rc = usb_control_msg(port->serial->dev,
-			     usb_rcvctrlpipe(port->serial->dev, 0),
-			     KL5KUSB105A_SIO_POLL,
-			     USB_TYPE_VENDOR | USB_DIR_IN,
-			     0, /* value */
-			     0, /* index */
-			     status_buf, KLSI_STATUSBUF_LEN,
-			     10000
-			     );
-	if (rc != KLSI_STATUSBUF_LEN) {
+	rc = usb_control_msg_recv(port->serial->dev, 0,
+				  KL5KUSB105A_SIO_POLL,
+				  USB_TYPE_VENDOR | USB_DIR_IN,
+				  0, /* value */
+				  0, /* index */
+				  status_buf, KLSI_STATUSBUF_LEN,
+				  10000,
+				  GFP_KERNEL);
+	if (rc) {
 		dev_err(&port->dev, "reading line status failed: %d\n", rc);
-		if (rc >= 0)
-			rc = -EIO;
 	} else {
 		status = get_unaligned_le16(status_buf);
 
@@ -198,7 +193,6 @@ static int klsi_105_get_line_state(struct usb_serial_port *port,
 		*line_state_p = klsi_105_status2linestate(status);
 	}
 
-	kfree(status_buf);
 	return rc;
 }
 
@@ -245,7 +239,7 @@ static int  klsi_105_open(struct tty_struct *tty, struct usb_serial_port *port)
 	int retval = 0;
 	int rc;
 	unsigned long line_state;
-	struct klsi_105_port_settings *cfg;
+	struct klsi_105_port_settings cfg;
 	unsigned long flags;
 
 	/* Do a defined restart:
@@ -255,27 +249,22 @@ static int  klsi_105_open(struct tty_struct *tty, struct usb_serial_port *port)
 	 * Then read the modem line control and store values in
 	 * priv->line_state.
 	 */
-	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
-	if (!cfg)
-		return -ENOMEM;
 
-	cfg->pktlen   = 5;
-	cfg->baudrate = kl5kusb105a_sio_b9600;
-	cfg->databits = kl5kusb105a_dtb_8;
-	cfg->unknown1 = 0;
-	cfg->unknown2 = 1;
-	klsi_105_chg_port_settings(port, cfg);
+	cfg.pktlen   = 5;
+	cfg.baudrate = kl5kusb105a_sio_b9600;
+	cfg.databits = kl5kusb105a_dtb_8;
+	cfg.unknown1 = 0;
+	cfg.unknown2 = 1;
+	klsi_105_chg_port_settings(port, &cfg);
 
 	spin_lock_irqsave(&priv->lock, flags);
-	priv->cfg.pktlen   = cfg->pktlen;
-	priv->cfg.baudrate = cfg->baudrate;
-	priv->cfg.databits = cfg->databits;
-	priv->cfg.unknown1 = cfg->unknown1;
-	priv->cfg.unknown2 = cfg->unknown2;
+	priv->cfg.pktlen   = cfg.pktlen;
+	priv->cfg.baudrate = cfg.baudrate;
+	priv->cfg.databits = cfg.databits;
+	priv->cfg.unknown1 = cfg.unknown1;
+	priv->cfg.unknown2 = cfg.unknown2;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	kfree(cfg);
-
 	/* READ_ON and urb submission */
 	rc = usb_serial_generic_open(tty, port);
 	if (rc)
-- 
2.17.1


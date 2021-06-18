Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0357E3AC0CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 04:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhFRCe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 22:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFRCe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 22:34:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 19:32:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so4895846pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 19:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C9hZzSo0VxYrrY/RL3/+l7RWf0FKv+uRsHHUcGsq+0I=;
        b=Xo7NuTx846Op9ojj/NMWYCX4nP/bAVRHM6cB8xVTg4g854Ds5zYDfS+82PMwWlZs+v
         tVFLWErXpER9qrUGc4lMW9JkIE4cOjq0g3MGeeVbPsF4knmZIwiKYHUVbPiXpC+nu2PI
         NyghVu7J96Lit6zDkTb1jPPlZ5sx20rxYp8cl0G2B1bBpV+RgQ4FWEk1lSR6pLNnPwpW
         nFjQJv3nh3aA+U07EGkA/Xjb6VH7rqKdiy5OLfCAzIA3eFiadscpGB+x3NCC0/W8QJ0K
         wvJVoeWI7FqPiYYCgzei8XHLlUBdFP5sqli2bTbSmYWUxOZBHEArO6KikkduXLPHaVsD
         QfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C9hZzSo0VxYrrY/RL3/+l7RWf0FKv+uRsHHUcGsq+0I=;
        b=o8w5wbPl5LBvkgS91+tWJXtoN34AnHRLRFEZuGGcgk++QbUwaW9bhJfzqGXBvryeII
         gWFvyI8yALuRvjhytLfKoH6PzjP9rZguAYCrNYY361kD9j5LcUVMsoGkKm956eWFkL1S
         xGkGQw9Hu5sR9HwNM8+NDI1W/wdtYY8b8CQNNJx61++cgIZGISTtgHxOy3CJIC1WqKIl
         BvN8k4deTUhpq3KBHc4cL921ZHaWedwc0KtrjkKyvdHSXYu3diXrveFnQmzzpp0rw43I
         UVGh1JxfXtkp6mcfo85zmAuF4V+M+SSGutOmZaW7kd1a5Zfwny4WzzlpuMfyhGq0H1Oy
         9T4Q==
X-Gm-Message-State: AOAM532J7LxCuGJ2IgBYzmP49O9Xo2hHFUwiMpV0cXLnKrurIlsh0hg4
        ueqQ+U8WMzpNbSED0R+BdKo=
X-Google-Smtp-Source: ABdhPJzeBi6jpwbR1ccxeJudnGPC/E6X6YkdDV+vCCcwJd1X/fCYl8ifVein76aAxsp7cFw/fA1V2A==
X-Received: by 2002:a17:90a:4491:: with SMTP id t17mr5403681pjg.30.1623983536733;
        Thu, 17 Jun 2021 19:32:16 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id nv1sm6121879pjb.43.2021.06.17.19.32.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jun 2021 19:32:16 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: n_gsm: add some instructions and code for slaver
Date:   Fri, 18 Jun 2021 10:31:04 +0800
Message-Id: <1623983464-19846-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

The gsm driver config to master or slaver by initiator,the config code
is different ,the doc has master instructions only,it should be add
instructions for responder.

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 Documentation/driver-api/serial/n_gsm.rst | 67 ++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-api/serial/n_gsm.rst b/Documentation/driver-api/serial/n_gsm.rst
index 87dfcd5..8cf08c4 100644
--- a/Documentation/driver-api/serial/n_gsm.rst
+++ b/Documentation/driver-api/serial/n_gsm.rst
@@ -12,13 +12,16 @@ modems connected to a physical serial port.
 
 How to use it
 -------------
-1. initialize the modem in 0710 mux mode (usually AT+CMUX= command) through
-   its serial port. Depending on the modem used, you can pass more or less
-   parameters to this command,
-2. switch the serial line to using the n_gsm line discipline by using
-   TIOCSETD ioctl,
-3. configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl,
-4. obtain base gsmtty number for the used serial port,
+1. config initiator
+^^^^^^^^^^^^^^^^^^^^^
+
+1.1 initialize the modem in 0710 mux mode (usually AT+CMUX= command) through
+    its serial port. Depending on the modem used, you can pass more or less
+    parameters to this command.
+1.2 switch the serial line to using the n_gsm line discipline by using
+    TIOCSETD ioctl.
+1.3 configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl.
+1.4 obtain base gsmtty number for the used serial port.
 
 Major parts of the initialization program :
 (a good starting point is util-linux-ng/sys-utils/ldattach.c)::
@@ -70,14 +73,14 @@ Major parts of the initialization program :
 	daemon(0,0);
 	pause();
 
-5. use these devices as plain serial ports.
+1.5 use these devices as plain serial ports.
 
    for example, it's possible:
 
    - and to use gnokii to send / receive SMS on ttygsm1
    - to use ppp to establish a datalink on ttygsm2
 
-6. first close all virtual ports before closing the physical port.
+1.6 first close all virtual ports before closing the physical port.
 
    Note that after closing the physical port the modem is still in multiplexing
    mode. This may prevent a successful re-opening of the port later. To avoid
@@ -87,6 +90,52 @@ Major parts of the initialization program :
 
       0xf9, 0x03, 0xef, 0x03, 0xc3, 0x16, 0xf9.
 
+2. config responter
+^^^^^^^^^^^^^^^^^^^^^
+
+2.1 switch the serial line to using the n_gsm line discipline by using
+    TIOCSETD ioctl.
+2.2 configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl.
+2.3 obtain base gsmtty number for the used serial port,
+
+  #include <stdio.h>
+  #include <stdint.h>
+  #include <linux/gsmmux.h>
+  #include <linux/tty.h>
+  #define DEFAULT_SPEED	B115200
+  #define SERIAL_PORT	/dev/ttyS0
+
+	int ldisc = N_GSM0710;
+	struct gsm_config c;
+	struct termios configuration;
+	uint32_t first;
+
+	/* open the serial port */
+	fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);
+
+	/* configure the serial port : speed, flow control ... */
+
+	/* use n_gsm line discipline */
+	ioctl(fd, TIOCSETD, &ldisc);
+
+	/* get n_gsm configuration */
+	ioctl(fd, GSMIOC_GETCONF, &c);
+	/* we are responter and need encoding 0 (basic) */
+	c.initiator = 0;
+	c.encapsulation = 0;
+	/* our modem defaults to a maximum size of 127 bytes */
+	c.mru = 127;
+	c.mtu = 127;
+	/* set the new configuration */
+	ioctl(fd, GSMIOC_SETCONF, &c);
+	/* get first gsmtty device node */
+	ioctl(fd, GSMIOC_GETFIRST, &first);
+	printf("first muxed line: /dev/gsmtty%i\n", first);
+
+	/* and wait for ever to keep the line discipline enabled */
+	daemon(0,0);
+	pause();
+
 Additional Documentation
 ------------------------
 More practical details on the protocol and how it's supported by industrial
-- 
1.9.1


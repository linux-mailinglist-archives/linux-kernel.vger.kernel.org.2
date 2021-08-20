Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B093F2BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbhHTMTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbhHTMTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:19:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE728C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t1so8978521pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4TF6dwsHEO54EutbZCRUeKRsrDNSjfQUcDbGAPwBh9c=;
        b=O47wPizb0Ete1NPtPJ2xBUhw37KmMl7CLzYQh+mvZ8Vc8ambrU7yGio+vy9QVk44zw
         YKwPVdn/BffgKehsIhA/Z37GHVVdeu7v8ioIaQnCOULLyqktM3s4iKayXOZQZUgWWVHj
         KCJ/X4d7H1qwX8hkbEXTOC/9sZkjSCWmhbIh+K+Q1+lbLzesi7UJxB4QiS+dU4OrL+Ak
         9fMhuel5Q/qw7VbMdY2mYVo7pTeJQKBUNQZsxNfJWMIPPL12GNPlIfbN6Pyacwtm5wtH
         mhVwqwbUVVQSecWf/IgMF3L2Wi4AhMTgUoz89b61cgSqxSWmN5GPXV6NXd4mdaDSSvEV
         MfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4TF6dwsHEO54EutbZCRUeKRsrDNSjfQUcDbGAPwBh9c=;
        b=kI7hpn3giwY16hKwCE13SD2nR0E+coscK6HB7tYPVj7ZVOgTpjiNdjeynK2Y5QSVRQ
         1udAOcqSuvOXwD2TTLKnLVpHX284bKLCcTWFNPMzw5////Q5axS7fyNrrdd34YP4dE4m
         DCL/3GVV8ZQXQB2Qzu/vikmkOxQqtj+7HuZyMNAEisUImTk+AliQTOpLvH5WUcciH5sA
         tqBU8f7hjmqTvMIhUkxgmsil3wlSBpAK65REa7ZBlagNJ/N9XxIENCRT5UpJtmmnmJWA
         xV6jd9yJlGx6CkugrCxJvwkESfgVVzbBPr42YIReQfOVetRGPNooaRGcukXlZe7J02ji
         QPdw==
X-Gm-Message-State: AOAM531ukSsomGkGPV4OI1DBpxEHyzmVo8bwMDZyA+StF2EuYS6w48xY
        Z3nyxY4tKBvim+GnlWy5fas=
X-Google-Smtp-Source: ABdhPJxzNnjCQyH7VjOUYWs5C923HXnDVd8O98Jqb728NJ0R/xWlsHO7b0ZI/xPVCUTauguhSZgzVA==
X-Received: by 2002:aa7:9115:0:b029:359:69db:bc89 with SMTP id 21-20020aa791150000b029035969dbbc89mr19465662pfh.32.1629461945319;
        Fri, 20 Aug 2021 05:19:05 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t18sm6629554pfg.111.2021.08.20.05.19.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:19:05 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] tty: n_gsm: Add some instructions and code for requester
Date:   Fri, 20 Aug 2021 20:17:45 +0800
Message-Id: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

The gsm driver can configure initiator or requester by parameter
initiator,but the config code and using are different ,the doc has
initiator instructions only,it should be add instructions for requester.

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 Documentation/driver-api/serial/n_gsm.rst | 71 +++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-api/serial/n_gsm.rst b/Documentation/driver-api/serial/n_gsm.rst
index 87dfcd5..8fe723a 100644
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
@@ -87,6 +90,56 @@ Major parts of the initialization program :
 
       0xf9, 0x03, 0xef, 0x03, 0xc3, 0x16, 0xf9.
 
+2. config requester
+^^^^^^^^^^^^^^^^^^^^^
+
+2.1 receive string "AT+CMUX= command" through its serial port,initialize
+    mux mode config
+2.2 switch the serial line to using the n_gsm line discipline by using
+    TIOCSETD ioctl.
+2.3 configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl.
+2.4 obtain base gsmtty number for the used serial port,
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
+	/* get serial data and check "AT+CMUX=command" parameter ... */
+
+	/* use n_gsm line discipline */
+	ioctl(fd, TIOCSETD, &ldisc);
+
+	/* get n_gsm configuration */
+	ioctl(fd, GSMIOC_GETCONF, &c);
+	/* we are requester and need encoding 0 (basic) */
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


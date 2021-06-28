Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EAB3B57C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 05:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhF1DXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 23:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1DXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 23:23:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5FFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 20:20:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id i6so12967453pfq.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 20:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2PsBlLK6dpoWzq9124m6mOoD5sAn+tth6CvCSsVuiRA=;
        b=uVnYBtv0SX17jMjMeFyFuei+Qxjq2QV5larfrDua+MEWOmG2vlNkvB6gOUoO7N+/99
         cdfab/T/5QNstNDU8ne5VyU5bDXaUQj8rCQJz8MCaGJBpNKnqPI8sC9z/zeJfaX7INis
         cpL3BBjOF/58MmJ44KiEi+PVN+3SpfMO1R2I/BDbeQ0XSlroKZi2xRYaERaBmPMCT2gT
         yScmjps3m0uL7cXiPIx/9MDBvqFiOsxkFRGhsV1Y2dfXTqIZPrQbJewq9TYdzXWXn/et
         M4c7Q0HagqOQGl46UOEFwP7vVVfYdgtjAunmMuvYgzO5/SGK+3ES4Q1o21E1UG+j7kO6
         9wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2PsBlLK6dpoWzq9124m6mOoD5sAn+tth6CvCSsVuiRA=;
        b=b+QN0kCo8fl2YNU0S5B17ZV/gJHfC3lj+AB0Q8aD5L5fCebDF9hlgq9OzXR3sCNhgz
         kNfXiZgTUJ+Fjtm3h3vnDiGXe9c/6OF7xHRNPMCIZMQjEBoStl3nFL/7ZtKzqDP55W+W
         m844Mlp4yFCiBnnkWdulo0N3f2b7qOObqpK7HXuUTIMPVLfBSt6bwuW9uTGu3LNT04UE
         r5CfwrhKyJz/D4d1JFoGBHgbGKZb+lb/xHjDmyvpv/E+FPgMKNxpcG7M6hK6CRMmkEXx
         IyXi8asHkknEZdJEs7tLoXWbv+F3YnWm8B0/gn8xYv3svz6/rtVOkVgpPmaFUFYcFX4V
         kBsw==
X-Gm-Message-State: AOAM530VLt67UXGUq4wNnwCHaBqireA0ghnihT1+EkcuyDNN2hLHbhsX
        zH1iVqs2PJLXl3cfgCDyzdU=
X-Google-Smtp-Source: ABdhPJwiILJ7SEIJhGhNQCWGQA7xr03gkfg2sAlCY+POAYJY6c5pzu71tr+UFOJtXJZWYXuXuqXZKw==
X-Received: by 2002:a65:4244:: with SMTP id d4mr21186385pgq.83.1624850435396;
        Sun, 27 Jun 2021 20:20:35 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j15sm12397830pfh.194.2021.06.27.20.20.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jun 2021 20:20:35 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: n_gsm: add some instructions and code for requester
Date:   Mon, 28 Jun 2021 11:20:30 +0800
Message-Id: <1624850430-28015-1-git-send-email-zhenguo6858@gmail.com>
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


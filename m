Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D163A3F7A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhHYQYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbhHYQYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:24:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB9DC061757;
        Wed, 25 Aug 2021 09:23:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u15so14606540plg.13;
        Wed, 25 Aug 2021 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PKWtw3U+UAUIlk82lhY86yQppmBBebN7/0wf9fkM/TM=;
        b=LcbJEgmfAcWBsIFGNxsT4YAFF/iY91iJ/cjmUVAft5d9auKBNuvawkczAJt3Wm/kxe
         Tbl8fI4YIw2rispLnKgQ5triWpaHynfv4dUtaTs9Qe0HHulLpPcxCv9g2z/41Gdn1+OW
         y2xzmMB7h1soJ/A9uQ/miCshHBVjdSJ4fQBFhdJSVEiP5LkeOLUw9arBmkaykX9ihEOD
         Qrm+wT4DZ2K87ZHMInJCX3buTh9pcR2aAiJBFzmfAh33o4kJ0tP9wBYdWgPgDvy0wKMH
         aQVBYKB88j0BfyVbqY1hXBsusWxBOUNKq13uoO9HaUJaNIIByEMoeZEOKBc+vb25T/3D
         Z2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PKWtw3U+UAUIlk82lhY86yQppmBBebN7/0wf9fkM/TM=;
        b=nE/Gu0QdLRfPINYCeai+ddbhUO5NPYraxzBMcZuTtyzkzMxeX1har2Tcg26ujWoz4+
         J7aObcO/WQjoL7RLix6qtAzAvIDVsS6WTR6JcTXvG6cHvjHxXOdZyFeCsY8916USaIMn
         kmaZzw7g11VREFPWPm4EZ4H95ukg46QDsJ8uUBJ++fjSA+Lxd6D/OkrXYqQ9Rg5FgBe2
         6tj4tprs3jiwiigufB2NYbdc6IeR728luzK3MfQceEyYtdy2DJMvvQ6iLCh6ElEMVegr
         su5fjeAs54sw1dbQMKAs6g+tbYpe4fvo9EYktB10oubiC6BvRlj/Ld0thlk+G3SGK46l
         VhBw==
X-Gm-Message-State: AOAM530AFvK4/6lDVPQOmH72UImUd6pfAGknTLjctaym+S/+0NjOFzjZ
        tYJPcAmkPePD0HP4/F7pQqc=
X-Google-Smtp-Source: ABdhPJz1Wfwuc9LqXitN++W5gC/AfmWmT/IX7qsiX5DUtd8mX67KCGiaHfM118JEqnKRl9hVDUOoYA==
X-Received: by 2002:a17:902:c406:b0:12d:d0ff:4be with SMTP id k6-20020a170902c40600b0012dd0ff04bemr38703069plk.24.1629908604185;
        Wed, 25 Aug 2021 09:23:24 -0700 (PDT)
Received: from localhost.localdomain ([49.36.209.183])
        by smtp.googlemail.com with ESMTPSA id t15sm489685pgk.13.2021.08.25.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:23:23 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH v2] USB: serial: Replace symbolic permissions by octal permissions
Date:   Wed, 25 Aug 2021 21:53:02 +0530
Message-Id: <20210825162302.16243-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YSYMXNvfjk0HdYr3@hovoldconsulting.com>
References: <YSYMXNvfjk0HdYr3@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace symbolic permission macros with octal permission numbers
because, octal permission numbers are easier to read and understand
instead of their symbolic macro names.

No functional change.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 drivers/usb/serial/cypress_m8.c  |  6 +++---
 drivers/usb/serial/ftdi_sio.c    |  2 +-
 drivers/usb/serial/garmin_gps.c  |  2 +-
 drivers/usb/serial/io_ti.c       |  4 ++--
 drivers/usb/serial/ipaq.c        |  4 ++--
 drivers/usb/serial/iuu_phoenix.c | 10 +++++-----
 drivers/usb/serial/sierra.c      |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 6b18990258c3..6924fa95f6bd 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -1199,9 +1199,9 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(stats, bool, S_IRUGO | S_IWUSR);
+module_param(stats, bool, 0644);
 MODULE_PARM_DESC(stats, "Enable statistics or not");
-module_param(interval, int, S_IRUGO | S_IWUSR);
+module_param(interval, int, 0644);
 MODULE_PARM_DESC(interval, "Overrides interrupt interval");
-module_param(unstable_bauds, bool, S_IRUGO | S_IWUSR);
+module_param(unstable_bauds, bool, 0644);
 MODULE_PARM_DESC(unstable_bauds, "Allow unstable baud rates");
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 33bbb3470ca3..99d19828dae6 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2938,5 +2938,5 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(ndi_latency_timer, int, S_IRUGO | S_IWUSR);
+module_param(ndi_latency_timer, int, 0644);
 MODULE_PARM_DESC(ndi_latency_timer, "NDI device latency timer override");
diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index 756d1ac7e96f..e5c75944ebb7 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -1444,5 +1444,5 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(initial_mode, int, S_IRUGO);
+module_param(initial_mode, int, 0444);
 MODULE_PARM_DESC(initial_mode, "Initial mode");
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index 84b848d2794e..a7b3c15957ba 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2746,9 +2746,9 @@ MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("edgeport/down3.bin");
 
-module_param(ignore_cpu_rev, bool, S_IRUGO | S_IWUSR);
+module_param(ignore_cpu_rev, bool, 0644);
 MODULE_PARM_DESC(ignore_cpu_rev,
 			"Ignore the cpu revision when connecting to a device");
 
-module_param(default_uart_mode, int, S_IRUGO | S_IWUSR);
+module_param(default_uart_mode, int, 0644);
 MODULE_PARM_DESC(default_uart_mode, "Default uart_mode, 0=RS232, ...");
diff --git a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
index f81746c3c26c..e11441bac44f 100644
--- a/drivers/usb/serial/ipaq.c
+++ b/drivers/usb/serial/ipaq.c
@@ -599,10 +599,10 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(connect_retries, int, S_IRUGO|S_IWUSR);
+module_param(connect_retries, int, 0644);
 MODULE_PARM_DESC(connect_retries,
 		"Maximum number of connect retries (one second each)");
 
-module_param(initial_wait, int, S_IRUGO|S_IWUSR);
+module_param(initial_wait, int, 0644);
 MODULE_PARM_DESC(initial_wait,
 		"Time to wait before attempting a connection (in seconds)");
diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index 19753611e7b0..0be3b5e1eaf3 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -1188,20 +1188,20 @@ MODULE_AUTHOR("Alain Degreffe eczema@ecze.com");
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(xmas, bool, S_IRUGO | S_IWUSR);
+module_param(xmas, bool, 0644);
 MODULE_PARM_DESC(xmas, "Xmas colors enabled or not");
 
-module_param(boost, int, S_IRUGO | S_IWUSR);
+module_param(boost, int, 0644);
 MODULE_PARM_DESC(boost, "Card overclock boost (in percent 100-500)");
 
-module_param(clockmode, int, S_IRUGO | S_IWUSR);
+module_param(clockmode, int, 0644);
 MODULE_PARM_DESC(clockmode, "Card clock mode (1=3.579 MHz, 2=3.680 MHz, "
 		"3=6 Mhz)");
 
-module_param(cdmode, int, S_IRUGO | S_IWUSR);
+module_param(cdmode, int, 0644);
 MODULE_PARM_DESC(cdmode, "Card detect mode (0=none, 1=CD, 2=!CD, 3=DSR, "
 		 "4=!DSR, 5=CTS, 6=!CTS, 7=RING, 8=!RING)");
 
-module_param(vcc_default, int, S_IRUGO | S_IWUSR);
+module_param(vcc_default, int, 0644);
 MODULE_PARM_DESC(vcc_default, "Set default VCC (either 3 for 3.3V or 5 "
 		"for 5V). Default to 5.");
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 4b49b7c33364..9d56138133a9 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -1056,5 +1056,5 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL v2");
 
-module_param(nmea, bool, S_IRUGO | S_IWUSR);
+module_param(nmea, bool, 0644);
 MODULE_PARM_DESC(nmea, "NMEA streaming");
-- 
2.17.1


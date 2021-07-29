Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC83DA9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhG2RKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhG2RJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:09:53 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE15C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:49 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so6628764oti.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IlFmYvL65EJ/K0zVzrAy+kcaagNB6BfLSJIY9lMTxMQ=;
        b=hXdFFJ64JtmyMm4DuJfIKi0cT+CIu3txpInHcWsVqbvaRg7KUiHw66Sb3uTLrveLx9
         DL3Ll41By9D1AOeMmQWKIlqqDXxEyefC6jxHxEkd1pHbxD6xl77h4BWedc+b71avu7IR
         y780XDjkOm5IbLZ6NvQaOsSxyRYSoVmZr3QfQt9x/WFvmk9g8fZQncNNxxrodZK4xxIc
         Lvjq9umw2pi5JGx2MJO/JltR7G5TYTt1RIx07GDtqkuUl7jFJd0/nz8ykHRwS9RXO6OF
         2gq35XtLqdknHx1s2hfyBqjXDmHulGxHhydde0YLIDheQwA1/6cuHK7MZxRcDPaqUhZN
         lJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IlFmYvL65EJ/K0zVzrAy+kcaagNB6BfLSJIY9lMTxMQ=;
        b=s1SLZ1V6bUZmzS2r4LTIjYsSMKWg1qnlPgBduuTw9o0Jm8e08WsE/dPEgqFuKMyJxx
         2uI5QQZcP49Ve7EhLa9plnYoF8PnQXSY5u67HeNVjIc5IIIsJTPHGvfWZTQU67iQUeY7
         HMK42NL+udO9DvYDDGCu2fVuyXwtPQ5vtYw29Gz56aI9bkP3g6XS+0K1rQ5PJ4iBjbXS
         VCqn01r6z/32auKHCAckeOfQF19f1iTIYi4K4PlKCb+lvBkArb2mTM/FwIEIjXf5yrF6
         QKfnxgF0l17hTuEdB1nnZsUlwMNTU7eff2Nu+EQRICfwibBmPRZdFdn2Z8NXIXPzUci6
         pN0Q==
X-Gm-Message-State: AOAM5337ZYI7KoQujDOTMHQa8YAyoQD093tDkxqPqreQiK0xyZ03iBQJ
        eWb/3U6o8oue5iC4MGxhnFA=
X-Google-Smtp-Source: ABdhPJzP7VtrOeRUWhdlbl1wJ1PY2NH/WRoWtPlGU5p4GikwKDK1IO0pHt2hbkXC6aV6m0PdqIpBzg==
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr4198025otf.52.1627578589186;
        Thu, 29 Jul 2021 10:09:49 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id a23sm614358otv.79.2021.07.29.10.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:09:48 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 5/6] staging: r8188eu: Remove header file include/rtw_version.h
Date:   Thu, 29 Jul 2021 12:09:29 -0500
Message-Id: <20210729170930.23171-6-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729170930.23171-1-Larry.Finger@lwfinger.net>
References: <20210729170930.23171-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file contains only the definition of the driver version. This statement
is moved into a header called by all the affected source files, and the now
empty header is deleted.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_debug.c      | 2 +-
 drivers/staging/r8188eu/include/drv_types.h   | 2 ++
 drivers/staging/r8188eu/include/rtw_version.h | 2 --
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 1 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 1 -
 6 files changed, 3 insertions(+), 6 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/rtw_version.h

diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
index 522fd59c2d50..a0ca61d8c3b8 100644
--- a/drivers/staging/r8188eu/core/rtw_debug.c
+++ b/drivers/staging/r8188eu/core/rtw_debug.c
@@ -4,7 +4,7 @@
 #define _RTW_DEBUG_C_
 
 #include <rtw_debug.h>
-#include <rtw_version.h>
+#include <drv_types.h>
 
 int proc_get_drv_version(char *page, char **start,
 			  off_t offset, int count,
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 0acc5847a602..d407d9274a78 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -38,6 +38,8 @@
 #include <rtw_mp.h>
 #include <rtw_br_ext.h>
 
+#define DRIVERVERSION	"v4.1.4_6773.20130222"
+
 enum _NIC_VERSION {
 	RTL8711_NIC,
 	RTL8712_NIC,
diff --git a/drivers/staging/r8188eu/include/rtw_version.h b/drivers/staging/r8188eu/include/rtw_version.h
deleted file mode 100644
index 4ca74a9465fe..000000000000
--- a/drivers/staging/r8188eu/include/rtw_version.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-#define DRIVERVERSION	"v4.1.4_6773.20130222"
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 37973930845d..109389549435 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -14,7 +14,6 @@
 #include <rtw_ioctl_set.h>
 #include <rtw_mp_ioctl.h>
 #include <usb_ops.h>
-#include <rtw_version.h>
 #include <rtl8188e_hal.h>
 
 #include <rtw_mp.h>
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 34af5237d9e6..cf92dc2a4fcc 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -9,7 +9,6 @@
 #include <recv_osdep.h>
 #include <hal_intf.h>
 #include <rtw_ioctl.h>
-#include <rtw_version.h>
 
 #include <usb_osintf.h>
 #include <rtw_br_ext.h>
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 905a08ebd80d..7db33946e418 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -8,7 +8,6 @@
 #include <recv_osdep.h>
 #include <xmit_osdep.h>
 #include <hal_intf.h>
-#include <rtw_version.h>
 #include <linux/usb.h>
 #include <osdep_intf.h>
 
-- 
2.32.0


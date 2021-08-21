Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F03F3B36
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 17:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhHUPxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 11:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhHUPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 11:53:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649BEC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 08:52:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f10so7703994wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JDjoRrO86i0x0pgh7O1gS7MImh2qtoWDpf+3Wu7hPlY=;
        b=JJeYDUTgItIzLNg9PuiizMppcQhRh/gbLbe+EaJS9DLLsSVvOVlbOmEXdOBoxA8y/K
         aJ+f7P+7aRiJqV/kRbN5wyU6KFsv2ZbNTMcG6ZJhhiDPK68HhS8iIP5vQNfSev3dnsEq
         hWNajYlmu4WGqF+Ae6d/36Z0Z0n44yp9IQQw24/5fqbtiyiDMr5+e46rRlm5DHNIhu24
         GQmIYolmtabssvwdZXNoSpVa/zy9qwhU8/o6160TRqlt4GZNimrgU5UGaI7RszH4KzPX
         ylAKG77A9Us8aaifrV4g32N0m46J9+qrdKOmlR0wGvlV/pElF4AePjA+n5+NVlKJssGr
         Dt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JDjoRrO86i0x0pgh7O1gS7MImh2qtoWDpf+3Wu7hPlY=;
        b=hvkDhzqGwA0/8/UDs3ZhAo1dr1FtidiB/4s1gXfZVvn2k3SNIXy0B+7B0HtQ30iWkX
         AQrE0DW3BNTsDe5mck8gEqWpk/MQ/zlepUNpUsfHr/6ONm2qNYyDmDx2pquJuw3Iw9XJ
         RC+gIwGlc7BB2DMuVUhaOOFj+DjtPRE6oM/65Emlq3+yfFFGIo2Uys2WEG5o42fqYWiG
         aTI5caVHC9S5J+H0YICeW9eDcF19Iuo0F6oX+d3HdOcdv6ygHAIULmx+CdN9iW3iwtY4
         kNJEw78evrF49ml6NeOAuH3KPWDBdTBWs4Y2cGS1CcUJoIIfnXesXMqn8Xv7noMdz2/h
         f44w==
X-Gm-Message-State: AOAM533PGpGVTya17oAtToBOh6Q1ExTYZ8etyzRa386OlNgkYi/R6ByU
        nYqUOmYCOgKKPsZmhjuE5z8=
X-Google-Smtp-Source: ABdhPJx8+or3o3DbhJZf1pgDRL7OYdmZ0Pw3RNoIwQqFU1HUv+O95gyChd9PpvJR7W64dW423RjTAQ==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr9159673wmj.61.1629561172059;
        Sat, 21 Aug 2021 08:52:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id k18sm1875032wmi.25.2021.08.21.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 08:52:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove cmd_osdep.h header file
Date:   Sat, 21 Aug 2021 17:51:51 +0200
Message-Id: <20210821155151.25822-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All functions declared in the cmd_osdep.h header file are only used in
a single c source file. Make the functions static and remove the header
file and its includes.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c      | 11 +++++------
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c  |  1 -
 drivers/staging/r8188eu/include/cmd_osdep.h | 16 ----------------
 3 files changed, 5 insertions(+), 23 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/cmd_osdep.h

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 955499eb608a..ce73ac7cf973 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -6,7 +6,6 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
-#include "../include/cmd_osdep.h"
 #include "../include/mlme_osdep.h"
 #include "../include/rtw_br_ext.h"
 #include "../include/rtw_mlme_ext.h"
@@ -16,7 +15,7 @@ Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
 No irqsave is necessary.
 */
 
-int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
+static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
 	int res = _SUCCESS;
 
@@ -59,7 +58,7 @@ int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 
 static void c2h_wk_callback(struct work_struct *work);
 
-int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
+static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
 {
 	int res = _SUCCESS;
 
@@ -87,7 +86,7 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 	}
 }
 
-void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
+static void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
 {
 	if (pcmdpriv) {
 		kfree(pcmdpriv->cmd_allocated_buf);
@@ -105,7 +104,7 @@ ISR/Call-Back functions can't call this sub-function.
 
 */
 
-int	_rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
+static int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
 {
 	unsigned long flags;
 
@@ -123,7 +122,7 @@ int	_rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
 	return _SUCCESS;
 }
 
-struct	cmd_obj	*_rtw_dequeue_cmd(struct __queue *queue)
+static struct cmd_obj *_rtw_dequeue_cmd(struct __queue *queue)
 {
 	struct cmd_obj *obj;
 	unsigned long flags;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 3e1a45030bc8..7d50d64cf34d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -6,7 +6,6 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
-#include "../include/cmd_osdep.h"
 #include "../include/mlme_osdep.h"
 #include "../include/rtw_ioctl_set.h"
 
diff --git a/drivers/staging/r8188eu/include/cmd_osdep.h b/drivers/staging/r8188eu/include/cmd_osdep.h
deleted file mode 100644
index 3954d6350cc6..000000000000
--- a/drivers/staging/r8188eu/include/cmd_osdep.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __CMD_OSDEP_H_
-#define __CMD_OSDEP_H_
-
-#include "osdep_service.h"
-#include "drv_types.h"
-
-extern int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv);
-extern int _rtw_init_evt_priv(struct evt_priv *pevtpriv);
-extern void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv);
-extern int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj);
-extern struct cmd_obj	*_rtw_dequeue_cmd(struct __queue *queue);
-
-#endif
-- 
2.32.0


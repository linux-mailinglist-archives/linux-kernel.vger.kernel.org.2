Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED023059C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbhA0LbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhA0L2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:28:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB706C061794
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a1so1512174wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tS3BpQ7TcxBqrK3CV55kl5AeIBZ9mcF/pZlX65f8Y00=;
        b=Nu8+n1/ZihhGiy1TfuXunJaZiL8mlLgwXtD+3HKuHzCxGA5KBXuDQx/azGs77uccfH
         ymALA7L46gPGCSXzr2scD5uHg/vMcJB/W0FV3XSwn+KE+LXkkhQVdMSrpyS/U51C9gBq
         +ENefxVJsmwGUNg8439/6SfDAMbXQbKdYUeYGialfDkO/93iApVl5adpNukr1BSHHnf0
         H5pvqFwEnx1LGGY47VMq1zC1gvxtHUG8vW1vRB3VF/04Mg1F8cFv1B2JP2b5/lDWKTm8
         u/xGaXj6tsV66oW3kNZ/v0nE3TVUef4Hp+V8kSGawP1PGLFaAAqrDzAPe2gEN+l8M8R5
         LqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tS3BpQ7TcxBqrK3CV55kl5AeIBZ9mcF/pZlX65f8Y00=;
        b=msVjPkMrx9VNRY+1qLwvt8Vvhlyjt9nWbwIpcQp4ZTCs++LQ6/IxT6XLTHzahpCrtZ
         /QvSmPgBB2Fv7qt8EdnGOldI/y53xhxXtzRxVZoyD5I6ZDiwrpmJxtuYRrjvcxR9mvwP
         pMLe+TPamujKvmLMkZYGeaucM3BeMBmn1wj2iTrcISiDZKBWt6T82HGjdJ1bxNfFSpbm
         DXm18kTBFXY1ek+SG5Ix7ggWlIOiSzL3CQUZap3eMd0Pl0Mlipd8ABfvk/9Q5wB/VYE5
         2gm55LJOElA2VK9zI/br0QLnLK4IYzJzRMTJfIuUmvotrtIjmyB9yWCJQkr2ZZucwYMS
         tpBw==
X-Gm-Message-State: AOAM530YxSfdowC0OPB4f1Os/sAChGPSs2ez/b7v+PGVFZfH8KEQGdoj
        n85r0t+vdJvebPh9AXMpd4sv/A==
X-Google-Smtp-Source: ABdhPJy6nMZ4WLsFP1oo29N2QsZtYnO46W7YC7oIsJ3Gtwq2ZObK+cQFj0glBklo0sMPKTLPLrAv6g==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr10663596wrq.76.1611746762542;
        Wed, 27 Jan 2021 03:26:02 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id m2sm2040065wml.34.2021.01.27.03.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:26:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 03/12] thunderbolt: ctl: Demote non-conformant kernel-doc headers
Date:   Wed, 27 Jan 2021 11:25:45 +0000
Message-Id: <20210127112554.3770172-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127112554.3770172-1-lee.jones@linaro.org>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/thunderbolt/ctl.c:38: warning: expecting prototype for struct tb_cfg. Prototype was for struct tb_ctl instead
 drivers/thunderbolt/ctl.c:350: warning: Function parameter or member 'ctl' not described in 'tb_ctl_tx'
 drivers/thunderbolt/ctl.c:350: warning: Function parameter or member 'data' not described in 'tb_ctl_tx'
 drivers/thunderbolt/ctl.c:350: warning: Function parameter or member 'len' not described in 'tb_ctl_tx'
 drivers/thunderbolt/ctl.c:350: warning: Function parameter or member 'type' not described in 'tb_ctl_tx'
 drivers/thunderbolt/ctl.c:350: warning: expecting prototype for tb_cfg_tx(). Prototype was for tb_ctl_tx() instead
 drivers/thunderbolt/ctl.c:383: warning: Function parameter or member 'ctl' not described in 'tb_ctl_handle_event'
 drivers/thunderbolt/ctl.c:383: warning: Function parameter or member 'type' not described in 'tb_ctl_handle_event'
 drivers/thunderbolt/ctl.c:383: warning: Function parameter or member 'pkg' not described in 'tb_ctl_handle_event'
 drivers/thunderbolt/ctl.c:383: warning: Function parameter or member 'size' not described in 'tb_ctl_handle_event'
 drivers/thunderbolt/ctl.c:611: warning: Function parameter or member 'nhi' not described in 'tb_ctl_alloc'
 drivers/thunderbolt/ctl.c:611: warning: Function parameter or member 'cb' not described in 'tb_ctl_alloc'
 drivers/thunderbolt/ctl.c:611: warning: Function parameter or member 'cb_data' not described in 'tb_ctl_alloc'
 drivers/thunderbolt/ctl.c:658: warning: Function parameter or member 'ctl' not described in 'tb_ctl_free'
 drivers/thunderbolt/ctl.c:682: warning: Function parameter or member 'ctl' not described in 'tb_ctl_start'
 drivers/thunderbolt/ctl.c:682: warning: expecting prototype for tb_cfg_start(). Prototype was for tb_ctl_start() instead
 drivers/thunderbolt/ctl.c:702: warning: Function parameter or member 'ctl' not described in 'tb_ctl_stop'
 drivers/thunderbolt/ctl.c:702: warning: expecting prototype for control(). Prototype was for tb_ctl_stop() instead
 drivers/thunderbolt/ctl.c:794: warning: Function parameter or member 'ctl' not described in 'tb_cfg_reset'
 drivers/thunderbolt/ctl.c:794: warning: Function parameter or member 'route' not described in 'tb_cfg_reset'
 drivers/thunderbolt/ctl.c:794: warning: Function parameter or member 'timeout_msec' not described in 'tb_cfg_reset'
 drivers/thunderbolt/ctl.c:830: warning: Function parameter or member 'ctl' not described in 'tb_cfg_read_raw'
 drivers/thunderbolt/ctl.c:830: warning: Function parameter or member 'buffer' not described in 'tb_cfg_read_raw'
 drivers/thunderbolt/ctl.c:830: warning: Function parameter or member 'route' not described in 'tb_cfg_read_raw'
 drivers/thunderbolt/ctl.c:830: warning: Function parameter or member 'port' not described in 'tb_cfg_read_raw'
 drivers/thunderbolt/ctl.c:830: warning: Function parameter or member 'space' not described in 'tb_cfg_read_raw'
 drivers/thunderbolt/ctl.c:830: warning: Function parameter or member 'offset' not described in 'tb_cfg_read_raw'
 drivers/thunderbolt/ctl.c:830: warning: Function parameter or member 'length' not described in 'tb_cfg_read_raw'
 drivers/thunderbolt/ctl.c:830: warning: Function parameter or member 'timeout_msec' not described in 'tb_cfg_read_raw'
 drivers/thunderbolt/ctl.c:830: warning: expecting prototype for tb_cfg_read(). Prototype was for tb_cfg_read_raw() instead
 drivers/thunderbolt/ctl.c:893: warning: Function parameter or member 'ctl' not described in 'tb_cfg_write_raw'
 drivers/thunderbolt/ctl.c:893: warning: Function parameter or member 'buffer' not described in 'tb_cfg_write_raw'
 drivers/thunderbolt/ctl.c:893: warning: Function parameter or member 'route' not described in 'tb_cfg_write_raw'
 drivers/thunderbolt/ctl.c:893: warning: Function parameter or member 'port' not described in 'tb_cfg_write_raw'
 drivers/thunderbolt/ctl.c:893: warning: Function parameter or member 'space' not described in 'tb_cfg_write_raw'
 drivers/thunderbolt/ctl.c:893: warning: Function parameter or member 'offset' not described in 'tb_cfg_write_raw'
 drivers/thunderbolt/ctl.c:893: warning: Function parameter or member 'length' not described in 'tb_cfg_write_raw'
 drivers/thunderbolt/ctl.c:893: warning: Function parameter or member 'timeout_msec' not described in 'tb_cfg_write_raw'
 drivers/thunderbolt/ctl.c:893: warning: expecting prototype for tb_cfg_write(). Prototype was for tb_cfg_write_raw() instead
 drivers/thunderbolt/ctl.c:1033: warning: Function parameter or member 'ctl' not described in 'tb_cfg_get_upstream_port'
 drivers/thunderbolt/ctl.c:1033: warning: Function parameter or member 'route' not described in 'tb_cfg_get_upstream_port'

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/thunderbolt/ctl.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index bac08b820015d..e5d7ff6807721 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -19,7 +19,7 @@
 #define TB_CTL_RX_PKG_COUNT	10
 #define TB_CTL_RETRIES		4
 
-/**
+/*
  * struct tb_cfg - thunderbolt control channel
  */
 struct tb_ctl {
@@ -338,7 +338,7 @@ static void tb_ctl_tx_callback(struct tb_ring *ring, struct ring_frame *frame,
 	tb_ctl_pkg_free(pkg);
 }
 
-/**
+/*
  * tb_cfg_tx() - transmit a packet on the control channel
  *
  * len must be a multiple of four.
@@ -375,7 +375,7 @@ static int tb_ctl_tx(struct tb_ctl *ctl, const void *data, size_t len,
 	return res;
 }
 
-/**
+/*
  * tb_ctl_handle_event() - acknowledge a plug event, invoke ctl->callback
  */
 static bool tb_ctl_handle_event(struct tb_ctl *ctl, enum tb_cfg_pkg_type type,
@@ -600,7 +600,7 @@ struct tb_cfg_result tb_cfg_request_sync(struct tb_ctl *ctl,
 
 /* public interface, alloc/start/stop/free */
 
-/**
+/*
  * tb_ctl_alloc() - allocate a control channel
  *
  * cb will be invoked once for every hot plug event.
@@ -647,7 +647,7 @@ struct tb_ctl *tb_ctl_alloc(struct tb_nhi *nhi, event_cb cb, void *cb_data)
 	return NULL;
 }
 
-/**
+/*
  * tb_ctl_free() - free a control channel
  *
  * Must be called after tb_ctl_stop.
@@ -675,7 +675,7 @@ void tb_ctl_free(struct tb_ctl *ctl)
 	kfree(ctl);
 }
 
-/**
+/*
  * tb_cfg_start() - start/resume the control channel
  */
 void tb_ctl_start(struct tb_ctl *ctl)
@@ -690,7 +690,7 @@ void tb_ctl_start(struct tb_ctl *ctl)
 	ctl->running = true;
 }
 
-/**
+/*
  * control() - pause the control channel
  *
  * All invocations of ctl->callback will have finished after this method
@@ -782,7 +782,7 @@ static bool tb_cfg_copy(struct tb_cfg_request *req, const struct ctl_pkg *pkg)
 	return true;
 }
 
-/**
+/*
  * tb_cfg_reset() - send a reset packet and wait for a response
  *
  * If the switch at route is incorrectly configured then we will not receive a
@@ -819,7 +819,7 @@ struct tb_cfg_result tb_cfg_reset(struct tb_ctl *ctl, u64 route,
 	return res;
 }
 
-/**
+/*
  * tb_cfg_read() - read from config space into buffer
  *
  * Offset and length are in dwords.
@@ -882,7 +882,7 @@ struct tb_cfg_result tb_cfg_read_raw(struct tb_ctl *ctl, void *buffer,
 	return res;
 }
 
-/**
+/*
  * tb_cfg_write() - write from buffer into config space
  *
  * Offset and length are in dwords.
@@ -1020,7 +1020,7 @@ int tb_cfg_write(struct tb_ctl *ctl, const void *buffer, u64 route, u32 port,
 	return res.err;
 }
 
-/**
+/*
  * tb_cfg_get_upstream_port() - get upstream port number of switch at route
  *
  * Reads the first dword from the switches TB_CFG_SWITCH config area and
-- 
2.25.1


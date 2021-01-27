Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC0C305A19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhA0Lme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbhA0La2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:30:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D2FC06121C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:11 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u14so1305427wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mwkTQ1nP1bLt6tR6lEnllegWqUs+MQYhQRklBiDlKoQ=;
        b=TECRuVSe4dnnPdOZ3qR5o+DV52hnLhGLAxQdA7gxPlQOxjeODPEdP7CQAZHat31ble
         wLQoPMy9pOhXcsz/6tW7pPJcKNhgLbTohtlvHttbI1k49AZeWJjjDOh7L8kG5ReuzLEi
         828/CAZHL6Lzyi/TChi7d3krhiR23NS8cUjvSXXeCm5f0cnpqmm+WZFQNkUfiqwbCRzl
         1abB6e9DEowFsRE9W6sVuPyJCU9t3ODjhnKbxw1EkJ7MGR7wZ/NfZvJIS4O3HEZSbiC/
         nWkbPp8U6agq6crMMXjtYH+QYnybAS+CXhs6eNbh33tcQpA4S3joP06IZzVINNJ8A4N4
         CHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mwkTQ1nP1bLt6tR6lEnllegWqUs+MQYhQRklBiDlKoQ=;
        b=c6QDn6WuSmCzmIr6KxPawavGLJ/WIi5r0OgGpMv2MLjElrolkxkkOrXwyK3u9SsU8e
         jXxihIHhGGkEdopUFbyjpYaUYUJ9GhTzuSnrEx2Po9IZJEUOEyVZezfHIMK/o2wJUmFg
         mtfGpIdEe2iEebmpR8HR8+0IN5mPOrQW4tR5YVGbcJP6iEyQTjgXYvyP6LuzxT8QpSbr
         /jnP5TdgMj+igJ+YXE6/RuP0o6Ka3L17ATID1wgZLJlbd5VIY1IzHbJbyWEnPhiJCQaB
         jyD3Mpkr6ER8rILHnV73ln5wm4X9+aM4JPMss5wXf0KfR7/e1POykQWnM8TXSTzRe8ao
         GnGw==
X-Gm-Message-State: AOAM531uyKqz/aRg+/h9lx+etsP/7sdZMZbZRAhWNGwAxE0HIVksPXBs
        2nOyxi71I9cuQ9D2uEbicTYMQg==
X-Google-Smtp-Source: ABdhPJzWCLrV0XonIhL5ykP68TTE3wBEGA002zEywUiOWL+7xnfhuyOYUsnFiVlQ2vc9hHLEHxf5BQ==
X-Received: by 2002:a1c:8002:: with SMTP id b2mr3944058wmd.94.1611746769810;
        Wed, 27 Jan 2021 03:26:09 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id m2sm2040065wml.34.2021.01.27.03.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:26:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 09/12] thunderbolt: swit: Demote a bunch of non-conformant kernel-doc headers
Date:   Wed, 27 Jan 2021 11:25:51 +0000
Message-Id: <20210127112554.3770172-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127112554.3770172-1-lee.jones@linaro.org>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/thunderbolt/switch.c:540: warning: Function parameter or member 'port' not described in 'tb_wait_for_port'
 drivers/thunderbolt/switch.c:540: warning: Function parameter or member 'wait_if_unplugged' not described in 'tb_wait_for_port'
 drivers/thunderbolt/switch.c:599: warning: Function parameter or member 'port' not described in 'tb_port_add_nfc_credits'
 drivers/thunderbolt/switch.c:599: warning: Function parameter or member 'credits' not described in 'tb_port_add_nfc_credits'
 drivers/thunderbolt/switch.c:653: warning: Function parameter or member 'port' not described in 'tb_port_clear_counter'
 drivers/thunderbolt/switch.c:653: warning: Function parameter or member 'counter' not described in 'tb_port_clear_counter'
 drivers/thunderbolt/switch.c:730: warning: Function parameter or member 'port' not described in 'tb_init_port'
 drivers/thunderbolt/switch.c:1348: warning: Function parameter or member 'sw' not described in 'tb_plug_events_active'
 drivers/thunderbolt/switch.c:1348: warning: Function parameter or member 'active' not described in 'tb_plug_events_active'
 drivers/thunderbolt/switch.c:2654: warning: Function parameter or member 'sw' not described in 'tb_sw_set_unplugged'

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/thunderbolt/switch.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index cdba05e72486b..ce1b120d1cd46 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -523,7 +523,7 @@ int tb_port_state(struct tb_port *port)
 	return phy.state;
 }
 
-/**
+/*
  * tb_wait_for_port() - wait for a port to become ready
  *
  * Wait up to 1 second for a port to reach state TB_PORT_UP. If
@@ -587,7 +587,7 @@ int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged)
 	return 0;
 }
 
-/**
+/*
  * tb_port_add_nfc_credits() - add/remove non flow controlled credits to port
  *
  * Change the number of NFC credits allocated to @port by @credits. To remove
@@ -644,7 +644,7 @@ int tb_port_set_initial_credits(struct tb_port *port, u32 credits)
 	return tb_port_write(port, &data, TB_CFG_PORT, ADP_CS_5, 1);
 }
 
-/**
+/*
  * tb_port_clear_counter() - clear a counter in TB_CFG_COUNTER
  *
  * Return: Returns 0 on success or an error code on failure.
@@ -718,7 +718,7 @@ int tb_port_disable(struct tb_port *port)
 	return __tb_port_enable(port, false);
 }
 
-/**
+/*
  * tb_init_port() - initialize a port
  *
  * This is a helper method for tb_switch_alloc. Does not check or initialize
@@ -1337,7 +1337,7 @@ int tb_switch_reset(struct tb_switch *sw)
 	return res.err;
 }
 
-/**
+/*
  * tb_plug_events_active() - enable/disable plug events on a switch
  *
  * Also configures a sane plug_events_delay of 255ms.
@@ -2647,7 +2647,7 @@ void tb_switch_remove(struct tb_switch *sw)
 	device_unregister(&sw->dev);
 }
 
-/**
+/*
  * tb_sw_set_unplugged() - set is_unplugged on switch and downstream switches
  */
 void tb_sw_set_unplugged(struct tb_switch *sw)
-- 
2.25.1


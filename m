Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D773059CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbhA0LcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbhA0L3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:29:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECA0C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so1531081wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3gNjVcguBm3iHiG+H/50H6Ct3jriN+3gNPTKUDiVErk=;
        b=Wtq2YxioRtkgawh7qJpG8HD2X/HY1bKKGFuf8Pcz48KrwrLGePpkmmlSS1eUL+FMlK
         +gsf93A5JGiHJtLYqiOirMxkpo2lmzv7MNnzmjozAC3NSaVENeoMMDAJ1AZ7e9TQf51u
         +vfIb4aPkruQShNg3SV8Fc6+tYkjmqP/c6DoDifN9uEyqAxTCjciJOO1TbBram3V8aFp
         0TprhXTdBq5PW6krbA0x77a8Eq2erIJ5JUXLTOv5zrII0OSya4x4VjIA6m5brHW8DnO9
         UvhlO7nkrGkmgV2NQPDq0nQeEMvP+KMzV4N5KQan4V1fo3uFwxdVLiRo+wLjzzDoQR0o
         /cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3gNjVcguBm3iHiG+H/50H6Ct3jriN+3gNPTKUDiVErk=;
        b=NKEPvIFvSUxV7nrMfDlY87Oo7Tkazz1hCFm4cZTge031ThYwEeZ30++3DKpTTqrrJY
         TawmsoZ8F79IQhWRNSxWReC3QFRo5gZ9WukWUvuvyPZO3FScFUd0J6sjGqoIAT/1Frn2
         3/oEiEDhN/N/B0e8OqqOfrzuJYv3av1kshGqOHWvf5rSiMx+mvfiFneuoQEYUekBVvmp
         808ceOWUq2hDX22nwp3pywQativ3ER2OPdQBRy1bN1LeDQSs9sNjtFjx7w5LaPDpVMgi
         Wpnot06weaLvhuyfZ+U8JC9ARg9meKcWhzq1xwH9jt1C1aVpXqc0DXY3DwmsW4GkDF7i
         JZFA==
X-Gm-Message-State: AOAM531JouCKDQ1MVKlKcWck5EAGzNSy/lyOwr0Wplxzpx/C40jDmAzq
        eOMvxipU6bc4wtAduFczV0dWlw==
X-Google-Smtp-Source: ABdhPJy4E+H0lQ3NmN4AOzPEglY0JTWYItaNl2G6bCZyk69savGjQ7hmVp0aic/hUbiYfbJaeMrzkw==
X-Received: by 2002:adf:c14d:: with SMTP id w13mr10453640wre.383.1611746763650;
        Wed, 27 Jan 2021 03:26:03 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id m2sm2040065wml.34.2021.01.27.03.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:26:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 04/12] thunderbolt: eeprom: Demote non-conformant kernel-doc headers to standard comment blocks
Date:   Wed, 27 Jan 2021 11:25:46 +0000
Message-Id: <20210127112554.3770172-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127112554.3770172-1-lee.jones@linaro.org>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/thunderbolt/eeprom.c:19: warning: Function parameter or member 'sw' not described in 'tb_eeprom_ctl_write'
 drivers/thunderbolt/eeprom.c:19: warning: Function parameter or member 'ctl' not described in 'tb_eeprom_ctl_write'
 drivers/thunderbolt/eeprom.c:27: warning: Function parameter or member 'sw' not described in 'tb_eeprom_ctl_read'
 drivers/thunderbolt/eeprom.c:27: warning: Function parameter or member 'ctl' not described in 'tb_eeprom_ctl_read'
 drivers/thunderbolt/eeprom.c:27: warning: expecting prototype for tb_eeprom_ctl_write(). Prototype was for tb_eeprom_ctl_read() instead
 drivers/thunderbolt/eeprom.c:43: warning: Function parameter or member 'sw' not described in 'tb_eeprom_active'
 drivers/thunderbolt/eeprom.c:43: warning: Function parameter or member 'enable' not described in 'tb_eeprom_active'
 drivers/thunderbolt/eeprom.c:73: warning: Function parameter or member 'sw' not described in 'tb_eeprom_transfer'
 drivers/thunderbolt/eeprom.c:73: warning: Function parameter or member 'ctl' not described in 'tb_eeprom_transfer'
 drivers/thunderbolt/eeprom.c:73: warning: Function parameter or member 'direction' not described in 'tb_eeprom_transfer'
 drivers/thunderbolt/eeprom.c:97: warning: Function parameter or member 'sw' not described in 'tb_eeprom_out'
 drivers/thunderbolt/eeprom.c:97: warning: Function parameter or member 'val' not described in 'tb_eeprom_out'
 drivers/thunderbolt/eeprom.c:117: warning: Function parameter or member 'sw' not described in 'tb_eeprom_in'
 drivers/thunderbolt/eeprom.c:117: warning: Function parameter or member 'val' not described in 'tb_eeprom_in'
 drivers/thunderbolt/eeprom.c:138: warning: Function parameter or member 'sw' not described in 'tb_eeprom_get_drom_offset'
 drivers/thunderbolt/eeprom.c:138: warning: Function parameter or member 'offset' not described in 'tb_eeprom_get_drom_offset'
 drivers/thunderbolt/eeprom.c:170: warning: Function parameter or member 'sw' not described in 'tb_eeprom_read_n'
 drivers/thunderbolt/eeprom.c:170: warning: Function parameter or member 'offset' not described in 'tb_eeprom_read_n'
 drivers/thunderbolt/eeprom.c:170: warning: Function parameter or member 'val' not described in 'tb_eeprom_read_n'
 drivers/thunderbolt/eeprom.c:170: warning: Function parameter or member 'count' not described in 'tb_eeprom_read_n'
 drivers/thunderbolt/eeprom.c:288: warning: Function parameter or member 'sw' not described in 'tb_drom_read_uid_only'
 drivers/thunderbolt/eeprom.c:288: warning: Function parameter or member 'uid' not described in 'tb_drom_read_uid_only'
 drivers/thunderbolt/eeprom.c:383: warning: Function parameter or member 'sw' not described in 'tb_drom_parse_entries'
 drivers/thunderbolt/eeprom.c:417: warning: Function parameter or member 'sw' not described in 'tb_drom_copy_efi'
 drivers/thunderbolt/eeprom.c:417: warning: Function parameter or member 'size' not described in 'tb_drom_copy_efi'
 drivers/thunderbolt/eeprom.c:526: warning: Function parameter or member 'sw' not described in 'tb_drom_read'

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/thunderbolt/eeprom.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 0c8471be3e32f..e8cb8399069c9 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -12,7 +12,7 @@
 #include <linux/slab.h>
 #include "tb.h"
 
-/**
+/*
  * tb_eeprom_ctl_write() - write control word
  */
 static int tb_eeprom_ctl_write(struct tb_switch *sw, struct tb_eeprom_ctl *ctl)
@@ -20,7 +20,7 @@ static int tb_eeprom_ctl_write(struct tb_switch *sw, struct tb_eeprom_ctl *ctl)
 	return tb_sw_write(sw, ctl, TB_CFG_SWITCH, sw->cap_plug_events + 4, 1);
 }
 
-/**
+/*
  * tb_eeprom_ctl_write() - read control word
  */
 static int tb_eeprom_ctl_read(struct tb_switch *sw, struct tb_eeprom_ctl *ctl)
@@ -33,7 +33,7 @@ enum tb_eeprom_transfer {
 	TB_EEPROM_OUT,
 };
 
-/**
+/*
  * tb_eeprom_active - enable rom access
  *
  * WARNING: Always disable access after usage. Otherwise the controller will
@@ -62,7 +62,7 @@ static int tb_eeprom_active(struct tb_switch *sw, bool enable)
 	}
 }
 
-/**
+/*
  * tb_eeprom_transfer - transfer one bit
  *
  * If TB_EEPROM_IN is passed, then the bit can be retrieved from ctl->data_in.
@@ -90,7 +90,7 @@ static int tb_eeprom_transfer(struct tb_switch *sw, struct tb_eeprom_ctl *ctl,
 	return tb_eeprom_ctl_write(sw, ctl);
 }
 
-/**
+/*
  * tb_eeprom_out - write one byte to the bus
  */
 static int tb_eeprom_out(struct tb_switch *sw, u8 val)
@@ -110,7 +110,7 @@ static int tb_eeprom_out(struct tb_switch *sw, u8 val)
 	return 0;
 }
 
-/**
+/*
  * tb_eeprom_in - read one byte from the bus
  */
 static int tb_eeprom_in(struct tb_switch *sw, u8 *val)
@@ -131,7 +131,7 @@ static int tb_eeprom_in(struct tb_switch *sw, u8 *val)
 	return 0;
 }
 
-/**
+/*
  * tb_eeprom_get_drom_offset - get drom offset within eeprom
  */
 static int tb_eeprom_get_drom_offset(struct tb_switch *sw, u16 *offset)
@@ -162,7 +162,7 @@ static int tb_eeprom_get_drom_offset(struct tb_switch *sw, u16 *offset)
 	return 0;
 }
 
-/**
+/*
  * tb_eeprom_read_n - read count bytes from offset into val
  */
 static int tb_eeprom_read_n(struct tb_switch *sw, u16 offset, u8 *val,
@@ -278,7 +278,7 @@ struct tb_drom_entry_port {
 } __packed;
 
 
-/**
+/*
  * tb_drom_read_uid_only - read uid directly from drom
  *
  * Does not use the cached copy in sw->drom. Used during resume to check switch
@@ -374,7 +374,7 @@ static int tb_drom_parse_entry_port(struct tb_switch *sw,
 	return 0;
 }
 
-/**
+/*
  * tb_drom_parse_entries - parse the linked list of drom entries
  *
  * Drom must have been copied to sw->drom.
@@ -410,7 +410,7 @@ static int tb_drom_parse_entries(struct tb_switch *sw)
 	return 0;
 }
 
-/**
+/*
  * tb_drom_copy_efi - copy drom supplied by EFI to sw->drom if present
  */
 static int tb_drom_copy_efi(struct tb_switch *sw, u16 *size)
@@ -519,7 +519,7 @@ static int tb_drom_read_n(struct tb_switch *sw, u16 offset, u8 *val,
 	return tb_eeprom_read_n(sw, offset, val, count);
 }
 
-/**
+/*
  * tb_drom_read - copy drom to sw->drom and parse it
  */
 int tb_drom_read(struct tb_switch *sw)
-- 
2.25.1


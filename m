Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FE938DB82
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhEWPDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 11:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhEWPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 11:02:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA3BC061574;
        Sun, 23 May 2021 08:01:33 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 27so16891767pgy.3;
        Sun, 23 May 2021 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nhqjrshLKf5vCSQxvzmXio+WBsrmrBlK+T8AYwqfU9o=;
        b=ctWlbxhqr4MlNnIVxzdQ9qiSFbPLPIqvo8BKPGj0px5TCS6h7oJG6sCxFeqGO5ZpjA
         cHGmF13fLhayCX3IJMCPhQFR0chF/xeVLfDH/GLtoWDAqTZ1zkNK7N1pFrx3VBeWhm1P
         j3iO+J5+JZX0DUGEf1PvFd05dsY0gORMHhkEEOTnnxt9bT5LMDpM8GX4/UVzmL+a27yL
         oiBRyVOtM2ziSSsxZX2WthQE8IHdupss6w/2/YNTpSKrWYAIGnLJl295NYmesVVZwC9x
         C+gvF3JMcPFe7VIqYZgAkgzGuZ5yuFXBXhVpjSBU/NFk3AGRWrsADFuYptz0TTkbzroH
         GG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nhqjrshLKf5vCSQxvzmXio+WBsrmrBlK+T8AYwqfU9o=;
        b=TZlTdCD5QtsZRr17ylxiREHbJ+U1DjLftfyKmyuqESGfo+YRgMe8exTyAeFczbs0Ju
         QqQKdEHV5hZuczHIBlce/FVIdMU6bDXYfwwpfO4SstGq9a4vQ7Z+oD94qMM55TeCqrep
         +uQ+pjC9ieMAnTRvd1IP6i1vYz0Lr61OGqCC42sOf5quoicoLQttZoNmHwvfF6hhXbx8
         VOEbd2IvehftCm/Y7h1I+7ty//Effg1dCcTDjcwjuKqFjJSKXyS1lzkIRjoLyDxjm0k7
         OBoTcOUDrznJxqKPsEZrPjESo/uNIpY6irYNu6fEcQLNL0d0GN3LciH82P+Qs+H/i2rB
         lNnQ==
X-Gm-Message-State: AOAM532Ld/EVEtdtf3lIxY3GG6Copb8x9NDwa7vsmqRKEqVykLVOKSDu
        odlRsY88RO+dHlpedmZFseQ=
X-Google-Smtp-Source: ABdhPJzFLk1BmzkDZUYS73KrtMj4NDq3qSf6VvGejItY1hyXrYRFk+r9lQkq+cGG8X7BZ3bhYj4tDw==
X-Received: by 2002:a63:338c:: with SMTP id z134mr9058975pgz.167.1621782092134;
        Sun, 23 May 2021 08:01:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:c492:941f:bc2a:cc89])
        by smtp.googlemail.com with ESMTPSA id l64sm9690973pgd.20.2021.05.23.08.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 08:01:31 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     zbr@ioremap.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] w1: ds2482: fix kernel-doc syntax in file
Date:   Sun, 23 May 2021 20:31:22 +0530
Message-Id: <20210523150122.21160-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The comments for drivers/w1/masters/ds2482.c follows this syntax, but
the content inside does not comply with kernel-doc.

Similarly, the syntax for function and arguments declaration as well.

Fix all such occurrences appropriately.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 drivers/w1/masters/ds2482.c | 94 ++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index b471779c3e2c..6c962e88501c 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * ds2482.c - provides i2c to w1-master bridge(s)
  * Copyright (C) 2005  Ben Gardner <bgardner@wabtec.com>
  *
@@ -19,7 +19,7 @@
 
 #include <linux/w1.h>
 
-/**
+/*
  * Allow the active pullup to be disabled, default is enabled.
  *
  * Note from the DS2482 datasheet:
@@ -39,7 +39,7 @@ static int extra_config;
 module_param(extra_config, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(extra_config, "Extra Configuration settings 1=APU,2=PPM,3=SPU,8=1WS");
 
-/**
+/*
  * The DS2482 registers - there are 3 registers that are addressed by a read
  * pointer. The read pointer is set by the last command executed.
  *
@@ -62,7 +62,7 @@ MODULE_PARM_DESC(extra_config, "Extra Configuration settings 1=APU,2=PPM,3=SPU,8
 #define DS2482_PTR_CODE_CHANNEL		0xD2	/* DS2482-800 only */
 #define DS2482_PTR_CODE_CONFIG		0xC3
 
-/**
+/*
  * Configure Register bit definitions
  * The top 4 bits always read 0.
  * To write, the top nibble must be the 1's compl. of the low nibble.
@@ -73,7 +73,7 @@ MODULE_PARM_DESC(extra_config, "Extra Configuration settings 1=APU,2=PPM,3=SPU,8
 #define DS2482_REG_CFG_APU		0x01	/* active pull-up */
 
 
-/**
+/*
  * Write and verify codes for the CHANNEL_SELECT command (DS2482-800 only).
  * To set the channel, write the value at the index of the channel.
  * Read and compare against the corresponding value to verify the change.
@@ -84,7 +84,7 @@ static const u8 ds2482_chan_rd[8] =
 	{ 0xB8, 0xB1, 0xAA, 0xA3, 0x9C, 0x95, 0x8E, 0x87 };
 
 
-/**
+/*
  * Status Register bit definitions (read only)
  */
 #define DS2482_REG_STS_DIR		0x80
@@ -124,9 +124,9 @@ struct ds2482_data {
 
 
 /**
- * Helper to calculate values for configuration register
- * @param conf the raw config value
- * @return the value w/ complements that can be written to register
+ * ds2482_calculate_config - Helper to calculate values for configuration register
+ * @conf: the raw config value
+ * Return: the value w/ complements that can be written to register
  */
 static inline u8 ds2482_calculate_config(u8 conf)
 {
@@ -140,10 +140,10 @@ static inline u8 ds2482_calculate_config(u8 conf)
 
 
 /**
- * Sets the read pointer.
- * @param pdev		The ds2482 client pointer
- * @param read_ptr	see DS2482_PTR_CODE_xxx above
- * @return -1 on failure, 0 on success
+ * ds2482_select_register - Sets the read pointer.
+ * @pdev:		The ds2482 client pointer
+ * @read_ptr:	see DS2482_PTR_CODE_xxx above
+ * Return: -1 on failure, 0 on success
  */
 static inline int ds2482_select_register(struct ds2482_data *pdev, u8 read_ptr)
 {
@@ -159,12 +159,12 @@ static inline int ds2482_select_register(struct ds2482_data *pdev, u8 read_ptr)
 }
 
 /**
- * Sends a command without a parameter
- * @param pdev	The ds2482 client pointer
- * @param cmd	DS2482_CMD_RESET,
+ * ds2482_send_cmd - Sends a command without a parameter
+ * @pdev:	The ds2482 client pointer
+ * @cmd:	DS2482_CMD_RESET,
  *		DS2482_CMD_1WIRE_RESET,
  *		DS2482_CMD_1WIRE_READ_BYTE
- * @return -1 on failure, 0 on success
+ * Return: -1 on failure, 0 on success
  */
 static inline int ds2482_send_cmd(struct ds2482_data *pdev, u8 cmd)
 {
@@ -176,14 +176,14 @@ static inline int ds2482_send_cmd(struct ds2482_data *pdev, u8 cmd)
 }
 
 /**
- * Sends a command with a parameter
- * @param pdev	The ds2482 client pointer
- * @param cmd	DS2482_CMD_WRITE_CONFIG,
+ * ds2482_send_cmd_data - Sends a command with a parameter
+ * @pdev:	The ds2482 client pointer
+ * @cmd:	DS2482_CMD_WRITE_CONFIG,
  *		DS2482_CMD_1WIRE_SINGLE_BIT,
  *		DS2482_CMD_1WIRE_WRITE_BYTE,
  *		DS2482_CMD_1WIRE_TRIPLET
- * @param byte	The data to send
- * @return -1 on failure, 0 on success
+ * @byte:	The data to send
+ * Return: -1 on failure, 0 on success
  */
 static inline int ds2482_send_cmd_data(struct ds2482_data *pdev,
 				       u8 cmd, u8 byte)
@@ -205,10 +205,10 @@ static inline int ds2482_send_cmd_data(struct ds2482_data *pdev,
 #define DS2482_WAIT_IDLE_TIMEOUT	100
 
 /**
- * Waits until the 1-wire interface is idle (not busy)
+ * ds2482_wait_1wire_idle - Waits until the 1-wire interface is idle (not busy)
  *
- * @param pdev Pointer to the device structure
- * @return the last value read from status or -1 (failure)
+ * @pdev: Pointer to the device structure
+ * Return: the last value read from status or -1 (failure)
  */
 static int ds2482_wait_1wire_idle(struct ds2482_data *pdev)
 {
@@ -230,12 +230,12 @@ static int ds2482_wait_1wire_idle(struct ds2482_data *pdev)
 }
 
 /**
- * Selects a w1 channel.
+ * ds2482_set_channel - Selects a w1 channel.
  * The 1-wire interface must be idle before calling this function.
  *
- * @param pdev		The ds2482 client pointer
- * @param channel	0-7
- * @return		-1 (failure) or 0 (success)
+ * @pdev:		The ds2482 client pointer
+ * @channel:		0-7
+ * Return:		-1 (failure) or 0 (success)
  */
 static int ds2482_set_channel(struct ds2482_data *pdev, u8 channel)
 {
@@ -254,11 +254,11 @@ static int ds2482_set_channel(struct ds2482_data *pdev, u8 channel)
 
 
 /**
- * Performs the touch-bit function, which writes a 0 or 1 and reads the level.
+ * ds2482_w1_touch_bit - Performs the touch-bit function, which writes a 0 or 1 and reads the level.
  *
- * @param data	The ds2482 channel pointer
- * @param bit	The level to write: 0 or non-zero
- * @return	The level read: 0 or 1
+ * @data:	The ds2482 channel pointer
+ * @bit:	The level to write: 0 or non-zero
+ * Return:	The level read: 0 or 1
  */
 static u8 ds2482_w1_touch_bit(void *data, u8 bit)
 {
@@ -284,13 +284,13 @@ static u8 ds2482_w1_touch_bit(void *data, u8 bit)
 }
 
 /**
- * Performs the triplet function, which reads two bits and writes a bit.
+ * ds2482_w1_triplet - Performs the triplet function, which reads two bits and writes a bit.
  * The bit written is determined by the two reads:
  *   00 => dbit, 01 => 0, 10 => 1
  *
- * @param data	The ds2482 channel pointer
- * @param dbit	The direction to choose if both branches are valid
- * @return	b0=read1 b1=read2 b3=bit written
+ * @data:	The ds2482 channel pointer
+ * @dbit:	The direction to choose if both branches are valid
+ * Return:	b0=read1 b1=read2 b3=bit written
  */
 static u8 ds2482_w1_triplet(void *data, u8 dbit)
 {
@@ -317,10 +317,10 @@ static u8 ds2482_w1_triplet(void *data, u8 dbit)
 }
 
 /**
- * Performs the write byte function.
+ * ds2482_w1_write_byte - Performs the write byte function.
  *
- * @param data	The ds2482 channel pointer
- * @param byte	The value to write
+ * @data:	The ds2482 channel pointer
+ * @byte:	The value to write
  */
 static void ds2482_w1_write_byte(void *data, u8 byte)
 {
@@ -341,10 +341,10 @@ static void ds2482_w1_write_byte(void *data, u8 byte)
 }
 
 /**
- * Performs the read byte function.
+ * ds2482_w1_read_byte - Performs the read byte function.
  *
- * @param data	The ds2482 channel pointer
- * @return	The value read
+ * @data:	The ds2482 channel pointer
+ * Return:	The value read
  */
 static u8 ds2482_w1_read_byte(void *data)
 {
@@ -378,10 +378,10 @@ static u8 ds2482_w1_read_byte(void *data)
 
 
 /**
- * Sends a reset on the 1-wire interface
+ * ds2482_w1_reset_bus - Sends a reset on the 1-wire interface
  *
- * @param data	The ds2482 channel pointer
- * @return	0=Device present, 1=No device present or error
+ * @data:	The ds2482 channel pointer
+ * Return:	0=Device present, 1=No device present or error
  */
 static u8 ds2482_w1_reset_bus(void *data)
 {
@@ -541,7 +541,7 @@ static int ds2482_remove(struct i2c_client *client)
 	return 0;
 }
 
-/**
+/*
  * Driver data (common to all clients)
  */
 static const struct i2c_device_id ds2482_id[] = {
-- 
2.17.1


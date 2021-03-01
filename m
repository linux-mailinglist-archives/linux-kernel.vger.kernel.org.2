Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49E8328046
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbhCAOHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:07:45 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52753 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236206AbhCAOGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:06:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UPzIpAQ_1614607517;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UPzIpAQ_1614607517)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Mar 2021 22:05:24 +0800
From:   Liguang Zhang <zhangliguang@linux.alibaba.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH] ipmi:ssif: make ssif_i2c_send() void
Date:   Mon,  1 Mar 2021 22:05:15 +0800
Message-Id: <20210301140515.18951-1-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function actually needs no return value. So remove the unneeded
check and make it void.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 81 +++++++++--------------------------
 1 file changed, 20 insertions(+), 61 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 0416b9c9d410..20d5af92966d 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -510,7 +510,7 @@ static int ipmi_ssif_thread(void *data)
 	return 0;
 }
 
-static int ssif_i2c_send(struct ssif_info *ssif_info,
+static void ssif_i2c_send(struct ssif_info *ssif_info,
 			ssif_i2c_done handler,
 			int read_write, int command,
 			unsigned char *data, unsigned int size)
@@ -522,7 +522,6 @@ static int ssif_i2c_send(struct ssif_info *ssif_info,
 	ssif_info->i2c_data = data;
 	ssif_info->i2c_size = size;
 	complete(&ssif_info->wake_thread);
-	return 0;
 }
 
 
@@ -531,22 +530,12 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 
 static void start_get(struct ssif_info *ssif_info)
 {
-	int rv;
-
 	ssif_info->rtc_us_timer = 0;
 	ssif_info->multi_pos = 0;
 
-	rv = ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
-			  SSIF_IPMI_RESPONSE,
-			  ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
-	if (rv < 0) {
-		/* request failed, just return the error. */
-		if (ssif_info->ssif_debug & SSIF_DEBUG_MSG)
-			dev_dbg(&ssif_info->client->dev,
-				"Error from i2c_non_blocking_op(5)\n");
-
-		msg_done_handler(ssif_info, -EIO, NULL, 0);
-	}
+	ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
+		  SSIF_IPMI_RESPONSE,
+		  ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
 }
 
 static void retry_timeout(struct timer_list *t)
@@ -620,7 +609,6 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 {
 	struct ipmi_smi_msg *msg;
 	unsigned long oflags, *flags;
-	int rv;
 
 	/*
 	 * We are single-threaded here, so no need for a lock until we
@@ -666,17 +654,10 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		ssif_info->multi_len = len;
 		ssif_info->multi_pos = 1;
 
-		rv = ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
-				  SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
-				  ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
-		if (rv < 0) {
-			if (ssif_info->ssif_debug & SSIF_DEBUG_MSG)
-				dev_dbg(&ssif_info->client->dev,
-					"Error from i2c_non_blocking_op(1)\n");
-
-			result = -EIO;
-		} else
-			return;
+		ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
+			 SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
+			 ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
+		return;
 	} else if (ssif_info->multi_pos) {
 		/* Middle of multi-part read.  Start the next transaction. */
 		int i;
@@ -738,19 +719,12 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 
 			ssif_info->multi_pos++;
 
-			rv = ssif_i2c_send(ssif_info, msg_done_handler,
-					   I2C_SMBUS_READ,
-					   SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
-					   ssif_info->recv,
-					   I2C_SMBUS_BLOCK_DATA);
-			if (rv < 0) {
-				if (ssif_info->ssif_debug & SSIF_DEBUG_MSG)
-					dev_dbg(&ssif_info->client->dev,
-						"Error from ssif_i2c_send\n");
-
-				result = -EIO;
-			} else
-				return;
+			ssif_i2c_send(ssif_info, msg_done_handler,
+				  I2C_SMBUS_READ,
+				  SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
+				  ssif_info->recv,
+				  I2C_SMBUS_BLOCK_DATA);
+			return;
 		}
 	}
 
@@ -908,8 +882,6 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 static void msg_written_handler(struct ssif_info *ssif_info, int result,
 				unsigned char *data, unsigned int len)
 {
-	int rv;
-
 	/* We are single-threaded here, so no need for a lock. */
 	if (result < 0) {
 		ssif_info->retries_left--;
@@ -972,18 +944,9 @@ static void msg_written_handler(struct ssif_info *ssif_info, int result,
 			ssif_info->multi_data = NULL;
 		}
 
-		rv = ssif_i2c_send(ssif_info, msg_written_handler,
-				   I2C_SMBUS_WRITE, cmd,
-				   data_to_send, I2C_SMBUS_BLOCK_DATA);
-		if (rv < 0) {
-			/* request failed, just return the error. */
-			ssif_inc_stat(ssif_info, send_errors);
-
-			if (ssif_info->ssif_debug & SSIF_DEBUG_MSG)
-				dev_dbg(&ssif_info->client->dev,
-					"Error from i2c_non_blocking_op(3)\n");
-			msg_done_handler(ssif_info, -EIO, NULL, 0);
-		}
+		ssif_i2c_send(ssif_info, msg_written_handler,
+			  I2C_SMBUS_WRITE, cmd,
+			  data_to_send, I2C_SMBUS_BLOCK_DATA);
 	} else {
 		/* Ready to request the result. */
 		unsigned long oflags, *flags;
@@ -1012,7 +975,6 @@ static void msg_written_handler(struct ssif_info *ssif_info, int result,
 
 static int start_resend(struct ssif_info *ssif_info)
 {
-	int rv;
 	int command;
 
 	ssif_info->got_alert = false;
@@ -1034,12 +996,9 @@ static int start_resend(struct ssif_info *ssif_info)
 		ssif_info->data[0] = ssif_info->data_len;
 	}
 
-	rv = ssif_i2c_send(ssif_info, msg_written_handler, I2C_SMBUS_WRITE,
-			  command, ssif_info->data, I2C_SMBUS_BLOCK_DATA);
-	if (rv && (ssif_info->ssif_debug & SSIF_DEBUG_MSG))
-		dev_dbg(&ssif_info->client->dev,
-			"Error from i2c_non_blocking_op(4)\n");
-	return rv;
+	ssif_i2c_send(ssif_info, msg_written_handler, I2C_SMBUS_WRITE,
+		   command, ssif_info->data, I2C_SMBUS_BLOCK_DATA);
+	return 0;
 }
 
 static int start_send(struct ssif_info *ssif_info,
-- 
2.19.1.6.gb485710b


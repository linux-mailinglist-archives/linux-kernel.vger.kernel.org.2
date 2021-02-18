Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E9231E833
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhBRJbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:31:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50510 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhBRITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:20 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613636298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSIsIPmVlAOVxLuOLTvnHU5nhDSI9EBpZMxs2i4jtII=;
        b=akB+LZGcn0e4uHaKSSgaworfvLdQDDPxWfkPbHjNR7wK7L409spQhFxDC/NVJU33sWm4AR
        gZMmYvvmpxQgrgSvjO0eTkK3pdj3dM8/wAybh4aEHvSiMBYB3ICgCgGJTZhoz2aJr70Uoy
        1WENYVNVe2CNs8zlhrup7HI2pUmZH3EXe1MXwl9Lj+E/bVD23IomIuDPDhBD+dN661hbUf
        czVCNndLzQOYufhV++yCsA7q3RuW+Ph3z4uV1nn321dk8n20hFeOhZgFBELg1gvI2zOTUi
        lRmRgcM5ZzeLxjFpsMyCrs0EKEG4iplxBvrm/+LWnRGhdUWIZZJzCqMx9DaJeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613636298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSIsIPmVlAOVxLuOLTvnHU5nhDSI9EBpZMxs2i4jtII=;
        b=vBgWHoCrX5rJjAmlJvpMa6dhVxGaYdI7z83jWBY/p7i3jF5uAU1NNE61+DN3+6FRrGRXAK
        AJ0k3Rl9NgfjLcDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 02/14] printk: kmsg_dump: remove unused fields
Date:   Thu, 18 Feb 2021 09:18:05 +0100
Message-Id: <20210218081817.28849-3-john.ogness@linutronix.de>
In-Reply-To: <20210218081817.28849-1-john.ogness@linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct kmsg_dumper still contains some fields that were used to
iterate the old ringbuffer. They are no longer used. Remove them
and update the struct documentation.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/kmsg_dump.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 3378bcbe585e..235c50982c2d 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -36,6 +36,9 @@ enum kmsg_dump_reason {
  * 		through the record iterator
  * @max_reason:	filter for highest reason number that should be dumped
  * @registered:	Flag that specifies if this is already registered
+ * @active:	Flag that specifies if this is currently dumping
+ * @cur_seq:	Points to the oldest message to dump (private)
+ * @next_seq:	Points after the newest message to dump (private)
  */
 struct kmsg_dumper {
 	struct list_head list;
@@ -45,8 +48,6 @@ struct kmsg_dumper {
 	bool registered;
 
 	/* private state of the kmsg iterator */
-	u32 cur_idx;
-	u32 next_idx;
 	u64 cur_seq;
 	u64 next_seq;
 };
-- 
2.20.1


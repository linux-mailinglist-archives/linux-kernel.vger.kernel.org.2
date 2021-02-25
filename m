Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62715325790
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhBYUZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhBYUZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:25:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED1DC061788
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:24:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOZMuUgkwAWprihzNIesBPOQH08R4L3VRbLmef0+nuU=;
        b=urv5MMOCyh99Hy+fj4+Szo+OYw5HxKo/Rw9IXsc3VaiKz4nrxMX4M4d7WoQ25H+nxB/bis
        VlBZt/h+gm9Mq7DRv7ewzgPq9XuxKOtW1ARpplnX7tKVyCPbQ6g8otTjgO+/+KsjmSNZfE
        7YgqV6NK3f/Qs+20BCuqhM/9wM2Tq72moff79k3xiExS/FXVJtTs9crC4S9TKv/gDTVCZh
        8yxQECyx2FezJWWNxnivrBsJqRcVHNl0JYh53BV5P0jl+VjpANq3wrYzHenjB4jzdMU+2B
        +WB5glzGdE6WF6GJkXB4Tr3oWGoT6sXOdH6vPoQWdBEUR0EBYT+P8VDcjqNX9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOZMuUgkwAWprihzNIesBPOQH08R4L3VRbLmef0+nuU=;
        b=vXbsFo5Xsv6JzAP4zKtB4dXBhC9za/FlarnnoLVjrFGZ2fsNGJq6O6+B9ruuMxNDmX4+5W
        ImwVT7+rTfvUfXAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH next v3 04/15] printk: kmsg_dump: remove unused fields
Date:   Thu, 25 Feb 2021 21:24:27 +0100
Message-Id: <20210225202438.28985-5-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-1-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct kmsg_dumper still contains some fields that were used to
iterate the old ringbuffer. They are no longer used. Remove them
and update the struct documentation.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/kmsg_dump.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 3378bcbe585e..ae38035f1dca 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -36,6 +36,9 @@ enum kmsg_dump_reason {
  * 		through the record iterator
  * @max_reason:	filter for highest reason number that should be dumped
  * @registered:	Flag that specifies if this is already registered
+ * @active:	Flag that specifies if this is currently dumping
+ * @cur_seq:	Points to the oldest message to dump
+ * @next_seq:	Points after the newest message to dump
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


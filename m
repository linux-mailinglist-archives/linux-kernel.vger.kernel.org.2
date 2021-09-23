Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9EC416470
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbhIWRax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242577AbhIWRaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:30:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFC5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:29:21 -0700 (PDT)
Date:   Thu, 23 Sep 2021 19:29:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632418159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Si/vz1d42NUZth7l/PUb8Mgx17FY4PbIXtYbGItefJo=;
        b=RgfFB21HybwgXpaVSKFI+iKhjH7Rk9VfJ4tDz6rTFIYKaBVSUsXpI+CXDEKrmrb5T0ozvj
        CXrs0kvLIomF+bArwmdD7neRhf10ZZ5IQkd31SdGoAaRIUWSbknmhuIijw65ZeOBKO0WtP
        jVAXhaPsPflYk7UVDHB+jxe+l+cpc9dxx2E8Lv5Z0i9NxXJAPACc1aMI0SirVPGESka4LB
        IdOovzGIJrtYJ9AVBNFziGW0HoeRL/jxTPs9co788YoOY7tr7y9c++8zkYD0Ci7QkfRigl
        Akf6V2Z81dtSNhYbfJLw6/bqNNIvuBIQUoisbI1d5p5J3LlWm5s0rKZgpDvSCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632418159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Si/vz1d42NUZth7l/PUb8Mgx17FY4PbIXtYbGItefJo=;
        b=IO5S33yV3iBB7UsNEUsvKDme5B7NwrSpNCKfXWxy0vDcmw1khIfIRbW833EV+HcK3z+IDz
        tBEXqPBxDhWWHRCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Stefani Seibold <stefani@seibold.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] samples/kfifo: Rename read_lock/write_lock
Message-ID: <20210923172918.o22iwgvn3w7ilh44@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables names read_lock and write_lock can clash with functions used for
read/writer locks.

Rename read_lock to read_access and write_lock to write_access to avoid a name
collision.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20210806152551.qio7c3ho6pexezup@linutronix.de
---

Repost.

 samples/kfifo/bytestream-example.c |   12 ++++++------
 samples/kfifo/inttype-example.c    |   12 ++++++------
 samples/kfifo/record-example.c     |   12 ++++++------
 3 files changed, 18 insertions(+), 18 deletions(-)
---
--- a/samples/kfifo/bytestream-example.c
+++ b/samples/kfifo/bytestream-example.c
@@ -22,10 +22,10 @@
 #define	PROC_FIFO	"bytestream-fifo"
 
 /* lock for procfs read access */
-static DEFINE_MUTEX(read_lock);
+static DEFINE_MUTEX(read_access);
 
 /* lock for procfs write access */
-static DEFINE_MUTEX(write_lock);
+static DEFINE_MUTEX(write_access);
 
 /*
  * define DYNAMIC in this example for a dynamically allocated fifo.
@@ -116,12 +116,12 @@ static ssize_t fifo_write(struct file *f
 	int ret;
 	unsigned int copied;
 
-	if (mutex_lock_interruptible(&write_lock))
+	if (mutex_lock_interruptible(&write_access))
 		return -ERESTARTSYS;
 
 	ret = kfifo_from_user(&test, buf, count, &copied);
 
-	mutex_unlock(&write_lock);
+	mutex_unlock(&write_access);
 	if (ret)
 		return ret;
 
@@ -134,12 +134,12 @@ static ssize_t fifo_read(struct file *fi
 	int ret;
 	unsigned int copied;
 
-	if (mutex_lock_interruptible(&read_lock))
+	if (mutex_lock_interruptible(&read_access))
 		return -ERESTARTSYS;
 
 	ret = kfifo_to_user(&test, buf, count, &copied);
 
-	mutex_unlock(&read_lock);
+	mutex_unlock(&read_access);
 	if (ret)
 		return ret;
 
--- a/samples/kfifo/inttype-example.c
+++ b/samples/kfifo/inttype-example.c
@@ -22,10 +22,10 @@
 #define	PROC_FIFO	"int-fifo"
 
 /* lock for procfs read access */
-static DEFINE_MUTEX(read_lock);
+static DEFINE_MUTEX(read_access);
 
 /* lock for procfs write access */
-static DEFINE_MUTEX(write_lock);
+static DEFINE_MUTEX(write_access);
 
 /*
  * define DYNAMIC in this example for a dynamically allocated fifo.
@@ -109,12 +109,12 @@ static ssize_t fifo_write(struct file *f
 	int ret;
 	unsigned int copied;
 
-	if (mutex_lock_interruptible(&write_lock))
+	if (mutex_lock_interruptible(&write_access))
 		return -ERESTARTSYS;
 
 	ret = kfifo_from_user(&test, buf, count, &copied);
 
-	mutex_unlock(&write_lock);
+	mutex_unlock(&write_access);
 	if (ret)
 		return ret;
 
@@ -127,12 +127,12 @@ static ssize_t fifo_read(struct file *fi
 	int ret;
 	unsigned int copied;
 
-	if (mutex_lock_interruptible(&read_lock))
+	if (mutex_lock_interruptible(&read_access))
 		return -ERESTARTSYS;
 
 	ret = kfifo_to_user(&test, buf, count, &copied);
 
-	mutex_unlock(&read_lock);
+	mutex_unlock(&read_access);
 	if (ret)
 		return ret;
 
--- a/samples/kfifo/record-example.c
+++ b/samples/kfifo/record-example.c
@@ -22,10 +22,10 @@
 #define	PROC_FIFO	"record-fifo"
 
 /* lock for procfs read access */
-static DEFINE_MUTEX(read_lock);
+static DEFINE_MUTEX(read_access);
 
 /* lock for procfs write access */
-static DEFINE_MUTEX(write_lock);
+static DEFINE_MUTEX(write_access);
 
 /*
  * define DYNAMIC in this example for a dynamically allocated fifo.
@@ -123,12 +123,12 @@ static ssize_t fifo_write(struct file *f
 	int ret;
 	unsigned int copied;
 
-	if (mutex_lock_interruptible(&write_lock))
+	if (mutex_lock_interruptible(&write_access))
 		return -ERESTARTSYS;
 
 	ret = kfifo_from_user(&test, buf, count, &copied);
 
-	mutex_unlock(&write_lock);
+	mutex_unlock(&write_access);
 	if (ret)
 		return ret;
 
@@ -141,12 +141,12 @@ static ssize_t fifo_read(struct file *fi
 	int ret;
 	unsigned int copied;
 
-	if (mutex_lock_interruptible(&read_lock))
+	if (mutex_lock_interruptible(&read_access))
 		return -ERESTARTSYS;
 
 	ret = kfifo_to_user(&test, buf, count, &copied);
 
-	mutex_unlock(&read_lock);
+	mutex_unlock(&read_access);
 	if (ret)
 		return ret;
 

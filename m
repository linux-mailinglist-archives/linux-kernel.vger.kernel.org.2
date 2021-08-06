Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216C03E2DB9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244257AbhHFP0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:26:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51092 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhHFP0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:26:09 -0400
Date:   Fri, 6 Aug 2021 17:25:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628263552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QVRFaRru1LQ4e/W8gfhVwkFnkfo4TW5sVv9nBOFPQtw=;
        b=aHz2nxx2C9h29TZ3OkZa+pzxMOv+GZqgAg1Gc6XTet0aQRyLMUbB/Cr4XMKJiNw05RZGAE
        W36Ro3Xeb1c1+DS41xe3suWlqpOKZdIf90RMRoDff79DSIu8/2DcxGADe6t67DepXQKD3V
        76zoIVbnXC6KvDoDWMSnLgl2FfJze6sRve6Ga0oeOkI+J4uNPHl9OtTP1hSNuVAx1jy9bY
        nA0pZycJp9Cj1pbQ0ezFLHbEz88RqiSgeMIntaCXd9+OIDJfOFE4S+4P1/YJ7f6IBdm9Th
        gQSQTuLWw7PYJZaaayKwiDqkeRM9621mkKvchCoadiUqjNi1YZ9cg/fjkYMAhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628263552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QVRFaRru1LQ4e/W8gfhVwkFnkfo4TW5sVv9nBOFPQtw=;
        b=KOnN9BsdAdinLBEaLzYbEPaNtpO7b+FR8DEoE1KLocN6s+pPkwPrwBJkCe9FiMao+TUQyM
        gD5W8BlQ/Noh2dDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Stefani Seibold <stefani@seibold.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] kfifo: Rename read_lock/write_lock
Message-ID: <20210806152551.qio7c3ho6pexezup@linutronix.de>
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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 samples/kfifo/bytestream-example.c | 12 ++++++------
 samples/kfifo/inttype-example.c    | 12 ++++++------
 samples/kfifo/record-example.c     | 12 ++++++------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/samples/kfifo/bytestream-example.c b/samples/kfifo/bytestream-example.c
index 5a90aa5278775..642d0748c1695 100644
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
@@ -116,12 +116,12 @@ static ssize_t fifo_write(struct file *file, const char __user *buf,
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
 
@@ -134,12 +134,12 @@ static ssize_t fifo_read(struct file *file, char __user *buf,
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
 
diff --git a/samples/kfifo/inttype-example.c b/samples/kfifo/inttype-example.c
index e5403d8c971a5..c61482ba94f4d 100644
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
@@ -109,12 +109,12 @@ static ssize_t fifo_write(struct file *file, const char __user *buf,
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
 
@@ -127,12 +127,12 @@ static ssize_t fifo_read(struct file *file, char __user *buf,
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
 
diff --git a/samples/kfifo/record-example.c b/samples/kfifo/record-example.c
index f64f3d62d6c2a..e4087b2d3fc4b 100644
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
@@ -123,12 +123,12 @@ static ssize_t fifo_write(struct file *file, const char __user *buf,
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
 
@@ -141,12 +141,12 @@ static ssize_t fifo_read(struct file *file, char __user *buf,
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
 
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A98422A47
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhJEOLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:11:49 -0400
Received: from www84.your-server.de ([213.133.104.84]:54676 "EHLO
        www84.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhJEOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:11:47 -0400
X-Greylist: delayed 1462 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2021 10:11:47 EDT
Received: from [88.134.96.152] (helo=skynet.local)
        by www84.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <bigeasy@linutronix.de>)
        id 1mXklC-0006nw-Cx; Tue, 05 Oct 2021 15:45:34 +0200
Message-ID: <115d9d8d97af87c4147f751a00f287f4bcbe16e1.camel@seibold.net>
Subject: [PATCH] kfifo: Rename read_lock/write_lock
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Stefani Seibold <stefani@seibold.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 05 Oct 2021 15:45:30 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: stefani@seibold.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26313/Tue Oct  5 11:04:18 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables names read_lock and write_lock can clash with functions
used for
read/writer locks.

Rename read_lock to read_access and write_lock to write_access to avoid
a name
collision.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked by Stefani Seibold <stefani@seibold.net>
---
 samples/kfifo/bytestream-example.c | 12 ++++++------
 samples/kfifo/inttype-example.c    | 12 ++++++------
 samples/kfifo/record-example.c     | 12 ++++++------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/samples/kfifo/bytestream-example.c
b/samples/kfifo/bytestream-example.c
index 5a90aa5278775..642d0748c1695 100644
--- a/samples/kfifo/bytestream-example.c
+++ b/samples/kfifo/bytestream-example.c
@@ -22,10 +22,10 @@
 #define        PROC_FIFO       "bytestream-fifo"
 
 /* lock for procfs read access */
-static DEFINE_MUTEX(read_lock);
+static DEFINE_MUTEX(read_access);
 
 /* lock for procfs write access */
-static DEFINE_MUTEX(write_lock);
+static DEFINE_MUTEX(write_access);
 
 /*
  * define DYNAMIC in this example for a dynamically allocated fifo.
@@ -116,12 +116,12 @@ static ssize_t fifo_write(struct file *file,
const char __user *buf,
        int ret;
        unsigned int copied;
 
-       if (mutex_lock_interruptible(&write_lock))
+       if (mutex_lock_interruptible(&write_access))
                return -ERESTARTSYS;
 
        ret = kfifo_from_user(&test, buf, count, &copied);
 
-       mutex_unlock(&write_lock);
+       mutex_unlock(&write_access);
        if (ret)
                return ret;
 
@@ -134,12 +134,12 @@ static ssize_t fifo_read(struct file *file, char
__user *buf,
        int ret;
        unsigned int copied;
 
-       if (mutex_lock_interruptible(&read_lock))
+       if (mutex_lock_interruptible(&read_access))
                return -ERESTARTSYS;
 
        ret = kfifo_to_user(&test, buf, count, &copied);
 
-       mutex_unlock(&read_lock);
+       mutex_unlock(&read_access);
        if (ret)
                return ret;
 
diff --git a/samples/kfifo/inttype-example.c b/samples/kfifo/inttype-
example.c
index e5403d8c971a5..c61482ba94f4d 100644
--- a/samples/kfifo/inttype-example.c
+++ b/samples/kfifo/inttype-example.c
@@ -22,10 +22,10 @@
 #define        PROC_FIFO       "int-fifo"
 
 /* lock for procfs read access */
-static DEFINE_MUTEX(read_lock);
+static DEFINE_MUTEX(read_access);
 
 /* lock for procfs write access */
-static DEFINE_MUTEX(write_lock);
+static DEFINE_MUTEX(write_access);
 
 /*
  * define DYNAMIC in this example for a dynamically allocated fifo.
@@ -109,12 +109,12 @@ static ssize_t fifo_write(struct file *file,
const char __user *buf,
        int ret;
        unsigned int copied;
 
-       if (mutex_lock_interruptible(&write_lock))
+       if (mutex_lock_interruptible(&write_access))
                return -ERESTARTSYS;
 
        ret = kfifo_from_user(&test, buf, count, &copied);
 
-       mutex_unlock(&write_lock);
+       mutex_unlock(&write_access);
        if (ret)
                return ret;
 
@@ -127,12 +127,12 @@ static ssize_t fifo_read(struct file *file, char
__user *buf,
        int ret;
        unsigned int copied;
 
-       if (mutex_lock_interruptible(&read_lock))
+       if (mutex_lock_interruptible(&read_access))
                return -ERESTARTSYS;
 
        ret = kfifo_to_user(&test, buf, count, &copied);
 
-       mutex_unlock(&read_lock);
+       mutex_unlock(&read_access);
        if (ret)
                return ret;
 
diff --git a/samples/kfifo/record-example.c b/samples/kfifo/record-
example.c
index f64f3d62d6c2a..e4087b2d3fc4b 100644
--- a/samples/kfifo/record-example.c
+++ b/samples/kfifo/record-example.c
@@ -22,10 +22,10 @@
 #define        PROC_FIFO       "record-fifo"
 
 /* lock for procfs read access */
-static DEFINE_MUTEX(read_lock);
+static DEFINE_MUTEX(read_access);
 
 /* lock for procfs write access */
-static DEFINE_MUTEX(write_lock);
+static DEFINE_MUTEX(write_access);
 
 /*
  * define DYNAMIC in this example for a dynamically allocated fifo.
@@ -123,12 +123,12 @@ static ssize_t fifo_write(struct file *file,
const char __user *buf,
        int ret;
        unsigned int copied;
 
-       if (mutex_lock_interruptible(&write_lock))
+       if (mutex_lock_interruptible(&write_access))
                return -ERESTARTSYS;
 
        ret = kfifo_from_user(&test, buf, count, &copied);
 
-       mutex_unlock(&write_lock);
+       mutex_unlock(&write_access);
        if (ret)
                return ret;
 
@@ -141,12 +141,12 @@ static ssize_t fifo_read(struct file *file, char
__user *buf,
        int ret;
        unsigned int copied;
 
-       if (mutex_lock_interruptible(&read_lock))
+       if (mutex_lock_interruptible(&read_access))
                return -ERESTARTSYS;
 
        ret = kfifo_to_user(&test, buf, count, &copied);
 
-       mutex_unlock(&read_lock);
+       mutex_unlock(&read_access);
        if (ret)
                return ret;
 



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6D1337272
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhCKMWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:22:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:39622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233322AbhCKMV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:21:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615465316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2aZ9LeK4qbmwMZ5nn6HkTvPIQZLxAljGxawO4hjaJ0=;
        b=cwinyoVBGHxz9659uGjORb3CAL5ktpA5YDq2f7tfoh6LpB5zCuN0S6+d8KKkQXF0EyO40R
        vKhzZnfIbCW8B2VAN7vrh3/zzLOa+9wblZB7rEcfvLa/HsQHqkZH3AgDk+o98R45EqKcPf
        TuHgYWfngca8ZkbxNrtLJB8It2YqdwA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26024AD73;
        Thu, 11 Mar 2021 12:21:56 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 7/7] Test softlockup
Date:   Thu, 11 Mar 2021 13:21:30 +0100
Message-Id: <20210311122130.6788-8-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311122130.6788-1-pmladek@suse.com>
References: <20210311122130.6788-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trigger busy loop by:
$> cat /proc/version

Stop the busy loop by:
$> cat /proc/consoles

The code also shows the first touch*watchdog() function that hides
softlockup on a "well known" location.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 fs/proc/consoles.c | 5 +++++
 fs/proc/version.c  | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index dfe6ce3505ce..213c0a209a7c 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -9,6 +9,8 @@
 #include <linux/seq_file.h>
 #include <linux/tty_driver.h>
 
+extern volatile bool proc_version_wait;
+
 /*
  * This is handler for /proc/consoles
  */
@@ -30,6 +32,9 @@ static int show_console_dev(struct seq_file *m, void *v)
 	unsigned int a;
 	dev_t dev = 0;
 
+	printk("%s: Going to break /proc/version infinite loop\n", __func__);
+	proc_version_wait = false;
+
 	if (con->device) {
 		const struct tty_driver *driver;
 		int index;
diff --git a/fs/proc/version.c b/fs/proc/version.c
index b449f186577f..15ec6a502589 100644
--- a/fs/proc/version.c
+++ b/fs/proc/version.c
@@ -6,8 +6,15 @@
 #include <linux/seq_file.h>
 #include <linux/utsname.h>
 
+volatile bool proc_version_wait;
+
 static int version_proc_show(struct seq_file *m, void *v)
 {
+	printk("%s: Going to wait until stopped\n", __func__);
+	proc_version_wait = true;
+	while (proc_version_wait)
+		cpu_relax();
+
 	seq_printf(m, linux_proc_banner,
 		utsname()->sysname,
 		utsname()->release,
-- 
2.26.2


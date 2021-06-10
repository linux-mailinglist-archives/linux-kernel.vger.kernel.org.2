Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ABA3A26A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFJIYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFJIX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:23:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35531C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:22:03 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lrFwb-0002qz-FO; Thu, 10 Jun 2021 10:21:41 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lrFwZ-0005Nd-Hw; Thu, 10 Jun 2021 10:21:39 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pstore/ftrace: add a kernel parameter to start pstore recording
Date:   Thu, 10 Jun 2021 10:21:34 +0200
Message-Id: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this knob you can enable pstore recording early enough to debug
hangs happening during the boot process before userspace is up enough to
enable it via sysfs.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 fs/pstore/ftrace.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 5939595f0115..92d35ee83c95 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -117,13 +117,26 @@ static const struct file_operations pstore_knob_fops = {
 
 static struct dentry *pstore_ftrace_dir;
 
+static unsigned int record_ftrace_init;
+module_param(record_ftrace_init, uint, 0400);
+
 void pstore_register_ftrace(void)
 {
+	int ret;
+
 	if (!psinfo->write)
 		return;
 
 	pstore_ftrace_dir = debugfs_create_dir("pstore", NULL);
 
+	if (record_ftrace_init) {
+		ret = register_ftrace_function(&pstore_ftrace_ops);
+		if (ret)
+			return;
+
+		pstore_ftrace_enabled = 1;
+	}
+
 	debugfs_create_file("record_ftrace", 0600, pstore_ftrace_dir, NULL,
 			    &pstore_knob_fops);
 }
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6581386DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344474AbhEQXhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbhEQXha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:37:30 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA1DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:36:13 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id b19-20020a05620a0893b02902e956b29f5dso5833448qka.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UsLi8/tp4hG7BhqZFDDLN66sU09bvDjXCRBpT3sJbPk=;
        b=BhWsf6N9OgUpmE6jLEyN6mJZ2OTV3ngDfmHVR9TUNuJnhnRR+J7x2+37xSi2duGj0V
         S8yT0GKIbb7w/+kZwfRXxQx9yuHbQOFVmH2y19OgzIYsMaNHRbKR49JoeKqyMVn/bpo3
         Bh8qf2ziRNOjykwTbJPfLQBjemR5sclGYTX6xe/7cGTeCFqcrGRujeDtHwxkE/lrq/Ja
         chw3TKuhPINVJ/pAp02CvWy50b/aOgblIbvJw+Dh1gOqOL1RlGzvwgLQJKz4sScKW4vq
         CflRE3WbbJJz1JQ0OPXoFfYD69BmXn7fx9GiDpeCAMxG+n0i5njk7CCWmPl3Z63Rr0+V
         cVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UsLi8/tp4hG7BhqZFDDLN66sU09bvDjXCRBpT3sJbPk=;
        b=IzMtQVnawqw0E2pn7pQfWY/So9Xd38E/HvjmiO4inb5bc5dmFtfkuIbTWRfGW91k8W
         kDUMsYYNGyKMrggXh51kh3Kmr4H9lLoGF/vq4bZoRltKKAzVtaYhBrgza2SCagBaTbCi
         pnEG7ppxO8oUhJxMIHNLOi7lhuaAGG74vkRR/Zd68dGyECmlHLZCZDE2V1PMpPiwf9MC
         G3sVw8rK7MuwH6YMJmt8Gwyy98xXAHNkhUlRuYrByqhHbWRbzgLiQSx8BMljCZ3en/y+
         rZgQISYKYIfBZ9AmvWeZBibHrhsF2rG7luEB12qLbyM9Mphe+GZ6ySfCqwQTQK3GEz56
         hu3g==
X-Gm-Message-State: AOAM532/y9Q7t8q2Q8GNLkSYVNzkTXe04Cc56C5H+S37EEHt32h36XMg
        d2v4w850W+ZGdDBgOmCZ1dYg6RKxPWY=
X-Google-Smtp-Source: ABdhPJxMA2f3bsKQ3RLm14ajdH11DmTpJLrnCoQdeBJiqNHLsHdMDVdMPplXn8FwzzGHtN4G9txBgO5psS8=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:b562:7011:fe35:1c9e])
 (user=badhri job=sendgmr) by 2002:a0c:f688:: with SMTP id p8mr2566256qvn.0.1621294572441;
 Mon, 17 May 2021 16:36:12 -0700 (PDT)
Date:   Mon, 17 May 2021 16:36:08 -0700
Message-Id: <20210517233609.610248-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v1 1/2] usb: typec: tcpm: Expose tcpm logs through a misc device
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although TCPM logs were primarily focussed to aid developers
during bringup, TCPM logs have proved to be critical even
post-bringup as it provides a good starting point to triage
interoperability issues with accessories. TCPM logs
are exposed through debugfs filesystem. For systems that
don't mount debugfs by default, this change introduces a
module parameter log_misc_dev which when set exports the
tcpm logs through a misc device. This change also leaves
the option of exporting tcpm logs through debugfs for
backwards compatibility.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 98 +++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c4fdc00a3bc8..b79194919b27 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -12,6 +12,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
+#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/power_supply.h>
@@ -33,6 +34,10 @@
 
 #include <uapi/linux/sched/types.h>
 
+static bool modparam_log_misc_dev;
+module_param_named(log_misc_dev, modparam_log_misc_dev, bool, 0444);
+MODULE_PARM_DESC(log_misc_dev, "Expose tcpm logs through misc device");
+
 #define FOREACH_STATE(S)			\
 	S(INVALID_STATE),			\
 	S(TOGGLING),			\
@@ -465,13 +470,15 @@ struct tcpm_port {
 	 * SNK_READY for non-pd link.
 	 */
 	bool slow_charger_loop;
-#ifdef CONFIG_DEBUG_FS
+
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
 	int logbuffer_head;
 	int logbuffer_tail;
 	u8 *logbuffer[LOG_BUFFER_ENTRIES];
-#endif
+
+	/* TCPM logs are exposed through misc device when modparam_log_misc_dev is set. */
+	struct miscdevice misc;
 };
 
 struct pd_rx_event {
@@ -565,8 +572,6 @@ static bool tcpm_port_is_disconnected(struct tcpm_port *port)
  * Logging
  */
 
-#ifdef CONFIG_DEBUG_FS
-
 static bool tcpm_log_full(struct tcpm_port *port)
 {
 	return port->logbuffer_tail ==
@@ -626,6 +631,9 @@ static void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
 {
 	va_list args;
 
+	if (!modparam_log_misc_dev && !IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
 	/* Do not log while disconnected and unattached */
 	if (tcpm_port_is_disconnected(port) &&
 	    (port->state == SRC_UNATTACHED || port->state == SNK_UNATTACHED ||
@@ -642,6 +650,9 @@ static void tcpm_log_force(struct tcpm_port *port, const char *fmt, ...)
 {
 	va_list args;
 
+	if (!modparam_log_misc_dev && !IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
 	va_start(args, fmt);
 	_tcpm_log(port, fmt, args);
 	va_end(args);
@@ -651,6 +662,9 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
 {
 	int i;
 
+	if (!modparam_log_misc_dev && !IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
 	for (i = 0; i < port->nr_source_caps; i++) {
 		u32 pdo = port->source_caps[i];
 		enum pd_pdo_type type = pdo_type(pdo);
@@ -708,7 +722,7 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
 	}
 }
 
-static int tcpm_debug_show(struct seq_file *s, void *v)
+static int tcpm_log_show(struct seq_file *s, void *v)
 {
 	struct tcpm_port *port = (struct tcpm_port *)s->private;
 	int tail;
@@ -725,23 +739,59 @@ static int tcpm_debug_show(struct seq_file *s, void *v)
 
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(tcpm_debug);
+DEFINE_SHOW_ATTRIBUTE(tcpm_log);
 
-static void tcpm_debugfs_init(struct tcpm_port *port)
+static int tcpm_log_dev_open(struct inode *inode, struct file *file)
+{
+	struct tcpm_port *port = container_of(file->private_data, struct tcpm_port, misc);
+
+	inode->i_private = port;
+	file->private_data = NULL;
+	return single_open(file, tcpm_log_show, inode->i_private);
+}
+
+static const struct file_operations tcpm_log_dev_operations = {
+	.owner = THIS_MODULE,
+	.open = tcpm_log_dev_open,
+	.read = seq_read,
+	.release = single_release,
+};
+
+static int tcpm_log_init(struct tcpm_port *port)
 {
 	char name[NAME_MAX];
+	int ret;
+
+	if (!modparam_log_misc_dev && !IS_ENABLED(CONFIG_DEBUG_FS))
+		return 0;
 
 	mutex_init(&port->logbuffer_lock);
 	snprintf(name, NAME_MAX, "tcpm-%s", dev_name(port->dev));
+	if (modparam_log_misc_dev) {
+		port->misc.minor = MISC_DYNAMIC_MINOR;
+		port->misc.name = name;
+		port->misc.fops = &tcpm_log_dev_operations;
+
+		ret = misc_register(&port->misc);
+		if (ret < 0)
+			dev_err(port->dev, "error while doing misc_register ret=%d\n", ret);
+		return ret;
+	}
+
 	port->dentry = debugfs_create_dir(name, usb_debug_root);
 	debugfs_create_file("log", S_IFREG | 0444, port->dentry, port,
-			    &tcpm_debug_fops);
+			    &tcpm_log_fops);
+
+	return 0;
 }
 
-static void tcpm_debugfs_exit(struct tcpm_port *port)
+static void tcpm_log_exit(struct tcpm_port *port)
 {
 	int i;
 
+	if (!modparam_log_misc_dev && !IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
 	mutex_lock(&port->logbuffer_lock);
 	for (i = 0; i < LOG_BUFFER_ENTRIES; i++) {
 		kfree(port->logbuffer[i]);
@@ -749,21 +799,14 @@ static void tcpm_debugfs_exit(struct tcpm_port *port)
 	}
 	mutex_unlock(&port->logbuffer_lock);
 
+	if (modparam_log_misc_dev) {
+		misc_deregister(&port->misc);
+		return;
+	}
+
 	debugfs_remove(port->dentry);
 }
 
-#else
-
-__printf(2, 3)
-static void tcpm_log(const struct tcpm_port *port, const char *fmt, ...) { }
-__printf(2, 3)
-static void tcpm_log_force(struct tcpm_port *port, const char *fmt, ...) { }
-static void tcpm_log_source_caps(struct tcpm_port *port) { }
-static void tcpm_debugfs_init(const struct tcpm_port *port) { }
-static void tcpm_debugfs_exit(const struct tcpm_port *port) { }
-
-#endif
-
 static void tcpm_set_cc(struct tcpm_port *port, enum typec_cc_status cc)
 {
 	tcpm_log(port, "cc:=%d", cc);
@@ -6135,11 +6178,13 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	init_completion(&port->tx_complete);
 	init_completion(&port->swap_complete);
 	init_completion(&port->pps_complete);
-	tcpm_debugfs_init(port);
+	err = tcpm_log_init(port);
+	if (err < 0)
+		goto out_destroy_wq;
 
 	err = tcpm_fw_get_caps(port, tcpc->fwnode);
 	if (err < 0)
-		goto out_destroy_wq;
+		goto out_unreg_log;
 
 	port->try_role = port->typec_caps.prefer_role;
 
@@ -6157,7 +6202,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->role_sw = usb_role_switch_get(port->dev);
 	if (IS_ERR(port->role_sw)) {
 		err = PTR_ERR(port->role_sw);
-		goto out_destroy_wq;
+		goto out_unreg_log;
 	}
 
 	err = devm_tcpm_psy_register(port);
@@ -6184,8 +6229,9 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 out_role_sw_put:
 	usb_role_switch_put(port->role_sw);
+out_unreg_log:
+	tcpm_log_exit(port);
 out_destroy_wq:
-	tcpm_debugfs_exit(port);
 	kthread_destroy_worker(port->wq);
 	return ERR_PTR(err);
 }
@@ -6200,7 +6246,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
 		typec_unregister_altmode(port->port_altmode[i]);
 	typec_unregister_port(port->typec_port);
 	usb_role_switch_put(port->role_sw);
-	tcpm_debugfs_exit(port);
+	tcpm_log_exit(port);
 	kthread_destroy_worker(port->wq);
 }
 EXPORT_SYMBOL_GPL(tcpm_unregister_port);
-- 
2.31.1.751.gd2f1c929bd-goog


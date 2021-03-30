Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4BB34F0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhC3SRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:17:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:15274 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232476AbhC3SQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:16:55 -0400
IronPort-SDR: pDQaL2BL/dy4khD71x7P06Hpv2NlI5lfJtCvqpTjMVbx4PykpHCpyJJRwXAhJY/HOGWmyR4ejd
 GZxvlAfEGfVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179369075"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179369075"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 11:16:54 -0700
IronPort-SDR: pwDGYOYuahn2sUGVqMIlCvj0OEDHfdvYVMKWL5L6Z+lf7miHg/o3K2y8GCDgvD4wZyW2w6ybF2
 lb89/PvApZXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="595565177"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2021 11:16:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4A5CA29D; Tue, 30 Mar 2021 21:17:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v1 05/10] ipmi_si: Introduce panic_event_str array
Date:   Tue, 30 Mar 2021 21:16:44 +0300
Message-Id: <20210330181649.66496-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of twice repeat the constant literals, introduce
panic_event_str array. It allows to simplify the code with
help of match_string() API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 49 ++++++++++-------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index f19f0f967e28..c7d37366d7bb 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -52,8 +52,12 @@ static bool drvregistered;
 enum ipmi_panic_event_op {
 	IPMI_SEND_PANIC_EVENT_NONE,
 	IPMI_SEND_PANIC_EVENT,
-	IPMI_SEND_PANIC_EVENT_STRING
+	IPMI_SEND_PANIC_EVENT_STRING,
+	IPMI_SEND_PANIC_EVENT_MAX
 };
+
+static const char *const panic_event_str[] = { "none", "event", "string", NULL };
+
 #ifdef CONFIG_IPMI_PANIC_STRING
 #define IPMI_PANIC_DEFAULT IPMI_SEND_PANIC_EVENT_STRING
 #elif defined(CONFIG_IPMI_PANIC_EVENT)
@@ -68,46 +72,27 @@ static int panic_op_write_handler(const char *val,
 				  const struct kernel_param *kp)
 {
 	char valcp[16];
-	char *s;
-
-	strncpy(valcp, val, 15);
-	valcp[15] = '\0';
+	int e;
 
-	s = strstrip(valcp);
-
-	if (strcmp(s, "none") == 0)
-		ipmi_send_panic_event = IPMI_SEND_PANIC_EVENT_NONE;
-	else if (strcmp(s, "event") == 0)
-		ipmi_send_panic_event = IPMI_SEND_PANIC_EVENT;
-	else if (strcmp(s, "string") == 0)
-		ipmi_send_panic_event = IPMI_SEND_PANIC_EVENT_STRING;
-	else
-		return -EINVAL;
+	strscpy(valcp, val, sizeof(valcp));
+	e = match_string(panic_event_str, -1, strstrip(valcp));
+	if (e < 0)
+		return e;
 
+	ipmi_send_panic_event = e;
 	return 0;
 }
 
 static int panic_op_read_handler(char *buffer, const struct kernel_param *kp)
 {
-	switch (ipmi_send_panic_event) {
-	case IPMI_SEND_PANIC_EVENT_NONE:
-		strcpy(buffer, "none\n");
-		break;
-
-	case IPMI_SEND_PANIC_EVENT:
-		strcpy(buffer, "event\n");
-		break;
-
-	case IPMI_SEND_PANIC_EVENT_STRING:
-		strcpy(buffer, "string\n");
-		break;
+	const char *event_str;
 
-	default:
-		strcpy(buffer, "???\n");
-		break;
-	}
+	if (ipmi_send_panic_event >= IPMI_SEND_PANIC_EVENT_MAX)
+		event_str = "???";
+	else
+		event_str = panic_event_str[ipmi_send_panic_event];
 
-	return strlen(buffer);
+	return sprintf(buffer, "%s\n", event_str);
 }
 
 static const struct kernel_param_ops panic_op_ops = {
-- 
2.30.2


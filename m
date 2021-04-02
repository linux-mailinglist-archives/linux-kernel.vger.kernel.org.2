Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46867352EA9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhDBRnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:43:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:17914 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235924AbhDBRnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:43:31 -0400
IronPort-SDR: BEPcNImKzg3PBDHsnCnQKa/5yIEpHr7waFbxnsq1K64+kV2dbm26tSxc8USBcYRSPBMaILY/qC
 fYTHBRwkwVOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="277702230"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="277702230"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:43:28 -0700
IronPort-SDR: tv8AY9uTXMxK8XE7mA2FLUF0hq0LJ+IwRYc80XnBLf8dBROOEOI2HOmQ/TFxGfNxTkfcalVksj
 4TC7mYLT4u/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="417142823"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 02 Apr 2021 10:43:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A7697450; Fri,  2 Apr 2021 20:43:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 05/10] ipmi_si: Introduce ipmi_panic_event_str[] array
Date:   Fri,  2 Apr 2021 20:43:29 +0300
Message-Id: <20210402174334.13466-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
References: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of repeating twice the constant literals, introduce
ipmi_panic_event_str[] array. It allows to simplify the code
with help of match_string() API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 51 +++++++++++------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index f19f0f967e28..367616a408b6 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -49,11 +49,17 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
 static bool initialized;
 static bool drvregistered;
 
+/* Numbers in this enumerator should be mapped to ipmi_panic_event_str */
 enum ipmi_panic_event_op {
 	IPMI_SEND_PANIC_EVENT_NONE,
 	IPMI_SEND_PANIC_EVENT,
-	IPMI_SEND_PANIC_EVENT_STRING
+	IPMI_SEND_PANIC_EVENT_STRING,
+	IPMI_SEND_PANIC_EVENT_MAX
 };
+
+/* Indices in this array should be mapped to enum ipmi_panic_event_op */
+static const char *const ipmi_panic_event_str[] = { "none", "event", "string", NULL };
+
 #ifdef CONFIG_IPMI_PANIC_STRING
 #define IPMI_PANIC_DEFAULT IPMI_SEND_PANIC_EVENT_STRING
 #elif defined(CONFIG_IPMI_PANIC_EVENT)
@@ -68,46 +74,27 @@ static int panic_op_write_handler(const char *val,
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
+	e = match_string(ipmi_panic_event_str, -1, strstrip(valcp));
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
+		event_str = ipmi_panic_event_str[ipmi_send_panic_event];
 
-	return strlen(buffer);
+	return sprintf(buffer, "%s\n", event_str);
 }
 
 static const struct kernel_param_ops panic_op_ops = {
-- 
2.30.2


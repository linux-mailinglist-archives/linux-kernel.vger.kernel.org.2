Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93563352EAA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhDBRnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:43:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:26096 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235166AbhDBRnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:43:32 -0400
IronPort-SDR: 10/LdvaKx0qTFA6YS76S53/Qxi8XbaWKW7rNDHdqqymO+G7HcFRZ5uTCa1vpLtj3wQ5u9ckubb
 jtKKAFWBPQ0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="172543164"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="172543164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:43:28 -0700
IronPort-SDR: rrtGNnNEFXtyqRVPHSXwHdVcfr1+xESwVdsc0unV7lIAKnbVuFZWux3e+l7jv209uojoVyqzr8
 6cuZBCzyQFag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="413277896"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Apr 2021 10:43:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C6F3360D; Fri,  2 Apr 2021 20:43:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 08/10] ipmi_si: Use strstrip() to remove surrounding spaces
Date:   Fri,  2 Apr 2021 20:43:32 +0300
Message-Id: <20210402174334.13466-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
References: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of home grown analogue, use strstrip() from the kernel library.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_si_hotmod.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_hotmod.c b/drivers/char/ipmi/ipmi_si_hotmod.c
index 4fbb4e18bae2..087f5eb1ebc0 100644
--- a/drivers/char/ipmi/ipmi_si_hotmod.c
+++ b/drivers/char/ipmi/ipmi_si_hotmod.c
@@ -185,24 +185,16 @@ static atomic_t hotmod_nr;
 
 static int hotmod_handler(const char *val, const struct kernel_param *kp)
 {
-	char *str = kstrdup(val, GFP_KERNEL), *curr, *next;
 	int  rv;
 	struct ipmi_plat_data h;
-	unsigned int len;
-	int ival;
+	char *str, *curr, *next;
 
+	str = kstrdup(val, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
 
 	/* Kill any trailing spaces, as we can get a "\n" from echo. */
-	len = strlen(str);
-	ival = len - 1;
-	while ((ival >= 0) && isspace(str[ival])) {
-		str[ival] = '\0';
-		ival--;
-	}
-
-	for (curr = str; curr; curr = next) {
+	for (curr = strstrip(str); curr; curr = next) {
 		enum hotmod_op op;
 
 		next = strchr(curr, ':');
@@ -235,7 +227,7 @@ static int hotmod_handler(const char *val, const struct kernel_param *kp)
 				put_device(dev);
 		}
 	}
-	rv = len;
+	rv = strlen(val);
 out:
 	kfree(str);
 	return rv;
-- 
2.30.2


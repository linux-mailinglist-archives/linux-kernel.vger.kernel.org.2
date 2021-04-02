Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFABD352EAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbhDBRnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:43:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:53440 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235720AbhDBRnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:43:31 -0400
IronPort-SDR: Pz6htKMZNw4OWJamHxVX4fyXfdrlbeKj2YduGT3lQCzwRnXK/fmI66DAAZPWAX+ucEMiK9y6dd
 3BCyS9Bx/BcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="180037573"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="180037573"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:43:28 -0700
IronPort-SDR: GPRwCoM4mGEYiCnGasQYzfOtjol4yoZQD7WWB/rC4BaXyzuK+sMagSnLTuuVrNWBswxp9MvQpz
 Ql6UREv+Gl6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="419749787"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 02 Apr 2021 10:43:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AE918368; Fri,  2 Apr 2021 20:43:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 06/10] ipmi_si: Reuse si_to_str[] array in ipmi_hardcode_init_one()
Date:   Fri,  2 Apr 2021 20:43:30 +0300
Message-Id: <20210402174334.13466-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
References: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of making the comparison one by one, reuse si_to_str[] array
in ipmi_hardcode_init_one() in conjunction with match_string() API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_si.h          |  6 +++++-
 drivers/char/ipmi/ipmi_si_hardcode.c | 23 +++++++++--------------
 drivers/char/ipmi/ipmi_si_intf.c     |  3 ++-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si.h b/drivers/char/ipmi/ipmi_si.h
index bac0ff86e48e..9492c53eba86 100644
--- a/drivers/char/ipmi/ipmi_si.h
+++ b/drivers/char/ipmi/ipmi_si.h
@@ -18,10 +18,14 @@
 #define DEFAULT_REGSPACING	1
 #define DEFAULT_REGSIZE		1
 
+/* Numbers in this enumerator should be mapped to si_to_str[] */
 enum si_type {
-	SI_TYPE_INVALID, SI_KCS, SI_SMIC, SI_BT
+	SI_TYPE_INVALID, SI_KCS, SI_SMIC, SI_BT, SI_TYPE_MAX
 };
 
+/* Array is defined in the ipmi_si_intf.c */
+extern const char *const si_to_str[];
+
 enum ipmi_addr_space {
 	IPMI_IO_ADDR_SPACE, IPMI_MEM_ADDR_SPACE
 };
diff --git a/drivers/char/ipmi/ipmi_si_hardcode.c b/drivers/char/ipmi/ipmi_si_hardcode.c
index f6ece7569504..bbcf7483d569 100644
--- a/drivers/char/ipmi/ipmi_si_hardcode.c
+++ b/drivers/char/ipmi/ipmi_si_hardcode.c
@@ -80,26 +80,21 @@ static void __init ipmi_hardcode_init_one(const char *si_type_str,
 					  enum ipmi_addr_space addr_space)
 {
 	struct ipmi_plat_data p;
+	int t;
 
 	memset(&p, 0, sizeof(p));
 
 	p.iftype = IPMI_PLAT_IF_SI;
-	if (!si_type_str || !*si_type_str || strcmp(si_type_str, "kcs") == 0) {
+	if (!si_type_str || !*si_type_str) {
 		p.type = SI_KCS;
-	} else if (strcmp(si_type_str, "smic") == 0) {
-		p.type = SI_SMIC;
-	} else if (strcmp(si_type_str, "bt") == 0) {
-		p.type = SI_BT;
-	} else if (strcmp(si_type_str, "invalid") == 0) {
-		/*
-		 * Allow a firmware-specified interface to be
-		 * disabled.
-		 */
-		p.type = SI_TYPE_INVALID;
 	} else {
-		pr_warn("Interface type specified for interface %d, was invalid: %s\n",
-			i, si_type_str);
-		return;
+		t = match_string(si_to_str, -1, si_type_str);
+		if (t < 0) {
+			pr_warn("Interface type specified for interface %d, was invalid: %s\n",
+				i, si_type_str);
+			return;
+		}
+		p.type = t;
 	}
 
 	p.regsize = regsizes[i];
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index be41a473e3c2..d6ecf88636c4 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -70,7 +70,8 @@ enum si_intf_state {
 #define IPMI_BT_INTMASK_CLEAR_IRQ_BIT	2
 #define IPMI_BT_INTMASK_ENABLE_IRQ_BIT	1
 
-static const char * const si_to_str[] = { "invalid", "kcs", "smic", "bt" };
+/* 'invalid' to allow a firmware-specified interface to be disabled */
+const char *const si_to_str[] = { "invalid", "kcs", "smic", "bt", NULL };
 
 static bool initialized;
 
-- 
2.30.2


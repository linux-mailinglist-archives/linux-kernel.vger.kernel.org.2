Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D10434F112
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhC3SRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:17:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:12952 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232659AbhC3SQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:16:55 -0400
IronPort-SDR: IfDk7OWVONSeDpGafbMGJ79wE5rB19dVaf64+VVSYGb7axie9lCKqfZhUAzmCryH5/mzhpBGza
 j30ajL3HWhhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="189586978"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="189586978"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 11:16:55 -0700
IronPort-SDR: CeoMWCfVGSdJmINyPHaR8iO6bTpC7TD/MRXBvK/yAPJl73TEqWaQ7PsF53mSp5ZT+OTDPJcqSr
 nLXWdqpaaGVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="527434455"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2021 11:16:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5151A2BF; Tue, 30 Mar 2021 21:17:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v1 06/10] ipmi_si: Reuse si_to_str array in ipmi_hardcode_init_one()
Date:   Tue, 30 Mar 2021 21:16:45 +0300
Message-Id: <20210330181649.66496-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of making the comparison one by one, reuse si_to_str array
in ipmi_hardcode_init_one() in conjunction with match_string() API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_si.h          |  3 +++
 drivers/char/ipmi/ipmi_si_hardcode.c | 23 +++++++++--------------
 drivers/char/ipmi/ipmi_si_intf.c     |  2 --
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si.h b/drivers/char/ipmi/ipmi_si.h
index bac0ff86e48e..fd3167d1e1e9 100644
--- a/drivers/char/ipmi/ipmi_si.h
+++ b/drivers/char/ipmi/ipmi_si.h
@@ -22,6 +22,9 @@ enum si_type {
 	SI_TYPE_INVALID, SI_KCS, SI_SMIC, SI_BT
 };
 
+/* 'invalid' to allow a firmware-specified interface to be disabled */
+static __maybe_unused const char *const si_to_str[] = { "invalid", "kcs", "smic", "bt" };
+
 enum ipmi_addr_space {
 	IPMI_IO_ADDR_SPACE, IPMI_MEM_ADDR_SPACE
 };
diff --git a/drivers/char/ipmi/ipmi_si_hardcode.c b/drivers/char/ipmi/ipmi_si_hardcode.c
index f6ece7569504..cf3797523469 100644
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
+		t = match_string(si_to_str, ARRAY_SIZE(si_to_str), si_type_str);
+		if (t < 0) {
+			pr_warn("Interface type specified for interface %d, was invalid: %s\n",
+				i, si_type_str);
+			return;
+		}
+		p.type = t;
 	}
 
 	p.regsize = regsizes[i];
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index be41a473e3c2..ff448098f185 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -70,8 +70,6 @@ enum si_intf_state {
 #define IPMI_BT_INTMASK_CLEAR_IRQ_BIT	2
 #define IPMI_BT_INTMASK_ENABLE_IRQ_BIT	1
 
-static const char * const si_to_str[] = { "invalid", "kcs", "smic", "bt" };
-
 static bool initialized;
 
 /*
-- 
2.30.2


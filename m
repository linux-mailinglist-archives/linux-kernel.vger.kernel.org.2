Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCA134F0C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhC3SRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:17:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:9467 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232715AbhC3SQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:16:58 -0400
IronPort-SDR: vRMP1B5ufp3x2xoAZyyhHgrHnWziuE5241HmKgtKgQBhA1gTS4NCsusNzHbvHlPiRNhATvSlbh
 r8CMrc8d9OMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="212049443"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="212049443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 11:16:57 -0700
IronPort-SDR: NR01EAVOVvU4hEc1uYHOtoW9yi79L+ckQUoRTRPMgq2zh9FQ2kyF1gtYb0JVV+x6HnPMoUcduK
 uVemJYxHvufA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="393703903"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2021 11:16:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6277E355; Tue, 30 Mar 2021 21:17:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v1 08/10] ipmi_si: Use strstrip() to remove surrounding spaces
Date:   Tue, 30 Mar 2021 21:16:47 +0300
Message-Id: <20210330181649.66496-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
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


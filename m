Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC68387A11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245118AbhERNf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:35:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:26478 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237343AbhERNf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:35:58 -0400
IronPort-SDR: CenqPQwkPTkCAfPHXNIaw3G5YT6P/7YLwJSdFX96zr7N8S/zd3rx5aA3UYPLl5OjjhPJqrcVMa
 X/6h5QLQxX1g==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="286243878"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="286243878"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 06:34:40 -0700
IronPort-SDR: SsrzPs4CzhROs3dv892beFg+r4USSr6aSc/wjFSqYObdE5TgMdAqvoQHzBK+g+7lJocWahocQN
 38z+9YOHtDZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="411275283"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2021 06:34:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5090812F; Tue, 18 May 2021 16:35:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] parport: Use string_upper() instead of open coded variant
Date:   Tue, 18 May 2021 16:34:58 +0300
Message-Id: <20210518133458.20403-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use string_upper() from string helper module instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/probe.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/parport/probe.c b/drivers/parport/probe.c
index 7e6d713fa5ac..5d1b9aacb130 100644
--- a/drivers/parport/probe.c
+++ b/drivers/parport/probe.c
@@ -8,8 +8,8 @@
 
 #include <linux/module.h>
 #include <linux/parport.h>
-#include <linux/ctype.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -74,11 +74,7 @@ static void parse_data(struct parport *port, int device, char *str)
 			u = sep + strlen (sep) - 1;
 			while (u >= p && *u == ' ')
 				*u-- = '\0';
-			u = p;
-			while (*u) {
-				*u = toupper(*u);
-				u++;
-			}
+			string_upper(p, p);
 			if (!strcmp(p, "MFG") || !strcmp(p, "MANUFACTURER")) {
 				kfree(info->mfr);
 				info->mfr = kstrdup(sep, GFP_KERNEL);
@@ -90,8 +86,7 @@ static void parse_data(struct parport *port, int device, char *str)
 
 				kfree(info->class_name);
 				info->class_name = kstrdup(sep, GFP_KERNEL);
-				for (u = sep; *u; u++)
-					*u = toupper(*u);
+				string_upper(sep, sep);
 				for (i = 0; classes[i].token; i++) {
 					if (!strcmp(classes[i].token, sep)) {
 						info->class = i;
-- 
2.30.2


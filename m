Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93C537914C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhEJOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:50:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:48269 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233149AbhEJOuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:50:22 -0400
IronPort-SDR: 3vUGNhl9FprzZWD1lkVzumrGVOWWuDn0ZV4ja1Tv4VIRCuprNQ/Z1dOg/2K7+HwFwpRXWemmZD
 zkz9+5F1gRMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="284695848"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="284695848"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 07:49:15 -0700
IronPort-SDR: g12/KNiR7GT/d2fjM18wH18qp3EhNi/k6SN/QLNplQgIsiZWolAIHWTY1kWIMBU0T7c+zjBJko
 iJacHGqmMiKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="398902358"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 10 May 2021 07:49:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B1F4C12A; Mon, 10 May 2021 17:49:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] powerpc/prom_init: Move custom isspace() to its own namespace
Date:   Mon, 10 May 2021 17:49:25 +0300
Message-Id: <20210510144925.58195-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If by some reason any of the headers will include ctype.h
we will have a name collision. Avoid this by moving isspace()
to the dedicate namespace.

First appearance of the code is in the commit cf68787b68a2
("powerpc/prom_init: Evaluate mem kernel parameter for early allocation").

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/kernel/prom_init.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 41ed7e33d897..6845cbbc0cd4 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -701,13 +701,13 @@ static int __init prom_setprop(phandle node, const char *nodename,
 }
 
 /* We can't use the standard versions because of relocation headaches. */
-#define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
-			 || ('a' <= (c) && (c) <= 'f') \
-			 || ('A' <= (c) && (c) <= 'F'))
+#define prom_isxdigit(c)	(('0' <= (c) && (c) <= '9') \
+				 || ('a' <= (c) && (c) <= 'f') \
+				 || ('A' <= (c) && (c) <= 'F'))
 
-#define isdigit(c)	('0' <= (c) && (c) <= '9')
-#define islower(c)	('a' <= (c) && (c) <= 'z')
-#define toupper(c)	(islower(c) ? ((c) - 'a' + 'A') : (c))
+#define prom_isdigit(c)		('0' <= (c) && (c) <= '9')
+#define prom_islower(c)		('a' <= (c) && (c) <= 'z')
+#define prom_toupper(c)		(prom_islower(c) ? ((c) - 'a' + 'A') : (c))
 
 static unsigned long prom_strtoul(const char *cp, const char **endp)
 {
@@ -716,14 +716,14 @@ static unsigned long prom_strtoul(const char *cp, const char **endp)
 	if (*cp == '0') {
 		base = 8;
 		cp++;
-		if (toupper(*cp) == 'X') {
+		if (prom_toupper(*cp) == 'X') {
 			cp++;
 			base = 16;
 		}
 	}
 
-	while (isxdigit(*cp) &&
-	       (value = isdigit(*cp) ? *cp - '0' : toupper(*cp) - 'A' + 10) < base) {
+	while (prom_isxdigit(*cp) &&
+	       (value = prom_isdigit(*cp) ? *cp - '0' : prom_toupper(*cp) - 'A' + 10) < base) {
 		result = result * base + value;
 		cp++;
 	}
-- 
2.30.2


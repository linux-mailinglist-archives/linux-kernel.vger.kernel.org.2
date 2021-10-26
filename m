Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448D643B3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhJZO1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:27:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:9914 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234374AbhJZO1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:27:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="290755904"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="290755904"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 07:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="722383504"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 26 Oct 2021 07:04:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D7DC8107; Tue, 26 Oct 2021 17:04:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 1/1] lib/vsprintf.c: Amend static asserts for format specifier flags
Date:   Tue, 26 Oct 2021 17:03:56 +0300
Message-Id: <20211026140356.45610-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are couple of improvements to static asserts against
the format specifier flags:

- new static assert for SIGN
- fix static assert for SMALL

SMALL is not equal to ASCII code of white space, it equals to
the bit difference between capital and small letters (however
the value is the same, semantically expression means different
things).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f15a49ff6fab..ddfb3d836f38 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -407,8 +407,9 @@ int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
 #define SMALL	32		/* use lowercase in hex (must be 32 == 0x20) */
 #define SPECIAL	64		/* prefix hex with "0x", octal with "0" */
 
+static_assert(SIGN == 1);
 static_assert(ZEROPAD == ('0' - ' '));
-static_assert(SMALL == ' ');
+static_assert(SMALL == ('a' ^ 'A'));
 
 enum format_type {
 	FORMAT_TYPE_NONE, /* Just a string part */
-- 
2.33.0


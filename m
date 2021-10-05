Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF974232CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhJEV2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:28:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:65235 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235679AbhJEV2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:28:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="212981665"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="212981665"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 14:27:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="488213955"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 14:27:01 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] lib/string_helpers: add linux/string.h for strlen()
Date:   Tue,  5 Oct 2021 14:26:34 -0700
Message-Id: <20211005212634.3223113-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/string_helpers.h uses strlen(), so include the correpondent
header. Otherwise we get a compilation error if it's not also included
by whoever included the helper.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/linux/string_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 68189c4a2eb1..4ba39e1403b2 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -4,6 +4,7 @@
 
 #include <linux/bits.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 struct file;
-- 
2.33.0


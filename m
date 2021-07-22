Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3D43D2C10
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhGVSDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 14:03:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:44942 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhGVSDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:03:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211436756"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="211436756"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="470759226"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jul 2021 11:43:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B6FFAE7; Thu, 22 Jul 2021 21:43:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] once: Fix trivia typo Not -> Note
Date:   Thu, 22 Jul 2021 21:43:49 +0300
Message-Id: <20210722184349.76290-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix trivia typo Not -> Note in the comment to DO_ONCE().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/once.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/once.h b/include/linux/once.h
index 9225ee6d96c7..095c6debd63b 100644
--- a/include/linux/once.h
+++ b/include/linux/once.h
@@ -16,7 +16,7 @@ void __do_once_done(bool *done, struct static_key_true *once_key,
  * out the condition into a nop. DO_ONCE() guarantees type safety of
  * arguments!
  *
- * Not that the following is not equivalent ...
+ * Note that the following is not equivalent ...
  *
  *   DO_ONCE(func, arg);
  *   DO_ONCE(func, arg);
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8004444E828
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhKLOKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:10:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:16984 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234199AbhKLOKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:10:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="220344711"
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="220344711"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 06:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="590533411"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 12 Nov 2021 06:07:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C28A81F8; Fri, 12 Nov 2021 16:07:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] printk: Remove printk.h inclusion in percpu.h
Date:   Fri, 12 Nov 2021 16:07:49 +0200
Message-Id: <20211112140749.80042-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
in NMI") the printk.h is not needed anymore in percpu.h.

Moreover `make headerdep` complains (an excerpt)

In file included from linux/printk.h,
                 from linux/dynamic_debug.h:188
                 from linux/printk.h:559 <-- here
                 from linux/percpu.h:9
                 from linux/idr.h:17
include/net/9p/client.h:13: warning: recursive header inclusion

Yeah, it's not a root cause of this, but removing will help to reduce
the noise.

Fixes: 42a0bb3f7138 ("printk/nmi: generic solution for safe printk in NMI")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/percpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 98a9371133f8..ae4004e7957e 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -6,7 +6,6 @@
 #include <linux/preempt.h>
 #include <linux/smp.h>
 #include <linux/cpumask.h>
-#include <linux/printk.h>
 #include <linux/pfn.h>
 #include <linux/init.h>
 
-- 
2.33.0


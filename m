Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EB73554C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhDFNQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:16:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:61660 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhDFNQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:16:12 -0400
IronPort-SDR: 28aR9Ndg3QggjuRTc7P3AEws3HBIDK3W5F+1dpHiArApWemzs5fUMRwIQVpCkewGvc9YHaLjsu
 7ilF0nX0SOnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="180603079"
X-IronPort-AV: E=Sophos;i="5.81,309,1610438400"; 
   d="scan'208";a="180603079"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 06:16:04 -0700
IronPort-SDR: cxmOqNvzso+345A9Jb8aaTzeCyIwh88Megyz6sXpuIdsgAGxU+F/ZA0BYWBsbVPDy4xQwnnYM5
 JDz/vOVw8GFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,309,1610438400"; 
   d="scan'208";a="379399563"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 06:16:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C8E17B7; Tue,  6 Apr 2021 16:16:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] misc: pti: Remove Kconfig leftovers
Date:   Tue,  6 Apr 2021 16:16:15 +0300
Message-Id: <20210406131615.85432-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 8ba59e9dee31 ("misc: pti: Remove driver for deprecated platform")
got rid of deprecated drivers under TTY subsystem, but cleaned only one Kconfig
entry. Remove Kconfig leftovers.

Fixes: 8ba59e9dee31 ("misc: pti: Remove driver for deprecated platform")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/Kconfig | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 1d30add862af..f6a7fd6d3bb6 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -361,36 +361,6 @@ config NULL_TTY
 
 	  If unsure, say N.
 
-config TRACE_ROUTER
-	tristate "Trace data router for MIPI P1149.7 cJTAG standard"
-	depends on TRACE_SINK
-	help
-	  The trace router uses the Linux tty line discipline framework to
-	  route trace data coming from a tty port (say UART for example) to
-	  the trace sink line discipline driver and to another tty port (say
-	  USB). This is part of a solution for the MIPI P1149.7, compact JTAG,
-	  standard, which is for debugging mobile devices. The PTI driver in
-	  drivers/misc/pti.c defines the majority of this MIPI solution.
-
-	  You should select this driver if the target kernel is meant for
-	  a mobile device containing a modem.  Then you will need to select
-	  "Trace data sink for MIPI P1149.7 cJTAG standard" line discipline
-	  driver.
-
-config TRACE_SINK
-	tristate "Trace data sink for MIPI P1149.7 cJTAG standard"
-	help
-	  The trace sink uses the Linux line discipline framework to receive
-	  trace data coming from the trace router line discipline driver
-	  to a user-defined tty port target, like USB.
-	  This is to provide a way to extract modem trace data on
-	  devices that do not have a PTI HW module, or just need modem
-	  trace data to come out of a different HW output port.
-	  This is part of a solution for the P1149.7, compact JTAG, standard.
-
-	  If you select this option, you need to select
-	  "Trace data router for MIPI P1149.7 cJTAG standard".
-
 config VCC
 	tristate "Sun Virtual Console Concentrator"
 	depends on SUN_LDOMS
-- 
2.30.2


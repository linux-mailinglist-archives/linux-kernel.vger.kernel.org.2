Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED93CA0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhGOOoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:44:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:9884 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhGOOog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:44:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197823011"
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="197823011"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 07:41:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="495468444"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jul 2021 07:41:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 71C05262; Thu, 15 Jul 2021 17:41:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] auxdisplay: charlcd: Drop unneeded initializers and switch to C99 style
Date:   Thu, 15 Jul 2021 17:41:52 +0300
Message-Id: <20210715144152.83582-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For structure initializers the fields are 0 (or NULL) by default, so
there is no need to fill them explicitly. Besides that, much easier
to read when initializers use C99 style. Hence, convert to C99 style
as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: completely rewrote patch (Willy)
 drivers/auxdisplay/charlcd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 24fd6f369ebe..304accde365c 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -637,9 +637,7 @@ static int panel_notify_sys(struct notifier_block *this, unsigned long code,
 }
 
 static struct notifier_block panel_notifier = {
-	panel_notify_sys,
-	NULL,
-	0
+	.notifier_call = panel_notify_sys,
 };
 
 int charlcd_register(struct charlcd *lcd)
-- 
2.30.2


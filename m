Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52373C9F64
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbhGONZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 09:25:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:3098 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232558AbhGONZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:25:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197809764"
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="197809764"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 06:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="505793494"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jul 2021 06:22:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0E815262; Thu, 15 Jul 2021 16:23:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] auxdisplay: charlcd: Drop unneeded terminator entry
Date:   Thu, 15 Jul 2021 16:23:10 +0300
Message-Id: <20210715132310.31514-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides 0 not being, strictly speaking, a pointer it's redundant after
the actual terminator NULL entry. Drop the former for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/charlcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 24fd6f369ebe..e9bc5fb4da28 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -638,8 +638,7 @@ static int panel_notify_sys(struct notifier_block *this, unsigned long code,
 
 static struct notifier_block panel_notifier = {
 	panel_notify_sys,
-	NULL,
-	0
+	NULL
 };
 
 int charlcd_register(struct charlcd *lcd)
-- 
2.30.2


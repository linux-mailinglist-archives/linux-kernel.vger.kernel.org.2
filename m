Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD074397E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhJYNyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:54:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:54232 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232830AbhJYNy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:54:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="227107187"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="227107187"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 06:52:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="721604653"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2021 06:52:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1D6E423E; Mon, 25 Oct 2021 16:52:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 4/5] tty: rpmsg: Add pr_fmt() to prefix messages
Date:   Mon, 25 Oct 2021 16:51:47 +0300
Message-Id: <20211025135148.53944-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com>
References: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make all messages to be prefixed in a unified way.
Add pr_fmt() to achieve this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/rpmsg_tty.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
index d172dd331bc9..4bee6c5bbb53 100644
--- a/drivers/tty/rpmsg_tty.c
+++ b/drivers/tty/rpmsg_tty.c
@@ -10,6 +10,8 @@
  * The "rpmsg-tty" service is directly used for data exchange. No flow control is implemented yet.
  */
 
+#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/rpmsg.h>
 #include <linux/slab.h>
@@ -235,13 +237,13 @@ static int __init rpmsg_tty_init(void)
 
 	ret = tty_register_driver(rpmsg_tty_driver);
 	if (ret < 0) {
-		pr_err("Couldn't install rpmsg tty driver: %d\n", ret);
+		pr_err("Couldn't install driver: %d\n", ret);
 		goto error_put;
 	}
 
 	ret = register_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
 	if (ret < 0) {
-		pr_err("Couldn't register rpmsg tty driver: %d\n", ret);
+		pr_err("Couldn't register driver: %d\n", ret);
 		goto error_unregister;
 	}
 
-- 
2.33.0


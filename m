Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C222B4397E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhJYNyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:54:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:47230 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233002AbhJYNyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:54:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="228416461"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="228416461"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 06:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="634746875"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2021 06:52:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 289C7321; Mon, 25 Oct 2021 16:52:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 5/5] tty: rpmsg: Define tty name via constant string literal
Date:   Mon, 25 Oct 2021 16:51:48 +0300
Message-Id: <20211025135148.53944-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com>
References: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver uses already twice the same string literal.

Define it in one place, so every user will have this
name consistent.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/rpmsg_tty.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
index 4bee6c5bbb53..dae2a4e44f38 100644
--- a/drivers/tty/rpmsg_tty.c
+++ b/drivers/tty/rpmsg_tty.c
@@ -18,6 +18,7 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 
+#define RPMSG_TTY_NAME	"ttyRPMSG"
 #define MAX_TTY_RPMSG	32
 
 static DEFINE_IDR(tty_idr);	/* tty instance id */
@@ -172,7 +173,7 @@ static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
 
 	dev_set_drvdata(dev, cport);
 
-	dev_dbg(dev, "New channel: 0x%x -> 0x%x : ttyRPMSG%d\n",
+	dev_dbg(dev, "New channel: 0x%x -> 0x%x: " RPMSG_TTY_NAME "%d\n",
 		rpdev->src, rpdev->dst, cport->id);
 
 	return 0;
@@ -224,7 +225,7 @@ static int __init rpmsg_tty_init(void)
 		return PTR_ERR(rpmsg_tty_driver);
 
 	rpmsg_tty_driver->driver_name = "rpmsg_tty";
-	rpmsg_tty_driver->name = "ttyRPMSG";
+	rpmsg_tty_driver->name = RPMSG_TTY_NAME;
 	rpmsg_tty_driver->major = 0;
 	rpmsg_tty_driver->type = TTY_DRIVER_TYPE_CONSOLE;
 
-- 
2.33.0


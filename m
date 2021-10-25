Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF04397E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhJYNyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:54:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:54232 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232796AbhJYNy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:54:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="227107185"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="227107185"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 06:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="485683585"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2021 06:52:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0DDAF107; Mon, 25 Oct 2021 16:52:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 3/5] tty: rpmsg: Use dev_err_probe() in ->probe()
Date:   Mon, 25 Oct 2021 16:51:46 +0300
Message-Id: <20211025135148.53944-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com>
References: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's fine to use dev_err_probe() in ->probe() even if we know
it won't be deferred.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/rpmsg_tty.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
index fc5d33dc4cb8..d172dd331bc9 100644
--- a/drivers/tty/rpmsg_tty.c
+++ b/drivers/tty/rpmsg_tty.c
@@ -153,10 +153,8 @@ static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
 	int ret;
 
 	cport = rpmsg_tty_alloc_cport();
-	if (IS_ERR(cport)) {
-		dev_err(dev, "Failed to alloc tty port\n");
-		return PTR_ERR(cport);
-	}
+	if (IS_ERR(cport))
+		return dev_err_probe(dev, PTR_ERR(cport), "Failed to alloc tty port\n");
 
 	tty_port_init(&cport->port);
 	cport->port.ops = &rpmsg_tty_port_ops;
@@ -164,9 +162,8 @@ static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
 	tty_dev = tty_port_register_device(&cport->port, rpmsg_tty_driver,
 					   cport->id, dev);
 	if (IS_ERR(tty_dev)) {
-		dev_err(dev, "Failed to register tty port\n");
-		ret = PTR_ERR(tty_dev);
-		goto  err_destroy;
+		ret = dev_err_probe(dev, PTR_ERR(tty_dev), "Failed to register tty port\n");
+		goto err_destroy;
 	}
 
 	cport->rpdev = rpdev;
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255044397E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhJYNy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:54:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:32497 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhJYNyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:54:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="229925336"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="229925336"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 06:52:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="578126430"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2021 06:52:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 03430BB; Mon, 25 Oct 2021 16:52:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 2/5] tty: rpmsg: Unify variable used to keep an error code
Date:   Mon, 25 Oct 2021 16:51:45 +0300
Message-Id: <20211025135148.53944-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com>
References: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some ret is used, in the other err. Let's unify it across the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/rpmsg_tty.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
index 8c17ddbf371d..fc5d33dc4cb8 100644
--- a/drivers/tty/rpmsg_tty.c
+++ b/drivers/tty/rpmsg_tty.c
@@ -114,22 +114,22 @@ static const struct tty_operations rpmsg_tty_ops = {
 static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
 {
 	struct rpmsg_tty_port *cport;
-	int err;
+	int ret;
 
 	cport = kzalloc(sizeof(*cport), GFP_KERNEL);
 	if (!cport)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_lock(&idr_lock);
-	err = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
+	ret = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
 	mutex_unlock(&idr_lock);
 
-	if (err < 0) {
+	if (ret < 0) {
 		kfree(cport);
-		return ERR_PTR(err);
+		return ERR_PTR(ret);
 	}
 
-	cport->id = err;
+	cport->id = ret;
 
 	return cport;
 }
@@ -217,7 +217,7 @@ static struct rpmsg_driver rpmsg_tty_rpmsg_drv = {
 
 static int __init rpmsg_tty_init(void)
 {
-	int err;
+	int ret;
 
 	rpmsg_tty_driver = tty_alloc_driver(MAX_TTY_RPMSG, TTY_DRIVER_REAL_RAW |
 					    TTY_DRIVER_DYNAMIC_DEV);
@@ -236,15 +236,15 @@ static int __init rpmsg_tty_init(void)
 
 	tty_set_operations(rpmsg_tty_driver, &rpmsg_tty_ops);
 
-	err = tty_register_driver(rpmsg_tty_driver);
-	if (err < 0) {
-		pr_err("Couldn't install rpmsg tty driver: err %d\n", err);
+	ret = tty_register_driver(rpmsg_tty_driver);
+	if (ret < 0) {
+		pr_err("Couldn't install rpmsg tty driver: %d\n", ret);
 		goto error_put;
 	}
 
-	err = register_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
-	if (err < 0) {
-		pr_err("Couldn't register rpmsg tty driver: err %d\n", err);
+	ret = register_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
+	if (ret < 0) {
+		pr_err("Couldn't register rpmsg tty driver: %d\n", ret);
 		goto error_unregister;
 	}
 
@@ -256,7 +256,7 @@ static int __init rpmsg_tty_init(void)
 error_put:
 	tty_driver_kref_put(rpmsg_tty_driver);
 
-	return err;
+	return ret;
 }
 
 static void __exit rpmsg_tty_exit(void)
-- 
2.33.0


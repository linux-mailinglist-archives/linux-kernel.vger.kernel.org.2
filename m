Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316784397E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhJYNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:54:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:54232 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231586AbhJYNyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:54:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="227107184"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="227107184"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 06:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="485683584"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2021 06:52:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EBFD6E7; Mon, 25 Oct 2021 16:52:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/5] tty: rpmsg: Assign returned id to a local variable
Date:   Mon, 25 Oct 2021 16:51:44 +0300
Message-Id: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of putting garbage in the data structure, assign allocated id
or an error code to a temporary variable. This makes code cleaner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/rpmsg_tty.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
index 813076341ffd..8c17ddbf371d 100644
--- a/drivers/tty/rpmsg_tty.c
+++ b/drivers/tty/rpmsg_tty.c
@@ -121,15 +121,16 @@ static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_lock(&idr_lock);
-	cport->id = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
+	err = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
 	mutex_unlock(&idr_lock);
 
-	if (cport->id < 0) {
-		err = cport->id;
+	if (err < 0) {
 		kfree(cport);
 		return ERR_PTR(err);
 	}
 
+	cport->id = err;
+
 	return cport;
 }
 
-- 
2.33.0


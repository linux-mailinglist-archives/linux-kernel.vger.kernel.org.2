Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD139DD63
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFGNQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:16:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:17596 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhFGNQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:16:13 -0400
IronPort-SDR: a3K+hAc73OG/NL63kfVXQB6Zz3sHE83JNv7U+coQlrBKWCTWh5RyEmCTMbLVHmw78B6tpRPG7x
 GIMg7Nh6gtLA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265773969"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265773969"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 06:14:22 -0700
IronPort-SDR: o9mg1kFB2+hwleThD7WQw8LP9AsfAFCj7Ac5ibTq0UtEZQdBuQaGM+wNdb7XLq+nhOS2dKIAvj
 9dUF+K2Xw5Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551881864"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2021 06:14:20 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/7] usb: typec: ucsi: Always cancel the command if PPM reports BUSY condition
Date:   Mon,  7 Jun 2021 16:14:36 +0300
Message-Id: <20210607131442.20121-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to execute next command immediately
after the busy condition.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 4e1973fbdf0dc..366c8a468bc18 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -128,8 +128,10 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	if (ret)
 		return ret;
 
-	if (cci & UCSI_CCI_BUSY)
+	if (cci & UCSI_CCI_BUSY) {
+		ucsi->ops->async_write(ucsi, UCSI_CANCEL, NULL, 0);
 		return -EBUSY;
+	}
 
 	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
-- 
2.30.2


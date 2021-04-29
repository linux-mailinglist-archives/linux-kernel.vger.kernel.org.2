Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33C436E721
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbhD2Ihc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhD2Ihb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:37:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 941AA61186;
        Thu, 29 Apr 2021 08:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619685404;
        bh=Q527VIq+GkpwCLejgbAK+745j3ug5PUj0Wy3UZuSaBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BA2K7uPPUo06DkGGdeG2QlunBOog1xiioiaPZ6qpA8wb8V9SCqQVykZJ4wr3Cg6J7
         6kD6JSabGa42dpT3KR9nNAvvC0V5MvXZGPpoxc8h5kcrU7KBS/URZ8H2ywsxKcU0UI
         hwT5SBoYisskV+jeKJzgZaUKSefWAFgxwjrYpccD7QqiaEfINhy7bkdlvIJ9IWrrty
         xZFv5gmTou9Z8zG6LwsMHsmIcDHTuhetHKmAbRb0qq0DqfUWG4BLoh9HwwlUXUfhK/
         qpe9a1LYMf/qlRE4R51TzK1NZMIc2xVUsLMafKBTz1DAag4UmhcCIZwCeMDNHtGnTg
         ql9XCu9to6+pw==
Received: by pali.im (Postfix)
        id D757C7DF; Thu, 29 Apr 2021 10:36:41 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 mvebu + mvebu/dt64 1/6] firmware: turris-mox-rwtm: fix reply status decoding function
Date:   Thu, 29 Apr 2021 10:36:31 +0200
Message-Id: <20210429083636.22560-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210308153703.23097-1-kabel@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <kabel@kernel.org>

The status decoding function mox_get_status() currently contains a dead
code path: if the error status is not MBOX_STS_SUCCESS, it always
returns -EIO, so the comparison to MBOX_STS_FAIL is never executed and
we don't get the actual error code sent by the firmware.

Fix this.

Signed-off-by: Marek Behún <kabel@kernel.org>
Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
---
 drivers/firmware/turris-mox-rwtm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 62f0d1a5dd32..f85acdb3130c 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -147,11 +147,14 @@ MOX_ATTR_RO(pubkey, "%s\n", pubkey);
 
 static int mox_get_status(enum mbox_cmd cmd, u32 retval)
 {
-	if (MBOX_STS_CMD(retval) != cmd ||
-	    MBOX_STS_ERROR(retval) != MBOX_STS_SUCCESS)
+	if (MBOX_STS_CMD(retval) != cmd)
 		return -EIO;
 	else if (MBOX_STS_ERROR(retval) == MBOX_STS_FAIL)
 		return -(int)MBOX_STS_VALUE(retval);
+	else if (MBOX_STS_ERROR(retval) == MBOX_STS_BADCMD)
+		return -ENOSYS;
+	else if (MBOX_STS_ERROR(retval) != MBOX_STS_SUCCESS)
+		return -EIO;
 	else
 		return MBOX_STS_VALUE(retval);
 }
-- 
2.20.1


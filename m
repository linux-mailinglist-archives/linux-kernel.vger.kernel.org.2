Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD6D375140
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhEFJJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233686AbhEFJJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:09:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6618360FEE;
        Thu,  6 May 2021 09:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620292107;
        bh=ORxyAXfPiELuOuNTDJqT+1syYGZTiHj3MDbntawW8/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGL9D2IBAelQF9B7swdwg/1sg3Mx5qW14puHFL3uwBHHCT2umIdS2bWBPZZU5CYWt
         mNREd4nWAXphE6uFpiyt430ukAYgyCfFujEEeA8VOXhGslpVvQIlieT3Q17V0wu3nj
         b9dxwKOwWJTze6xx3vtZOBR3dvPqxRn/mZ3G8FYadYp+wEavaWD7G5nnQQUc0t1KHb
         2mpAj9tFODF1G6R/hL3q4bsJoZAvyGlsoKTSR0xfkjgK33EVaNJvZ720lRi0TsoOyL
         KMa4o+hWU1ChpP1yzX6xNDj8XSp4HltiUxBLOG3arZFFZ3PEy4d8UyZqWC+gf5dZC7
         fTngHZhTSZQ5g==
Received: by pali.im (Postfix)
        id DAC3A732; Thu,  6 May 2021 11:08:24 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 mvebu + mvebu/dt64 1/6] firmware: turris-mox-rwtm: fix reply status decoding function
Date:   Thu,  6 May 2021 11:07:57 +0200
Message-Id: <20210506090802.14268-1-pali@kernel.org>
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

The status decoding function mox_get_status() currently contains an
incorrect check: if the error status is not MBOX_STS_SUCCESS, it always
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D663C38ACE0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbhETLuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241762AbhETLgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:36:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A6A6611AB;
        Thu, 20 May 2021 11:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621510532;
        bh=X3jopxsX61QS+or7ehscRsDEihXrE0LQ/xHPv2/OfAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kI1SIb7omMxdoGjWjB4B5Kty8kDjP2oWTMDvEjcj+fOeUHuES5d1b8flMxJoMPkQu
         ELh2Afz1ugedNnCe9UqQIQvpoYfDYXCseC7ujLiPh5gqOszMwwzF3uYuKbgQ4hUYT6
         7AX3h9AYLvi4lHV3IhCNFzHguwgnekTGSaFhUc27FQXIjSxW3XvsZaOjxY13rAZxvr
         lQdWsgavCwvSvhT3W3ZGZ0qErfdCBAhrLnJRWGRYr886+nB+opva/9kgANkquoK9fp
         rh5ToZbt72QyDNcdh5vlTCl4ai19UY+QXw73CEI8wDVyOPgoGpHZYfzpyRPkZ3mg8o
         csBa5GMpSaGbA==
Received: by pali.im (Postfix)
        id 787CC9D7; Thu, 20 May 2021 13:35:30 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 mvebu 1/4] firmware: turris-mox-rwtm: fix reply status decoding function
Date:   Thu, 20 May 2021 13:35:17 +0200
Message-Id: <20210520113520.32240-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520113520.32240-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113520.32240-1-pali@kernel.org>
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
Reviewed-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


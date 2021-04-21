Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726DD366BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbhDUNFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240488AbhDUNEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D95B76143B;
        Wed, 21 Apr 2021 13:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010227;
        bh=uwUa5giK+hqOEz8KG6fYiKCbWvTf4cA9SwlNTJe96AE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2IVc8JRUKB44u9tHL74XqG8M108pk5V2LE9kFhF0KrLLo4SY+x3OV8tnGBe/nTO8
         a3cvP4WIxsAkyQPz3PgbEOZd+9YHmxFe4rY1QXA1prEHNrNX96DhOEcxjrWL/BKzvk
         CvA8+eOhiR/5AF1PNiOySrpAZaRQPLAAAEKqOAE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 058/190] Revert "media: cx231xx: replace BUG_ON with recovery code"
Date:   Wed, 21 Apr 2021 14:58:53 +0200
Message-Id: <20210421130105.1226686-59-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 93a24578de721006055b422c7772e0e417e1983c.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/cx231xx/cx231xx-i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-i2c.c b/drivers/media/usb/cx231xx/cx231xx-i2c.c
index c6659253c6fb..f33b6a077d57 100644
--- a/drivers/media/usb/cx231xx/cx231xx-i2c.c
+++ b/drivers/media/usb/cx231xx/cx231xx-i2c.c
@@ -515,8 +515,7 @@ int cx231xx_i2c_register(struct cx231xx_i2c *bus)
 {
 	struct cx231xx *dev = bus->dev;
 
-	if (!dev->cx231xx_send_usb_command)
-		return -EINVAL;
+	BUG_ON(!dev->cx231xx_send_usb_command);
 
 	bus->i2c_adap = cx231xx_adap_template;
 	bus->i2c_adap.dev.parent = dev->dev;
-- 
2.31.1


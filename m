Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3027366C55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbhDUNO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241930AbhDUNJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B004661457;
        Wed, 21 Apr 2021 13:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010541;
        bh=Ou1R9w3f+npUv/Jrxwt8MJ0KDgjjFawshzKVNswysck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3E3Xsy7ifCyq5glQ8+d4ZIGqTQDo+4o3Ws1E0H4MCwvD4y5xgH1GE63F4BmGZzSn
         hxueslXmRQx3YVG7jdV969fvp1RFmz9MNxnHRAk6dj1HvHXOUj1xNTZFcIz/s6Qfco
         p738DZMK2417mZMJL201DwhgaeaSa6rfkJnveQLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 146/190] Revert "media: dvb: Add check on sp8870_readreg"
Date:   Wed, 21 Apr 2021 15:00:21 +0200
Message-Id: <20210421130105.1226686-147-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 467a37fba93f2b4fe3ab597ff6a517b22b566882.

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
Cc: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/sp8870.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/sp8870.c b/drivers/media/dvb-frontends/sp8870.c
index 655db8272268..ee893a2f2261 100644
--- a/drivers/media/dvb-frontends/sp8870.c
+++ b/drivers/media/dvb-frontends/sp8870.c
@@ -280,9 +280,7 @@ static int sp8870_set_frontend_parameters(struct dvb_frontend *fe)
 	sp8870_writereg(state, 0xc05, reg0xc05);
 
 	// read status reg in order to clear pending irqs
-	err = sp8870_readreg(state, 0x200);
-	if (err)
-		return err;
+	sp8870_readreg(state, 0x200);
 
 	// system controller start
 	sp8870_microcontroller_start(state);
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0410366BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbhDUNJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240889AbhDUNG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F19E6147F;
        Wed, 21 Apr 2021 13:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010383;
        bh=Tx6TRLl2PIEPearhZRweiXGHVRw1eOg7YVKuG+Z9hkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvBinzxp6V9orOZU6M7VjuvIKonchoj5DlsGobGoGIKFHafzkhyKHEOJa705Zci/8
         1MI90gN/JxEVKFOH4LUx0wWspfU62OXE2crFSMlx5APTkl1QdL42pX3BNYH5E0qzTy
         1aWQt610b4VHWLGj3oaAbCzVeHwkFC1ID3XUTvNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 117/190] Revert "media: si2165: fix a missing check of return value"
Date:   Wed, 21 Apr 2021 14:59:52 +0200
Message-Id: <20210421130105.1226686-118-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0ab34a08812a3334350dbaf69a018ee0ab3d2ddd.

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

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Matthias Schwarzott <zzam@gentoo.org>
Cc: Matthias Schwarzott <zzam@gentoo.org>
Cc: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/si2165.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-frontends/si2165.c b/drivers/media/dvb-frontends/si2165.c
index ebee230afb7b..dc39543e0db1 100644
--- a/drivers/media/dvb-frontends/si2165.c
+++ b/drivers/media/dvb-frontends/si2165.c
@@ -266,20 +266,18 @@ static u32 si2165_get_fe_clk(struct si2165_state *state)
 
 static int si2165_wait_init_done(struct si2165_state *state)
 {
-	int ret;
+	int ret = -EINVAL;
 	u8 val = 0;
 	int i;
 
 	for (i = 0; i < 3; ++i) {
-		ret = si2165_readreg8(state, REG_INIT_DONE, &val);
-		if (ret < 0)
-			return ret;
+		si2165_readreg8(state, REG_INIT_DONE, &val);
 		if (val == 0x01)
 			return 0;
 		usleep_range(1000, 50000);
 	}
 	dev_err(&state->client->dev, "init_done was not set\n");
-	return -EINVAL;
+	return ret;
 }
 
 static int si2165_upload_firmware_block(struct si2165_state *state,
-- 
2.31.1


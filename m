Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721A1366C67
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242939AbhDUNQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238818AbhDUNKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:10:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C0146143B;
        Wed, 21 Apr 2021 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010584;
        bh=GYtLgN2svqnMuH2z87XhdlxjjfFs8CTS8yebKaeI9oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2QccoBIXU4SaH8grWodDwI8C6cHvrugR2qY/xxbfAwvID+skMnlUSYZKowzr4LLki
         JNSUaP3H0emmomLvCnYagG8TeJAxwgbvxqcd47b/6V6VDlKL5HVpUz7FY+XuzjREMS
         JV5bpHCoQnwVKvNHvTvVkP6Ey7D0QyeR5g/Co9bw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 143/190] Revert "power: twl4030: fix a missing check of return value"
Date:   Wed, 21 Apr 2021 15:00:18 +0200
Message-Id: <20210421130105.1226686-144-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6f12e46eebf1a7d4fdd66df5e815df96b8f8b1b5.

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
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/twl4030_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 1bc49b2e12e8..dcbd9f03f31a 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -805,9 +805,7 @@ static int twl4030_bci_get_property(struct power_supply *psy,
 		is_charging = state & TWL4030_MSTATEC_AC;
 	if (!is_charging) {
 		u8 s;
-		ret = twl4030_bci_read(TWL4030_BCIMDEN, &s);
-		if (ret < 0)
-			return ret;
+		twl4030_bci_read(TWL4030_BCIMDEN, &s);
 		if (psy->desc->type == POWER_SUPPLY_TYPE_USB)
 			is_charging = s & 1;
 		else
-- 
2.31.1


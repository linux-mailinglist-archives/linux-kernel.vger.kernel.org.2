Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ADD366C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbhDUNNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241655AbhDUNJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00D526146E;
        Wed, 21 Apr 2021 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010517;
        bh=mWy6ChpFILAZqYMtiEutOl0+dtzswutb0rriam5WrmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGgzwNGWMqv9RmtFX0Hquu5scVRqQpSAi72p3jSXFtV8JuNHK8si+yBD4U0RHhmRw
         NsbgrbtiMxbefEqwuz7tGFbdST924ZaB7CTf7qTlaauQu/6holSrmhbiq6r1u8yIUz
         t+uEO4qJMdq9VZR5+pxaBngPVqkhxplaFLfi7TWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 165/190] Revert "mfd: mc13xxx: Fix a missing check of a register-read failure"
Date:   Wed, 21 Apr 2021 15:00:40 +0200
Message-Id: <20210421130105.1226686-166-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9e28989d41c0eab57ec0bb156617a8757406ff8a.

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
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/mc13xxx-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 1abe7432aad8..b2beb7c39cc5 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -271,9 +271,7 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 
 	mc13xxx->adcflags |= MC13XXX_ADC_WORKING;
 
-	ret = mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
-	if (ret)
-		goto out;
+	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
 
 	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2 |
 	       MC13XXX_ADC0_CHRGRAWDIV;
-- 
2.31.1


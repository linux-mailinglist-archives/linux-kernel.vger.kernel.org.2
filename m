Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AB8366BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbhDUNHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240857AbhDUNFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ADCB6144C;
        Wed, 21 Apr 2021 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010316;
        bh=uIwD9j9Rer4ZZY61rj5nY8c5JGTlapsGFBnHUQPBBbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OnywF1Zt8einKntUqoLw8ZXxuI0bJ8NbvLm7hYOKfQrO3H1lLhK9tLGVqNZb/Tdr6
         Wl7tMQqsEkIh1jVDzhKmsl6t1mPyH0aqByY/3rKJe/Ic06riDc9DpgBKEO0ph45nD/
         uCvoenXbEnnYjvk8igGFTitAoqup2ELZU3xDO/QI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 091/190] Revert "pinctrl: axp209: Fix NULL pointer dereference after allocation"
Date:   Wed, 21 Apr 2021 14:59:26 +0200
Message-Id: <20210421130105.1226686-92-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1adc90c7395742827d754a5f02f446818a77c379.

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
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-axp209.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 207cbae3a7bf..58f7149dd39b 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -365,8 +365,6 @@ static int axp20x_build_funcs_groups(struct platform_device *pdev)
 		pctl->funcs[i].groups = devm_kcalloc(&pdev->dev,
 						     npins, sizeof(char *),
 						     GFP_KERNEL);
-		if (!pctl->funcs[i].groups)
-			return -ENOMEM;
 		for (pin = 0; pin < npins; pin++)
 			pctl->funcs[i].groups[pin] = pctl->desc->pins[pin].name;
 	}
-- 
2.31.1


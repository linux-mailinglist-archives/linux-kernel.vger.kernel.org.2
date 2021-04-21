Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FE4366C46
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbhDUNNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241756AbhDUNJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B31761440;
        Wed, 21 Apr 2021 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010526;
        bh=g+lex5KcIa6oASUJQKykhsjhMMZgfqQQZKdIlq4EphA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXOiy3ApFXrr8Jl3M7tF6FDZMaJmasn9m76eALXP+eqmrNOlaSke6a7MB3k1dSmNB
         a30Cq40ryr0uVN6mQLADYcgWiEBUxTvXOdJ7trtVfHMsxi0ngMvO0kcG3+O8TjZent
         crKzJnu9QFaTQeHMf1p0HGwTeEn+7mh2CLqbKVyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 168/190] Revert "net: marvell: fix a missing check of acpi_match_device"
Date:   Wed, 21 Apr 2021 15:00:43 +0200
Message-Id: <20210421130105.1226686-169-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 92ee77d148bf06d8c52664be4d1b862583fd5c0e.

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
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 1767c60056c5..f1a70b37227f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7328,8 +7328,6 @@ static int mvpp2_probe(struct platform_device *pdev)
 	if (has_acpi_companion(&pdev->dev)) {
 		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
 					    &pdev->dev);
-		if (!acpi_id)
-			return -EINVAL;
 		priv->hw_version = (unsigned long)acpi_id->driver_data;
 	} else {
 		priv->hw_version =
-- 
2.31.1


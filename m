Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9A366C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbhDUNM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241595AbhDUNJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CA3B61490;
        Wed, 21 Apr 2021 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010507;
        bh=Xt7209rGwREThTcDv+SmGI3pQmUdWPuA4ZT4v2byidk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yjV0RH1U2lP/rqxPyeZbaqidUrYttAf6MoLTtTF5OyNsSE30NFWCYusujhVWiXbLF
         Jgt3SqIaKBr5sJLyBushNJ4zNUR3sQB9yIO2j1Tu2oH13MYkPnLHSdGhCUfK98tq8j
         v6GvoDVeKa5aP8p4KtHxtnC1ZwA7gl/v5PrRZs2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Sinan Kaya <okaya@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 162/190] Revert "dmaengine: qcom_hidma: Check for driver register failure"
Date:   Wed, 21 Apr 2021 15:00:37 +0200
Message-Id: <20210421130105.1226686-163-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a474b3f0428d6b02a538aa10b3c3b722751cb382.

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
Cc: Sinan Kaya <okaya@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/qcom/hidma_mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 806ca02c52d7..fe87b01f7a4e 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -418,8 +418,9 @@ static int __init hidma_mgmt_init(void)
 		hidma_mgmt_of_populate_channels(child);
 	}
 #endif
-	return platform_driver_register(&hidma_mgmt_driver);
+	platform_driver_register(&hidma_mgmt_driver);
 
+	return 0;
 }
 module_init(hidma_mgmt_init);
 MODULE_LICENSE("GPL v2");
-- 
2.31.1


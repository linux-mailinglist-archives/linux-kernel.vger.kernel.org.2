Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5504A366B86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbhDUNDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240246AbhDUNCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CA186144B;
        Wed, 21 Apr 2021 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010139;
        bh=fkWLEin4S5OkwzkSHiUCSkPpCMl/AS9bq7K44LL5cfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tj4KfKz0L3Exv0KvrI2J/3vNpllj9ya+Kh2utRQ250dsn4dVa9knBKoAzStLB4eRl
         u5WYhBZp3MYAYbQFyLqSgO5j5Ra3t/FyXueb/V/2T5g8zWWX7RwgJMJl10YIah5N+R
         QmU82o6l+6HkgHtuied81PKZ6GZEpcsWAUP+xoJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 026/190] Revert "usb: dwc3: pci: Fix reference count leak in dwc3_pci_resume_work"
Date:   Wed, 21 Apr 2021 14:58:21 +0200
Message-Id: <20210421130105.1226686-27-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2655971ad4b34e97dd921df16bb0b08db9449df7.

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
Cc: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 4c5c6972124a..0c0619f7b1a7 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -226,10 +226,8 @@ static void dwc3_pci_resume_work(struct work_struct *work)
 	int ret;
 
 	ret = pm_runtime_get_sync(&dwc3->dev);
-	if (ret) {
-		pm_runtime_put_sync_autosuspend(&dwc3->dev);
+	if (ret)
 		return;
-	}
 
 	pm_runtime_mark_last_busy(&dwc3->dev);
 	pm_runtime_put_sync_autosuspend(&dwc3->dev);
-- 
2.31.1


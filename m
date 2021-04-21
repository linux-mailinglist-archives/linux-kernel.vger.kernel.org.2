Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA47F366BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbhDUNJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241094AbhDUNHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:07:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DC4061455;
        Wed, 21 Apr 2021 13:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010397;
        bh=+wvQYNN3mheQSauFtd+crHc6s0cExTvPZFyP3t/D5Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0t5e2FqKIW5OdFy4PDj2MEGAlbbAH1eFQfc2soMtIavEC7s71O6eDEyrooBtoMiD
         1y7QxFyhXWU+0n70ATBzRtUe9gd9x+PsqO30PrRuXI53UG/I0bGtp9mrxgM3tMlnVf
         arggl6/LVEy8S888i0BGw+VJLoQPMjyvlX5552i8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 122/190] Revert "HID: logitech: check the return value of create_singlethread_workqueue"
Date:   Wed, 21 Apr 2021 14:59:57 +0200
Message-Id: <20210421130105.1226686-123-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6c44b15e1c9076d925d5236ddadf1318b0a25ce2.

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
Cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-logitech-hidpp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d459e2dbe647..cb73febbe893 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2547,13 +2547,6 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 		kfree(data);
 		return -ENOMEM;
 	}
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
-	if (!data->wq) {
-		kfree(data->effect_ids);
-		kfree(data);
-		return -ENOMEM;
-	}
-
 	data->hidpp = hidpp;
 	data->version = version;
 	for (j = 0; j < num_slots; j++)
@@ -2575,6 +2568,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 		hid_warn(hidpp->hid_dev, "Unable to create sysfs interface for \"range\", errno %d!\n", error);
 
 	/* init the hardware command queue */
+	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
 	atomic_set(&data->workqueue_size, 0);
 
 	hid_info(hid, "Force feedback support loaded (firmware release %d).\n",
-- 
2.31.1


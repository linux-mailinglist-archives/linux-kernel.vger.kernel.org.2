Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF81366B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbhDUNCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240175AbhDUNCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4AEE61464;
        Wed, 21 Apr 2021 13:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010121;
        bh=q81lHXn6JB9j4YllVdhBoBEjrSOPgbSC+nIjCcUca9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vRKDbm9Xc6T4p0ob4LQE8Mgyn6iayTVy09zrLPufmULv3DBR5Rb4IALj8Rzh6O7PT
         uVmC5dq4htgJ9zvG8lGPUT9UcpxTuSVYMrw86mVnDLa4Qqn9aWHYKgzmFwY/RADp2b
         36PGjvLlXTmhXZ8QYTffc6SHi8NQcXk7ZArep3iM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 020/190] Revert "PCI: Fix pci_create_slot() reference count leak"
Date:   Wed, 21 Apr 2021 14:58:15 +0200
Message-Id: <20210421130105.1226686-21-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8a94644b440eef5a7b9c104ac8aa7a7f413e35e5.

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

Cc: https
Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/slot.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index d627dd9179b4..c190e09af356 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -268,7 +268,6 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	slot_name = make_slot_name(name);
 	if (!slot_name) {
 		err = -ENOMEM;
-		kfree(slot);
 		goto err;
 	}
 
@@ -277,10 +276,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, NULL,
 				   "%s", slot_name);
-	if (err) {
-		kobject_put(&slot->kobj);
+	if (err)
 		goto err;
-	}
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
@@ -296,6 +293,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	mutex_unlock(&pci_slot_mutex);
 	return slot;
 err:
+	kfree(slot);
 	slot = ERR_PTR(err);
 	goto out;
 }
-- 
2.31.1


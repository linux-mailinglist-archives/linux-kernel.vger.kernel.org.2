Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019A4366C89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242869AbhDUNTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241050AbhDUNKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:10:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 482846145E;
        Wed, 21 Apr 2021 13:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010599;
        bh=Y672P6BbdL1h7x7HhN95ClrzKujkBDcMO0X0IK2Kaws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wu6v4WFoxNGSUKNfiuLxyPpjVloS2995W02z63F8/kRYLvRXr7hjHeGBPNrNstF8f
         Ix5TDB7K7thGMbbGoMkCeZQznANbGYr6JXB5Vt4JMeRmnQJpGlPn1KIXcvOO1Bqkpp
         Gd3nQgvaxNFKSi0u2nJMFejv9rwj+tJrADdV9+SU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 186/190] Revert "virt: vbox: Only copy_from_user the request-header once"
Date:   Wed, 21 Apr 2021 15:01:01 +0200
Message-Id: <20210421130105.1226686-187-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit bd23a7269834dc7c1f93e83535d16ebc44b75eba.

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

Cc: Wenwen Wang <wang6495@umn.edu>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/vboxguest/vboxguest_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 73eb34849eab..f5cd9cfa1ef6 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -142,9 +142,7 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
 	if (!buf)
 		return -ENOMEM;
 
-	*((struct vbg_ioctl_hdr *)buf) = hdr;
-	if (copy_from_user(buf + sizeof(hdr), (void *)arg + sizeof(hdr),
-			   hdr.size_in - sizeof(hdr))) {
+	if (copy_from_user(buf, (void *)arg, hdr.size_in)) {
 		ret = -EFAULT;
 		goto out;
 	}
-- 
2.31.1


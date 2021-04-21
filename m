Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70453366C81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbhDUNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241961AbhDUNJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7558B6144C;
        Wed, 21 Apr 2021 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010544;
        bh=kWGI08KQBeQdbPe5swrq2AflAvoSiJbrmwb1Bo9mr6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2FqtZwbmID9voRrNdFQjh1u9rTR/uJwdEEsO3TiFXzi9uj1dwX+5LZZN7h7EuZmSi
         B5ZXTQ5bpv5QCW0OV/P4l6HjHL7DxQEk1KqA7U8798uoIl4XSIBRz7Ntp/y7JnPsbL
         ji1Z/jUs3i01M9ns1Q2OaN/FkXXp3trqb93qx+Ic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Shannon Nelson <shannon.lee.nelson@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 173/190] Revert "niu: fix missing checks of niu_pci_eeprom_read"
Date:   Wed, 21 Apr 2021 15:00:48 +0200
Message-Id: <20210421130105.1226686-174-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 26fd962bde0b15e54234fe762d86bc0349df1de4.

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
Cc: Shannon Nelson <shannon.lee.nelson@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sun/niu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 707ccdd03b19..d70cdea756d1 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -8097,8 +8097,6 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
 		start += 3;
 
 		prop_len = niu_pci_eeprom_read(np, start + 4);
-		if (prop_len < 0)
-			return prop_len;
 		err = niu_pci_vpd_get_propname(np, start + 5, namebuf, 64);
 		if (err < 0)
 			return err;
@@ -8143,12 +8141,8 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
 			netif_printk(np, probe, KERN_DEBUG, np->dev,
 				     "VPD_SCAN: Reading in property [%s] len[%d]\n",
 				     namebuf, prop_len);
-			for (i = 0; i < prop_len; i++) {
-				err = niu_pci_eeprom_read(np, off + i);
-				if (err >= 0)
-					*prop_buf = err;
-				++prop_buf;
-			}
+			for (i = 0; i < prop_len; i++)
+				*prop_buf++ = niu_pci_eeprom_read(np, off + i);
 		}
 
 		start += len;
-- 
2.31.1


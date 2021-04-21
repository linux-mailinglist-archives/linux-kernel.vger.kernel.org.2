Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897A5366BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbhDUNFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240721AbhDUNEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C6846143B;
        Wed, 21 Apr 2021 13:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010246;
        bh=H2pJce2KP7UAPHvN+4v+sJafKZ5LNmgaqnLtIeULL5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9DFjm6f6PQpTnHGi63oNu0Rw3I25Np6Jvzdk4tALBGGyY5R1ZeW045sdgtgnRQeU
         8YHT8hJqV4Eh4bBmZxZgvlcR9kwgVpQa+Qv3UMHJ64aONR9jPnhS42IQkQ50xKRMuU
         m7ClAcYBGcXQl4H2zs9fHC9suwfMmOzos42DA5FQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 064/190] Revert "nfc: s3fwrn5: replace the assertion with a WARN_ON"
Date:   Wed, 21 Apr 2021 14:58:59 +0200
Message-Id: <20210421130105.1226686-65-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 615f22f58029aa747b12768985e7f91cd053daa2.

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
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/s3fwrn5/firmware.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index eb5d7a5beac7..f77f183c9bd0 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -492,10 +492,7 @@ int s3fwrn5_fw_recv_frame(struct nci_dev *ndev, struct sk_buff *skb)
 	struct s3fwrn5_info *info = nci_get_drvdata(ndev);
 	struct s3fwrn5_fw_info *fw_info = &info->fw_info;
 
-	if (WARN_ON(fw_info->rsp)) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
+	BUG_ON(fw_info->rsp);
 
 	fw_info->rsp = skb;
 
-- 
2.31.1


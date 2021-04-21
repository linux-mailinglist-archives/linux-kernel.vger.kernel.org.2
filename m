Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE2366C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbhDUNLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241379AbhDUNIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C59361457;
        Wed, 21 Apr 2021 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010460;
        bh=2xIl6TqYWNQSoir/V0aFZhxTGvsJ0dApCwdCMBj0h10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbeV7hJygd5LMBbMyqU7AEKEhawV5/ppP6OyrCiHXR9XJYO0UI880qQ6sUl0+cLSu
         06ivjYuycjzVtDDKe9HiwS0APS8Z1wVVqCTeKWZZJuj5R4O51n72m2SkH1DaiqEGaJ
         EGkjodFL22yuIH7lzx0QsV9x96TxTSBiFFOfdNYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 109/190] Revert "usb: sierra: fix a missing check of device_create_file"
Date:   Wed, 21 Apr 2021 14:59:44 +0200
Message-Id: <20210421130105.1226686-110-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1a137b47ce6bd4f4b14662d2f5ace913ea7ffbf8.

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
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/sierra_ms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
index b9f78ef3edc3..0f5c9cd8535f 100644
--- a/drivers/usb/storage/sierra_ms.c
+++ b/drivers/usb/storage/sierra_ms.c
@@ -190,6 +190,8 @@ int sierra_ms_init(struct us_data *us)
 		kfree(swocInfo);
 	}
 complete:
-	return device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
+	result = device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
+
+	return 0;
 }
 
-- 
2.31.1


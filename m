Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7100045A614
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbhKWO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:56:23 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:12591 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233112AbhKWO4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637679194; x=1669215194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KGXbfqWN+3ZQbqGsNObl01CTxD3yxm7UN4OpU43QcPI=;
  b=kedEf3bEKFqCnvEPolmsGzvHVwFTB1gaiu9e9X7N43xUnT1MD8Bfh5bQ
   4C3Q1A7WJF5WasSs1s1FgUgdYF0HSJTME39GDxs6F4m4A8RwB4G2Nr+kx
   iHKZttijQilmaW3PZc4LBhK4GR+oSslgv9uSg3UAM5I44S5bvfBwsL7Xu
   quhQQKO6bOKstsGpqX33IXsSyOPrbI50PNAgz6KIpT3h106pMoK6dsxPO
   q4TqYjGHKEd1ChrHXV5UYleRL9mJ753jnedu1TgQp3Zs2Tz71s4K1p9Gy
   Yj4Z7MzBC8awYKjuZMqa7JguROJKSFwZ7h97tgplGeqElhejyseF+5gpH
   g==;
X-IronPort-AV: E=Sophos;i="5.87,258,1631570400"; 
   d="scan'208";a="20626660"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 Nov 2021 15:53:12 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 23 Nov 2021 15:53:12 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 23 Nov 2021 15:53:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637679192; x=1669215192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KGXbfqWN+3ZQbqGsNObl01CTxD3yxm7UN4OpU43QcPI=;
  b=YyVX8yBHEP9BXNv/eudsfWaObmAGUlWpvXkNT3EERyywJR0HvUlelPZc
   DbLKET2fPrkGNrOwKQLo5ibM6BdBI9pzwDoEkQb0aHAAGCsZ8t3jIwT+f
   CGLXKQvgGdzZauO4JcqFsC32kYcQZmcRE+h3t7vq+hvEpqsyVQ++UgY9v
   DTQVApctoPtIze9VIJnN6PHbPtThbMRXb9OPaH2W/RERqZtPbgRE7wuVq
   CrMIUv7TdIE39dlrWOZ3cALKN2N9i5rcsAm0EDUzZPsYDpiw4mLZtECCf
   4hPb+jkg5/0NMtFzrDmuR6rUmeYtQZZyxy+k+58hePGthBiUjHJXJHXco
   w==;
X-IronPort-AV: E=Sophos;i="5.87,258,1631570400"; 
   d="scan'208";a="20626659"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Nov 2021 15:53:12 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 46A36280065;
        Tue, 23 Nov 2021 15:53:12 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] extcon: deduplicate code in extcon_set_state_sync()
Date:   Tue, 23 Nov 2021 15:53:01 +0100
Message-Id: <20211123145301.778629-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finding the cable index and checking for changed status is also done
in extcon_set_state(). So calling extcon_set_state_sync() will do these
checks twice. Remove them and use these checks from extcon_set_state().

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
I noticed this duplicated code while debugging an extcon related issue.
I do not know if it is allowed in the kernel to assume some behavior in
EXPORT_SYMBOL* functions, but as the two functions mentioned are in the
same source file it should be ok.
In the case it is not okay to assume some behaviour,
extcon_set_state_sync() is missing a check for !edev, like
extcon_set_state() does.

 drivers/extcon/extcon.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e7a9561a826d..a09e704fd0fa 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -576,19 +576,7 @@ EXPORT_SYMBOL_GPL(extcon_set_state);
  */
 int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id, bool state)
 {
-	int ret, index;
-	unsigned long flags;
-
-	index = find_cable_index_by_id(edev, id);
-	if (index < 0)
-		return index;
-
-	/* Check whether the external connector's state is changed. */
-	spin_lock_irqsave(&edev->lock, flags);
-	ret = is_extcon_changed(edev, index, state);
-	spin_unlock_irqrestore(&edev->lock, flags);
-	if (!ret)
-		return 0;
+	int ret;
 
 	ret = extcon_set_state(edev, id, state);
 	if (ret < 0)
-- 
2.25.1


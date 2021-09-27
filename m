Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4D4419338
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhI0Lip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234075AbhI0Lio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:38:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C1B560EFD;
        Mon, 27 Sep 2021 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632742626;
        bh=S53mQIgJmKuw8oAdVPMGibdAZq9B1XNWAEqUxJ18+bg=;
        h=From:To:Cc:Subject:Date:From;
        b=Co0Utw3xDXUni3n1X3K6LnsXERWQcHHvduRZWQRoxmHJePzRhYkDzOT6ovApqrmj0
         xuGJLgPVHkMBtowLerSvwwtD/1Cdm0RmdKmkLuYd16vEv1i0BqM6wPVmZm+uzEGyq/
         abFf0+tVJPE6qnOBvlGPtJlA3vtg8G8qT7T3blGam/XMwOGjO3fFclqa71ZHkVOqPZ
         1znJk2//wPEJg3eMoVrGSnQJdmqE2Y0UVTvIpumUitoy5vf79V8tMs4uP3xMQ9nUz2
         AyZE5EV0c2x4BgJ5NWWNoV0Tjn+jyuH8xb7m1ShoinYSomhTm3hu0fPwQR3mJ4pkDx
         rcA5yfykA5DLw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vc04_services: shut up out-of-range warning
Date:   Mon, 27 Sep 2021 13:36:56 +0200
Message-Id: <20210927113702.3866843-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The comparison against SIZE_MAX produces a harmless warning on 64-bit
architectures:

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:185:16: error: result of comparison of constant 419244183493398898 with expression of type 'unsigned int' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (num_pages > (SIZE_MAX - sizeof(struct pagelist) -
            ~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Shut up that warning by adding a cast to a longer type.

Fixes: ca641bae6da9 ("staging: vc04_services: prevent integer overflow in create_pagelist()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index b25369a13452..967f10b9582a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -182,7 +182,7 @@ create_pagelist(char *buf, char __user *ubuf,
 		offset = (uintptr_t)ubuf & (PAGE_SIZE - 1);
 	num_pages = DIV_ROUND_UP(count + offset, PAGE_SIZE);
 
-	if (num_pages > (SIZE_MAX - sizeof(struct pagelist) -
+	if ((size_t)num_pages > (SIZE_MAX - sizeof(struct pagelist) -
 			 sizeof(struct vchiq_pagelist_info)) /
 			(sizeof(u32) + sizeof(pages[0]) +
 			 sizeof(struct scatterlist)))
-- 
2.29.2


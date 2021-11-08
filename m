Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEE3447D96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbhKHKRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:17:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38262 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238546AbhKHKPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:06 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00EC81EC04EE;
        Mon,  8 Nov 2021 11:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S25eMXn6hpdZN3Pddzt03AvMdhzZdSwpbxmvL0Bmj8g=;
        b=lchuiTDtCzlrCJGlE1CQJhWUjXqHGyLvQaEflcOJUI21dZ4VLCUuy2RmeV1qVmriPJElqM
        1wNnTWv6jnCIYEwAke74gyYPPMP0yz09fbqbN/YUaksYBpnjEk/8sME2RHdeA+JPTXosaF
        qit42UU3/BaGsoG1uY3oOiSV3VshLQs=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v0 16/42] USB: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:31 +0100
Message-Id: <20211108101157.15189-17-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/core/notify.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/notify.c b/drivers/usb/core/notify.c
index e6143663778f..80d1bfa61887 100644
--- a/drivers/usb/core/notify.c
+++ b/drivers/usb/core/notify.c
@@ -28,7 +28,8 @@ static BLOCKING_NOTIFIER_HEAD(usb_notifier_list);
  */
 void usb_register_notify(struct notifier_block *nb)
 {
-	blocking_notifier_chain_register(&usb_notifier_list, nb);
+	if (blocking_notifier_chain_register(&usb_notifier_list, nb))
+		pr_warn("USB change notifier already registered\n");
 }
 EXPORT_SYMBOL_GPL(usb_register_notify);
 
-- 
2.29.2


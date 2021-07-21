Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08B43D0E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhGULNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:13:43 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37206
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238576AbhGUK7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:59:52 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E15553F231;
        Wed, 21 Jul 2021 11:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626867620;
        bh=EI6lWYDMKnKmAeOVCPHsH4FVwm1n7Ms3nflLoux8RE4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=Z9FGv0WSXpYmC2VTCH5El7pEp8Epr8RtEE+EReQlznQ91+QGw7ai0wUNzAlLY1psu
         uZzXyVkVVgFucpQ5ogILqQjdKZYos++nm8exzVvqPmS/aoUYYAtxpThK5Y4tNJWqk/
         L9F2k2kgN5PO33Xp4qHdNdddd6JdiYWT1wwvWm39P9MFZefK541n8Y/3SxzMV5Oael
         UaOQZkZDZhQhU5v1a/iFfYLxF4jhLCgwrPbQ1CK1tN7yPZOszTJn1XSLcq2ua04VS+
         MrvSpzS2+k1g0YKCTL0+/lhMkOT9ojfXaIybvs88b38F6caTTlglt3ndBsqKGu33p+
         ksh9axhikNL/A==
From:   Colin King <colin.king@canonical.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen/events: remove redundant initialization of variable irq
Date:   Wed, 21 Jul 2021 12:40:10 +0100
Message-Id: <20210721114010.108648-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable irq is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/xen/events/events_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index d7e361fb0548..154daddbdcb4 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1009,7 +1009,7 @@ static void __unbind_from_irq(unsigned int irq)
 int xen_bind_pirq_gsi_to_irq(unsigned gsi,
 			     unsigned pirq, int shareable, char *name)
 {
-	int irq = -1;
+	int irq;
 	struct physdev_irq irq_op;
 	int ret;
 
-- 
2.31.1


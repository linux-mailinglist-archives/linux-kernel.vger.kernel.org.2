Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B712406B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhIJMBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:01:38 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:33108
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232613AbhIJMBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:01:37 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EDC3340198;
        Fri, 10 Sep 2021 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631275224;
        bh=uBCGG54tKUGFtWWVoZuFFm7JRT/gA4rrE2H2EHpPDZM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=J5EuyL/+CWw5L3xaTcyKxzjcidpwr2fZ//FyZmkpXGM4QRjUzfd5Cd+v6ijB2oY/8
         5V7fHOT8IlhuCwVd/B6OCu1bhpeXsRx1u06zukuQNBYWWxUk+DjKtOKTtUMLR1Mvst
         vVbf/EEzI4P2nUV4KZa0ct3221BvcyHLjKdWnagzcZbZNKR8NvAdany7pEgvCM0YMA
         vm7dBvCPlHzlara0D/O4ksvtARSgARcjqMh/QK/uuQMgrPE3cBVW4vZMcPmRPn8NxC
         PFuFsFzUYr+gJhKWQTm42JLCZ6Klyo/Qywdvq1NzJm7KO84EEXdvZ8MzU4TTFzs4pa
         cRWXy3SG6MgeA==
From:   Colin King <colin.king@canonical.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: mtdswap: Remove redundant assignment of pointer eb
Date:   Fri, 10 Sep 2021 13:00:23 +0100
Message-Id: <20210910120023.46308-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer eb is being assigned a value that is never read, it is
being updated later on. The assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/mtdswap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index 7e309270ddd4..e86b04bc1d6b 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -716,7 +716,6 @@ static int mtdswap_move_block(struct mtdswap_dev *d, unsigned int oldblock,
 		return ret;
 	}
 
-	eb = d->eb_data + *newblock / d->pages_per_eblk;
 	d->page_data[page] = *newblock;
 	d->revmap[oldblock] = PAGE_UNDEF;
 	eb = d->eb_data + oldblock / d->pages_per_eblk;
-- 
2.32.0


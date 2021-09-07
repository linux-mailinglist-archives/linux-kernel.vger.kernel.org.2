Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2658402707
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbhIGKTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:19:39 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:49194
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245372AbhIGKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:19:38 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DDD163F04C;
        Tue,  7 Sep 2021 10:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631009910;
        bh=AOzGaLqMVON6gOAw8oKfQg6yGECJe/N3Saup0Kinv8s=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=m8ENZ8KbDNC1PrFPdM6wBfFZrRs1uI67+u1TFsT33+wOVxtgoxu1xJscqU0JU+QvR
         pJ1nms5hdWvIo0DkqNb7tiv/bRT1huHkj9MA4XlOQeCjTurxMNuBonjLoXvgxxqJKP
         hZgFKruezWpkGSbUifkbSKnJXFbJl7wpyl1d4ErNWujxMFSbOb92CJxapfQ5+FuBUP
         UQsXk6Za/1j020T+JEI3Ok7k2W90JkmyDLCDC2g07Y5BcHTMzwk27TI9HB2/vscWYj
         L6WJaYxx0hMsl9HsTj3+OhXiAYqc5vlYnjSXFMRpLw/6+KZtGLJhHZNLUBQsIOJXDJ
         aUUAueO3E9Tuw==
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pata_legacy: Remove redundant initialization of variable timing
Date:   Tue,  7 Sep 2021 11:18:30 +0100
Message-Id: <20210907101830.13736-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable timing is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/pata_legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index c3e6592712c4..bb5694ecdfba 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -815,7 +815,7 @@ static void winbond_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	struct legacy_data *ld_winbond = ap->host->private_data;
 	int active, recovery;
 	u8 reg;
-	int timing = 0x88 + (ap->port_no * 4) + (adev->devno * 2);
+	int timing;
 
 	reg = winbond_readcfg(ld_winbond->timing, 0x81);
 
-- 
2.32.0


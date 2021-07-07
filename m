Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7083BE916
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhGGN4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:56:49 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:46489 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhGGN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:56:48 -0400
Received: from mwalle01.kontron.local (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E8C7B22239;
        Wed,  7 Jul 2021 15:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625666046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=463I5Kn83G/zVB2GPiLeqFvap57D0rJfLHdECXpBuRE=;
        b=IV9HpANbPafhl3HpYqL3jLg8qQcVxE1vfNilaqpJl3wSUlbkC5wsU8tWz6WqhYH8daw6bX
        jTtuTCJCW9d6KMqcQPSpvkOQ93BsNuixhwFnbSPeeimwmrBiQSryiDcDuCd3KewXkqdedu
        Tnr5iCguAA4eJ6o6WELtm5uiBxljfXQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor.Ambarus@microchip.com, Michael Walle <michael@walle.cc>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] mtd: core: handle flashes without OTP gracefully
Date:   Wed,  7 Jul 2021 15:53:59 +0200
Message-Id: <20210707135359.32398-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are flash drivers which registers the OTP callbacks although the
flash doesn't support OTP regions and return -ENODATA for these
callbacks if there is no OTP. If this happens, the probe of the whole
flash will fail. Fix it by handling the ENODATA return code and skip
the OTP region nvmem setup.

Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
changes since v1:
 - move the check into mtd_otp_size()

 drivers/mtd/mtdcore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index b5ccd3037788..c8fd7f758938 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -806,7 +806,9 @@ static ssize_t mtd_otp_size(struct mtd_info *mtd, bool is_user)
 
 err:
 	kfree(info);
-	return ret;
+
+	/* ENODATA means there is no OTP region. */
+	return ret == -ENODATA ? 0 : ret;
 }
 
 static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
-- 
2.20.1


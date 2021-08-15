Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08BA3ECB81
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhHOVmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:42:39 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:56520
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230450AbhHOVmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:42:38 -0400
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net [80.193.200.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B70CF3F230;
        Sun, 15 Aug 2021 21:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629063726;
        bh=L2I5EZ00zkBPJC+2/pMrA/9sOe0DYIDewr3RggcL2KU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=VAtmGyNW5+RU01BlojdtMgA0FoKp/JmZMto8k+Un5moKcZ9bZsOKg1AoSfcwo7oBJ
         rJzlop2No8I1Gyxz0psVgXGHuzTAJVlwan4HooNNjKv8M9QO7wLIa7EPQX0GvKqSWj
         Oo89VMSY7xWaMD8raBS3iAkWAGy0dMAx1kUR0Rrin57bB/O7C/EnHLh1QvjN7RBxga
         IaGqStdgJWzt8ZdwqLcUuV+VdWSdNiXuNLejdFLYCI6z6KpUimhOay550EPzhZOAzt
         7v++sTqvHXAjkN6Fpbd+n4oxGMyVtDIp+fqCX59p1+w5Ho5ZqrbKt7GpkELrgoV5Na
         aD813CeTK8/0Q==
From:   Colin King <colin.king@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] misc: gehc-achc: Fix spelling mistake "Verfication" -> "Verification"
Date:   Sun, 15 Aug 2021 22:42:06 +0100
Message-Id: <20210815214206.47970-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_dbg debug message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/gehc-achc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
index 891d9a214454..02f33bc60c56 100644
--- a/drivers/misc/gehc-achc.c
+++ b/drivers/misc/gehc-achc.c
@@ -280,7 +280,7 @@ static int ezport_flash_compare(struct spi_device *spi, u32 address,
 	ret = memcmp(payload, buffer + 4 + 1, payload_size);
 	if (ret) {
 		ret = -EBADMSG;
-		dev_dbg(&spi->dev, "Verfication failure @ %06x", address);
+		dev_dbg(&spi->dev, "Verification failure @ %06x", address);
 		print_hex_dump_bytes("fw:  ", DUMP_PREFIX_OFFSET, payload, payload_size);
 		print_hex_dump_bytes("dev: ", DUMP_PREFIX_OFFSET, buffer + 4, payload_size);
 	}
-- 
2.32.0


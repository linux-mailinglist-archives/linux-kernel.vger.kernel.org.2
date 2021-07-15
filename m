Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F843CA05C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhGOOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:18:27 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:38330
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232422AbhGOOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:18:25 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 51FA64060A;
        Thu, 15 Jul 2021 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626358531;
        bh=1aBUOcNt/rV/wPjiRY8zFNCi9+ykUnRX/oOakeygs28=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=s7P5SVQN60dmPE3LbFAcywsxSFvaZND37ByGIVluTcWHGXuzZdJ961Be1EzRiPk5o
         mcdVsUw+wH6+hTPhAA/KYgkRUjYF1ZjYlxYzLIFtS/5kuS2JSIlMVpAPwQ2N211dME
         U26oeGokLL+QdUTvgNlovevfUNf9jwlL/lW2rKXV3h3BDAcgHdRhCJxwG351/8WPgJ
         SVvKn0e/QaSZZZzwM0GJnVUCGZZjf5JIIStxwcv5zRSqrecbij5kgtqmjfc+ykU9iq
         sIOmlDN3P3EPvU/JoNMTuccQO/hF51gfGxcAZa6NM54doY24vLzAJ9TuwHOB1MalPO
         GiAoXj/WJlOYA==
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: rt6245: make a const array func_base static, makes object smaller
Date:   Thu, 15 Jul 2021 15:15:31 +0100
Message-Id: <20210715141531.27672-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array func_base on the stack but instead it
static. Makes the object code smaller by 55 bytes:

Before:
   text    data     bss     dec    hex filename
   6422    3216      64    9702   25e6 drivers/regulator/rt6245-regulator.o

After:
   text    data     bss     dec    hex filename
   6303    3280      64    9647   25af drivers/regulator/rt6245-regulator.o

Reduction of 55 bytes

(gcc version 10.3.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/rt6245-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rt6245-regulator.c b/drivers/regulator/rt6245-regulator.c
index d3299a72fd10..cb22a207e9ff 100644
--- a/drivers/regulator/rt6245-regulator.c
+++ b/drivers/regulator/rt6245-regulator.c
@@ -144,7 +144,7 @@ static int rt6245_init_device_properties(struct device *dev)
 static int rt6245_reg_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct i2c_client *i2c = context;
-	const u8 func_base[] = { 0x6F, 0x73, 0x78, 0x61, 0x7C, 0 };
+	static const u8 func_base[] = { 0x6F, 0x73, 0x78, 0x61, 0x7C, 0 };
 	unsigned int code, bit_count;
 
 	code = func_base[reg];
-- 
2.31.1


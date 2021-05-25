Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA773902AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhEYNo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:44:28 -0400
Received: from www.zeus03.de ([194.117.254.33]:59598 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233155AbhEYNo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=bhV3YP72IjNVHNzEPafPtYj2MGU
        r+1tGwx1KjtHWfhE=; b=EsZMeqsKAzK2U24ygL7ndlGyRcj+miLZPhPxKmUXW1p
        yi2XvGtvOSvG6NE5UzBAxFYrjGh1jzX6yjtYT6ctc6SFdRIBUlEFVPu5xBIXxGFZ
        lO71e2tdsgh0wjUt/5GRBLHYjHgUBqiS6y5Td6xWBySq8JuRCwiqfVx+zyyg5UHU
        =
Received: (qmail 1269530 invoked from network); 25 May 2021 15:42:54 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 May 2021 15:42:54 +0200
X-UD-Smtp-Session: l3s3148p1@rrrTsyfDksAgAwDPXxHuALK7lyLF31aG
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Jonas <mark.jonas@de.bosch.com>,
        Hubert Streidl <hubert.streidl@de.bosch.com>,
        stwiss.opensource@diasemi.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mfd: da9063: propagate errno when I2C mode fails
Date:   Tue, 25 May 2021 15:42:43 +0200
Message-Id: <20210525134243.4003-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't hardocde EIO but use the obtained value.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mfd/da9063-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 783a14af18e2..4b7f707b7952 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -448,7 +448,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 					DA9063_TWOWIRE_TO);
 		if (ret < 0) {
 			dev_err(da9063->dev, "Failed to set Two-Wire Bus Mode.\n");
-			return -EIO;
+			return ret;
 		}
 	}
 
-- 
2.30.2


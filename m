Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD3348DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhCYKUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:20:31 -0400
Received: from m12-16.163.com ([220.181.12.16]:59704 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhCYKUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=VG5pv2GH8R52rludct
        6hPThVPq000PA+eCG5zTVpFZ8=; b=lNCJORMsqfxyz6ufstQVvB8PbIKTVysx/4
        TL4Oq6wh+B2MXJkA3Z9dJc6sDx7zEjigP4u4rCOOScpo8R24kVWi07E52GReB3Dq
        n7alQPVK+E3XSMxRvUIXPs6r/iiFhaU7V4g3LjaU11P6EDUvsf2iqabDZoS5mYHg
        zny8qmpu0=
Received: from bf-rmnj-02.ccdomain.com (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowAD3BFGyY1xgGRBqiQ--.42582S2;
        Thu, 25 Mar 2021 18:19:36 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        Jian Dong <dongjian@yulong.com>
Subject: [PATCH]  staging: greybus: fix fw is NULL but dereferenced
Date:   Thu, 25 Mar 2021 18:19:26 +0800
Message-Id: <1616667566-58997-1-git-send-email-dj0227@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: EMCowAD3BFGyY1xgGRBqiQ--.42582S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW8ZFyfWw13uFyfWrW3KFg_yoW8XrW5pF
        4UA3sFk3WrWa4Yqa45CFWDXFyrKFWxJrWxG348G3s5Jr4rZFnYqr1Utry3WF1fAFZ3Jw15
        Xanagr4Fq3WIyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7nYrUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/1tbiEBhg3V8YFVxYfwAAsc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Dong <dongjian@yulong.com>

 fixes coccicheck Error:

 drivers/staging/greybus/bootrom.c:301:41-45: ERROR:
 fw is NULL but dereferenced.

 if procedure goto label directly, ret will be nefative, so the fw is NULL
 and the if(condition) end with dereferenced fw. let's fix it.

Signed-off-by: Jian Dong <dongjian@yulong.com>
---
 drivers/staging/greybus/bootrom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
index a8efb86..0439efa 100644
--- a/drivers/staging/greybus/bootrom.c
+++ b/drivers/staging/greybus/bootrom.c
@@ -246,7 +246,7 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 	struct gb_bootrom_get_firmware_response *firmware_response;
 	struct device *dev = &op->connection->bundle->dev;
 	unsigned int offset, size;
-	enum next_request_type next_request;
+	enum next_request_type next_request = NEXT_REQ_GET_FIRMWARE;
 	int ret = 0;
 
 	/* Disable timeouts */
@@ -298,10 +298,10 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 
 queue_work:
 	/* Refresh timeout */
-	if (!ret && (offset + size == fw->size))
-		next_request = NEXT_REQ_READY_TO_BOOT;
-	else
+	if (!!ret)
 		next_request = NEXT_REQ_GET_FIRMWARE;
+	else if (offset + size == fw->size)
+		next_request = NEXT_REQ_READY_TO_BOOT;
 
 	gb_bootrom_set_timeout(bootrom, next_request, NEXT_REQ_TIMEOUT_MS);
 
-- 
1.9.1



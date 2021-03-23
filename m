Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EBD345DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhCWMRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:17:17 -0400
Received: from m12-12.163.com ([220.181.12.12]:41476 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhCWMQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6QZd+
        Qu0fIzv6FrkmEmhT2O1Vr/D3wWNz5LeNfDEykY=; b=aBnCPsqePEj/C83PjqBP4
        lLp7tKrL+h25sOzKlI9vawdHaaSe5xHJRvycFVYKIde7OsqNm1dH0p6QzgWOQ9tb
        x5xNou15pbRQudkkzQ9JYml388xmgTdMhre7C83AlErKXljpt3fzXlIHPqmrir8t
        03TDL2Or/iet0EPSPDUCN4=
Received: from caizhichao.ccdomain.com (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowAAXHrLH21lgfoN2WA--.9610S2;
        Tue, 23 Mar 2021 20:15:26 +0800 (CST)
From:   caizhichao <tomstomsczc@163.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Zhichao Cai <caizhichao@yulong.com>
Subject: [PATCH] sound/i2c: Simplify the return expression of snd_i2c_bit_sendbyte()
Date:   Tue, 23 Mar 2021 20:14:43 +0800
Message-Id: <20210323121443.1276-1-tomstomsczc@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAXHrLH21lgfoN2WA--.9610S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1xWryxAw1kXF1rKr17Jrb_yoWxZwc_Gr
        ykWw48WrW5XayYv3yfZrW5Zw47GF1DCrn2kF18Kw43Gay5Ww42qr18Gr929rykXr4F9Fy3
        Wr95Wr9xC39FvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnUl1DUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pwrp23prpvu6rf6rljoofrz/xtbBzR5eil0CPryz5AAAsN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhichao Cai <caizhichao@yulong.com>

Simplify the return expression.

Signed-off-by: Zhichao Cai <caizhichao@yulong.com>
---
 sound/i2c/i2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/i2c/i2c.c b/sound/i2c/i2c.c
index 847e3b6..dfcc87e 100644
--- a/sound/i2c/i2c.c
+++ b/sound/i2c/i2c.c
@@ -235,9 +235,7 @@ static int snd_i2c_bit_sendbyte(struct snd_i2c_bus *bus, unsigned char data)
 	for (i = 7; i >= 0; i--)
 		snd_i2c_bit_send(bus, !!(data & (1 << i)));
 	err = snd_i2c_bit_ack(bus);
-	if (err < 0)
-		return err;
-	return 0;
+	return err < 0 ? err : 0;
 }
 
 static int snd_i2c_bit_readbyte(struct snd_i2c_bus *bus, int last)
-- 
1.9.1



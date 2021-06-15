Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73243A7F91
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhFONah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:30:37 -0400
Received: from m12-13.163.com ([220.181.12.13]:50992 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhFONaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qs27p
        JeZ1mQL9K5taQuwUm0jcorZc4N6MuyH4mgHdZA=; b=ESGAdfqMZVyII+6Z1+StY
        THC0VBvpH9S2OYzs3kkIS8jA94HoAADUyKzGjKfw9OYfnvBu63YeQJOqwtRDkxyL
        7nlK0lgNbfA6yIqohpv6AUa87K8qBBJXgLQ5sCXa9+MdY59D42Mz0PKZgDUx8v5C
        Tr/w87c9E6NcwUv9lKck9Q=
Received: from yangjunlin.ccdomain.com (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowABne6ygqshgs5gvGg--.38926S2;
        Tue, 15 Jun 2021 21:26:58 +0800 (CST)
From:   angkery <angkery@163.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH] mfd: 88pm860x-core: Remove unneeded variable:"ret"
Date:   Tue, 15 Jun 2021 21:26:26 +0800
Message-Id: <20210615132626.1386-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABne6ygqshgs5gvGg--.38926S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF13JFW8tr4xXF1Dtw43Jrb_yoW8CF4kp3
        ZrWayjyrZ5Jw17Ww4DJryfur1akF48Kay8WF48Aasag3W5t39YkF1qgryUZF1rGF97GFWa
        y3y2qFyrCF4jyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jBc_-UUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/1tbixgKyI13bmh81XAAAs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

The variable "ret" is initialized to -EIO and then returned.
So remove the "ret" variable and return -EIO.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
 drivers/mfd/88pm860x-core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index b1e829e..1e69279 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -651,7 +651,6 @@ static void device_irq_exit(struct pm860x_chip *chip)
 
 int pm8606_osc_enable(struct pm860x_chip *chip, unsigned short client)
 {
-	int ret = -EIO;
 	struct i2c_client *i2c = (chip->id == CHIP_PM8606) ?
 		chip->client : chip->companion;
 
@@ -680,19 +679,18 @@ int pm8606_osc_enable(struct pm860x_chip *chip, unsigned short client)
 	}
 	mutex_unlock(&chip->osc_lock);
 
-	dev_dbg(chip->dev, "%s(A): vote=0x%x status=%d ret=%d\n",
+	dev_dbg(chip->dev, "%s(A): vote=0x%x status=%d\n",
 			__func__, chip->osc_vote,
-			chip->osc_status, ret);
+			chip->osc_status);
 	return 0;
 out:
 	mutex_unlock(&chip->osc_lock);
-	return ret;
+	return -EIO;
 }
 EXPORT_SYMBOL(pm8606_osc_enable);
 
 int pm8606_osc_disable(struct pm860x_chip *chip, unsigned short client)
 {
-	int ret = -EIO;
 	struct i2c_client *i2c = (chip->id == CHIP_PM8606) ?
 		chip->client : chip->companion;
 
@@ -721,13 +719,13 @@ int pm8606_osc_disable(struct pm860x_chip *chip, unsigned short client)
 	}
 	mutex_unlock(&chip->osc_lock);
 
-	dev_dbg(chip->dev, "%s(A): vote=0x%x status=%d ret=%d\n",
+	dev_dbg(chip->dev, "%s(A): vote=0x%x status=%d\n",
 			__func__, chip->osc_vote,
-			chip->osc_status, ret);
+			chip->osc_status);
 	return 0;
 out:
 	mutex_unlock(&chip->osc_lock);
-	return ret;
+	return -EIO;
 }
 EXPORT_SYMBOL(pm8606_osc_disable);
 
-- 
1.9.1



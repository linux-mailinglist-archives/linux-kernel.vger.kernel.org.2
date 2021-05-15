Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09330381B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 22:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhEOU4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 16:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhEOU4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 16:56:45 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB48DC061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 13:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DceUy+2NUnlC8ur/URFEkVm8PqULS5zh5pj+vzZYRL4=; b=UU1A8Js74rkX+Cal28SjjTTrfj
        IuzAb92N5bRe39OKkLcPvjeiEjAPCV3JmDbQHBiud8IZ1c3I2BtbH8P/cs6AS+IK7rrCxyoe5K/GK
        B8mxA2JvQcVj5IeiJkUQLrjIhpqblQoFLj7Pd9sSvUz0yInnFMs1ljVfQdq0xWMU2LRI=;
Received: from p200300ccff3902001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff39:200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1li1Jj-0005cR-Pt; Sat, 15 May 2021 22:55:24 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1li1Jj-0001Xi-FO; Sat, 15 May 2021 22:55:23 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, andreas@kemnade.info,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: [PATCH RESEND] mfd: rn5t618: fix IRQ trigger by changing it to level mode
Date:   Sat, 15 May 2021 22:55:18 +0200
Message-Id: <20210515205519.5884-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During more massive generation of interrupts, the IRQ got stuck,
and the subdevices did not see any new interrupts. That happens
especially at wonky USB supply in combination with ADC reads.
To fix that trigger the IRQ at level low instead of falling edge.

Fixes: 0c81604516af ("mfd: rn5t618: Add IRQ support")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/rn5t618.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index ecddd7b6500e..a852eef1f4d2 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -109,7 +109,7 @@ static int rn5t618_irq_init(struct rn5t618 *rn5t618)
 
 	ret = devm_regmap_add_irq_chip(rn5t618->dev, rn5t618->regmap,
 				       rn5t618->irq,
-				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				       IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 				       0, irq_chip, &rn5t618->irq_data);
 	if (ret)
 		dev_err(rn5t618->dev, "Failed to register IRQ chip\n");
-- 
2.29.2


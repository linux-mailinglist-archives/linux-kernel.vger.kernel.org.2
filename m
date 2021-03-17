Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B457233EA22
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhCQGyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:54:22 -0400
Received: from m12-13.163.com ([220.181.12.13]:56952 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhCQGxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PVCS6
        n9VBus/smtZ8Q5BMGAwKiM9f5C6Td+nDQPILAM=; b=d22513stYldqja3Btrdqo
        VwpqfTNZts7HR0M3OumPVTfejiS9qLK0dQkvp1NaUBLfJUliubwkg2FUtDPBi7k8
        u2cWt8xvCPdxjGbByl38ep1UG7qf0s4MUJvkBvzarWzn1qQNxsw6lKotxFdVRdn1
        NugmS+qGWTgsSeFLbzhPmM=
Received: from COOL-20200916KH.ccdomain.com (unknown [218.94.48.178])
        by smtp9 (Coremail) with SMTP id DcCowACnPV5xp1FgQVGhBg--.15356S2;
        Wed, 17 Mar 2021 14:53:43 +0800 (CST)
From:   qiumibaozi_1@163.com
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, ganjisheng <ganjisheng@yulong.com>
Subject: [PATCH 2/2] Fix spelling typo
Date:   Wed, 17 Mar 2021 14:53:45 +0800
Message-Id: <20210317065345.287-1-qiumibaozi_1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowACnPV5xp1FgQVGhBg--.15356S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr48AF13GFWDtF1kWFy8Krg_yoWfJFX_WF
        1rXrnIg3y2q3Z7Kr4xtF4jv34Fkr12gr4qgrs0yFna9FyFqr1fXFn7Zry5Ca97u3WUAFyk
        Jr9rK34SyFnFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeebyJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5tlxzxxedr6xjbr6il2tof0z/1tbiLRdY2FSIlT9HFAAAsf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ganjisheng <ganjisheng@yulong.com>

Signed-off-by: ganjisheng <ganjisheng@yulong.com>
---
 drivers/mfd/88pm800.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index c7f9649..4ffd9d2 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -285,10 +285,10 @@ static int device_gpadc_init(struct pm80x_chip *chip,
 		goto out;
 
 	/*
-	 * the defult of PM800 is GPADC operates at 100Ks/s rate
+	 * the default of PM800 is GPADC operates at 100Ks/s rate
 	 * and Number of GPADC slots with active current bias prior
 	 * to GPADC sampling = 1 slot for all GPADCs set for
-	 * Temprature mesurmants
+	 * Temperature measurements
 	 */
 	mask = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN1 |
 		PM800_GPADC_GP_BIAS_EN2 | PM800_GPADC_GP_BIAS_EN3);
-- 
1.9.1



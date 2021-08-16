Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2073ECD35
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 05:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhHPDVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:21:11 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:38982 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhHPDUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:20:51 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 99E9CD62E5;
        Mon, 16 Aug 2021 11:20:12 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P4989T139770959193856S1629084004780123_;
        Mon, 16 Aug 2021 11:20:06 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4d0f75539e9bc9660cee06c1899b5596>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: lgirdwood@gmail.com
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, ulf.hansson@linaro.org,
        lee.jones@linaro.org, zhangchangzhong@huawei.com, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 1/4] regulator: add PRE_ENABLE event define
Date:   Mon, 16 Aug 2021 11:20:00 +0800
Message-Id: <20210816032003.1162779-2-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816032003.1162779-1-jay.xu@rock-chips.com>
References: <20210816032003.1162779-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add REGULATOR_EVENT_PRE_ENABLE to allow to notify driver that the
regulator is about to enabled.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 include/linux/regulator/consumer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 20e84a84fb77..edd31f0dad17 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -102,6 +102,7 @@ struct regulator_dev;
  *                      Data passed is old voltage cast to (void *).
  * PRE_DISABLE    Regulator is about to be disabled
  * ABORT_DISABLE  Regulator disable failed for some reason
+ * PRE_ENABLE     Regulator is about to be enabled
  *
  * NOTE: These events can be OR'ed together when passed into handler.
  */
@@ -119,6 +120,7 @@ struct regulator_dev;
 #define REGULATOR_EVENT_PRE_DISABLE		0x400
 #define REGULATOR_EVENT_ABORT_DISABLE		0x800
 #define REGULATOR_EVENT_ENABLE			0x1000
+#define REGULATOR_EVENT_PRE_ENABLE		0x2000
 
 /*
  * Regulator errors that can be queried using regulator_get_error_flags
-- 
2.25.1




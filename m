Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D63ECD31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 05:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhHPDU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:20:56 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:59384 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhHPDUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:20:45 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 30A04CF700;
        Mon, 16 Aug 2021 11:20:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P4989T139770959193856S1629084004780123_;
        Mon, 16 Aug 2021 11:20:07 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c4f8c53f758bc9d3c8598cc53bfcec66>
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
Subject: [PATCH 2/4] regulator: core: notify regulator enable with the voltage value
Date:   Mon, 16 Aug 2021 11:20:01 +0800
Message-Id: <20210816032003.1162779-3-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816032003.1162779-1-jay.xu@rock-chips.com>
References: <20210816032003.1162779-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the voltage of regulator and then pass it as the parameter of
notify, the driver could take it.

The origin parameter for notify is NULL, so this patch do nothing effect
to other driver who not care about the voltage value.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/regulator/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f192bf19492e..a53f1644a6f4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2658,8 +2658,12 @@ static int _regulator_enable(struct regulator *regulator)
 			if (ret < 0)
 				goto err_consumer_disable;
 
+			ret = _regulator_get_voltage(rdev);
+			if (ret < 0)
+				ret = 0;
+
 			_notifier_call_chain(rdev, REGULATOR_EVENT_ENABLE,
-					     NULL);
+					     &ret);
 		} else if (ret < 0) {
 			rdev_err(rdev, "is_enabled() failed: %pe\n", ERR_PTR(ret));
 			goto err_consumer_disable;
-- 
2.25.1




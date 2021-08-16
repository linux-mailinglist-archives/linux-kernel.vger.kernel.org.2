Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A693ECD33
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 05:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhHPDVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:21:00 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:43226 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhHPDUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:20:51 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id CA67AB2B78;
        Mon, 16 Aug 2021 11:20:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P4989T139770959193856S1629084004780123_;
        Mon, 16 Aug 2021 11:20:08 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <0892698090bf98ad3edcbbcd00073b7d>
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
Subject: [PATCH 3/4] regulator: core: add pre-enable event notify to regulator
Date:   Mon, 16 Aug 2021 11:20:02 +0800
Message-Id: <20210816032003.1162779-4-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816032003.1162779-1-jay.xu@rock-chips.com>
References: <20210816032003.1162779-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify the event about regulator to be enabled to driver.

The IO-DOMAIN driver on Rockchip SoCs will take this event and then to
configure the io-domain mode before regualtor_enable.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/regulator/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a53f1644a6f4..0eb7af487931 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2654,6 +2654,9 @@ static int _regulator_enable(struct regulator *regulator)
 				goto err_consumer_disable;
 			}
 
+			_notifier_call_chain(rdev, REGULATOR_EVENT_PRE_ENABLE,
+					     NULL);
+
 			ret = _regulator_do_enable(rdev);
 			if (ret < 0)
 				goto err_consumer_disable;
-- 
2.25.1




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608043EE522
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhHQDjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:39:39 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:53178 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhHQDj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:39:27 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id C91E5D657D;
        Tue, 17 Aug 2021 11:38:52 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26933T140041124820736S1629171530026669_;
        Tue, 17 Aug 2021 11:38:53 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <67d7e864abf3b9b84a3879236bdf7c6c>
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
Subject: [PATCH v2 2/3] regulator: core: add pre-enable event notify to regulator
Date:   Tue, 17 Aug 2021 11:38:47 +0800
Message-Id: <20210817033848.1396749-3-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817033848.1396749-1-jay.xu@rock-chips.com>
References: <20210817033848.1396749-1-jay.xu@rock-chips.com>
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
v2: none

 drivers/regulator/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f192bf19492e..d7dacc608509 100644
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




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FE73EE51E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhHQDj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:39:29 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:53188 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhHQDj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:39:27 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 6B237D6584;
        Tue, 17 Aug 2021 11:38:53 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26933T140041124820736S1629171530026669_;
        Tue, 17 Aug 2021 11:38:53 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c1e31f59ea19769c91253998fd12f1ed>
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
Subject: [PATCH v2 3/3] soc: rockchip: io-domain: do more thing about regulator notify
Date:   Tue, 17 Aug 2021 11:38:48 +0800
Message-Id: <20210817033848.1396749-4-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817033848.1396749-1-jay.xu@rock-chips.com>
References: <20210817033848.1396749-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do a fix to rockchip io-domain, follow this orders:

* system running state
  -> io-domain vsel to 3.3V
    -> regulator_enable
      -> vsel change according to regulator voltage

* system running state
  -> io-domain vsel to 3.3V
    -> regulator_disable

Found on some Rockchip SoCs, the regulator enable or disable without
care about the io-domain maybe caused soc damaged.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
v2:
 - use "uV = regulator_get_voltage(supply->reg);" but from notify data
v1:
 - first version

 drivers/soc/rockchip/io-domain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
index cf8182fc3642..3c59077fafb1 100644
--- a/drivers/soc/rockchip/io-domain.c
+++ b/drivers/soc/rockchip/io-domain.c
@@ -123,6 +123,12 @@ static int rockchip_iodomain_notify(struct notifier_block *nb,
 	} else if (event & (REGULATOR_EVENT_VOLTAGE_CHANGE |
 			    REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE)) {
 		uV = (unsigned long)data;
+	} else if (event & REGULATOR_EVENT_PRE_ENABLE) {
+		uV = MAX_VOLTAGE_3_3;
+	} else if (event & REGULATOR_EVENT_PRE_DISABLE) {
+		uV = MAX_VOLTAGE_3_3;
+	} else if (event & REGULATOR_EVENT_ENABLE) {
+		uV = regulator_get_voltage(supply->reg);
 	} else {
 		return NOTIFY_OK;
 	}
-- 
2.25.1




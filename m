Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266D73EE51F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbhHQDjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:39:32 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:45872 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhHQDj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:39:27 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id DEFDEFB912;
        Tue, 17 Aug 2021 11:38:51 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26933T140041124820736S1629171530026669_;
        Tue, 17 Aug 2021 11:38:51 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7bdc27060b36dfdb4e9799efaee7136d>
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
Subject: [PATCH v2 0/3] regulator pre-enable
Date:   Tue, 17 Aug 2021 11:38:45 +0800
Message-Id: <20210817033848.1396749-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip io-domain care about regulator pre-enable

Jianqun Xu (3):
  regulator: add PRE_ENABLE event define
  regulator: core: add pre-enable event notify to regulator
  soc: rockchip: io-domain: do more thing about regulator notify

 drivers/regulator/core.c           | 3 +++
 drivers/soc/rockchip/io-domain.c   | 6 ++++++
 include/linux/regulator/consumer.h | 2 ++
 3 files changed, 11 insertions(+)

-- 
v2:
 - remove patch "regulator: core: notify regulator enable with the voltage value"
 - use "uV = regulator_get_voltage(supply->reg);" but from notify data
v1:
 - first

2.25.1




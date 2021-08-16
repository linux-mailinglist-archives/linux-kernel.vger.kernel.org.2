Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C307C3ECD32
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 05:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhHPDU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:20:58 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:43158 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhHPDUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:20:49 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 713E7B2C61;
        Mon, 16 Aug 2021 11:20:06 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P4989T139770959193856S1629084004780123_;
        Mon, 16 Aug 2021 11:20:06 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <2eb7ea09efe101ed92c78d230ebfab94>
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
Subject: [PATCH 0/4] regulator pre-enable
Date:   Mon, 16 Aug 2021 11:19:59 +0800
Message-Id: <20210816032003.1162779-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip io-domain care about regulator pre-enable

Jianqun Xu (4):
  regulator: add PRE_ENABLE event define
  regulator: core: notify regulator enable with the voltage value
  regulator: core: add pre-enable event notify to regulator
  soc: rockchip: io-domain: do more thing about regulator notify

 drivers/regulator/core.c           | 9 ++++++++-
 drivers/soc/rockchip/io-domain.c   | 6 ++++++
 include/linux/regulator/consumer.h | 2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.25.1




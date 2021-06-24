Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E793B2E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFXLts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:49:48 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:51062 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFXLtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:49:47 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 4939ED56A8;
        Thu, 24 Jun 2021 19:47:22 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1335T140034770458368S1624535240956933_;
        Thu, 24 Jun 2021 19:47:22 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8a73664a9ad95f5549fa13ac1c89dcab>
X-RL-SENDER: cl@rock-chips.com
X-SENDER: cl@rock-chips.com
X-LOGIN-NAME: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, zhangqing@rock-chips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, Liang Chen <cl@rock-chips.com>
Subject: [PATCH v1 0/3] arm64: dts: rockchip: add pmu and qos nodes for rk3568
Date:   Thu, 24 Jun 2021 19:47:16 +0800
Message-Id: <20210624114719.1685-1-cl@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

v1:
1. Document rk3568 compatible for pmu and qos nodes.
2. Add the power-management and qos nodes to the core rk3568 dtsi.

Liang Chen (3):
  dt-bindings: arm: rockchip: add rk3568 compatible string to pmu.yaml
  dt-binding: mfd: syscon: add rk3568 QoS register compatible
  arm64: dts: rockchip: add pmu and qos nodes for rk3568

 .../devicetree/bindings/arm/rockchip/pmu.yaml |   2 +
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 229 ++++++++++++++++++
 3 files changed, 232 insertions(+)

-- 
2.17.1




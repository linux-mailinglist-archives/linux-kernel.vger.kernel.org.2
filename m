Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54919347016
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhCXDYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:24:38 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:54866 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhCXDXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:23:30 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 9FCEEF3344;
        Wed, 24 Mar 2021 11:23:10 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13109T139929674307328S1616556189578495_;
        Wed, 24 Mar 2021 11:23:10 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <cdee19ffc678ee8e11142310d3e75f1e>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     robh+dt@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 0/3] soc: rockchip: power-domain: add rk3568 powerdomains
Date:   Wed, 24 Mar 2021 11:23:05 +0800
Message-Id: <20210324032308.6309-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support power domain function for RK3568 Soc.

Change in V3:
[PATCH v3 1/3]: No change.
[PATCH v3 2/3]: Fix up the code styles and add rk3568 base on:
https://patchwork.kernel.org/project/linux-rockchip/patch/20210225102643.653095-1-enric.balletbo@collabora.com/
[PATCH v3 3/3]: No change.

Change in V2:
[PATCH v2 1/3]: No change.
[PATCH v2 2/3]: Fix up yaml code styles.
[PATCH v2 3/3]: No change.

Elaine Zhang (3):
  dt-bindings: add power-domain header for RK3568 SoCs
  dt-bindings: Convert the rockchip power_domain to YAML and extend
  soc: rockchip: power-domain: add rk3568 powerdomains

 .../power/rockchip,power-controller.yaml      | 286 ++++++++++++++++++
 .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
 drivers/soc/rockchip/pm_domains.c             |  31 ++
 include/dt-bindings/power/rk3568-power.h      |  32 ++
 4 files changed, 349 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 include/dt-bindings/power/rk3568-power.h

-- 
2.17.1




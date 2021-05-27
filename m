Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5C5392984
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhE0I0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:26:45 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:58050 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbhE0I0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:26:42 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id C1137BA3FD;
        Thu, 27 May 2021 16:25:01 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32529T140357225019136S1622103895766083_;
        Thu, 27 May 2021 16:24:57 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e4b221734771537f262c1853334436a9>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     heiko@sntech.de, lee.jones@linaro.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, jbx6244@gmail.com,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH v2 0/3] rockchip io domain
Date:   Thu, 27 May 2021 16:24:50 +0800
Message-Id: <20210527082453.1447484-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Covert rockchip io domain document to YAML, and add rk3568 support.

Jianqun Xu (3):
  dt-bindings: soc: rockchip: convert io-domain.txt to YAML
  soc: rockchip: io-domain: add rk3568 support
  dt-bindings: soc: rockchip: add rk3568-pmu-io-domain support

 .../bindings/power/rockchip-io-domain.txt     | 135 ------------------
 .../bindings/soc/rockchip/io-domain.yaml      |  46 ++++++
 drivers/soc/rockchip/io-domain.c              |  88 ++++++++++--
 3 files changed, 126 insertions(+), 143 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/rockchip-io-domain.txt
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml

--
v2:
- add yaml
2.25.1




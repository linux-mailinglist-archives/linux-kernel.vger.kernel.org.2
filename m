Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528A9392997
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbhE0Iar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:30:47 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:34916 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbhE0Iao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:30:44 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id B8D3FAC981;
        Thu, 27 May 2021 16:29:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31748T140095126476544S1622104146775929_;
        Thu, 27 May 2021 16:29:10 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <1953f266d8f4e49cd1b138fe1e6ffe77>
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
Subject: [PATCH v2 3/3] dt-bindings: soc: rockchip: add rk3568-pmu-io-domain support
Date:   Thu, 27 May 2021 16:29:05 +0800
Message-Id: <20210527082905.1447591-4-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527082905.1447591-1-jay.xu@rock-chips.com>
References: <20210527082905.1447591-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for rk3568-pmu-io-domain.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
v2:
- first version
 Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml b/Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml
index 2931e0ea8fa8..debfcadd3f2f 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml
@@ -24,6 +24,7 @@ properties:
             - rockchip,rk3368-pmu-io-voltage-domain
             - rockchip,rk3399-io-voltage-domain
             - rockchip,rk3399-pmu-io-voltage-domain
+            - rockchip,rk3568-pmu-io-voltage-domain
             - rockchip,rv1108-io-voltage-domain
             - rockchip,rv1108-pmu-io-voltage-domain
 
-- 
2.25.1




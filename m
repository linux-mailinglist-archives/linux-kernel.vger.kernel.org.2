Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F4F367D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhDVJAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:00:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16490 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhDVJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:00:18 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FQrs91fgszrgC9;
        Thu, 22 Apr 2021 16:57:17 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 22 Apr 2021 16:59:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 2/3] dt-bindings: serial: pl011: Change to reference the kernel-defined serial.yaml
Date:   Thu, 22 Apr 2021 16:58:36 +0800
Message-ID: <20210422085837.513-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210422085837.513-1-thunder.leizhen@huawei.com>
References: <20210422085837.513-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /schemas/serial.yaml from dt-schema only has the property $nodename,
whereas the kernel-defined /schemas/serial/serial.yaml contains more
useful properties, support for more complex application scenarios.

For example:
1) The property "current-speed" in fsl-lx2160a.dtsi
2) The subnode "bluetooth" in hi3660-hikey960.dts

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/serial/pl011.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
index 1f8e9f2644b6..142187337c76 100644
--- a/Documentation/devicetree/bindings/serial/pl011.yaml
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Rob Herring <robh@kernel.org>
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
 
 # Need a custom select here or 'arm,primecell' will match on lots of nodes
 select:
@@ -103,7 +103,7 @@ dependencies:
   poll-rate-ms: [ auto-poll ]
   poll-timeout-ms: [ auto-poll ]
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.21.1



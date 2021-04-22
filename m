Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54213367D17
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhDVJAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:00:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17025 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbhDVJAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:00:17 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FQrrQ6WFZzPrBl;
        Thu, 22 Apr 2021 16:56:38 +0800 (CST)
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
Subject: [PATCH v2 3/3] dt-bindings: serial: Add label property in serial.yaml
Date:   Thu, 22 Apr 2021 16:58:37 +0800
Message-ID: <20210422085837.513-4-thunder.leizhen@huawei.com>
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

When there is more than one serial port present, the property 'label'
allows a custom name to be used for briefly describe the usage or position
of each serial port.

Without this "label" property, many dtbs_check warnings similar to the
following are reported:
arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dt.yaml: \
serial@ffd74000: Additional properties are not allowed ('label' was unexpected)
        From schema: Documentation/devicetree/bindings/serial/pl011.yaml

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 71aec7fda07d..04ec229cbb4f 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -23,6 +23,8 @@ properties:
   $nodename:
     pattern: "^serial(@[0-9a-f,]+)?$"
 
+  label: true
+
   cts-gpios:
     maxItems: 1
     description:
-- 
2.21.1



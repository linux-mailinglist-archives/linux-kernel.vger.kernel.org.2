Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDBB3CCC45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 04:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhGSCeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 22:34:16 -0400
Received: from mx.socionext.com ([202.248.49.38]:22293 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233713AbhGSCeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 22:34:14 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Jul 2021 11:31:14 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id ACA95205902A;
        Mon, 19 Jul 2021 11:31:14 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 19 Jul 2021 11:31:14 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6B030B633F;
        Mon, 19 Jul 2021 11:31:14 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 1/2] dt-bindings: nvmem: Extend patternProperties to optionally indicate bit position
Date:   Mon, 19 Jul 2021 11:31:03 +0900
Message-Id: <1626661864-15473-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626661864-15473-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1626661864-15473-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to extend expression of sub nodes to optionally indicate bit
position. This extension is needed to distinguish between different bit
positions in the same address.

For example, there are two nvmem nodes starting with bit 4 and bit 0
at the same address 0x54. In this case, it can be expressed as follows.

    trim@54,4 {
        reg = <0x54 1>;
        bits = <4 2>;
    };
    trim@54,0 {
        reg = <0x54 1>;
        bits = <0 4>;
    };

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index b8dc3d2..9dfe196 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -40,7 +40,7 @@ properties:
     maxItems: 1
 
 patternProperties:
-  "^.*@[0-9a-f]+$":
+  "^.*@[0-9a-f]+(,[0-9]+)?$":
     type: object
 
     properties:
-- 
2.7.4


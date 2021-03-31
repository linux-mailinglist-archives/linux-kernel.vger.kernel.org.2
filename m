Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2797B34FC73
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhCaJRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:17:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14974 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbhCaJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:16:38 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9LHB5cHdzyNLl;
        Wed, 31 Mar 2021 17:14:30 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 17:16:26 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 2/2] ASoC: dt-bindings: renesas, rsnd: Clear warning 'ports' does not match any of the regexes
Date:   Wed, 31 Mar 2021 17:16:16 +0800
Message-ID: <20210331091616.2306-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210331091616.2306-1-thunder.leizhen@huawei.com>
References: <20210331091616.2306-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if there are more than two ports, or if there is only one port
but other properties(such as "#address-cells") is required, these ports
are placed under the "ports" node. So add the schema of property "ports".

Otherwise, warnings similar to the following will be reported:
arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dt.yaml: \
sound@ec500000: 'ports' does not match any of the regexes: \
'^rcar_sound,ctu$', '^rcar_sound,dai$', '^rcar_sound,dvc$', ...

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index 384191ee497f534..a42992fa687d3f3 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -115,6 +115,11 @@ properties:
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false
 
+  ports:
+    patternProperties:
+      '^port@[0-9]':
+        $ref: "#/properties/port"
+
 # use patternProperties to avoid naming "xxx,yyy" issue
 patternProperties:
   "^rcar_sound,dvc$":
-- 
1.8.3



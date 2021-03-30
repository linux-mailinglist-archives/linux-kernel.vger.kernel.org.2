Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111B134DEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhC3DHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:07:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14953 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhC3DGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:06:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8Z6z5BWvzyNB3;
        Tue, 30 Mar 2021 11:04:43 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 11:06:40 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 1/2] ASoC: dt-bindings: renesas, rsnd: Clear warning 'dais' is a required property
Date:   Tue, 30 Mar 2021 11:06:30 +0800
Message-ID: <20210330030631.2253-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210330030631.2253-1-thunder.leizhen@huawei.com>
References: <20210330030631.2253-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I do dt_binding_check, below warning is reported:
Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: \
sound@ec500000: 'dais' is a required property

I looked at all the dts files in the "arch/arm64/boot/dts/renesas/"
directory, I found that all nodes that contain the "dais" property have
compatible string: "audio-graph-card". So I can be sure that the
"$ref: audio-graph.yaml#" should be corrected to
"$ref: audio-graph-card.yaml#".

In addition, not all nodes have compatible string "audio-graph-card", so
the "$ref: audio-graph-card.yaml#" should be described as "anyOf". To
ensure the validation of "anyOf" always passes, group it with the "if"
statement, because the result of the "if" statement is always not empty.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index 2e1046513603ed0..487aeabd1f0e65b 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -256,8 +256,10 @@ required:
   - "#sound-dai-cells"
 
 allOf:
-  - $ref: audio-graph.yaml#
   - $ref: audio-graph-port.yaml#
+
+anyOf:
+  - $ref: audio-graph-card.yaml#
   - if:
       properties:
         compatible:
-- 
1.8.3



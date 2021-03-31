Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02E134FC72
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhCaJRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:17:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14975 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbhCaJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:16:38 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9LHB574HzyNLX;
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
Subject: [PATCH v2 1/2] ASoC: dt-bindings: renesas, rsnd: Clear warning 'dais' is a required property
Date:   Wed, 31 Mar 2021 17:16:15 +0800
Message-ID: <20210331091616.2306-2-thunder.leizhen@huawei.com>
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

When I do dt_binding_check, below warning is reported:
Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: \
sound@ec500000: 'dais' is a required property

I looked at all the dts files in the "arch/arm64/boot/dts/renesas/"
directory. However, the dts node of this driver does not reference any
property in file audio-graph.yaml. This can be proved to be true, because
after I deleted "$ref: audio-graph.yaml#", the old 'dais' warnings are
cleared, and no new warning are generated.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index 1e0e14e889133b8..384191ee497f534 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -258,7 +258,6 @@ required:
   - "#sound-dai-cells"
 
 allOf:
-  - $ref: audio-graph.yaml#
   - if:
       properties:
         compatible:
-- 
1.8.3



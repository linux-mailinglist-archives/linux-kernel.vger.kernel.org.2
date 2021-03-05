Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DC932F6C1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCEXpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:45:17 -0500
Received: from smtpcmd02102.aruba.it ([62.149.158.102]:55336 "EHLO
        smtpcmd15177.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229592AbhCEXoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:44:39 -0500
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IK7Ql1dnx4WhhIK7aloTIZ; Sat, 06 Mar 2021 00:44:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1614987879; bh=P2eDRpOPoLDBZphurFRNJe+CzBEnh2dDJ2gk+Ji/8O0=;
        h=From:To:Subject:Date:MIME-Version;
        b=EL0PnI4B/iNEayD5sP4LqScM9oCmHX7yQx4rBcDLqXX3PhiLT5O+NpC0KsAcqFUIm
         1jD68RKredeIgfFq5P8UIZahQZbB24LSURwTBx0uACn5ODPTgxra6utBF7SVtIMKrj
         0Hqgybww5ZwjBKg2vRnpfDO+aWYGASHiB8J7RcR9O+RyzeAth1agQQXcSE9zanl537
         iojBysyZd96BlN4ZcnaQeRN0cacNTjaSDvfJQKQN40FgYGvqZL5LyhsZCsSJI2LhSb
         og/t/uw9yKpCFbBAMOCVme9yaTJyNhGO3iuzln9D1PE7B/ZBvaqJ/GRnIgi4M3AjZI
         Seke/alVk1foA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Daniel Palmer <daniel@0x0f.com>, allen <allen.chen@ite.com.tw>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v2 3/9] dt-bindings: display/panel: add Jenson JT60248-01
Date:   Sat,  6 Mar 2021 00:44:20 +0100
Message-Id: <20210305234427.572114-4-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
References: <20210305225444.GA792026@robh.at.kernel.org>
 <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHxsbX5aOZd/fJk9/zmrUoTl5zVu1P7dQ81+Mh8ypJLK+KsU96L9GpuNFxo37uF8yMvMJTJIm8cyEdeL7r6TOZWekbqQWEdv12O18PElNZZmbPH/Esjo
 cqBgrcrMt7m/YiFu4CzOAdHILW6Jc+pbMKrGKPuSUr13AqJeUSBAKEKDcjhFLzooezF2u3g9QUkObm3JzQzdTfLeFqgSfMZ0U+ERIcBTpR34rKwviVs+v1vK
 fwerPg9kb50kRFaeq1CaOa72WMpDlosUxbuTetQiUznsld4he9sZ6x6lF8HFBUEsrzLaWEN688LtgxmMwmLPNsfHcXtTgUqE7bmdoq+qwrWffKJa31sSbh/W
 GF7cM7tzWwZ3qwUb5TQ7ZKcY+sZES8DLCqnNwq/0JfOqyqAURbuLWasM4n3TjHhZpie+FEMtbAxNgMsz7PehcSqpwtu4vyyusYAhV4Tz//mDDMc5Bkpoy3Ia
 kBMEKBl39s0OES2skJOyyLb3dh/2nEBlSkEa0fTxwlMAcXFiDf/oy8arseNIABuohRFsU65e+5o0Wq9L7P5vEVQWA2aBbwlN+spmzf3duQ+xyhy9x6zCxyx5
 3h2vRofhAyupKxWBKkvK8MAtJpqJa4iTQ/8Em9GUzpR1JYguBGVh8LdTobCAb/W/F9+onAWeq6foOd7Z1heNULYUpDSMeDqoe5+rKvrEX78Bj+JZZ+ws006o
 hsYc0kpdnUUNPtFPq20TdOb+wSafSeBs43gAYQLhWDQwDF/1KDb7SQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

Add DT binding for "jenson,jt60248-01".

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index ce41a589a3f4..35c335aa085e 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -170,6 +170,8 @@ properties:
       - innolux,zj070na-01p
         # Jenson Display JT60245-01 7" (800x480) TFT LCD panel
       - jenson,jt60245-01
+        # Jenson Display JT60248-01 4,3" (480x272) TFT LCD panel
+      - jenson,jt60248-01
         # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
       - kingdisplay,kd116n21-30nv-a010
         # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
-- 
2.25.1


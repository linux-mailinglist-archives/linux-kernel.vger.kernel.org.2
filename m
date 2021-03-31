Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB834F981
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhCaHLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:11:45 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60509 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbhCaHLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:11:34 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12V7Aqu36002573, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 12V7Aqu36002573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 31 Mar 2021 15:10:52 +0800
Received: from localhost.localdomain (172.22.102.1) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 15:10:51 +0800
From:   Jack Yu <jack.yu@realtek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <lars@metafoo.de>,
        <flove@realtek.com>, <kenny_chen@realtek.com>,
        <kent_chen@realtek.com>, <oder_chiou@realtek.com>,
        <shumingf@realtek.com>, <derek.fang@realtek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] dt-bindings: sound: add address-cells and size-cells information
Date:   Wed, 31 Mar 2021 15:10:46 +0800
Message-ID: <20210331071046.12526-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add address-cells and size-cells information to fix warnings
for rt1019.yaml.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt1019.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt1019.yaml b/Documentation/devicetree/bindings/sound/rt1019.yaml
index c24c29eafa54..3d5a91a942f4 100644
--- a/Documentation/devicetree/bindings/sound/rt1019.yaml
+++ b/Documentation/devicetree/bindings/sound/rt1019.yaml
@@ -26,6 +26,8 @@ additionalProperties: false
 examples:
   - |
     i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
         rt1019: codec@28 {
             compatible = "realtek,rt1019";
             reg = <0x28>;
-- 
2.29.0


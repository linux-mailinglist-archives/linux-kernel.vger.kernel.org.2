Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD31832F6C3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCEXpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:45:19 -0500
Received: from smtpcmd02106.aruba.it ([62.149.158.106]:55112 "EHLO
        smtpcmd15181.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229714AbhCEXom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:44:42 -0500
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IK7Ql1dnx4WhhIK7cloTJc; Sat, 06 Mar 2021 00:44:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1614987880; bh=Uh/MerCqx7HNuMLAo6nGs7yP+j4R6Ys7RlV/zXgdgmU=;
        h=From:To:Subject:Date:MIME-Version;
        b=Xja8i3sEYwwAmkgULT9CAj64ojcs8+5mTU9ySl8J98hpTrw9zHhxnPoFi+STej77D
         hSep3U8sww5fJVT+xvdeb35gnmkQ+E6D26fW1CU8aFlHDSC9LJwsBsbl12daRTvGMD
         46/BVD9LOeIFnXUiAOGXR/baBIQhPTKe1J6FBD8LCuu+1phWv+Xpb3zck4V8JhH9En
         lNYHYRjNvf4Jb0YFMs7ppnUymd563ONuX46dv9WAkWLh9EEEWNJ6hitjHVPWocxKjQ
         yT5hb1uj4I+7W0pgl4wmWaGpmeA8X1zcZ7QJslkCmk+GRZpONGrxJi59W2LnTwWtmT
         4ppdVbOi/mBtw==
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
Subject: [PATCH v2 5/9] dt-bindings: display/panel: add Jenson JT60250-02
Date:   Sat,  6 Mar 2021 00:44:22 +0100
Message-Id: <20210305234427.572114-6-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
References: <20210305225444.GA792026@robh.at.kernel.org>
 <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBPnTCRO2tni6GZimRTXr+kZhTaph+UMU0bmZ1fUu8zNDIXmgEmGpkfMIlcKnMZ5gLnh2q8OLhAtoTRGrP+3kwE0byFBHm9d4drxoYOZOFD6DqnOu807
 tEfGK7F2Eyg4QUExJ1C/U48mdr2ZqCHw//Vu1nxZdehYnq/2KQEf+QLf38cR9H0biDaDCGtiMOI63bGYWUnfHVCJqb5ociglI3aR0/xnMQ6Ozc5t1yUfFJcN
 NRt33LnoLpmqryU50t1j1jsz1BG/Rcwtb6MhUsgNoquEqT9wfpiExzsoMM6JMGErU1cXZl+xDO+SkLBLCcGa1Us8KpgBCZXnT2HqOIWs3CrzBJBdtqzd+kFW
 rBnOzUDJj1TsI8Dnv6buyo4A+LeuFqF4x8oOKTVHF39J/4p/usB3snNUZCCRtT0sLk715JpYpRBMgSq5N7xxxVL3VYF/Ngo7B5EF2B0ZqyylrDzNsYM8nC98
 XvT2CedIgshkc/R7dXPyDd6f+a2yghtbqpDk/JspcstEUasA19k7K6uVMWMw92ulNFDjNXVNXBA5yJnaKvPoaHn7ZApawxw2oZ7HpYkmFEYI6drriqfQqFcq
 KmuD7x8beFmGruJ1Lud2SJa9eBUJjyi7ucL7OZ520KcMG+LQvEsDOCi4dW4rF7rR/AJKYq2lNNJtVDLVnE3wA003R4gQdXT8v57McG/8gIOMvhAMPelYEIkR
 7j453ueNdnOXImr5WRnWOKCsQodZkU8Sn21G2yIOmJjTlg+8bLb3aQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

Add DT binding for "jenson,jt60250-02".

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 68eaa353be0d..cd2f4421de7e 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -174,6 +174,8 @@ properties:
       - jenson,jt60248-01
         # Jenson Display JT60249-01 5" (800x480) TFT LCD panel
       - jenson,jt60249-01
+        # Jenson Display JT60250-02 10.1" (1024x600) TFT LCD panel
+      - jenson,jt60250-02
         # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
       - kingdisplay,kd116n21-30nv-a010
         # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
-- 
2.25.1


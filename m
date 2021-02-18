Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAEC31F2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBRW5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:57:00 -0500
Received: from smtpcmd0991.aruba.it ([62.149.156.91]:43637 "EHLO
        smtpcmd0991.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhBRW4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:56:42 -0500
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id CsCZl9zcdJFRNCsCqlTfSq; Thu, 18 Feb 2021 23:55:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1613688933; bh=xbrdgKWA9weotOeXTke9i6mSPyW7p+KSPNkV4aWdNhg=;
        h=From:To:Subject:Date:MIME-Version;
        b=itxpif0VsJTqGvZK2Ja6IQOjc69Ehb1sNygiSu/ZAq8PpGGi5qaDXgu4qWWysGwls
         YgEXb74SssPQaPu4ru1pBXw06KnUPnkpGws/vNNV/cL4Uozw2Ml5z5zCkAbEIBz5OZ
         HsclvNZUG1toTYo2CdZ+iwpPEOuSxB4/5Ht2p77UWKa8v982VUOth4XiJ6J+eV7s8S
         vdNqesz9FU7jiwDumqkZlhc2j2FQLIwhWLqff2Wui9JbsS8fcBwrhWiAPRD+OODygH
         qv45t/+Ge5xX2BtUnmRKifUJiyDj5BQEeTxtaN0mIKUYfBn6jYhKEkuZDzqMC8A3zE
         Mo08u3JvxAi3g==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Max Merchel <Max.Merchel@tq-group.com>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] dt-bindings: display/panel: add Jenson JT60250-02
Date:   Thu, 18 Feb 2021 23:54:53 +0100
Message-Id: <20210218225458.823773-6-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
References: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJWGlmAkWqZcf7vKKwws/H4t4c1ZiSdJy2weMlSZU3SVPDlGLCna40sBILrngF2bi7CW2FjKuSWJV7LRgpgezRHBaD6dxlZijtJcn+xkpMDWAx+bMcjw
 74rDi25kUW1TBdtrlcGP0R2PFO0DHt9EiDpKCF732sob6tmuHXMYAeWwKpwQcfhwxX5DNLBCQ+ns25dEgrkkTHaMRaRCKVVZ8wf0KMYHoIJvKZDK3LunFvpa
 WW0Tm/yf4q8fLKhMKHuVooPTeKgQmNj2nGa6/PiZ1Z1c3kG0ZauSZalUbl3TwMKeNNk6w2DDTJ24GdoXydi2xNxGzlCzyMqvrFACvXUz+STkPYKYCZ9Jhebe
 WKWfIspHwsiwyTGA5AOFL97x/nomuA++27bKLvr1/Z0QudQaaMJOdHGTc4OGZnqBcGE+ek5pQYDO09ft6yo5WWKXCJS0BCtVpKQxlY+kcnFs0uzB8HW0ZHCd
 U/EBacmfHy9rz2H2ICnqeVu9ET3NAmJZHCpXkDnXUJ9qMKdS+BjB5N5cZ8hco4w+nSulLOc8pNu4UqibQoHhqGRqvP6fNq44NzyIx4tISFBarcHZCnLUC3q8
 5z3pxvoQI8PuMn7sCHPGCzYZwQMdKFqpZArMDtd287Yy4Wl7WVyZaSPaMrbJHvmu+oeibbwhcDWKvmwxf3Hg9EYedWA6tGlflKqY2tfZnwVaelrfMOt9mCjN
 d32dOVyHh+FKHPzss5qV+pC0OHC90ZqRzxFukO67dPb3jq7Ae0W2xpNL2ITe/JIKHCbanFj9v3NRmns9wJAmSzGZFzI8yS1ubWq9VOoioWBnPiuyuLgx4g==
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

Add DT binding for "jenson,jt60250-02".

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index fd0d2a573350..a3edf313be54 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -171,6 +171,8 @@ properties:
       - jenson,jt60249-01
         # Jenson Display JT60245-01 7" (800x480) TFT LCD panel
       - jenson,jt60245-01
+        # Jenson Display JT60250-02 10.1" (1024x600) TFT LCD panel
+      - jenson,jt60250-02
         # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
       - kingdisplay,kd116n21-30nv-a010
         # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
-- 
2.25.1


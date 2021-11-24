Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9AC45C92D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346478AbhKXPyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:54:39 -0500
Received: from ixit.cz ([94.230.151.217]:34952 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240826AbhKXPyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:54:37 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 4C34A20064;
        Wed, 24 Nov 2021 16:51:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1637769083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IU5q06TQT1C9vzgb5Uz3GHm36Avlp6WLGrtHyJxiET4=;
        b=MIAJzKFXWT+bddlCrj3j5q0t8K83XBjdckPE/hJOBahw4KDwUAiZHmISMLgX32ZqTXSPsA
        M83GTfm7Sqad5USsi9YjW3fet+mXohuIDqTMJmsmyXOS9nOhO/sewovr/QngCLH/ZsIyjg
        jJ1K4T57qYNJBHrK2ry1Z1vfK8el6sc=
From:   David Heidelberg <david@ixit.cz>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        - <patches@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: wlf,wm8962: add missing interrupt property
Date:   Wed, 24 Nov 2021 16:51:01 +0100
Message-Id: <20211124155101.59694-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both, hardware and drivers does support interrupts.

Fix warnings as:
arch/arm/boot/dts/tegra30-microsoft-surface-rt-efi.dt.yaml: audio-codec@1a: 'interrupt-parent', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /home/runner/work/linux/linux/Documentation/devicetree/bindings/sound/wlf,wm8962.yaml

Fixes: cd51b942f344 ("ASoC: dt-bindings: wlf,wm8962: Convert to json-schema")

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/sound/wlf,wm8962.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8962.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8962.yaml
index 0e6249d7c133..5e172e9462b9 100644
--- a/Documentation/devicetree/bindings/sound/wlf,wm8962.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8962.yaml
@@ -19,6 +19,9 @@ properties:
   clocks:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
   "#sound-dai-cells":
     const: 0
 
-- 
2.33.0


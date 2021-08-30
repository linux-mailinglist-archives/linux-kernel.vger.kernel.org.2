Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA063FB414
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhH3KtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:49:15 -0400
Received: from dnyon.com ([82.223.165.189]:56230 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236436AbhH3KtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:49:10 -0400
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id 96F4F40457;
        Mon, 30 Aug 2021 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630320495; bh=usbyNj5IeNgrsk3Uei98GMZEnx/QqhyJ1XLt49/UCGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkt2/RzF2mL2OXMF+k91W9z1erWHWMyIFDAhMzrhqAd4RnpKahO7Dd4X+QpEZhKzH
         xbov3MDY8icOFZc5hqjEoyYr02y19Ej3raIxKxvk0wEQcikdeozfhjipLDaOamcDH8
         Y1AfDdyvuHUlKr+hvfF4M1T60jYFluwNg6vNCN+G2VgBf1bdhaR8iFyWX6/Yu+9y1w
         U/xSCZsPEsJWTFeP9lYRk3D6mwxTB/imBX+YQqTB8hKdaBiQzPr3MKx/6Wqz8uzuwU
         maUsej44S47n/Vdzhjn3/qnJk3pFCUS9U1hz3gFeinb6reQG90g3ZFK7i/tuLUZXZs
         dXK6m9ywqrf9Q==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: sound: max98927: Add reset-gpios optional property
Date:   Mon, 30 Aug 2021 12:44:24 +0200
Message-Id: <20210830104426.487246-3-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210830104426.487246-1-atafalla@dnyon.com>
References: <20210830104426.487246-1-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset-gpios as an optional property because some devices might
not need it to work properly.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/max9892x.txt b/Documentation/devicetree/bindings/sound/max9892x.txt
index f6171591ddc6..98cb9ba5b328 100644
--- a/Documentation/devicetree/bindings/sound/max9892x.txt
+++ b/Documentation/devicetree/bindings/sound/max9892x.txt
@@ -30,6 +30,9 @@ Required properties:
 
   - reg : the I2C address of the device for I2C
 
+Optional properties:
+  - reset-gpios : GPIO to reset the device
+
 Example:
 
 codec: max98927@3a {
-- 
2.32.0


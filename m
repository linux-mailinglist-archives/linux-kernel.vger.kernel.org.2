Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ABD3FF8BB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347102AbhICBwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 21:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347254AbhICBwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 21:52:40 -0400
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E06C061575;
        Thu,  2 Sep 2021 18:51:41 -0700 (PDT)
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id 32CCF40487;
        Fri,  3 Sep 2021 01:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630633899; bh=mcwX7Miz5TrtHPejHmXNGJzxpaa4beQjg0TVC4MXFPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJpeUgZwzCOtQsHa8UiD74DoTmY7z1QKEpUoLkzfSNsQNPNIuQ6pwvPIZxmr6Z+Hv
         SRQO6mteBd9vp2aLTtZ7cOUWXidwjZulAT+oQtFB6B8Uwz3r1zQ6+x0rFwk8ehfLVr
         IjxR4pcbDjkcu6U5IKaFOnNR5hXQ4BRv/p/+k5TF6bNVVKBagHC1mwvs4HpHrtNpCg
         pWFr8cVV4wXa3dQv+hqWPtQOb+v57lyonLZ6WsGC9JAygs0Glr8SdDg58sugOZFybp
         QfmS/B98kN2EUAdWFCneAG7/nJ/mbbXQjZQFBi+MlndhHBMafi3GfNDeWKgypBqhHN
         ZgfS9CSe2Yu3A==
From:   Alejandro <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: sound: max98927: Add reset-gpios optional property
Date:   Fri,  3 Sep 2021 03:49:51 +0200
Message-Id: <102ae6df3b5398e8c66b954ac5e13a9d565fab6f.1630632805.git.atafalla@dnyon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630632805.git.atafalla@dnyon.com>
References: <cover.1630632805.git.atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alejandro Tafalla <atafalla@dnyon.com>

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
2.33.0


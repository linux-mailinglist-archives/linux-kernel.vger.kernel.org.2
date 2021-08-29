Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C613FAD66
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 19:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhH2RIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 13:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbhH2RI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 13:08:27 -0400
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B5C061756;
        Sun, 29 Aug 2021 10:07:35 -0700 (PDT)
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id CD4C940457;
        Sun, 29 Aug 2021 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630256854; bh=d+2QNTvIoV14dRg4l4dGxY/K6mqRrojAgpr6qjkd1vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQZTpODurghBG3P44ykBj/me+k/9HHMcNsQrngtFfakKZH9kJW/EC8he6HXATnO3/
         QdcTVp94I+/HcESNsN/2wT/VpPWZadHpqfLBh6KXCCiJcFNSik0v6tKh87Vrp5s3+s
         OH0rcDgvvtvSS+9XaI+0SmsfeKHI2f/faKMRyO4TsiMbFJOHkrWO2A2z32Qphhgj5M
         xHjyXQf/zEhF3hw94DpuauoryI0k2W06QbL+gegnjqjx4e6GoVAxwIzn+knFNka3yC
         +NciyzLVJi57ChDvjvI7f8Wj9c1vDwRL2O1pu22a/u541ADeWH5E/OqUiPPx1AVCQ1
         tdnEsbS9J+Wpg==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/2] dt-bindings: sound: max98927: Add reset-gpios optional property
Date:   Sun, 29 Aug 2021 19:00:17 +0200
Message-Id: <20210829170019.384632-3-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829170019.384632-1-atafalla@dnyon.com>
References: <20210829170019.384632-1-atafalla@dnyon.com>
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
index f6171591ddc6..73733fb60136 100644
--- a/Documentation/devicetree/bindings/sound/max9892x.txt
+++ b/Documentation/devicetree/bindings/sound/max9892x.txt
@@ -30,6 +30,9 @@ Required properties:
 
   - reg : the I2C address of the device for I2C
 
+Optional Properties:
+  - reset-gpios : reference to the GPIO connected to the reset pin, if any.
+
 Example:
 
 codec: max98927@3a {
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A6B3FACFB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 18:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbhH2P7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhH2P7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:59:50 -0400
X-Greylist: delayed 539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Aug 2021 08:58:58 PDT
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5403EC061575;
        Sun, 29 Aug 2021 08:58:58 -0700 (PDT)
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id 44C304047D;
        Sun, 29 Aug 2021 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630252202; bh=d+2QNTvIoV14dRg4l4dGxY/K6mqRrojAgpr6qjkd1vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Osy384ieHriXcIo+oFdAZN118xCPRIeNgdh3SG47Yuvxa8GT3a7PTQAHpNvqleZ71
         A82drEb1RMbHvlB+SOE2fySWzXW/9s//juzRTYmD1wZJySnxSn06bhdMxnVK52z5eH
         43jwf/rzq6mR9tyJ1IyHbanN5niGc7Krc1SmQXOlHLKMpQurB1k3OKDVRGjEzbwoVw
         IYIe2YV3Fl2loGuCKL9F9Nze+qU+Wb6MRvNomHoGXx5Y9ahxk6hIfpFFwlDpo82Jjj
         HX5yMxELFE/PCrbbQxYdY2Gh5q0cMldXwyyFpNF57YBjUvHGuUJOsH5lrhbhjKd6sq
         GRPkDNrfzAPXA==
From:   Alejandro Tafalla <atafalla@dnyon.com>
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: sound: max98927: Add reset-gpios optional property
Date:   Sun, 29 Aug 2021 17:45:44 +0200
Message-Id: <20210829154545.383119-3-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829154545.383119-1-atafalla@dnyon.com>
References: <20210829154545.383119-1-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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


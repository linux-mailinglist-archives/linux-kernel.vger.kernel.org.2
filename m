Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF93A7B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhFOJwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:52:49 -0400
Received: from phobos.denx.de ([85.214.62.61]:34210 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhFOJwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:52:46 -0400
Received: from localhost (dslb-084-062-104-230.084.062.pools.vodafone-ip.de [84.62.104.230])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ch@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8E7D382877;
        Tue, 15 Jun 2021 11:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1623750641;
        bh=xeDue/WnOOtGXp+2ku3MmnMQPyFPmeXZP5vSiFO0p24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pENU6Le7NwTMxQZjqOEj25QkR75JDIHmwQFXp33kkUSRIu4HdUoRp8YyIPK4BtShZ
         7QPsMVbLS1oxk91BQlr7ZG4Ws56kuSDbC6JqcHdW5D92CEUl2U30t7T9vPbxV6vcvO
         2N9v5g+C+KbBXrgxMoQov+xaRESgrt5kb5mkHIYpJ9OQju05Eb+gTyzOcZXyluwNgW
         /P7QgqKmS4EYIj7VdLRkxgvDtSN/F/2S1VQeIEN+M88mZLEzR7bKCqEqRlF0nqvvNi
         2LVYwJZCgOdX0D5p1N4oaf34Li6bamWv7Ygnx/0s9j/R5/JHc89o0miB04EVCBgpm0
         Oe4qnMgT+15GQ==
From:   Claudius Heine <ch@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Marek Vasut <marex@denx.de>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     Claudius Heine <ch@denx.de>
Subject: [PATCH 3/3] ASoC: tlv320aic32x4: dt-bindings: add TAS2505 to compatible
Date:   Tue, 15 Jun 2021 11:49:32 +0200
Message-Id: <20210615094933.3076392-4-ch@denx.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210615094933.3076392-1-ch@denx.de>
References: <20210615094933.3076392-1-ch@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds 'ti,tas2505' for TAS2505 to the list of allowed compatible
strings.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 Documentation/devicetree/bindings/sound/tlv320aic32x4.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
index ca75890f0d07..f59125bc79d1 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
@@ -6,6 +6,7 @@ Required properties:
  - compatible - "string" - One of:
 	"ti,tlv320aic32x4" TLV320AIC3204
 	"ti,tlv320aic32x6" TLV320AIC3206, TLV320AIC3256
+	"ti,tas2505" TAS2505, TAS2521
  - reg: I2C slave address
  - supply-*: Required supply regulators are:
     "iov" - digital IO power supply
-- 
2.32.0


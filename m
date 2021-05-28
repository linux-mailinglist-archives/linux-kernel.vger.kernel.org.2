Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E6394160
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbhE1KxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:53:16 -0400
Received: from msg-1.mailo.com ([213.182.54.11]:36208 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236340AbhE1KxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1622199078; bh=xiYAYJ4ReoERjHj/7lnXJ2gG8qm27EGp9h0Zicsjm2A=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=PxlCSR5w+TtcWNQHVtNEN71h0mP8zqj3o/bahrQk9tNcUrkjvVKOvUPT2RWtrqbpG
         NM4LtC/9dDoWqWaaYOd+eOCgzAL7Eoe8eBZN7fIO1BvBcB4vik48jKIJwhJX9WKDzR
         bT3X4eLMuBe9fSq+C4TxGo8EcRZuI5c2FdD/dU5w=
Received: by 192.168.90.15 [192.168.90.15] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Fri, 28 May 2021 12:51:18 +0200 (CEST)
X-EA-Auth: SD0V86Q8ap8CtVY4uhieJZ54T3WTDESiy4Rm1MXlEiRfL4uMado0R8JV+UTvoTYVF21OAyIoqgWrrDhofMvhjYe2atea8x1ShV+x+68wU5E=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] ASoC: dt-bindings: nxp,tfa989x: Add tfa9897 support
Date:   Fri, 28 May 2021 12:50:58 +0200
Message-Id: <20210528105101.508254-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document TFA9897 bindings.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
index 45db5776550c..46ddc1f3fc0c 100644
--- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
+++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     enum:
       - nxp,tfa9895
+      - nxp,tfa9897
 
   reg:
     maxItems: 1
-- 
2.31.1




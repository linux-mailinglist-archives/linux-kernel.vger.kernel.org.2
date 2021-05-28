Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3C839415D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbhE1KxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:53:07 -0400
Received: from ip-15.mailobj.net ([213.182.54.15]:45970 "EHLO msg-4.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236603AbhE1KxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1622199080; bh=OKYKG4Td/pA0tworGfD316KejA0heP4GSr6nhVKZgcs=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=UYvqC49ZWz4nm0Y1EtH5rHaV1xRpaQ+VN8UVELAzhxID/VTaAGtPAiKqABHdXGuK2
         or/Jx0RaAdcMskZToqzytonRjSdqbD0lZDbJWqMieI4fydfaigwT3Lv1O/jwnppc2O
         qaW5YdolLlLO7v4gWfv/+LOKvXLUYvEPNY4DXf0g=
Received: by 192.168.90.15 [192.168.90.15] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Fri, 28 May 2021 12:51:20 +0200 (CEST)
X-EA-Auth: RDFPup0CGiESeT4DRztaa5d7F5htMiWQg095Z1QC++mxU6PK1lhKWwIAhJjRsHxp1a4svIiKucHduZJ0mIH4rDg0SdWoDPTbey18SIlWnPU=
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
Subject: [PATCH v1 3/4] ASoC: dt-bindings: nxp,tfa989x: Add vddd-supply property
Date:   Fri, 28 May 2021 12:51:00 +0200
Message-Id: <20210528105101.508254-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528105101.508254-1-vincent.knecht@mailoo.org>
References: <20210528105101.508254-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional vddd-supply property to allow regulator control.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
index 46ddc1f3fc0c..ffb8fcfeb629 100644
--- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
+++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
@@ -27,6 +27,9 @@ properties:
       Used as prefix for sink/source names of the component. Must be a
       unique string among multiple instances of the same component.
 
+  vddd-supply:
+    description: regulator phandle for the VDDD power supply.
+
 required:
   - compatible
   - reg
-- 
2.31.1




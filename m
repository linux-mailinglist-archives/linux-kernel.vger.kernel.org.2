Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5174387D9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhJXJWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:22:01 -0400
Received: from ip-15.mailobj.net ([213.182.54.15]:45518 "EHLO msg-4.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhJXJV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1635065952; bh=edaOULKcIPSqN06uR8YMKZSATK8xiZRc12utDsr7zZg=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=fdc6mPrk8KUwC7r4mIi12cO7J64tpZSYCnHn6Regq2NhsHyinEZZogAJXcu51kvUw
         QbC/lTNEOAdPFzOiGvow6spTltonXdEepoyFawFV49V7AZiXTTZjJmvqMfKshA1j8u
         UTUjDQ92mxAEFRsAVZ/k9xTLIVVqD94s3Lc/dDkQ=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sun, 24 Oct 2021 10:59:11 +0200 (CEST)
X-EA-Auth: 3r99JCI1a8z8dSvQ8+piqA3S/XcW8wmuinX4GEnRGm09T5i26nBrdfB/q31gd8dASxgOja3G3ARQaeOvtGDcvxrrSW68lLOtOPy4JSsaK1Q=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     stephan@gerhold.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v1 3/4] ASoC: dt-bindings: nxp, tfa989x: Add rcv-gpios property for tfa9897
Date:   Sun, 24 Oct 2021 10:58:39 +0200
Message-Id: <20211024085840.1536438-4-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
References: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional rcv-gpios property specific to tfa9897 receiver mode.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../devicetree/bindings/sound/nxp,tfa989x.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
index 7667471be1e4..a9e15baedafd 100644
--- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
+++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
@@ -12,6 +12,16 @@ maintainers:
 allOf:
   - $ref: name-prefix.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tfa9897
+    then:
+      properties:
+        rcv-gpios:
+          description: optional GPIO to be asserted when receiver mode is enabled.
+
 properties:
   compatible:
     enum:
-- 
2.31.1




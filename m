Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B72C33AA73
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhCOEdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:33:15 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58009 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229699AbhCOEcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:32:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C9AED5807FC;
        Mon, 15 Mar 2021 00:32:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Mar 2021 00:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=czi+mm/WRAlli
        yY3vx1O61Hzo2LcF+Emfju32DJj5MA=; b=JNiMNkxIId8JyOvAY6zEBR6EHtYam
        P3mS4NQ366vCcWNXoTRGGtcyJn9qAx0iu7auw3sWDIfB7oUnfATsXtj/1AMRqfJW
        F4doI6jlwbvM0MiefsgUHLdybLA7Zp21yvkuI9Uan6XdMNDKPhqDUL9w0po7NnOe
        snoPtjz8xnj3yRHJenvTFOE96x4+3jAvPImpAj3j67tgd18iYJ4FS8rHrBa3G4gg
        BeeAwisq5Tq/HOMWwoOsB0qGLgP8+sHFuBAE10QeRbNtsjPLDI8uGOqoxKYASJy0
        kQwGN5YLfq/+EisYlnRzl0A+H2OHtMv7iPwe4LoR99zUGohwJFvuJEcHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=czi+mm/WRAlliyY3vx1O61Hzo2LcF+Emfju32DJj5MA=; b=IZW3zEKy
        Mw0kMffsNcXyhxp1I4F5FmqrbUVB1FpXfWpwC4dy6IsMpVE0RdRlP8gzlzcIAsRo
        D8RtxgDvfXL7e1rUoQnYm/aOeP+HbBrv+7M5ZDATxep3bLz2UlDyEH7dVtDRX5m8
        4mmEVz8psAmxSfSZ6VA0GRYYK9C0RC0/MO4Cu2dqZ1Id53itTTYI+BDGaDI0BN0Z
        EZ6zYnhhwEcWELBiHCdqTNdcIMfEBVuIlUOjqsVALhXNT9lLuf3F6dF3G7EBSfHM
        fK5IEjl3I+6AHahEA/U6CGkyILP9ytOTOmw2M7TvK55W24bq6t8+AbCmCGoA7CJk
        iuqg9aMeXSYaiw==
X-ME-Sender: <xms:dONOYEkcf7z1vP4PzTLSUeO1uit8eyTshB9qCPMs3hxqhzOWRpFVjQ>
    <xme:dONOYD29yh6EcBxtMdXjUEaLp_J-ws98L2KIScP3wkGvtgFb5KN-0A0aYb6tRG19T
    EVFCdt0lsp6ib0uLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:dONOYCq585OnpbWpm3UWGTJ9JZtx3Q8Dx7hZ1GevOlLE9C5dpGcUKg>
    <xmx:dONOYAn_vFq6hPbwtSnXedGME5_0XcHgAdNf7bR5Ms3ZssiTFLsrxA>
    <xmx:dONOYC1xKpYDwkzOAkB6ULqsw7y1QAuGOXFtnburcWJTzBOWZGVPIg>
    <xmx:deNOYAz0I5EOeYqXWbu_Rs9ohpjEGYC7Gm-scaNgphIaInNNzL9FSg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 169331080054;
        Mon, 15 Mar 2021 00:32:52 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/5] dt-bindings: timer: Simplify conditional expressions
Date:   Sun, 14 Mar 2021 23:32:46 -0500
Message-Id: <20210315043250.45095-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210315043250.45095-1-samuel@sholland.org>
References: <20210315043250.45095-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sun4i timer IP block has a variable number of interrupts based on
the compatible. Use enums to combine the two sections for the existing
3-interrupt variants, and to simplify adding new compatible strings.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../timer/allwinner,sun4i-a10-timer.yaml      | 25 ++++++-------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
index 1c7cf32e7ac2..3462598e609d 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
@@ -34,8 +34,8 @@ allOf:
   - if:
       properties:
         compatible:
-          items:
-            const: allwinner,sun4i-a10-timer
+          enum:
+            - allwinner,sun4i-a10-timer
 
     then:
       properties:
@@ -46,8 +46,8 @@ allOf:
   - if:
       properties:
         compatible:
-          items:
-            const: allwinner,sun8i-a23-timer
+          enum:
+            - allwinner,sun8i-a23-timer
 
     then:
       properties:
@@ -58,20 +58,9 @@ allOf:
   - if:
       properties:
         compatible:
-          items:
-            const: allwinner,sun8i-v3s-timer
-
-    then:
-      properties:
-        interrupts:
-          minItems: 3
-          maxItems: 3
-
-  - if:
-      properties:
-        compatible:
-          items:
-            const: allwinner,suniv-f1c100s-timer
+          enum:
+            - allwinner,sun8i-v3s-timer
+            - allwinner,suniv-f1c100s-timer
 
     then:
       properties:
-- 
2.26.2


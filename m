Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B251C3437FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 05:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCVEro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 00:47:44 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51027 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229865AbhCVErL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 00:47:11 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0E4D1581B0C;
        Mon, 22 Mar 2021 00:47:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Mar 2021 00:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=kn90WelRryWGO
        vGeYwBhPQaYl+homL8f2WWhOA4xjB4=; b=TznZjqsBcm/AXUmrIs16RFjt4+w5z
        7F5ita+tFD6T1gYA0IycFQVEfVt+px/OEAVYvmg83wX5c3C5nD86zbDzosn/XyBD
        xoaweNsMAg3Czqpp7hlWHa10QqQeXVqhpjYNWiXbwVv2egTopSXzOtzjg+tLLhLs
        fO3TsyfMl5SjrUA7aTBGQVcqduLrTVQo7vu6iJSd7wAMj7o6uL2hbGXy5/PY/MNY
        6uhS18UeO3rwUkO4SbbMS+T4pRmv0mMGilzDoUV7Zf6/2UusMae66I1bEgVLu3RL
        SgTOoqKHv6DbKkKsklfwb7iXPHOneiwm8Fc8Jp2FBPULxcuuDjeNiwLrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=kn90WelRryWGOvGeYwBhPQaYl+homL8f2WWhOA4xjB4=; b=LvauHsbo
        Zqh9roAzx9+3aNODpDu8QLi0qhIi995AFslpBcqFYIDyy4Ogc4PBRCYAfllGdVL8
        VLqqmaw6pKPNTRN1341vB5PCQuuw/2sOwP6Rh464m1zHp/V1gILpWBRUJqpVV9ob
        pWf3GQxGMO/qzL5TDyum4rnGmm6MqtbpGALnWxcurtYKdjXZghXQPzY6+895CQ7O
        F/L1u6SzqwOLbr8K9ZDFJQsMkwEJo8TNDJ0N2ZlqHG/oSFgqVhtoGk0EQi0VUMm6
        o37ys4IUaw4O68OLxwKN5L0eVmFC1Im1Q4Es6u7XrNywO9/xZGL1+T+ltBUNyfzZ
        bX3a4nvlgb7D5Q==
X-ME-Sender: <xms:TSFYYJWYt0bbAZ6OUlBFSPQnaN5WbrvlWr7JIxfKp95Oh5viCbKivA>
    <xme:TSFYYJnxkzboPL89SM45tUj1cMhdaCgvwT1j2RJXIwgVjAyPAQhtvUJDOP-oTDLey
    jhn2Sfy9y4yyxWxOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:TSFYYFaseYYVBiLNt2Pis-jCWwD-Y2coheZZl9Wzbx0FkXyxd_dEYw>
    <xmx:TSFYYMUQz0rjc1CjiQAZ5xeQozjv2fPRuHAIrmt5c-jds9GBa4OVFA>
    <xmx:TSFYYDnmGmtRr0O_mH67JbVHmO-tNvQrjDRs-H-kawU49xEc8ewl2g>
    <xmx:TyFYYBc_5541FSS2gI4RinRDex7nnVeRDYWN6HWYTXSGyNqKqYhTQg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 03D64108005F;
        Mon, 22 Mar 2021 00:47:08 -0400 (EDT)
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
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 1/5] dt-bindings: timer: Simplify conditional expressions
Date:   Sun, 21 Mar 2021 23:47:03 -0500
Message-Id: <20210322044707.19479-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210322044707.19479-1-samuel@sholland.org>
References: <20210322044707.19479-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sun4i timer IP block has a variable number of interrupts based on
the compatible. Use enums to combine the two sections for the existing
3-interrupt variants, and to simplify adding new compatible strings.

Acked-by: Maxime Ripard <maxime@cerno.tech>
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


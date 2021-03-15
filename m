Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B4833AA78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCOEdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:33:17 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59201 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229594AbhCOEcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:32:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 98FD75807DD;
        Mon, 15 Mar 2021 00:32:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Mar 2021 00:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=jvtWrGk1v3ZHG
        VbBzJ3xjNsfiIB+WPFTiLXwxkYfxso=; b=hhL5YrbdLCUMqBWvHXI8g4WOF9fI7
        17t14vUeOBxPSGkUuAfHWegEeIayFiaqTWGFFsv4kkThrrGnn/iTu8zjYLBttMin
        Ko0JPUDskSVLJ4u5EN0BCKgrRpci6GhyknKD9z1cFlbZj/rbclrAUfW8uTCEle79
        lAm1TQSX4pAtkZdpiTCPNG2Kb/hgp+wYmgM2986BjUT/DmCajZ6vLrInt94soH9K
        3ggbWfydScOsZrtw99WrnxWKhpgkkG6F/MJPPuJq8pIws3rqC/OdhSvRUGStPkrc
        2mCb/QuC5LY5yEJixU/UBBxwN7d5JxbEUYk6Xtoe6Mau+c/Lwt6ID6Lzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=jvtWrGk1v3ZHGVbBzJ3xjNsfiIB+WPFTiLXwxkYfxso=; b=uzND26RK
        o8/AxFwgpv2ZZMFq+6yB3DDS+kkkbzmDNCyzFX/VkIVaXDAegwb1GFKnTtIqb/wT
        88BOpPnIsmw5sR6feE3fnuOjfdusXEbaqtavJxPUsO0xCX8yudF2TDTZJwoLNtR1
        pAzAkZjt8129gmQo/SI2EjmJziU3JcED15laxaYttNYail6Wurto7zF8SCwjPWG6
        a23kcEjaP+95e+01JSJL+tk4thtv4PQF8GaIwWmvkX95AWSMmXr/SDpIOzrOCRoC
        ocGQBhodHFGbn7a93vIi9lgp5PIbaP7/BLqTYEVBpDsNByK97TSwIgkIxVDGviok
        p+zJ3RfSIL034A==
X-ME-Sender: <xms:deNOYPAfDpKPzApr0O9zK9suGOYdqA5IeW7772Sg5fbNpUzDDEfSvg>
    <xme:deNOYFhV67k_Ki90fricGuwJyC4FlZFSJsF10v7V8stLmGmL6bQglEHkGHvhpZ0rM
    aJHqse8dW1XRGmN0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:deNOYKm-YIwROK7jKevY3OdiHcW7_FtOi4zf5sKYDFLxVI4o7LM_ZA>
    <xmx:deNOYBxwLEdhSWeheosLRs6L-CkFI9kevxft8rDwB4aQhUB5PpqTRA>
    <xmx:deNOYESouBjmiHGVhtAhibcyV5VizstVi3hr_SjNR6yxmuLAhsDthw>
    <xmx:deNOYN_P7dTvbLt452NDKDBEVhzxBZMIZH3j3vp9TAqCxeXU1MUPew>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F72B108005F;
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
Subject: [PATCH 2/5] dt-bindings: timer: Add compatibles for sun50i timers
Date:   Sun, 14 Mar 2021 23:32:47 -0500
Message-Id: <20210315043250.45095-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210315043250.45095-1-samuel@sholland.org>
References: <20210315043250.45095-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sun50i SoCs contain timer blocks which are useful as broadcast
clockevent sources. They each have 2 interrupts, matching the A23
variant, so add the new compatible strings with the A23 compatible
as a fallback.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../timer/allwinner,sun4i-a10-timer.yaml        | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
index 3462598e609d..53fd24bdc34e 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
@@ -12,11 +12,18 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - allwinner,sun4i-a10-timer
-      - allwinner,sun8i-a23-timer
-      - allwinner,sun8i-v3s-timer
-      - allwinner,suniv-f1c100s-timer
+    oneOf:
+      - enum:
+          - allwinner,sun4i-a10-timer
+          - allwinner,sun8i-a23-timer
+          - allwinner,sun8i-v3s-timer
+          - allwinner,suniv-f1c100s-timer
+      - items:
+          - enum:
+              - allwinner,sun50i-a64-timer
+              - allwinner,sun50i-h6-timer
+              - allwinner,sun50i-h616-timer
+          - const: allwinner,sun8i-a23-timer
 
   reg:
     maxItems: 1
-- 
2.26.2


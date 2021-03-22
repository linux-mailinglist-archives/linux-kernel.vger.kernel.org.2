Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CAC343803
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 05:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCVErq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 00:47:46 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34899 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhCVErL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 00:47:11 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B3752581B07;
        Mon, 22 Mar 2021 00:47:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Mar 2021 00:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=dyW4KFPM6bBPy
        u0UhgCtHoqbveAGS27dC5bKLdzD794=; b=KXViEFZDTygsMkrfR3IISfIQ/ziFz
        eDiEoGKVd7ojrohCtemrYYGJQrtyP8dsivQCksm7dgIsDKWO/r5XHghCzbBZ9fat
        dmIecnf4tuUlEbxx6wAjm6ft2MFUYbg/HFLITX1QvRaEP9fsSmOt99GACzsFjG45
        t3qpO6ipbgnXJwKLNu8oL+0X26L9tDMWE8TidAOUE3MnOjb6Ukq/aWdF6xSeTnM3
        kIXvlmNyP72aBzLmVFt7jwl8yAMIpYJB1JGCnfzbhgti72XwU1nhcpbQQ+xGVgFT
        MpMXekzcm3hJpfLLxGe39LZ9i6OKSev6bAkkVeeOafAX494H/JM8JcSdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=dyW4KFPM6bBPyu0UhgCtHoqbveAGS27dC5bKLdzD794=; b=tXO+OWBV
        IbQ/GjQOMwGHm3sQBfh+53FBPT33H1o+gfNsPLZbWMeUPB9v4SQvsLQIw28B7JZu
        ojpaQWDb+1uG3loelfcGmHDEIZPWzt3ZEzei6rJfcx0WRNsSe+5Oby4XRWTJ/zZ7
        NaOi3PU/+5KptmzhejK1V59ffe6AuJrh44UIHOtOmorIkgvyEgSRah7WHFWzoWHr
        3+bcBr78aRZ/qnHPzsya5+x0C9ZZE0+9g1khbpzaXKlFuKfQH6Pw+KPE+zATtN7j
        Nm5phIfhb71W6D2sLFJJAl214C9tmrTlt/198OmNnFElf//ZJSldNsl5UTUVP9A4
        iz1tV2IHNAH12w==
X-ME-Sender: <xms:TiFYYEXu6sJVFjFmAomqNov4dr_499QpW615FD0yGFKKVoWVYTsWWA>
    <xme:TiFYYImNq9XzCdRrc8ra_-yKecEsXYZrgT381a3v4nuCUwCRF01A983Xdd23ai3zV
    pS_OcAhxYBAjtnggw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:TiFYYIax4Fq-fmotTr7vz02zKE1q-yFmPiaF4v6a8C25oc6nRW5PsQ>
    <xmx:TiFYYDVmlbFL3Lk_G4IuPN5zN6JSdUtmkSm1O5DTGa23cfmwhvIXkw>
    <xmx:TiFYYOnmj0EYohyd-XyScOv1L95RDtlDzWz-9zMb9G54JHZ9ByvVQQ>
    <xmx:TiFYYAdGB0-dvswbGjJi2mPJS6VW8ur9GyHWMp1jt2hJyuqJJsgY7w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8A1EC1080064;
        Mon, 22 Mar 2021 00:47:09 -0400 (EDT)
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
Subject: [PATCH v2 2/5] dt-bindings: timer: Add compatibles for sun50i timers
Date:   Sun, 21 Mar 2021 23:47:04 -0500
Message-Id: <20210322044707.19479-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210322044707.19479-1-samuel@sholland.org>
References: <20210322044707.19479-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sun50i SoCs contain timer blocks which are useful as broadcast
clockevent sources. They each have 2 interrupts, matching the A23
variant, so add the new compatible strings with the A23 compatible
as a fallback.

Acked-by: Maxime Ripard <maxime@cerno.tech>
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


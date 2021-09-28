Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6D41B356
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbhI1P5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:57:06 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:46195 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241514AbhI1P5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:57:01 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 96434580C24;
        Tue, 28 Sep 2021 11:55:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 28 Sep 2021 11:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=iEV8ydA3V+61q
        tB26+TqR77mGD10Kt8vZjivysugJU8=; b=c840B/y/OheuY+uzVpRWr2ruwIsGU
        u0fBoBA4X8SlpwbKvewW12BOwG1F3SMjhMd0rHgO/xGe5KhHhEur5/jBjgNv1yk4
        P5S1z5+5XqiEXKN7FF1YqbWWufxy8t7xJOVKU5N/LxPTdd27c0rTfptmbPdzFjZM
        +VAOnMVh+J+KLYCUQ6oKDC2zWDJxrJWhIbxUxCvXx5nnLdqJKBiphF0/thpvzs/x
        lCzZ3PQ++eECks2ZWLFBCJ8+/hH70XnSPkm92XdOqi5FZAu98kmgGLC9oKnYk+Jx
        CE77sOa8fvvskWVORnsT3OIVt0XqzqdnR8PnhQUNRPKDoyfLbPvf89UUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=iEV8ydA3V+61qtB26+TqR77mGD10Kt8vZjivysugJU8=; b=FtcsFRij
        Q3Lg9OHHPijQAI7s7PoFKB0jpabNPhqlYuSrFMCj1es6vGmbgPjiFvuTOVmox3xN
        JOeS/qit3k1O7YS7O5IPUbmKUwXGAFN8lyIzlniylDrjJD1ljU17V0lv6uQGPJIN
        duy7QDy0rnuDNVzxu+FbjdXUdvcgR9EHcjv8UgJp3rHKkeAHKd/jRINaO10aZusE
        ihlSXotvJwc2GlZQTjRoObeL9OZx/zwFqwUCvYfYaED2tiURQhb/MeU1xckuplNa
        S1gySrd60kluOij0QVvMhfaZGCj+MYgN8BTjc0WDfIY97xHL9a/HpebrzxSH/SnD
        Ok9QW8g3NcqdBQ==
X-ME-Sender: <xms:6TpTYcPWxNNwq4UO8scxo958sseD9_29ycYvTTlgg78wHKvXaAZVOw>
    <xme:6TpTYS-_fGHQ3M3gULflMvhtTK9UUUerpRwqdZQDBvIehF4euMZ2NU2iaVmdTtEZT
    LgNuSDAbglxIgWoBY8>
X-ME-Received: <xmr:6TpTYTT5lY4lLRSNto7ZvbYGENvL4BaBSyeNbF1Kj9c3_s9I7_IUk2SYRVIeASwPFb5KJrOb8ebCD5n8Rl0zkay9zUGWHKM8H0XdEPJUu2Ngxbm-fhHVWG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:6TpTYUs_k4xCdy7OOq43l2h1c9eoHqdVT3ORvtYbOTMZJX2rPlP0vw>
    <xmx:6TpTYUcZ98TFSnoLDuEcGWb_xRyzIhXAL38pjiqgxOrLpuSTSo7vEQ>
    <xmx:6TpTYY0pRj62-eP2pXCb_UVxKVuK5pzclcGaI6-EuwFHuqkfBuJIBg>
    <xmx:6TpTYf1uLq_yOl8k6ldCZCWmq9I_2hJLqhuAMq7IZq0Ik0EYS7JBBg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 11:55:19 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/6] dt-bindings: usb: tps6598x: Add Apple CD321x compatible
Date:   Tue, 28 Sep 2021 17:54:57 +0200
Message-Id: <20210928155502.71372-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210928155502.71372-1-sven@svenpeter.dev>
References: <20210928155502.71372-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A variant of the TI TPS 6598x Type-C Port Switch and Power Delivery
controller known as Apple CD321x is present on boards with Apple SoCs
such as the M1. Add its compatible to the device tree binding.

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
no changes since v2

changes since v1:
  - added robh's ack and alyssa's rb

 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
index f6819bf2a3b5..a4c53b1f1af3 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -12,10 +12,14 @@ maintainers:
 description: |
   Texas Instruments 6598x Type-C Port Switch and Power Delivery controller
 
+  A variant of this controller known as Apple CD321x or Apple ACE is also
+  present on hardware with Apple SoCs such as the M1.
+
 properties:
   compatible:
     enum:
       - ti,tps6598x
+      - apple,cd321x
   reg:
     maxItems: 1
 
-- 
2.25.1


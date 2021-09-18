Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDBA41063B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbhIRMLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:11:50 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39437 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239578AbhIRMLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:11:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 23539580A6A;
        Sat, 18 Sep 2021 08:09:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 18 Sep 2021 08:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=cEal9g6XjUtTf
        /+blnFGD/0r9W4KfOLAKJXx/OVMfPQ=; b=O+X8MSeJQ7T73PWHX8toq+IPO4nFg
        WfwR41ARq4KH3Rr8fPnMMcOENkIWzd6H/EKNe1Ry1J3JROZwF0pOu78mLkOirKGs
        6XtOfsOUrDyRTxHDuAKDm1vX0why6ghheIMHkbJnNLkWi/Z6ExAP3yf5VoPeIfHr
        Vs719+Ipe/T0PoGmncNB4SGIbTof9ONaVBtQDRCG8ZOAgV7Js2xOWLz0i1MO7RFD
        PRCW68avx+TXhItG/yZwFwb/Bo4yg2/Px7D7DEdugJ16ckmG7eZnDWaIXarZLGM1
        FFyV2OnuOMvUjZYQXUrV3nN3BQpDFfr+rcbN/PPY3yiTyzm5R/GvcQciA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=cEal9g6XjUtTf/+blnFGD/0r9W4KfOLAKJXx/OVMfPQ=; b=JtRfETVR
        h4pm5y4JfhIv+BCoiBsNT3kDv9VPyw0YwKIufgMyYFiuvaxsW5gNI6TNDZfUeEdP
        3uovH03RccqIPQb66yxIF1g/n7KD8zp9g92AE+KpRxdAtWsNv6fzXWmRqHx5RZn/
        s9Lj7BGXyVa6jgDPSJb9FjxI2WUb7T4BqGgo2ovq4YwFTNIFA8V1dzyk5YZ37VMH
        cWw1Io+5sda0pTxcSsrPAl7dgR0KX5tt4zxecxavm1OVMTdX3w2kjMjs2r03e+WM
        RPv9wnxlrSBIuujNLfv5f/fSgCYzta1DwclDP6rwlN6w/VbW5/X8lOo3JHeYoqjg
        7LhdjGqlC4kVNQ==
X-ME-Sender: <xms:EtdFYTWf4AxLerCbd9YMymRxuEfTfQUxpKvQ38EZ6g0DBFIHk5CZ4w>
    <xme:EtdFYbmDf02ihRPtluZX9MkTPIDksS1Y2wougo6puwAIKUyRZA4nfUA-cJa1Xt_RV
    mwiPw6FxR_T2OYGHPM>
X-ME-Received: <xmr:EtdFYfajj2NU2dmEKZm6QnscfQKOygmlVAIrVfUtwPxtays5sQWqzlpDhfKiF_c8NjqCgx1jyjjZdNXEF8McLF9iubFbhAPOfZ4jvOIP2LdcNR0FLLWT5TYSXg3sTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:EtdFYeU_IzExlt_F-eFDCgnGnBENh9HuJpuuW7qIHhpiMpqdQlkcrg>
    <xmx:EtdFYdm2yVCHkApSuPOaAyDFbMJPtchwrsJzYxjyGk0ULLKPjoQG1g>
    <xmx:EtdFYbdsHN-AZQaES0bbEp7KOCiuRxr9MfIbWRtbujJvS0mWZ-gxmw>
    <xmx:EtdFYfkvF-rXAaayH4nJkj2DokWddBUrEe_Jx9RjHUoapK-zECpvZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Sep 2021 08:09:52 -0400 (EDT)
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
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RFT PATCH 1/9] dt-bindings: usb: tps6598x: Add Apple CD321x compatible
Date:   Sat, 18 Sep 2021 14:09:26 +0200
Message-Id: <20210918120934.28252-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210918120934.28252-1-sven@svenpeter.dev>
References: <20210918120934.28252-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A variant of the TI TPS 6598x Type-C Port Switch and Power Delivery
controller known as Apple CD321x is present on boards with Apple SoCs
such as the M1. Add its compatible to the device tree binding.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
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


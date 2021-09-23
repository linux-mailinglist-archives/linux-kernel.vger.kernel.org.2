Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50950416500
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbhIWSP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:15:28 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:35277 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242876AbhIWSPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:15:05 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id D3274580C16;
        Thu, 23 Sep 2021 14:13:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 Sep 2021 14:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=8J2pMkdcddEeX
        32jWc7dxabP5tr+NvvBXsVJUff+mmA=; b=rkILv9euxrZiUPLGwXcRgETcG3cqy
        Za+Wk/iPiWeY8f5vXa7zxQ6aEixrek+D/UBNPbxBcNgqCxIXQUVBF5m4BaHs3c7k
        4kertH7M3lfKv0C3/kaIT1RmUIsfAvX98EbMIxnIHCK8TciKEmZQlvmuwyr9Fvln
        S+jnXK+av1OjOOd4sRlEdZr8/5pwKnezFJbLqpQ1zdTxrJ/oRTRyjpyOtX/xbmgN
        QfGduDSLYCIbldrh/ifZQpcIPae1r5tjJSjolayge1J/2SXYkUDJCoAf+YzWmiLV
        vTvDTynSJEhTsTITqo6pjVJ5JxhXFWQ/EGradfilwV7UEGF/X35QMbQmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8J2pMkdcddEeX32jWc7dxabP5tr+NvvBXsVJUff+mmA=; b=P7Rk4uXV
        fCDw/+thtFiowFWVqQWxGChWi/LuJ5XaSxQq8+yfTtfTg91DGLmSil9q8jgkUDWJ
        C0gEarO+EVMf7ZeVF10QjUK9eRu8ONVy2LNTNhxBKipa1cVx9nfSh/+uTkTl1jNW
        uw5ejHxYx2R53b46W1dmX/zK++sPx5zPZ5n9+HGQRyA5FYNjlp5ZoQmQ47Wy7CHa
        043qh/G2cVuLWclbD6tK1fTX4kZXKKH5J3Ee/sSIMJKp47RZ69SzwzTr8mqDQ51U
        y+DCdW9MuPbMMdAtel/C2Fu4R0TqUd+5YGNS/l7/py7u/tnXBEpeQ0E/T2R/zOlx
        K+2aQHm27de2UA==
X-ME-Sender: <xms:zcNMYUAcvPiX3doaju6Uj3Q1_NFzcU0yKqqzvb4sl1lnUieodqgIwQ>
    <xme:zcNMYWijb7wGbTeCCZSaZI-_7_T_eWNSF_9o-vzCgfOE-T5vohmrwb_b0pqEuLo3-
    xGlv26Z-GOv___Tkz8>
X-ME-Received: <xmr:zcNMYXlbmFPRi84w0_4p2NNgfNLHKxZL-d4Lj-s2sIWW55kkXI6E_TX0TxHLCbVfxPUfegIAvLwcrpl2noO9NlJY9Isk9hc14pcDJW3_ei3NAyCQNFFOrgs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeiledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:zcNMYawUfQCCmRrUfzZrQTP9cwURQIUAWsdgHFdAGByI-zKdDiDQxA>
    <xmx:zcNMYZQZqAi8uhGmsMVNZ7oSANo1bEVW8uuH3mbo9sUkORcYlj55GA>
    <xmx:zcNMYVZ45CMlGXZ9Q-nfrkqh9w4eCVaefVz0nU14ApSuA4zLKF75QQ>
    <xmx:zcNMYVpIAjyfSNOMKBbdK5DgEJEQiNjCsAVXefJudIKpacFx_AqMEg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Sep 2021 14:13:31 -0400 (EDT)
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
Subject: [PATCH v2 1/6] dt-bindings: usb: tps6598x: Add Apple CD321x compatible
Date:   Thu, 23 Sep 2021 20:13:16 +0200
Message-Id: <20210923181321.3044-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210923181321.3044-1-sven@svenpeter.dev>
References: <20210923181321.3044-1-sven@svenpeter.dev>
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


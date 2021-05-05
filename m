Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21645374A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhEEVj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbhEEVjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:39:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB0FC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:38:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i13so3198616pfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhdjZZj0cxH1sOFf7cnRwsPjytINyJCyqoplegM2Sio=;
        b=KK/K8fTNtpI/sRKDN8LJvWs6y2Qovav6Xw5RxAc1rnqpauUJhF78f/iHvVOeJ3TgZW
         6yjVrsBJK14LiSiumhRtbCB/uHTme/poowcZKzyNQosaW19AyH3U/ejQFzDHUHCZMplg
         eWZs9aJA0zmE3SOfR/wUgdO2M47TSn8+Cx6VP3Cp4C7pMr2rV784fW6JzU//1XTdfz9z
         OWCgZVTGKx0WRIAc1uGCfvdzqk/K8N2yoJNDAtnG65byYQDIMbK+57GfgPG80pj4KMD4
         fyDBOscWHWEZCZutV3LwdXor4Ei6P4cWEpotCEtAeul1FQBi1wabIAbBPRJhipmEN/39
         5dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhdjZZj0cxH1sOFf7cnRwsPjytINyJCyqoplegM2Sio=;
        b=XtvcjrdHu7VTrUGEXFn06R0XfPtIJTDyfz/OXqu5adik+gaFKrk2GJh7NvtfpZRyoy
         nx00aRJnEpsBP1fSBmt9AFWOBLnUfGQNQOJdm4LoUwVBByCnSl4ZeJgROS1UUx+SRjoh
         0xUDekDULffB9IInjSn2NGFkeqKvPnN2PmO8LFb/bGVFqYBZB/7aT9ntyX9Iivrr9F/y
         K/6W4sg+/lV6NUkne6411IOY4Y/YsjImXYZxtbT9jqU+o1c+FsUHmaJvhsdybnx+/DuI
         hJ9DgNon9asxgPO2xjWYzLZ7DPLSyYr+lIJwgsbh4IZJp1MKGWp2G3k2IrTxT8z6SltG
         HX8g==
X-Gm-Message-State: AOAM532wmVKO22yDHwDOc7k1/n9QvQbtxlXio48yfBeT+4enBghQMuaj
        On9DhIGhEZf94XavqsWtvQOf2w==
X-Google-Smtp-Source: ABdhPJyWSpq7imTNSFR9FHpSkOIrd2OpZ1ePNrNW0UYnS8xM5sixk3U1mHqE+u12pKmEZxHEdAH3jQ==
X-Received: by 2002:a63:4b5b:: with SMTP id k27mr920490pgl.368.1620250703669;
        Wed, 05 May 2021 14:38:23 -0700 (PDT)
Received: from localhost.localdomain.name ([223.235.141.68])
        by smtp.gmail.com with ESMTPSA id z26sm167031pfq.86.2021.05.05.14.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:38:23 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH v2 04/17] dt-bindings: qcom-qce: Add 'interconnects' and move 'clocks' to optional properties
Date:   Thu,  6 May 2021 03:07:18 +0530
Message-Id: <20210505213731.538612-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'interconnects' and 'interconnect-names' to the device-tree binding
documentation for qcom crypto IP.

These properties describe the interconnect path between crypto and main
memory and the interconnect type respectively.

While at it also move 'clocks' to the optional properties sections,
as crypto IPs on SoCs like sm8150, sm8250, sm8350 (and so on), don't
require linux to setup the clocks (this is already done by the secure
firmware running before linux).

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/crypto/qcom-qce.txt        | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.txt b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
index 07ee1b12000b..3f70cee1a491 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.txt
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
@@ -4,15 +4,19 @@ Required properties:
 
 - compatible  : should be "qcom,crypto-v5.1"
 - reg         : specifies base physical address and size of the registers map
-- clocks      : phandle to clock-controller plus clock-specifier pair
-- clock-names : "iface" clocks register interface
-                "bus" clocks data transfer interface
-                "core" clocks rest of the crypto block
 - dmas        : DMA specifiers for tx and rx dma channels. For more see
                 Documentation/devicetree/bindings/dma/dma.txt
 - dma-names   : DMA request names should be "rx" and "tx"
 - iommus      : phandle to apps_smmu node with sid mask
 
+Optional properties:
+- clocks	    : phandle to clock-controller plus clock-specifier pair
+- clock-names	    : "iface" clocks register interface
+                      "bus" clocks data transfer interface
+                      "core" clocks rest of the crypto block
+- interconnects	    : Interconnect path between qce crypto and main memory
+- interconnect-names: should be "memory"
+
 Example:
 	crypto@fd45a000 {
 		compatible = "qcom,crypto-v5.1";
@@ -23,4 +27,6 @@ Example:
 		clock-names = "iface", "bus", "core";
 		dmas = <&cryptobam 2>, <&cryptobam 3>;
 		dma-names = "rx", "tx";
+		interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+		interconnect-names = "memory";
 	};
-- 
2.30.2


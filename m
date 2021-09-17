Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F5B40F562
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbhIQJ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:56:52 -0400
Received: from egress-ip33b.ess.de.barracuda.com ([18.185.115.237]:34336 "EHLO
        egress-ip33b.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242122AbhIQJ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:56:38 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71]) by mx-outbound47-143.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 17 Sep 2021 09:55:11 +0000
Received: by mail-pj1-f71.google.com with SMTP id k1-20020a17090a590100b001971da53970so7104252pji.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nwMHJe+MclcWVODW8A3c3lO8x6KvaoNWqV/K2W2abb4=;
        b=DpsQrkEOH1jQHxqyo5M+x6QJkGMp2n0n4ZE7wbcLSf/euTQtzAG+hqCJyWc2B2QI8d
         SkTxQb7zyix6U8NWlgf4ITFfAhJFDaGpavsk54KF+oom3HJcmeU61sbMjJ8rG6ghfa2j
         CeBCFP5scuxFp4LpGSSaT9ucacr5NHiBtZfPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwMHJe+MclcWVODW8A3c3lO8x6KvaoNWqV/K2W2abb4=;
        b=RqJtaN4rzvdeXJXv7Q8/BW23XePv1p5l9vGP0bGjfU7jffohDd6vGA6XIc1FLydbmy
         GHeNZSB10wQFV/HV2HhlhCPqBstVPFmWUFYO4B4NNTL36vejgmUKUrjr5tWDA791xd11
         4MLI0gY2c/RLdZsnT3OUE7ZO9Uo6e00SATkjA60BEgA441mTgmd2/w16pmFymP1v2WME
         WG9lSXKikEnelKdl+Iesc7tf7JBILRGf2p2EbY+4ESMul0BMumbmli3N9HT0BjNGsZgL
         bXifpT/pmg3pXglr0obkjF485dBzHVBEsh+em4mJVxNl6o3ik4zKxUWE9+DNFIZ9O5Fa
         WDJQ==
X-Gm-Message-State: AOAM5337QGw9F7L+7uLruFuIunj611mzjifRBsPSiyhU/UU5RZ64McYD
        g4ljvkgjLFfh/u6IhymUTFX7cfCgowsDlvBbHue0xdiTOC2565kk+dyDSkeik3WY2503579KSEg
        AdxSwVYJUXbiiLeOFC1k5dplqQL1moadZe3Wj6/Mo29E5xPlmRYV4EqNq+Ie7
X-Received: by 2002:a17:90b:120c:: with SMTP id gl12mr11392349pjb.231.1631872510850;
        Fri, 17 Sep 2021 02:55:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxDifBpzLTz4pLUftgsbvysTDAehIyQ1nLl46Ggr+9io/98ovOaBufLQ3zTZU5+8ew7nhJqg==
X-Received: by 2002:a17:90b:120c:: with SMTP id gl12mr11392332pjb.231.1631872510619;
        Fri, 17 Sep 2021 02:55:10 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id p2sm6077333pgd.84.2021.09.17.02.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:55:10 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Suman Anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 2/2] dt-bindings: remoteproc: k3-dsp: Remove board-specific compatible from DT example
Date:   Fri, 17 Sep 2021 15:24:26 +0530
Message-Id: <20210917095426.19277-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917095426.19277-1-sinthu.raja@ti.com>
References: <20210917095426.19277-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1631872511-312175-5440-1356-1
X-BESS-VER: 2019.1_20210916.2102
X-BESS-Apparent-Source-IP: 209.85.216.71
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234537 [from 
        cloudscan20-104.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

The example includes a board-specific compatible property, this is
wrong as the example should be board agnostic and gets in the way of
additions for newer platforms. Replace the same with a generic soc
node.

Fixes: 2a2180206ab6 ("dt-bindings: remoteproc: Add bindings for C66x DSPs on TI K3 SoCs")
Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

Changes since V2:
* review comment updates, including simplifying the changes, commit
  message and $subject updates.

V2: https://lore.kernel.org/all/20210818074030.1877-1-sinthu.raja@ti.com/
V1: https://lore.kernel.org/all/20210817152005.21575-1-sinthu.raja@ti.com/

 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml       | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index 6070456a7b67..5ec6505ac408 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -133,9 +133,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    / {
-        model = "Texas Instruments K3 J721E SoC";
-        compatible = "ti,j721e";
+    soc {
         #address-cells = <2>;
         #size-cells = <2>;
 
-- 
2.32.0


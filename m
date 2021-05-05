Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF61374A4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhEEVjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhEEVjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:39:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E684C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:38:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g24so1663379pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 14:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vuvuy1+AT+Se+Ymw219J/gL7FUpA6VquAVOTuh+g8Jc=;
        b=uLOLtUcD3/U1CPx3mWyktMgcU6UbmGRwzeLDy4y7Ko+ItOTBeVT4QOjivBXuALBv1Z
         54HWe0iEGbQEYyCBJ2mM+dIUqEYuwoHRv23IcpltCHEvUpbB5mV9o8YEfzyF4fgTmAgc
         VpMDp2zXpdU3XunQJKlaiAld9JzGfl4jL6hSmsebXSmPtAHp8oLn6lkNmJQOOH1UOYR1
         X3Zfyb3GZ5j2F8pkHhMtaKjToe4oOhPvurX6uYcrBUvghfzKbouG4B/adKZ+hGJKWag+
         RzJvBrTqmA0OQNcq7P/Pp3MOjBIrVbbawH1TIpNtswND6IsjO09IT2KuU4BdtxZOXbJu
         RumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vuvuy1+AT+Se+Ymw219J/gL7FUpA6VquAVOTuh+g8Jc=;
        b=CiumRONBhoN5WWELqtxJASaz9QV0f1KXY8gk/5QgePTETkn5drmYb8p191jjwaQksU
         NWb+XqZobQW+tRCeUxDULttV764Stu/OYx3RrnR+MqX+4mbLz7Tvb6s18bBhrO8EtiR4
         3vgDceQdYQvdRqLO285XmNb0Fsw2iZiPwucayiHVlf8YH6M8wha8vqb5ULCYOoCaKaCL
         xX53WI+X9bbd5TTDpWvBoDGnHsmMlrgV9cRmSrJ3DsdceWn++rrhMz8NmeFh1/J64Xzs
         LgvSnygNYp2rNo+FoIXJuw02mmLQ0HyItfX2IAIh7EhTs1yhqklNbGchiwpmfemVZNpB
         V+Ng==
X-Gm-Message-State: AOAM530JZNHCAm5kXrW/KroczWLEmE5eYvh5fq5AEgT+BynEKRcqthIW
        RHFSn+yAEQ+2t8pa3IjWfbaNPw==
X-Google-Smtp-Source: ABdhPJzgyvFxC589Qe4/bKRPP1/ndf0oUgZck9SproAnrE2LdXa+IqmozDQT9VjeQ6MEgdjPA6HmGA==
X-Received: by 2002:a17:90a:e643:: with SMTP id ep3mr13636722pjb.194.1620250684644;
        Wed, 05 May 2021 14:38:04 -0700 (PDT)
Received: from localhost.localdomain.name ([223.235.141.68])
        by smtp.gmail.com with ESMTPSA id z26sm167031pfq.86.2021.05.05.14.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:38:04 -0700 (PDT)
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
Subject: [PATCH v2 01/17] dt-bindings: qcom-bam: Add 'interconnects' & 'interconnect-names' to optional properties
Date:   Thu,  6 May 2021 03:07:15 +0530
Message-Id: <20210505213731.538612-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new optional properties - 'interconnects' and
'interconnect-names' to the device-tree binding documentation for
qcom-bam DMA IP.

These properties describe the interconnect path between bam and main
memory and the interconnect type respectively.

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
 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
index cf5b9e44432c..077242956ff2 100644
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
@@ -13,12 +13,16 @@ Required properties:
 - clock-names: must contain "bam_clk" entry
 - qcom,ee : indicates the active Execution Environment identifier (0-7) used in
   the secure world.
+
+Optional properties:
 - qcom,controlled-remotely : optional, indicates that the bam is controlled by
   remote proccessor i.e. execution environment.
 - num-channels : optional, indicates supported number of DMA channels in a
   remotely controlled bam.
 - qcom,num-ees : optional, indicates supported number of Execution Environments
   in a remotely controlled bam.
+- interconnects : Interconnect path between bam and main memory.
+- interconnect-names: should be "memory".
 
 Example:
 
-- 
2.30.2


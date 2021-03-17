Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3A33F050
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhCQM0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCQMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:25:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A7FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 05:25:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x184so986114pfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGzmTTjWe1AbEuSBzNDXhCdxGNlI9I7Ym5rhNfsOEPE=;
        b=hyvzVHeaKT5CdkW0D6cUUD6bRVX++YCV20wSSg1coULPHz5AfgOLvfL7HQdaFojqF4
         5v5t26HbIHzmBHYJByEC5vRHB0+BuY3YWAuFHJzy78JeIiK+Omr99zGUnnIo0UEk3NJH
         +7NCVU+du5H0Nc9HPbgBqKXKKf4SQnGGeac+PX2ihWZMdU+GY1g6IlxX9ftl+p47cmeC
         GB7jHqacMALLLOWAy593vGyu8uMc6wI6cFc+6AXzfAiYhA9FJHJ5ZtCHCeFPTQ1/sWUc
         DIOWri0EIJbsenDSWoRFMeIGOG9c1TVi3ShhoCPpbZ1KwWu9AaVWZWZXvbLI6BVpbciN
         H1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGzmTTjWe1AbEuSBzNDXhCdxGNlI9I7Ym5rhNfsOEPE=;
        b=Ne8bucjjQz93FS7ylDQuN3xqTvgAqAnnEdQ8gSjap5+qaAe0SF4XKRtULXhyNtNDgI
         w5HXmqVyTArP8erjpb4YWBgx10VSHwG6Q5x1cfissMuqq3YdIBT9mFhecN6dIg8yWKa7
         kiFM27fBSKrkNz6WVUl0wyyaTfS4iioGmJ34CkNAFEF7WsT6ZfwQawRL1jY8TzhQ3FNj
         3JAULP3ieAq5iuLxzwAm7WXtw7hOdqV/Th5+vFcA50bsb3lwg7oi7aYcFMVBC/dxFjNU
         j+uxLw6nGxgn2pQK8S0nWjOeXeeR4q3xVY/Pj+Mm8hWmPUzkmIrVHKGn7v0bjHXEWDnl
         5HrA==
X-Gm-Message-State: AOAM531CBjR0C/6nNWd11ddosjTpNTHUFAkewummxNiGstCZ+unZ1SZt
        tMhW8PIfA2S8y+UF0OClaY4K
X-Google-Smtp-Source: ABdhPJy/SeiYsJVh0qMKBjSvnT0Qdi9a9LDO5ABIuNeOAUoWTJYARGoqrPl1gtZ2yOidGarSm3aqOQ==
X-Received: by 2002:aa7:92c7:0:b029:1ee:75b2:2dab with SMTP id k7-20020aa792c70000b02901ee75b22dabmr4123453pfa.61.1615983938243;
        Wed, 17 Mar 2021 05:25:38 -0700 (PDT)
Received: from localhost.localdomain ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id y23sm19285730pfo.50.2021.03.17.05.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 05:25:37 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: mtd: Add a property to declare secure regions in NAND chips
Date:   Wed, 17 Mar 2021 17:55:12 +0530
Message-Id: <20210317122513.42369-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210317122513.42369-1-manivannan.sadhasivam@linaro.org>
References: <20210317122513.42369-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a typical end product, a vendor may choose to secure some regions in
the NAND memory which are supposed to stay intact between FW upgrades.
The access to those regions will be blocked by a secure element like
Trustzone. So the normal world software like Linux kernel should not
touch these regions (including reading).

So let's add a property for declaring such secure regions so that the
drivers can skip touching them.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/mtd/nand-controller.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index d0e422f4b3e0..678b39952502 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -143,6 +143,13 @@ patternProperties:
           Ready/Busy pins. Active state refers to the NAND ready state and
           should be set to GPIOD_ACTIVE_HIGH unless the signal is inverted.
 
+      secure-regions:
+        $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        description:
+          Regions in the NAND chip which are protected using a secure element
+          like Trustzone. This property contains the start address and size of
+          the secure regions present.
+
     required:
       - reg
 
-- 
2.25.1


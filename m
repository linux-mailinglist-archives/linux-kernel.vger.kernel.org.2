Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD5937FE74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhEMT6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhEMT6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:58:02 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:56:52 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 197so26685260qkl.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ImB00rCkO3Du5fe7tW03c3z2e4cEx+x9KwGSBQTfV8Y=;
        b=MYFZYZfeOsnayRhW4lf4ZMW7Qg1ZxX5/VeI5As9fUKYtgLYeIfesf4bvt4LNtZOd+n
         mkh1Pl/j62eJYdcFcF8Y2m6ir8r1lBayar5pI5GS/9TfjCguiGAxUpRTjmDCYN3YH2Mm
         Z0AnoB/pz5FOM4R1rfgdwYatRIcNVvXv6Dd1QJICdDN2iC66ipJ+K+zDXDw9M/IMJJ/4
         0jQySlzbudom8C/dZwF2oQFXMydcug0llFJ2F8aLGsh62K9YKz2SVWcD6csBXeZZ+rYR
         CUCXvys1qHCIdb/JwjDUvGntkYEyNUIEFy25Qpq7Qy4zk5fQUo6uUWx6Xx10j9hFMVTx
         ejTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ImB00rCkO3Du5fe7tW03c3z2e4cEx+x9KwGSBQTfV8Y=;
        b=skHgYmAw0i+Os7rml+Snt85jpOGwZt3L40O6WRqYaV8y1f8A9qKHZu+F+0spZFFzly
         sVCTOrSaucnrNqi2p69XrluvapuOJVXJhsWTrhf/B/xuH9WuiCG2Udjv3C1nTeldrjGM
         V7wch9WhkUCeG7mpsZw8i2n97E9iUDeljuh7ieq8VLx5bne8km87g9AIBy4OoggcZ9XS
         30GTv/G6vd17alnAVKegMxPe6PPdIys5JXiDTccQVs3jYna9hbbYUWlGi21cXIrMmkrq
         kzbuFO2BgQ157tZvhutwCsngCqY1uPdxJw7GaJcYwsXWROFvdYOfbZpxwqR99HQ2jB3l
         alnw==
X-Gm-Message-State: AOAM530PtnzJoy1Ao5DMweQgIhWJkkk6kmnWMUK09EmY/TiDRAg8qo7m
        Tvkm+9fxMjeX1WC2UmMAB2glIw==
X-Google-Smtp-Source: ABdhPJx1RtfJ/l4n/RuqVFt93meQ5WMhpxPL9gL8UNj3gRu1WJT/XnnZlFikpcxf3KQh0hdKj1TlWA==
X-Received: by 2002:ae9:ed86:: with SMTP id c128mr32927476qkg.224.1620935811744;
        Thu, 13 May 2021 12:56:51 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id h12sm3211228qkj.52.2021.05.13.12.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 12:56:51 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] dt-bindings: clock: add QCOM SM8350 display clock bindings
Date:   Thu, 13 May 2021 15:56:17 -0400
Message-Id: <20210513195617.15068-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210513195617.15068-1-jonathan@marek.ca>
References: <20210513195617.15068-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sm8350 DISPCC bindings, which are simply a symlink to the sm8250
bindings. Update the documentation with add the new compatible.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml       | 6 ++++--
 include/dt-bindings/clock/qcom,dispcc-sm8350.h              | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)
 create mode 120000 include/dt-bindings/clock/qcom,dispcc-sm8350.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
index 0cdf53f41f84..8f414642445e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
@@ -4,24 +4,26 @@
 $id: http://devicetree.org/schemas/clock/qcom,dispcc-sm8x50.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Display Clock & Reset Controller Binding for SM8150/SM8250
+title: Qualcomm Display Clock & Reset Controller Binding for SM8150/SM8250/SM8350
 
 maintainers:
   - Jonathan Marek <jonathan@marek.ca>
 
 description: |
   Qualcomm display clock control module which supports the clocks, resets and
-  power domains on SM8150 and SM8250.
+  power domains on SM8150/SM8250/SM8350.
 
   See also:
     dt-bindings/clock/qcom,dispcc-sm8150.h
     dt-bindings/clock/qcom,dispcc-sm8250.h
+    dt-bindings/clock/qcom,dispcc-sm8350.h
 
 properties:
   compatible:
     enum:
       - qcom,sm8150-dispcc
       - qcom,sm8250-dispcc
+      - qcom,sm8350-dispcc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,dispcc-sm8350.h b/include/dt-bindings/clock/qcom,dispcc-sm8350.h
new file mode 120000
index 000000000000..0312b4544acb
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sm8350.h
@@ -0,0 +1 @@
+qcom,dispcc-sm8250.h
\ No newline at end of file
-- 
2.26.1


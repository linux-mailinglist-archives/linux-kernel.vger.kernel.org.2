Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90A53C7BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhGNC2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbhGNC2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:28:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B29CC0613DD;
        Tue, 13 Jul 2021 19:25:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id o201so630689pfd.1;
        Tue, 13 Jul 2021 19:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dPSiVnXH54t9EeTnrT4sUiAziqFMF5bTlSumQ1g0W5E=;
        b=TUmKap5JTowpagWzjfhq1NKnchBUIF5yPeHlGuZOaZTwD0iFgDCa4EC37u6GjiR5B0
         /uIY71OFv5WaimVGoCNN1JYCP4SME7/hvC/JY0io6YNaI457AB1wfxHq98WGcWDGq3u3
         9YG2E2MZTBvsO2/nI0v+/YyLWlo/pORe/+NfoNGTRIT/j8UXdHFo0EFm++xZfcGMBjSR
         tzWraMUmyTvlMRR9J9gXzCbY42Fqm/kEqlG8DRytjhQjRnYBJLb7jHsJTS6PiGxEUwAA
         L4U58AXJzSnSRFzM+1Fn/UjhFxOBVM2KPOB85LOJm/u164iDMRaAlKwFFZS/dtOaBYgM
         X8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dPSiVnXH54t9EeTnrT4sUiAziqFMF5bTlSumQ1g0W5E=;
        b=ofrzsd9x/9PhyGwanlV3VJbMW/J4cq9c0QKDIgoSppbxu1l+HJxBkSmS/QK6tAQ6on
         wMXH8Ub8x8/ZlCqgpbL0MzfWAeu49Vwt3K7zJqTxXVv6yrQzJ7UYunU/r9cO0DEp18Yn
         a5+JopR/b3JZX2jQGfP4KLE5k3hkf/IsMvspzi1ALo653bPJdYuBr/l+nrWfHLBE+qdn
         Te/ldHCWUbET+zwqG2Cao4OIKpl7JyBh81KiVvv8NtZ1RhlHQ7lL5SUusBEICv7mtkFL
         FIenVZAgy87USGg7UJUXX0C9ezJvlCszJoBlsB7G8Uoc9NPisYsqgB81SC16WPc3GqS7
         ds3Q==
X-Gm-Message-State: AOAM532xuOW8PDhfXjmHorZDeLywUguhAAypJCje/Fm7esSqEyHrcUXq
        Of3CKib/vCAnlIY5ttBk9tM=
X-Google-Smtp-Source: ABdhPJweQvuueiPtUVvB2tVDlWH2VReXnBVTrzyhbhlplAAZL8yR95zWGJp6Iirv0xD+dnh/S4mxYQ==
X-Received: by 2002:a63:d014:: with SMTP id z20mr7112258pgf.203.1626229550279;
        Tue, 13 Jul 2021 19:25:50 -0700 (PDT)
Received: from localhost.localdomain (1-171-13-208.dynamic-ip.hinet.net. [1.171.13.208])
        by smtp.gmail.com with ESMTPSA id h14sm447583pgv.47.2021.07.13.19.25.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jul 2021 19:25:49 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] regulator: rtq6752: Refine binding document
Date:   Wed, 14 Jul 2021 10:25:32 +0800
Message-Id: <1626229532-13037-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Drop regulators property reference and remove the status in example dts.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Following by the below comment to update the binding document.
Link: /https://lore.kernel.org/linux-devicetree/20210713214659.GA892012@robh.at.kernel.org/
---
 .../devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml        | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
index 641840e..e6e5a9a 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
@@ -30,7 +30,6 @@ properties:
 
   regulators:
     type: object
-    $ref: regulator.yaml#
 
     patternProperties:
       "^(p|n)avdd$":
@@ -56,7 +55,6 @@ examples:
 
       rtq6752@6b {
         compatible = "richtek,rtq6752";
-        status = "okay";
         reg = <0x6b>;
         enable-gpios = <&gpio26 2 0>;
 
-- 
2.7.4


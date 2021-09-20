Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33A411489
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhITMei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:34:38 -0400
Received: from egress-ip4a.ess.de.barracuda.com ([18.184.203.227]:38064 "EHLO
        egress-ip4a.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233066AbhITMee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:34:34 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198]) by mx-outbound8-184.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 20 Sep 2021 12:33:05 +0000
Received: by mail-pf1-f198.google.com with SMTP id v206-20020a627ad7000000b0043e010e5392so13017099pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SEL1gkIAJp4KVblBAp/xhehzJxXPAFWh7FPt5vFeWVs=;
        b=OYMo6gnbLCtZZtBUzwIqSzxff70GhWSCYTxM54e15pLXvWDJBNHICSOMtZpsEDW/P4
         8bPJNlbEttfsryty2dACC8alIulPFB9RPS/uzx416TRpWRfw1+5i1qRi9Bc3gxAfMjGz
         g1URznygBLY+7fLMfbyXjdWLtF3gZ3OdN6EgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SEL1gkIAJp4KVblBAp/xhehzJxXPAFWh7FPt5vFeWVs=;
        b=3PVyv6VZ5gHb++Mds/pwxkLnnsYgvw9YpnZyONjA5nJLoCoIxLHCaDLTyZF2dgismW
         oJ94gZL9Z1YCpvIQo4MFvLhWJFqOHjQBwVsRllLhgePbbc9joMF1vFqL4NvTy9Ve/GX9
         j0D70meqYOHIEad4a5NwpB76I4kC47E8jo3kILY8bZDaI0yl0jwK+xfZZzR88ay5bLjN
         ubVIetPKm/Z0OCubfx2lrkd8MAYhQaPtgoxtnMt/72KRpZKGBO4GKXl/dL32fB8/rI39
         uFS09JFTOMjRjVBEdW7DbCE+gIdLzKaTAiNQndlI9APraIY40AuoPPlJFB0M/zSJIxN1
         jGYw==
X-Gm-Message-State: AOAM533sI00fUquJ1upDebqvgxa+sQwtXGevQGpUH7s/c5b2vNBfxcdW
        zr90Onc1+5iC6194lNHoAV9WzI/BN5Wgyo1vghMtL4/w4WIlrHWDuULj59J+Hf+QSdZ7Gdb7AYJ
        MJ7IJ79VfOKUcIwgERa75U/XEUzY5F8eeV+EYkPoLfwrAGUTT7YsEqTz7zdGA
X-Received: by 2002:a17:902:a50f:b029:11a:b033:e158 with SMTP id s15-20020a170902a50fb029011ab033e158mr22604825plq.26.1632141183820;
        Mon, 20 Sep 2021 05:33:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjw48yoSF+t1cM9uQwmmG4D25VWxribqv/ULIu0flFFUYM1g25aTWElA0jtLb7zkd+Nj5KlA==
X-Received: by 2002:a17:902:a50f:b029:11a:b033:e158 with SMTP id s15-20020a170902a50fb029011ab033e158mr22604807plq.26.1632141183540;
        Mon, 20 Sep 2021 05:33:03 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id d14sm7605712pfq.61.2021.09.20.05.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 05:33:03 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Suman Anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3] dt-bindings: hwlock: omap: Remove redundant binding example
Date:   Mon, 20 Sep 2021 18:01:52 +0530
Message-Id: <20210920123152.32751-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1632141184-302232-5362-224-1
X-BESS-VER: 2019.1_20210917.1726
X-BESS-Apparent-Source-IP: 209.85.210.198
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234608 [from 
        cloudscan19-45.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

The example includes a board-specific compatible property, this is wrong
as the example should be board agnostic and should represent the particular
binding. Also, the file includes two similar examples but with a different
compatible. So, drop the entire second example

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>

---

Changes in V3:
Addressed review comment, that includes adding Suggested By: tag to the 
commit message

V2: https://lore.kernel.org/all/20210917170805.5079-1-sinthu.raja@ti.com/
V1: https://lore.kernel.org/all/20210917094740.18891-1-sinthu.raja@ti.com/

 .../bindings/hwlock/ti,omap-hwspinlock.yaml   | 33 +------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
index ae1b37dbee75..0a955c7b9706 100644
--- a/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
+++ b/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
@@ -39,39 +39,8 @@ additionalProperties: false
 examples:
 
   - |
-    /* OMAP4 SoCs */
-    hwspinlock: spinlock@4a0f6000 {
+    spinlock@4a0f6000 {
         compatible = "ti,omap4-hwspinlock";
         reg = <0x4a0f6000 0x1000>;
         #hwlock-cells = <1>;
     };
-
-  - |
-    / {
-        /* K3 AM65x SoCs */
-        model = "Texas Instruments K3 AM654 SoC";
-        compatible = "ti,am654-evm", "ti,am654";
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        bus@100000 {
-            compatible = "simple-bus";
-            #address-cells = <2>;
-            #size-cells = <2>;
-            ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
-                     <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>; /* Main NavSS */
-
-            bus@30800000 {
-                compatible = "simple-mfd";
-                #address-cells = <2>;
-                #size-cells = <2>;
-                ranges = <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>;
-
-                spinlock@30e00000 {
-                    compatible = "ti,am654-hwspinlock";
-                    reg = <0x00 0x30e00000 0x00 0x1000>;
-                    #hwlock-cells = <1>;
-                };
-            };
-        };
-    };
-- 
2.31.1


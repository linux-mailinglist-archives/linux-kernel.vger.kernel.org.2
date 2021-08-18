Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC81B3EFDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbhHRHl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:41:28 -0400
Received: from egress-ip4a.ess.de.barracuda.com ([18.184.203.227]:52412 "EHLO
        egress-ip4a.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239219AbhHRHlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:41:23 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199]) by mx-outbound10-152.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 18 Aug 2021 07:40:42 +0000
Received: by mail-pg1-f199.google.com with SMTP id q23-20020a6562570000b029023cbfb4fd73so935609pgv.14
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UkIuG9kG2oKl5x8f+ApK/mUtbc6w+fjs3SOOWN0kRIM=;
        b=lr0HtKv9rPHKgCeJK6CrjS5BRAZ1C4gQekRy3DuWQbU6als+LRedy/my6VvNNdKrzL
         oeepcNTjfgJEUIJB6A/fUlLESmSSfLP77HUvbevgfa4yUecJmIAGHdHdJXIY/5T/ZKpV
         3/DSkwHpdm/UGUhK/7lqjaNCTabKq3+R8tSCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UkIuG9kG2oKl5x8f+ApK/mUtbc6w+fjs3SOOWN0kRIM=;
        b=QCx0MAHBleW+svmsDoBP9tTvxztL+yVKXmjGULL9kUgYpvDFXyUZduOXDdaQ2XrL+T
         z+OWXDrZNHnSmCP7abWMPZP5QCq8xvHKAM7HZ60+ZpDYPp2MRn2qItsQ223kjc+sOl8M
         rlo0T1wcZC9xPBzKBiKDXRHfo8EQTQSu9ms8w7ifENfQohNf3d+5BCkKzt1gSok9vyVi
         Qk8ohTp6Uf+7IjPg2zqcQHWQdUn0Oy1YXTf082PG63rB3ydQgiXzPc0tZl0Q5qCvmPov
         e5K3+fv6cIj3K+OVr7dNuRGY8munwuE0n1x8dByb8eoxO5lDGju0mg70dFAl8NSlX9Rz
         N3Cg==
X-Gm-Message-State: AOAM5300BSBjW2l1eruqEPh9ZxF03051YV4EmhrYUJzajB26Pb8679/y
        UVu6wHIj/9gqXUJADHxv7T42Sa23PuGQ0yiy2M3ne46KfYIfj4sIyNQXHIeeLIMQaZpZNN5A0BZ
        feWKVuu+944sEp1BkTwtMMiTk6yWDKzEQuSHNe3RXWCUlb4ZvADgLFvXcA902
X-Received: by 2002:a17:903:248f:b029:128:d5ea:18a7 with SMTP id p15-20020a170903248fb0290128d5ea18a7mr6302809plw.83.1629272441679;
        Wed, 18 Aug 2021 00:40:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzW12eztIemFNz4nqgJdsosiXRAEcL1J4Iw8uicr4OKsG4mgSPpr0fXRPt4Rust4y8D+4i9aA==
X-Received: by 2002:a17:903:248f:b029:128:d5ea:18a7 with SMTP id p15-20020a170903248fb0290128d5ea18a7mr6302778plw.83.1629272441424;
        Wed, 18 Aug 2021 00:40:41 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id 186sm5224756pfg.11.2021.08.18.00.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 00:40:40 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V1] dt-bindings: remoteproc: k3-dsp: Update example to remove board specific
Date:   Wed, 18 Aug 2021 13:10:30 +0530
Message-Id: <20210818074030.1877-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1629272442-302712-5369-5853-1
X-BESS-VER: 2019.1_20210805.2250
X-BESS-Apparent-Source-IP: 209.85.215.199
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234026 [from 
        cloudscan8-166.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example includes a board-specific compatible property, but developers
need to add the board name each time when a new board is added to the K3
J721E SoC list. This grows the compatible string-list. So, drop the
board-specific compatible string and add cbass_main as a parent node to
avoid parent node and child node address-cells mismatch error.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
Changes in V1:
Fixed alignment issue which caused the yaml parse error.

 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml     | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index 6070456a7b67..e44a9397b8db 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -132,10 +132,8 @@ required:
 unevaluatedProperties: false
 
 examples:
-  - |
-    / {
-        model = "Texas Instruments K3 J721E SoC";
-        compatible = "ti,j721e";
+  - |+
+    cbass_main {
         #address-cells = <2>;
         #size-cells = <2>;
 
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE3D3EEF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhHQPqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:46:51 -0400
Received: from egress-ip4a.ess.de.barracuda.com ([18.184.203.227]:48916 "EHLO
        egress-ip4a.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237594AbhHQPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:46:50 -0400
X-Greylist: delayed 1509 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Aug 2021 11:46:49 EDT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69]) by mx-outbound42-68.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 17 Aug 2021 15:46:15 +0000
Received: by mail-pj1-f69.google.com with SMTP id t16-20020a17090ae510b0290178bb9f2f04so2310749pjy.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VsSZGWUvvn7j0SbAPqKoESI5XWDvpP3o/VbecLlOcio=;
        b=oR1CYR+7YdGW2W8VFM1r+9qUEa+rDxkRR2PPpuFBlFF/c/gVdD5SGVgWgSWMRydzY0
         o4owHijmmHzVAG0LMvckc9NiORMrV4AherWsE+HuY9Bpo6onWj+GW0+cEJx8zoTjic1x
         lO7Dm+i7A0PjtDc9IFp9+qJrm573Hb5qO5HAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VsSZGWUvvn7j0SbAPqKoESI5XWDvpP3o/VbecLlOcio=;
        b=aZN8g1+TaIbXjP0OXdrvnHbSyn4ziCEPlcxKKlonA7qBN0n+3zrOzEcV2KYMt7ErOT
         HzG/vUVR5hTvkD3/Nxg7Lq7wvZxJJHIk5zOfg1hBxXetoghE4Z35es2lWJPpTsAeaAsw
         2cVIZDqhPxUDG8C/BQPlSp+87JZdJNX91S0uO6TAm4+HvrBV/yoLpCnLKuozv0D609OG
         sk0YKBZxTh2dXAnG/+p8TdYNiGqdWVSLgsVh3EUZ5fXTnePnjEv27GlNTHU9+PJkMPxM
         D5LdZbxJomAFlhPRK45yR/HIKLaw0C8J4WwObk8D+avR7ayKepRn7KkasjIcPkOp5afg
         ZQIQ==
X-Gm-Message-State: AOAM533TqWBIH98sCAvxOe9Vx8S4ArlCejM9dWLllfIunhYT99Rq6tc+
        0TNcbdzph2n7xXeYhmpS2wpRXnnjlnadgscVcrjiWg6zAdEHiQmQINtz9lKkWm3q47p1VH90Luu
        ts4/qMPyCo9gyRTE6AOzxZWXVbFf5cU5F0e/r0YP1kVq1Zp/Cz/4OY4rNqmjz
X-Received: by 2002:a17:902:7c87:b029:12c:8f2d:4238 with SMTP id y7-20020a1709027c87b029012c8f2d4238mr3278434pll.50.1629213664531;
        Tue, 17 Aug 2021 08:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwCljfSrQAguX6MEzyY1djUhbhAX3lvGHwKM1bezzxj6OMs03o2YiVWt6FZgwoCkxfOPU1Ww==
X-Received: by 2002:a17:902:7c87:b029:12c:8f2d:4238 with SMTP id y7-20020a1709027c87b029012c8f2d4238mr3278418pll.50.1629213664266;
        Tue, 17 Aug 2021 08:21:04 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id f137sm3148368pfa.160.2021.08.17.08.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 08:21:03 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH] dt-bindings: remoteproc: k3-dsp: Update example to remove board specific
Date:   Tue, 17 Aug 2021 20:50:05 +0530
Message-Id: <20210817152005.21575-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1629215174-310820-5354-3040-1
X-BESS-VER: 2019.1_20210805.2250
X-BESS-Apparent-Source-IP: 209.85.216.69
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234018 [from 
        cloudscan12-43.eu-central-1a.ess.aws.cudaops.com]
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

From: Sinthu Raja <sinthu.raja@ti.com>

The example includes a board-specific compatible property, but developers
need to add the board name each time when a new board is added to the K3
J721E SoC list. This grows the compatible string-list. So, drop the
board-specific compatible string and add cbass_main as a parent node to 
avoid parent node and child node address-cells mismatch error.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml     | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index 6070456a7b67..905b8798d4c4 100644
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
+     cbass_main {
         #address-cells = <2>;
         #size-cells = <2>;
 
-- 
2.31.1


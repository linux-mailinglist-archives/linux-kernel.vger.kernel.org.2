Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5627340F55E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbhIQJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:56:41 -0400
Received: from egress-ip33b.ess.de.barracuda.com ([18.185.115.237]:34066 "EHLO
        egress-ip33b.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241500AbhIQJ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:56:32 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197]) by mx-outbound47-143.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 17 Sep 2021 09:55:08 +0000
Received: by mail-pl1-f197.google.com with SMTP id s8-20020a170902ea0800b0013b6f74f3a2so4875201plg.14
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QB8NxGfldn0ZW62MV3i+kZyEGH1apCb7zjxlCREGC5o=;
        b=GXoJmBrS0TgwapaeusnK49vzhsMHqCJDrp1XAGr2w9CqOH8DChrx82JGC5aGJGw5CR
         XCupOfz99xda1/rnU4iuQhGriE0WhEgqezxJ9sxpCyL8y5bZHpxSHh2WoXsM45y/arK5
         0qtdeu4sEkWJXpURktVm9rRiTUYUox1BAV0Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QB8NxGfldn0ZW62MV3i+kZyEGH1apCb7zjxlCREGC5o=;
        b=4McmXH6XyTCQNQM/3aUfKhDNW+jAQmf55ylP9RrR0rE0LYoMBxvSlrqkWqxPNTVNwC
         P12Ybvx8M3kt5zsaBTBUN31iKTcwQFwFcwHd3a7tbRSBhJm8tps7jQikVcpiqfVcQRhC
         ippNhIFDKd0NnGjWEg17iEJaZ+kp/eCkXVTFlzARbBwSpsfYfKAbisbOjVkhYDWOVTQ6
         TcWEK5Mm6iPnNGxwf1SIlRSQdj9eXK7HU8jQd2JZKcPXdVMsudv/3AouYQCItkRUDvBA
         9PVE4nP/eN2uUTdjzP+hCVjdo5jk5TmSozEz+kys+rTTisXOnU62t6aYn6OfyeGuMiPY
         DIzQ==
X-Gm-Message-State: AOAM531zuac0OChSHpvLKYpumwPZoyR02QGLspMRcF2VX4jsqWXMEArC
        FPVNo7hq6gDEYR6WJn8Q4XB/UnIzK5P4QrZ+NTbWpY1+bELq4FtSSa4q+jX+zdZ7JJZVw1XzezY
        3i3PzZIPYRVZVd4ygcc6e15JDcAg/AlFYV7H6KKdV9xDPTT9kR1lmt53t1yoE
X-Received: by 2002:a63:7453:: with SMTP id e19mr8970576pgn.243.1631872507012;
        Fri, 17 Sep 2021 02:55:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/O5dLoAsia5gmNWlpvAL+HxZASOmtWKqP7o/JPIBjw6jtKUb9+M7e1iPxfpd1ILgMRdpOLw==
X-Received: by 2002:a63:7453:: with SMTP id e19mr8970555pgn.243.1631872506818;
        Fri, 17 Sep 2021 02:55:06 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id p2sm6077333pgd.84.2021.09.17.02.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:55:06 -0700 (PDT)
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
Subject: [PATCH V3 1/2] dt-bindings: remoteproc: k3-r5f: Remove board-specific compatible from DT example
Date:   Fri, 17 Sep 2021 15:24:25 +0530
Message-Id: <20210917095426.19277-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917095426.19277-1-sinthu.raja@ti.com>
References: <20210917095426.19277-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1631872507-312175-5433-1353-1
X-BESS-VER: 2019.1_20210916.2102
X-BESS-Apparent-Source-IP: 209.85.214.197
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234538 [from 
        cloudscan23-185.eu-central-1b.ess.aws.cudaops.com]
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

The example includes a board-specific compatible property, this is
wrong as the example should be board agnostic. Replace the same with a
generic soc node.

Fixes: 5ee79c2ed5bd ("dt-bindings: remoteproc: Add bindings for R5F subsystem on TI K3 SoCs")
Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

Changes in V3: new patch in the series.

 .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml       | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
index 130fbaacc4b1..eeef255c4045 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
@@ -230,9 +230,7 @@ additionalProperties: false
 
 examples:
   - |
-    / {
-        model = "Texas Instruments K3 AM654 SoC";
-        compatible = "ti,am654-evm", "ti,am654";
+    soc {
         #address-cells = <2>;
         #size-cells = <2>;
 
-- 
2.32.0


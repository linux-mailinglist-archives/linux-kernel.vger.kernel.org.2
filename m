Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135A6419252
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhI0KkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:40:11 -0400
Received: from egress-ip4a.ess.de.barracuda.com ([18.184.203.227]:42294 "EHLO
        egress-ip4a.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233858AbhI0KkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:40:07 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71]) by mx-outbound40-42.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 27 Sep 2021 10:38:26 +0000
Received: by mail-pj1-f71.google.com with SMTP id gq10-20020a17090b104a00b0019ec5538b25so4466210pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sCG/LglCvdRg/oGkfksE39oKp0qqB5Zh3UzOqOO6HuM=;
        b=FwQfvnoxXTujx5hOw76v4pnT2w7YEeZHvO6q7nOgbKKqy96GE0NSlCjZeKpxPwrREr
         L4LvQDN/jpwZoBNV35bquH70KAZxYOKTiaFYsZc/IUjrwkhcwV/56Ph0WRtRJ4tEOXcW
         oPMU9OUSIbkmeIimgN+ulbnArdtLknRmMuJLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sCG/LglCvdRg/oGkfksE39oKp0qqB5Zh3UzOqOO6HuM=;
        b=hppdKfxjqliEm1HsRCWoorzKIoHeZxOUbp1oCWx3F8egIz9lwqGY+6ZIXWpo5Wpj4v
         61fLepm/ELgvVyEOir1bNd51kAPvT5oznBhisIvgwUtm5szPa5HZzCEUZwqB1giEn/wx
         +mxjnOK4/HMR7FjJhFCbx0VR1S7WmEkDHXjFoCjlrLC3aYio+btf24zWAhzcBmN9VHHq
         nMgL8C+5soDFckdUDHeWkk4D0eBj8LEGpln+/66Z/gQZ/HnfaYo+9pgI6XEvkwYZZ76z
         ShL/kbUoa1OFO3kWls13MxBQKak6w6sUpMDG/04Fv+Or4f4qT0eyTSVEmjYBcCtMl+ai
         IiIA==
X-Gm-Message-State: AOAM533AEvG7LYS4ykstPBQak3KvewuF1MkEHW59OOzb99oD4lxx4ciW
        QMM0N6wnMeZfpa996ZFPL9z7LN8G+M3R/W0MtCKjDkU4kKzdnUADAlu/p0sGNQY/SbPt/FmdDtj
        8gxP+saByrJafWHLSjkQiXm3GF+NNEWElbbcuVhx1N9MopNYjGQzzhp/qg86b
X-Received: by 2002:a17:90b:1102:: with SMTP id gi2mr18954386pjb.43.1632739105764;
        Mon, 27 Sep 2021 03:38:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzciYVKi71v8xhIPcFz9bTM5VAy8i1i3VXdLzJ4HCmoplHzneMMjjuWJuzNm1cOfqljbCNOmw==
X-Received: by 2002:a17:90b:1102:: with SMTP id gi2mr18954367pjb.43.1632739105559;
        Mon, 27 Sep 2021 03:38:25 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id t68sm18030894pgc.59.2021.09.27.03.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 03:38:25 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Suman Anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V4 2/2] dt-bindings: remoteproc: k3-dsp: Cleanup SoC compatible from DT example
Date:   Mon, 27 Sep 2021 16:08:11 +0530
Message-Id: <20210927103811.11222-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927103811.11222-1-sinthu.raja@ti.com>
References: <20210927103811.11222-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1632739106-310282-5424-278-1
X-BESS-VER: 2019.1_20210921.2035
X-BESS-Apparent-Source-IP: 209.85.216.71
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234758 [from 
        cloudscan23-46.eu-central-1b.ess.aws.cudaops.com]
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

The K3 DSP binding example used the root-node with a SoC compatible
property originally to address the dt_binding_check warnings resulting
from using a value of 2 for #address-cells and #size-cells as per most
common usage on K3 SoCs. Clean this up and replace it with a generic soc
node to keep it agnostic of the SoC or board compatibles that are outside
the scope of this binding.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Suman Anna <s-anna@ti.com>
---

Changes since V4:
* review comment updates, including, commit message and $subject updates
  & dropped Fixes tag.

V3: https://lore.kernel.org/all/20210917095426.19277-3-sinthu.raja@ti.com/
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
2.31.1


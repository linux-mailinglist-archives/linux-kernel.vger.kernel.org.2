Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666873B40E4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhFYJxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhFYJx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:53:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A89C061760;
        Fri, 25 Jun 2021 02:51:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b3so9896933wrm.6;
        Fri, 25 Jun 2021 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3RskP7ABczDPV/xayjgJz+jTz8nS+XbtsVOlwA5TU0=;
        b=OcddEErbfOY6ExeISiSk7YFKrdvt8iiNzITQZIQpXEkMFnsJBVqW6omdPQrj+MI4t+
         RQxMHVEsgRlByVTOZLNnx8ReJ5cL6+GL4mfOd29Q6fKLvHTOoJGy/JtTc+kjoUaErCMY
         MbpC6MfUnN93kmPSghr5n0mdemefm14+Hke2HLaB5JxDQSO9JVYY1SD3M792mgnld594
         /oR2Wxdaq2z2oRKgO5NCU08fOKj5PIjCwFb/a8SX0aeOH8dr2VoNRXbUvdaspjq93OFt
         Gs7R5u9rjXb1Yjvs8rUHbtg6qvYUaTD8GqGlbB9g2wpu8fjfIXCjju4FMm+HT8HZEMNy
         oLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3RskP7ABczDPV/xayjgJz+jTz8nS+XbtsVOlwA5TU0=;
        b=UVQFsjju3loVMg43Ztnw44EfstAqpm4E1YZIVsLGhUG0MjJhgkFnlFVzs/q7yNBB/W
         DNSjKFvzffEkf4osk/CBzh7GdWOpPPVppYLoaeUbcfaJzrIpYlNqkUG4f5/T35h0dgTm
         b118HLOpFsn1yWDXsGQ9d03HVMMGCl1+1sp86/Tf7wPK4t0eiTdWgNaV7X7OZ3cTbCIZ
         sPcsxetusory+a/udUXpSpacdTTNKixbCohC89JxFfnOdEZ0L2SR0Xch5Ttm9q8EbUtI
         sbG1KldN4lA/R1rwD30ud/U4hEf8tjjI7XG1merytcHANxER6FWt4evzmvcxp3j9YgHq
         /G1A==
X-Gm-Message-State: AOAM531M2JWhTbFqxY7x6sjX1eIbOE6Z66hNC2mg6zWbMxbp5ZUsOMyE
        tIMk8xRe7X72auTnx2rPTvo=
X-Google-Smtp-Source: ABdhPJyS2uk3MmSY2uN1krFSfu+xoBlyO0DZF7uSh/HopQ+aQVgpEfA/mvIw5qtHdIqKnhxkRiipWw==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr10104727wru.380.1624614664376;
        Fri, 25 Jun 2021 02:51:04 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id t11sm5628277wrz.7.2021.06.25.02.51.03
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 25 Jun 2021 02:51:03 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/4] dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65
Date:   Fri, 25 Jun 2021 10:49:51 +0100
Message-Id: <20210625095000.3358973-5-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625095000.3358973-1-mnhagan88@gmail.com>
References: <20210625095000.3358973-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Meraki MX64/MX65 series.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
index 78dfa315f3d0..7d184ba7d180 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
@@ -62,6 +62,12 @@ properties:
           - enum:
               - brcm,bcm958625hr
               - brcm,bcm958625k
+              - meraki,mx64
+              - meraki,mx64-a0
+              - meraki,mx64w
+              - meraki,mx64w-a0
+              - meraki,mx65
+              - meraki,mx65w
           - const: brcm,bcm58625
           - const: brcm,nsp
 
-- 
2.26.3


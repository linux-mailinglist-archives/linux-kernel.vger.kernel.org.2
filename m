Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFD41C064
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbhI2IPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:15:42 -0400
Received: from egress-ip33a.ess.de.barracuda.com ([18.185.115.192]:37812 "EHLO
        egress-ip33a.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244590AbhI2IPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:15:36 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69]) by mx-outbound11-76.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 Sep 2021 08:13:47 +0000
Received: by mail-pj1-f69.google.com with SMTP id m9-20020a17090ade09b029017903cc8d6cso4579790pjv.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8MazRJC/UFdJ6inkSvyaSkOTKbg7uW4ICaCKt8HQWg=;
        b=XuXkej7QqnC8RWkGjaaFg0MR8d4VtpfgyHekkw5yY7nuTx1zffy7NRfT0AL3AIkgAt
         askII6lvssBO++WFi9Vq/m5usZ9atWx6r32tMfjP6ZOhFhzx0waqsxrB71k/Bv8mok6D
         ly806GMJ4Hcl/FVA0eODFXjgdysxtJQkRyn90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8MazRJC/UFdJ6inkSvyaSkOTKbg7uW4ICaCKt8HQWg=;
        b=gihH7wnBPptoeGNWhXIZqJMwaqpNGfIUlbvY0DEGJUqMfxvFxaxwrDJqIkt8qrXrJK
         6+I7YncP5tiPsy/mq32S79cuyOE0iKudLnNcEbfNlIL2glBCJ6i2l0dvSKmiiwVJsiPk
         adHu5tVsNLX6VbF3JcENTBKZLHxJWbsDuaP0adL7VatFuTTNkdYNnftrwnS/gunQM6sU
         a3sEVjfPnB8UiPVk79lYhhSI5F9YeKJqbhZKASAVKuTaoI3c3tdCD8Qw6OvoVSwzXPV/
         Y5fCdkrfp0Hoz7WoLqWHu0mlW6ibKoJZJoT4vBp07osp3uzwUG3FIBtJZf5yQ263AQRh
         i+Pw==
X-Gm-Message-State: AOAM533Zp3g70tAY0xEonwRJYYPZ/LgsPOU4GV/wIWdFkiy9KOTnBaay
        K0mG2Mjth66DK+C3tBg4+sSy0Cztgt6F7Lpa7utbH59wzhFYD2RRZNBmXIHH/lWojNZ0xkDj5Uf
        edOGvDhOIytv/AVTsnvY6bccCY+0g91c3opH4qB30bgb8/8qeZQSph4GjChoL
X-Received: by 2002:a17:902:8ec5:b0:13a:2789:cbb0 with SMTP id x5-20020a1709028ec500b0013a2789cbb0mr9140999plo.60.1632903226272;
        Wed, 29 Sep 2021 01:13:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLCZOKQda9thwsb7v/vH7TZg+GFsB20LqbXn7MGuaW/EbqhMgFfXTUlQqWBIY5xehfRLCC6Q==
X-Received: by 2002:a17:902:8ec5:b0:13a:2789:cbb0 with SMTP id x5-20020a1709028ec500b0013a2789cbb0mr9140985plo.60.1632903226041;
        Wed, 29 Sep 2021 01:13:46 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id k14sm1152026pji.45.2021.09.29.01.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 01:13:45 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 1/4] dt-bindings: arm: ti: Add compatible for J721E SK
Date:   Wed, 29 Sep 2021 13:43:30 +0530
Message-Id: <20210929081333.26454-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929081333.26454-1-sinthu.raja@ti.com>
References: <20210929081333.26454-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1632903226-302892-1133-19169-1
X-BESS-VER: 2019.1_20210928.1746
X-BESS-Apparent-Source-IP: 209.85.216.69
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234800 [from 
        cloudscan20-168.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

J721E Starter Kit (SK)[1] is a low cost, small form factor board
designed for TI’s J721E SoC. Add j721e-sk into compatible enum.

[1]https://www.ti.com/tool/SK-TDA4VM

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

Changes in V3:
* Addressed review comments.
* Added Board URL to the commit description.

V2: https://lore.kernel.org/all/20210607093314.23909-2-sinthu.raja@ti.com/
V1: https://lore.kernel.org/all/20210602182237.12632-2-sinthu.raja@ti.com/

 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 29ca364e8a76..d97af3f628d8 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -31,6 +31,7 @@ properties:
         items:
           - enum:
               - ti,j721e-evm
+              - ti,j721e-sk
           - const: ti,j721e
 
       - description: K3 J7200 SoC
-- 
2.31.1


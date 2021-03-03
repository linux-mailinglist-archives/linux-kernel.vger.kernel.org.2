Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1332BB9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbhCCMow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842517AbhCCIGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:06:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C77C0617AB;
        Wed,  3 Mar 2021 00:05:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id a24so13574079plm.11;
        Wed, 03 Mar 2021 00:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5CH01EA9VYt10FW0+mfZjDjaLT5fUS+mwHbeYhgolHE=;
        b=pVzfgsNk6xvxfRSrEMjzQfQ195hwniJYYN4YwNc6i/kxr6ug9QlmKKRNS5He6xVuMk
         XVYvBO23bwSWkVIXHzMUmvT/Jcu6doW7WntugzKTRC14J/TjjcvvjPD9BPYjCJV2aN86
         Ao4O1BKMnNXD/EsHxADdgBH/4J9SJVp8H+thAz9rZeSjhoQaRUqs3hpId75BWe4bU+IQ
         W2tt9dIyK8YKczJu6dlTZVl+95zr1Iy+OWmAPKZXU73RmPfLcEBMSC5YWdCG0nU3p4gu
         UummH4u+rku2UPUri/5dXHlb1Uhd5YceyYzJyTkRDTkzvPYGT1HpiooW/hF6zAwGWevB
         zGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CH01EA9VYt10FW0+mfZjDjaLT5fUS+mwHbeYhgolHE=;
        b=Dm7C56hzVQ5uF56F08ZCZY05mgUfIFuhUNMbsKDZaKt63nObvS4/nQ4pdqWSh7GWFN
         Ugpnm67i4/ys+hFhIF1K9EFvMnngi6Z7FlE8EhwHk3GoIt/3HaVNF0HLdXIsSfnmyvYQ
         0HrKBePT/2FHLqAvhNJTPMW/OYTdIHfyNGQQANjd3zfJpb0VpRf4ujuBIHCsti0DSmYg
         3tPwqSpGcWNywJIaY/Sa9TbSB9OYZq1JGiI3CcRLh8sHAeJVKNlHu/OkUpAie2toXob+
         SWzdz9KAcOfyH5pExbnNMYQnGhLvs+H66/aYRHhRfEyXSJ6MmoeFXY76wzaU+3oAAWvZ
         fGDg==
X-Gm-Message-State: AOAM532GZsEAg6y9Z+UGG9OE4yHlSZVEkgPUXe4W915npmzEnKzc9Xdw
        +es4NXyJJBjrC60dQADLenA=
X-Google-Smtp-Source: ABdhPJwo6ae/R50WZM3DB2SsjWo4OPuZ3H1RvOS13q+blJrwXA4mzp82m6B0MYUidNv14Thew4KpJA==
X-Received: by 2002:a17:90a:6385:: with SMTP id f5mr8604972pjj.91.1614758731962;
        Wed, 03 Mar 2021 00:05:31 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm22260887pfv.84.2021.03.03.00.05.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 00:05:31 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 3/8] dt-bindings: arm: stm32: Add compatible strings for ART-PI board
Date:   Wed,  3 Mar 2021 16:05:12 +0800
Message-Id: <1614758717-18223-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Art-pi based on stm32h750xbh6, with following resources:

-8MiB QSPI flash
-16MiB SPI flash
-32MiB SDRAM
-AP6212 wifi, bt, fm

detail information can be found at:
https://art-pi.gitee.io/website/

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index e7525a3395e5..306e7551ad39 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -53,6 +53,10 @@ properties:
           - const: st,stm32h743
       - items:
           - enum:
+              - st,stm32h750i-art-pi
+          - const: st,stm32h750
+      - items:
+          - enum:
               - shiratech,stm32mp157a-iot-box # IoT Box
               - shiratech,stm32mp157a-stinger96 # Stinger96
               - st,stm32mp157c-ed1
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A042E3E5852
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhHJK2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbhHJK0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:26:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08EEC061799;
        Tue, 10 Aug 2021 03:26:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r6so3300003wrt.4;
        Tue, 10 Aug 2021 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ail8+T+/FwVUA7gWn+lZm4pSQKQ3OOV0PrkoWmQeTKk=;
        b=o3oRVpQOYqzisi2aOnz1qHAh9uGBtJoDj7CFeBaTrYp7DgxeNI7n+VqiLVkG1qcVnj
         MmXJdUfUP3DtOx8c/95snq+oxF+kh+5vTy8WEP/PDXThjGrjZzhHs+75RhXzrND61xhI
         uumM5Re4/3hmwEErAyt3dtfEIzlOS+AFfd+xC68ajQSq9y9iXW28mNR4taTjeKyE1txg
         uryoTS0i7a9DQdK8clEVb1VFue/26S8eIhm5V49PeGWI00nWV7qNdySSqm1ddpEZ2ks7
         FXiqUfRW4ace2jXMW0OmvApHjaBVCNnQxPCBeadJRJGyVdPBCinmK4gyvhnHbLtujXbD
         sAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ail8+T+/FwVUA7gWn+lZm4pSQKQ3OOV0PrkoWmQeTKk=;
        b=DVoW8jdJxN6k30Jp9C/5fZljm7gDGmZZduvwKflXfY613gzxH3QFXBsbPBL7LHTicc
         hJWcdgkNww0GlVI/WWcwrssNvHMHtjY0y8C1h3v+pGsoqJwLL/qmOzfs6m/nhviiS/L9
         mhEw+4QXGQos3rCN0bOuHlRxxIR3djfM9GUTrXloPZILAVmU3dG171sSuMNPyUg7RSja
         lA5TcasIn0e821BHnvfJXg1cnrQr6yErKG60/IyyWqD6MKDlsQHizc4dotuQKVntu+gh
         +a+t0S6fDab+6oHNoEL6etZmM10lr4rctlge0+rJ2p26dnqetm5cMsJOYuyer10bd3kQ
         M/jQ==
X-Gm-Message-State: AOAM531Q4koIGCqcDF/L/yuwfXr7d1BiPOyHnI1s0SN6OI8fWmjiBTET
        GG/mRn0/cPqgn8d5RPnx2bo=
X-Google-Smtp-Source: ABdhPJwNfCBobSymUcYfJpl1FqjQ2PAxFPjbwCpAu1CzE0LNqwQHqzD2SojSx7/cNv2BJIC6osYb/A==
X-Received: by 2002:adf:c549:: with SMTP id s9mr30205853wrf.344.1628591179291;
        Tue, 10 Aug 2021 03:26:19 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j194sm1582998wmj.3.2021.08.10.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 03:26:18 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: add support for Radxa Zero
Date:   Tue, 10 Aug 2021 10:26:12 +0000
Message-Id: <20210810102613.25149-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810102613.25149-1-christianshewitt@gmail.com>
References: <20210810102613.25149-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radxa Zero is a small form-factor SBC with an Amlogic S905Y2 chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 6423377710ee..67dccdd9a5a4 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -141,6 +141,7 @@ properties:
           - enum:
               - amediatech,x96-max
               - amlogic,u200
+              - radxa,zero
               - seirobotics,sei510
           - const: amlogic,g12a
 
-- 
2.17.1


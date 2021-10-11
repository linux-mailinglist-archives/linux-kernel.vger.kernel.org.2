Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE9B4287D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbhJKHl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:41:56 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57464
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234578AbhJKHlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:41:49 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E64D74002B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633937988;
        bh=UgKOyYZwudZNcbOmLjHV2oxljhkCMf/FkAv9xZY25jk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VcX+7spCnd6U+Ae1SvJ6nByzv9umNK0MFTJqQhyyT6zUPS34NIgD/5QFP02Pz3YSz
         S9X/6sy8vogjKrIYEzC0w847WiYaJJ0ak9Zv69EygZTSAjTE6F1h7HHwzsJhcImej9
         srYnfkUyZe9RajA0QNQW2rE3NSzdZ8TuxX/YZ5rgbpjpNyO7KQ6LauPo4ClpriR6fx
         Ip+v9mF6anCXRxVOptLhOU4HHXLeYUv8P9gdUD5SkA/w8EYLZCEF4cfYeShmTW13lQ
         /cKHZzjpE1AcSraO53f5zCTSA0Byxv1akTDS5Sv6guGY+hD9mzJFWAf1ydOuiiJcS8
         vWgCiMYAgmlKg==
Received: by mail-ed1-f72.google.com with SMTP id t28-20020a508d5c000000b003dad7fc5caeso15050144edt.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UgKOyYZwudZNcbOmLjHV2oxljhkCMf/FkAv9xZY25jk=;
        b=H+kkmsTIVSWaU1JJX7oLJGdBz5Du6gDxf88y+s7m/fz12E9pxCZdmG4Ae8uD5QmTw5
         8BwKLxK2MVc+MZcr3Ii+rxmhIS/ZE0uLPCHZ1qfWeKRDEtAJ40MbWkJ8VbqEYruNg7oC
         2jdIXU1wSnzPpnKEUOBhCMMJxrC/SfpTW+9gyp9+8YYQyms5rW6RPFjBfsYO43coX9IJ
         2vdqlmLVUC6BP8sfkgaRWL3xN9QISBMVzO//LllMJeOWvKaJbKdXy2jMczsH1l57iB7p
         rNgbM/2ILeJOBCoWf+dJhp3b8b0/8HkMgV1uaY/nHxfi5HoG5T1YsKJEDSbm9Gw5CzTi
         P6Hg==
X-Gm-Message-State: AOAM530S12SVKF2tVBQDUUHFbYM5DEPOoaaT72HN9bUNzRnPlyDn3n+k
        qeLfDiVDuXBUpVJ0SShYf4n0P6Mds3Vrak2iPzN0NBKADbw3jCbfdJDOMrb4oNGHGacofZjMLjj
        idhiNCGKaJMFAqIVjHWyYdgHMkmZYMgh39FRJYGRI6Q==
X-Received: by 2002:a05:6402:90b:: with SMTP id g11mr285850edz.32.1633937987495;
        Mon, 11 Oct 2021 00:39:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpldaLH9a88wXudeyQvv2eytBFPukbJ2BYMZlSB5t8tpzJmcsqoMhbsiBWxgjJeaELLuFqBA==
X-Received: by 2002:a05:6402:90b:: with SMTP id g11mr285836edz.32.1633937987365;
        Mon, 11 Oct 2021 00:39:47 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y8sm3023965ejm.104.2021.10.11.00.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 00:39:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Mark Greer <mgreer@animalcreek.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/8] dt-bindings: nfc: nxp,nci: document NXP PN547 binding
Date:   Mon, 11 Oct 2021 09:39:28 +0200
Message-Id: <20211011073934.34340-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011073934.34340-1-krzysztof.kozlowski@canonical.com>
References: <20211011073934.34340-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP PN547 NFC controller seems to be compatible with the NXP NCI and
there already DTS files using two compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
index 70634d20d4d7..7465aea2e1c0 100644
--- a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
@@ -12,7 +12,11 @@ maintainers:
 
 properties:
   compatible:
-    const: nxp,nxp-nci-i2c
+    oneOf:
+      - const: nxp,nxp-nci-i2c
+      - items:
+          - const: nxp,pn547
+          - const: nxp,nxp-nci-i2c
 
   enable-gpios:
     description: Output GPIO pin used for enabling/disabling the controller
-- 
2.30.2


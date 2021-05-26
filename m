Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32805391D03
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 18:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhEZQ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 12:29:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35347 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhEZQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 12:29:31 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llwNy-0008Sl-Vy
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 16:27:59 +0000
Received: by mail-ua1-f69.google.com with SMTP id o7-20020ab01e870000b029020d37e3e144so1035843uak.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 09:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jv4RCq2GGtpFX/YkIBJQBGSbcUXH9Iixusyba6gZ0pY=;
        b=fPyz+fdSfV2/VZZA4kZHanL07dH9G5ENUEeJyO8i3psP7aA5j/fthWASiLp+rHBsB5
         GV6cK4pmHBtH359y2//hF+3TQ1LBgblY2IalI75N1YwXOPNCQZVocl/71bQhrRCHC4TR
         eg2TUhkmu8Um811HHFel/AdsnTOCAmkox4++XJo7zi3uICDzq5VDRSvlCuujWgrNQM7B
         X5DMfo1LypUeZBqjOw+k9CiODteW+PtuG3V47vdOHSWVJaz9FWvT5TZsRMsFy+0azPud
         6PrU2XreiIM+3ycXMq8GxdVLwF75c27eXfI7qyePALQH3DgWneF0lg3HUxhCZZfk94e/
         B1dQ==
X-Gm-Message-State: AOAM530Bl/av2noj8fXPvd8EUdJpqKCaQ+xBF6PeVnwiC45l4XKznOuC
        nBETnBb7+c3HzHv4DV/FmbavAQYYlaJbjHECx+Gf8+wWZDoN0Mql+qK4zQTxg94OfgbE3JddRt+
        jEQzOJ+AaqrDlemldmgwGwaheepHMG4/lJ2e5FXbFRg==
X-Received: by 2002:a1f:c704:: with SMTP id x4mr31787714vkf.9.1622046478120;
        Wed, 26 May 2021 09:27:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvxkeC5RXrpicrG41l+kp8biprBycXmdMTc4vtLYKtowR0ZjBj7tchNvSJOqK7MNbiF1Ja+A==
X-Received: by 2002:a1f:c704:: with SMTP id x4mr31787684vkf.9.1622046477867;
        Wed, 26 May 2021 09:27:57 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.4])
        by smtp.gmail.com with ESMTPSA id m186sm1541501vkh.56.2021.05.26.09.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:27:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] dt-bindings: arm: intel,keembay: limit the dtschema to root node
Date:   Wed, 26 May 2021 12:27:50 -0400
Message-Id: <20210526162750.135139-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

The check for the board compatible should be limited only to the root
node.  Any other nodes with such compatible are not part of this schema
and should not match.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---

Hi Rob,

Can you take it directly?

Best regards,
Krzysztof


---
 Documentation/devicetree/bindings/arm/intel,keembay.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,keembay.yaml b/Documentation/devicetree/bindings/arm/intel,keembay.yaml
index 69cd30872928..107e686ab207 100644
--- a/Documentation/devicetree/bindings/arm/intel,keembay.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,keembay.yaml
@@ -11,6 +11,8 @@ maintainers:
   - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
 
 properties:
+  $nodename:
+    const: '/'
   compatible:
     items:
       - enum:
-- 
2.27.0


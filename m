Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16343729D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhEDMIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 08:08:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40993 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhEDMIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 08:08:42 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ldtq6-0008ST-OI
        for linux-kernel@vger.kernel.org; Tue, 04 May 2021 12:07:46 +0000
Received: by mail-qt1-f199.google.com with SMTP id g21-20020ac858150000b02901ba6163708bso3380687qtg.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 05:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVesYaENPQnmH0Y+0cgUhUAMs63SA+oD/fSsjdC26ig=;
        b=QTeh4ip1y3PFGBiJHEinNMd8o+31wxAuGQxKYPsqPfE/EbBst5hZOyr4w+cIKrOp+K
         X2kA8N4qGFY7WZh19wRB0OyQrXVl04Je00ctazkQIrzhl5t9pa/h3/HvpcjZSu3mmrib
         QwY6mXlgGZdyk9I7hB6ws5YTbJaLR1n5s+jo2Oh8GBoWWkXNGFKrOiE6dpSGcBOq/N0M
         Swvj/bWLubLntweKh7ngoeYCuUO/8BikrLsTDHS5gJZ2WilGQCrdEiHncEoF305tkSQS
         6fVfxFNOh3cVxBgvqFvIFSDohmCZOUUogrfh4UBFd7SV1hdhWIOd4xBvR0ZDyciST6n3
         3zgw==
X-Gm-Message-State: AOAM531mpI00JzZ0EfJkg3BvfqVblXhg6InW8fieOfU5hqhI0FhDPWL4
        rvz75uduwgfXbVSyDbYT+50L15h1yGqlz0hKiBOal8KQMHFxHaHP3oAWOXQt7HIED6sqDhWISCa
        UiyK0GSlUNKrd2Cq3PTdsvjkbtzoov8JSqzuI8f24nw==
X-Received: by 2002:ac8:4d92:: with SMTP id a18mr22604000qtw.312.1620130065894;
        Tue, 04 May 2021 05:07:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoYrnnQOO1oFrRDt4NmqosElKRk+sv3Q4DZYT7DYboiQ2X0BbNl4S/vdfqvGbVcXiuckPC/A==
X-Received: by 2002:ac8:4d92:: with SMTP id a18mr22603979qtw.312.1620130065684;
        Tue, 04 May 2021 05:07:45 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.5])
        by smtp.gmail.com with ESMTPSA id d68sm10805112qkf.93.2021.05.04.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:07:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: add vendor prefix for Insignal Ltd
Date:   Tue,  4 May 2021 08:07:42 -0400
Message-Id: <20210504120742.12922-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Insignal Ltd (http://www.insignal.co.kr).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b868cefc7c55..92fa427d2a80 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -533,6 +533,8 @@ patternProperties:
     description: Innolux Corporation
   "^inside-secure,.*":
     description: INSIDE Secure
+  "^insignal,.*":
+    description: Insignal Ltd.
   "^inspur,.*":
     description: Inspur Corporation
   "^intel,.*":
-- 
2.25.1


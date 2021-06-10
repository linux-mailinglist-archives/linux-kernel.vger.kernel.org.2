Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD93A37EA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFJXbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:31:40 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34379 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJXbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:31:39 -0400
Received: by mail-wr1-f44.google.com with SMTP id q5so4043142wrm.1;
        Thu, 10 Jun 2021 16:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nt1QAmwrT7KiwVRGBb2sEf7u5dtEbfMgMB1Y3n/d6U=;
        b=Eq89jfHz5HtM/LYs41rCP41gcszr+5aevF46W868z1ggqWA7F2YEIbtWSBnz8t0fOb
         G5WKgiPzhOkWyom+ib0Q48I5t+kZYmWkM01ILBhz5ooilZCDOQ6fDUQI0C/CRGX1Fevt
         WK/MRIQOWUbg4yy1SFOB/Bs2aQwYzsopQ3ULXUwROcnkRK7HCB+JjAry/wYP99GgoyW0
         cwJRLfVel4p5nK31KDMlW2Sh5Qmhag7QVxJ3c3WjnYNI4yvk1PE0SWH39XfgUL+rOTfY
         iWOJlv7ngdCWc80UXbPKAwMAX0s7/Cik774swDTXSOXV5IRmoT/ZQycXo6PYKuWaC53/
         yYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nt1QAmwrT7KiwVRGBb2sEf7u5dtEbfMgMB1Y3n/d6U=;
        b=jLodAN62gBDry4HDRhQ8onOGVYPl91ETIGu24DCJzZUMqL+APhDcoYD46yqa4wT50p
         QNegc2MT6W7a+E+R55baaKMH2JZjDFYNqORrUpUqaQfoutiFRmW5sLoXQ+THi1A89QGH
         kwUNdUwVu4ew/X07yNTl1EpFjtS39PZWhEjNZl07l9UmW2hHbsuZlizwj3auGjHuWGFr
         zKbhJUZ15vGhub77F26dw+vnjdCXDDP+AM5fWN8BZwbLRAz5rKlmxiB7i5IwkD0l1vn8
         7C4Z8PX/63LRdJRwo+syvFxjHQ8jLFs9ZDx7OXRJ2Qbh6JbJJ3FwZxIYI8z5cW0vM1cD
         ORRw==
X-Gm-Message-State: AOAM533O1QSy6StgGuKe5M6rO+U+m3bBBXjOWAovwrOxrYmPVkJkanML
        6xvYhzOMP6peUnNa6tRjVC0=
X-Google-Smtp-Source: ABdhPJzkq1CzfZQJ8JofM0yC65tXnI8aWTVOPbJZPZymMPGbOqTy3A8A+IWO3hilqAsMDEWhYfPW0Q==
X-Received: by 2002:a05:6000:18f:: with SMTP id p15mr820358wrx.102.1623367705704;
        Thu, 10 Jun 2021 16:28:25 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id d13sm3196182wrs.41.2021.06.10.16.28.25
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 10 Jun 2021 16:28:25 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/5] dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65
Date:   Fri, 11 Jun 2021 00:27:13 +0100
Message-Id: <20210610232727.1383117-2-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610232727.1383117-1-mnhagan88@gmail.com>
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Meraki MX64/MX65 series. Note this patch should be
applied on top of "dt-bindings: arm: bcm: add NSP devices to SoCs".

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F04F3A876F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhFORWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:22:38 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:42817 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhFORWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:22:35 -0400
Received: by mail-il1-f173.google.com with SMTP id h3so15969116ilc.9;
        Tue, 15 Jun 2021 10:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Az/0fozoY6b7RLZTi5Hm+i0pDrgxovZi8IAn2kV+mrc=;
        b=izLxy3RYEeI64sV1IvUiZUfON9g80Y+5hxzDbeAi+pghoyQDQ6WI5PudLsgFBcz2ED
         cMKF+/9Z0mxfp/69QlP7OZTMChz8JOAZXplkVD4FxrDD1Np7TyzgMyWndFrRNo6CUC+r
         U/wmTUYIf5GB36pb6dMqJ7AyR+QXADY54lYfh1qpzcTkk512RcjUx6Ah/GFIu1qUHRgH
         C7we33bYpgHUD/fl6cuQamQsDx36Od5fPWoPhd1G/9Rno7cJjHTMzYNvO5I2ivsiV3ts
         yNMJEwZPcdbWLHukrWOMCvsUj8BgrL8O+cxaocOs7wsqS5ckeI5+snD7mAL5Eb2RK4Lj
         R0+Q==
X-Gm-Message-State: AOAM5327/gK4QWGKXQojAU2cT5vwRo7ssSSBYmK83wjZd3Rah2o9vXEP
        DKD5++NZeFdxv2wPzNh7v9FCPVAIaA==
X-Google-Smtp-Source: ABdhPJzwWLRquhqTkFno9O36gYQT7R6u6UI+7WWzQbtuZguRVivlUj9UTrTFrfLyeVs0smDCgLpx+A==
X-Received: by 2002:a05:6e02:1d1c:: with SMTP id i28mr421242ila.13.1623777627685;
        Tue, 15 Jun 2021 10:20:27 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id z8sm10540503ilq.30.2021.06.15.10.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:20:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] dt-bindings: spmi: Correct 'reg' schema
Date:   Tue, 15 Jun 2021 11:20:24 -0600
Message-Id: <20210615172024.856360-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'reg' is defined to be N address entries of M cells each. For SPMI, N is 1
and M is 1 or 2. The schema fails to define the number of entries as it
only specifies the inner cell(s). To fix, add an outer items list with 1
entry.

Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spmi/spmi.yaml | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spmi/spmi.yaml b/Documentation/devicetree/bindings/spmi/spmi.yaml
index 173940930719..1d243faef2f8 100644
--- a/Documentation/devicetree/bindings/spmi/spmi.yaml
+++ b/Documentation/devicetree/bindings/spmi/spmi.yaml
@@ -40,14 +40,15 @@ patternProperties:
 
     properties:
       reg:
-        minItems: 1
-        maxItems: 2
         items:
-          - minimum: 0
-            maximum: 0xf
-          - enum: [ 0 ]
-            description: |
-              0 means user ID address. 1 is reserved for group ID address.
+          - minItems: 1
+            items:
+              - minimum: 0
+                maximum: 0xf
+              - enum: [ 0 ]
+                description:
+                  0 means user ID address. 1 is reserved for group ID
+                  address.
 
     required:
       - reg
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9A730C8D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbhBBSCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:02:03 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39213 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbhBBRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:55:25 -0500
Received: by mail-oi1-f180.google.com with SMTP id w124so23678673oia.6;
        Tue, 02 Feb 2021 09:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PY1eqlCJkvXHbJWD80MmmPmZKyzxd9wr3f3PYIBpUVc=;
        b=j2A07y3d62hZyuNsSzk8N3+XBzUTeBkTqao3ARvqjHoZyFq9okLRknULxt5PjAyxeK
         QJvnlVIUlWXrRSscLFXbvnaa+y9HuqqXPTbvJ3LW3sw3srncRt/XrtrihAb0A9wyIdWd
         m7zNmgTp7JzlMC2GuL39vCzXw9C4tn+H0QoqZ05fW6NTKlCOTkUf6clMN3huyumgQ19a
         ZSXkTwfn/RDHEHq41UXZBDDaqc+7kj7kd8x/pdL+KSCtbdyvQVrbGxI2eyL0X6AutEpE
         UI/cSQK7vMkQhYla/vEoVe07bz55bYjQKiqSgANef0FOcRes2U4espQwPxpv2Zs1ymrw
         oAhA==
X-Gm-Message-State: AOAM533QoLhfRCBUgEfYYbn5RudnVqgqQAYGVQtR1GndZES6eOtAJSBJ
        j+fUZKROSzRVi9bV8gCUqSJlRzmuVA==
X-Google-Smtp-Source: ABdhPJxQVjkQxH7g11QJoQLfO7bARahwERaBawAPzAhaaOebgvT6fKeVG53K1OiEb7+d/ps6f6UBWQ==
X-Received: by 2002:a05:6808:48e:: with SMTP id z14mr3503610oid.167.1612288484209;
        Tue, 02 Feb 2021 09:54:44 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id l7sm6552otr.81.2021.02.02.09.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:54:42 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: usb: generic-ohci: Add missing compatible strings
Date:   Tue,  2 Feb 2021 11:54:39 -0600
Message-Id: <20210202175439.3904060-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210202175439.3904060-1-robh@kernel.org>
References: <20210202175439.3904060-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic OHCI binding needs to document all the specific compatible
strings so we can track undocumented compatible strings. Add all the
compatible strings from in tree users.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/generic-ohci.yaml | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index 2178bcc401bc..53df281f618c 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -14,8 +14,38 @@ maintainers:
 
 properties:
   compatible:
-    contains:
-      const: generic-ohci
+    oneOf:
+      - items:
+          - enum:
+              - allwinner,sun4i-a10-ohci
+              - allwinner,sun50i-a64-ohci
+              - allwinner,sun50i-h6-ohci
+              - allwinner,sun5i-a13-ohci
+              - allwinner,sun6i-a31-ohci
+              - allwinner,sun7i-a20-ohci
+              - allwinner,sun8i-a23-ohci
+              - allwinner,sun8i-h3-ohci
+              - allwinner,sun8i-r40-ohci
+              - allwinner,sun9i-a80-ohci
+              - brcm,bcm3384-ohci
+              - brcm,bcm63268-ohci
+              - brcm,bcm6328-ohci
+              - brcm,bcm6358-ohci
+              - brcm,bcm6362-ohci
+              - brcm,bcm6368-ohci
+              - brcm,bcm7125-ohci
+              - brcm,bcm7346-ohci
+              - brcm,bcm7358-ohci
+              - brcm,bcm7360-ohci
+              - brcm,bcm7362-ohci
+              - brcm,bcm7420-ohci
+              - brcm,bcm7425-ohci
+              - brcm,bcm7435-ohci
+              - ibm,476gtr-ohci
+              - ingenic,jz4740-ohci
+              - snps,hsdk-v1.0-ohci
+          - const: generic-ohci
+      - const: generic-ohci
 
   reg:
     maxItems: 1
-- 
2.27.0


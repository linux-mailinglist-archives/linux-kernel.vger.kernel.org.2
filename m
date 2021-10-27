Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0C43D079
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbhJ0SSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:18:23 -0400
Received: from box.trvn.ru ([194.87.146.52]:54355 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243469AbhJ0SSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:18:16 -0400
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id BB50041511;
        Wed, 27 Oct 2021 23:15:29 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1635358530; bh=ro7ZVSbXpCwuaZX3j2xP7JzBXPN1tirbnRREQXQvgG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTz7F78NmkuT15Mb+2mqqiyay21LWBApUaDgnM+9Sce+FK0ZFduUNS0Q0x5iUXdzl
         N+iNktbClL5YkHxZMbzLe4mHVf6mO2BpjFI0PzEzKrNTRgv5dFO+C45tEPxFSS8uPh
         jruL/gZfS9YUZ1ZWbYNXR/BZGGIWSsIAX0UC4YpVyVUSzTqPGeCldT1cRXR3bGRjUp
         cHcOIHctTKsGlyNq30YsAv/3xp6sWYOTZbggFvjXjSpDT43DWM2oGdQ5CF/IstYrUZ
         mp7GBqrGUJ6xbgrgtY1hqzOHQf3UBB0ZeWZhiL9Xx5RhS8IlN0rx6ZRuJO6625xuQZ
         ww6VIsCgUiPPA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, Michael.Srba@seznam.cz,
        linus.walleij@linaro.org, broonie@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 5/6] dt-bindings: input: zinitix: Document touch-keys support
Date:   Wed, 27 Oct 2021 23:13:49 +0500
Message-Id: <20211027181350.91630-6-nikita@trvn.ru>
In-Reply-To: <20211027181350.91630-1-nikita@trvn.ru>
References: <20211027181350.91630-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configrations the touch controller can support the touch-keys.
Doucument the linux,keycodes property that enables those keys and
specifies the keycodes that should be used to report the key events.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../bindings/input/touchscreen/zinitix,bt400.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml b/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
index b4e5ba7c0b49..40b243c07fd4 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
@@ -79,6 +79,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2]
 
+  linux,keycodes:
+    description: |
+      This property specifies an array of keycodes assigned to the
+      touch-keys that can be present in some touchscreen configurations.
+    $ref: /schemas/input/input.yaml#/properties/linux,keycodes
+    minItems: 1
+    maxItems: 8
+
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-fuzz-x: true
-- 
2.30.2


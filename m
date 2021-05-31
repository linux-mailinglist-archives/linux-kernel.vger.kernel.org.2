Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506A7395E31
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhEaNzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 09:55:25 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:12665 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbhEaNgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:36:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622468096; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CDlKXnxCVJpX5VaZyyVKIdYwX2+CAPl4G0S86ug9RWhIdIuPN1tlO2ux3mJlVQh7L0
    UA+8WmYXl5yiQWwB4IZ4R3dnBE+oD2C0mrkPg7Z5NqcqmtSsQapxhR0rfnYt0soFxubH
    85RnfvEBnCbgp/IPtxA3TxtdGxkPNEo0lkwonpzNQOcE+C9xsZWpu1TbIP8t8Q+sLJ5n
    aN/rHT7nZfE1anyUOX4Bli5+EfK0l/QaJuAx8o8okqtaoPfeY8eIkxCq/0MhoN4PvnAI
    AXvuxEjQeXyIwTfjLl0KAcCF6qGscsSJaONW8zSx2TOiVQB9WmBvMocA8TpUjOw4OS1i
    qDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468096;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WusjepEf0ImZGQpetBmFDA0rblZD8nyERdVuhtSp86Q=;
    b=guwQoK6kE+BoqqqfvO+UdILye34ofV1XkqLTAz60XwTuC0yf8E2IYJ9AdYRZGSjIuW
    iHqaD87Kivxi6LvYSM9ypVBGMcQI9Lo32UFSlEcxX/zR+5Ulhy4WoT7WdCpuMOitFGkM
    jrD2GV0fEoDnvaYv3vTQk/vH8Et7U5nYpmn7p40yQniGBCOJv6vofyhngPuQGPWx0lda
    2am5b17+E412Noloi7Tc7T+vpp8Wl/znYqueDvFSvEq8QqFi0yWvTVMjyt2HCV9Pa5+Y
    Z4ZZQwCdN7Nd7x0L4OaeVpWnvvoPeywalBGsGoctQ3fmPGddb/Km/j6LMd36qaH+Nr+4
    nqjQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468096;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WusjepEf0ImZGQpetBmFDA0rblZD8nyERdVuhtSp86Q=;
    b=oEazqH9Kcbio3XlIs+c4mVsCSQAP8f4SqoKbzqDnjS4eSOkd5jJPoDv+vAdRp6GHRo
    6DdmxAvuIbO6RLDEKvU7gWaxGBSkJZGmcDWUNJg0xUmaO+cTVxjHe5OLYhXv14jyPzdA
    SMKWyIjK+V9iBqv3eHEnFv1gIKjXUMGMRusCMsx8A7K4GgwZE/LDXCx/UzvUcAfshVk0
    9XqwOm4kPOgi619BVlmVpV2jUmUMe1WYGC9EO61WB8exaIw4pCv5ZCIaDVjJCYM2V3vl
    4VHfu9la5UjrdhNip0JTrYmki2cX63Vb7ZyrGi+PgNu05SJqQdLEBVelffzr6HYLBgB1
    TQtQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526Kcak="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x4VDYtKxC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 31 May 2021 15:34:55 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 5/6] dt-bindings: extcon: sm5502: Document siliconmitus,sm5504-muic
Date:   Mon, 31 May 2021 15:34:37 +0200
Message-Id: <20210531133438.3511-6-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531133438.3511-1-stephan@gerhold.net>
References: <20210531133438.3511-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for SM5504 with the new siliconmitus,sm5504-muic
compatible.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/extcon/siliconmitus,sm5502-muic.yaml           | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
index 0432b0502e0b..fd2e55088888 100644
--- a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
+++ b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/extcon/siliconmitus,sm5502-muic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: SM5502 MUIC (Micro-USB Interface Controller) device
+title: SM5502/SM5504 MUIC (Micro-USB Interface Controller) device
 
 maintainers:
   - Chanwoo Choi <cw00.choi@samsung.com>
@@ -19,10 +19,12 @@ properties:
   compatible:
     enum:
       - siliconmitus,sm5502-muic
+      - siliconmitus,sm5504-muic
 
   reg:
     maxItems: 1
-    description: I2C slave address of the device. Usually 0x25 for SM5502.
+    description: I2C slave address of the device. Usually 0x25 for SM5502,
+      0x14 for SM5504.
 
   interrupts:
     maxItems: 1
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121C4400BA1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbhIDO3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 10:29:22 -0400
Received: from mx.msync.work ([95.217.65.204]:48086 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236621AbhIDO3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 10:29:19 -0400
X-Greylist: delayed 116836 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Sep 2021 10:29:19 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E981D848A;
        Sat,  4 Sep 2021 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1630765695; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=fPLTKd8LlOzoI4ZFKG/vdJe5fbB/TRLUEFV1mGcBBps=;
        b=CSkxB77gr/b/DJdC/YjIvGptG5KI1TX5ZBU/F/JgU+mQsnD4xjKEytk6AwtB0jvAkUMKIU
        Q4ufSqwuYNwOWW7BaBPTdc6s/2hpzCnMKtYen+zn1h4RZzKuGPAUkghEC8zjLCQBP15Otv
        ULt8tqivmtV5k6DKrNj8szQb6Ht5cgclT4L/2qbiejkxyT5x23o6w2dVEEgURCIdecN7Dr
        pPKZw0EN2wGnXiuY/Cc/TFGmJ7AK4EGZTKvunWNz07OWyKD19WtGoQE6j4abThoYanGH2A
        lI8xDPRpYfNdqDF1zKF91BuvmTFwB7BECKAm/PhfX/PwvSH0xgc5NdjoxBAEDQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 1/4] dt-bindings: arm: amlogic: add bindings for Jethub D1/H1
Date:   Sat,  4 Sep 2021 17:27:42 +0300
Message-Id: <20210904142745.183875-2-adeep@lexina.in>
In-Reply-To: <20210904142745.183875-1-adeep@lexina.in>
References: <20210904142745.183875-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JetHome is a series of home automation controllers:
- Jethub D1 based on Amlogic A113X
- Jethub H1 based on AmLogic S905W

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 6423377710ee..b223d7829c3d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -86,6 +86,7 @@ properties:
           - enum:
               - amlogic,p281
               - oranth,tx3-mini
+              - jethome,jethub-j80
           - const: amlogic,s905w
           - const: amlogic,meson-gxl
 
@@ -133,6 +134,7 @@ properties:
         items:
           - enum:
               - amlogic,s400
+              - jethome,jethub-j100
           - const: amlogic,a113d
           - const: amlogic,meson-axg
 
-- 
2.30.2


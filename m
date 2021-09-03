Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD303FFA17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 08:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbhICGCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 02:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbhICGCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:02:02 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BE6C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 23:01:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94355D50BB;
        Fri,  3 Sep 2021 06:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1630648860; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=5AST0dnrP28CYScPQA4dGXy3BMvm9dDouxDZK1j+8X0=;
        b=mN35dW+WJK6S5KKcJlfha2zR0C5XGlC+DBtq8skAFT2hpCibROZK1+MjBR0XyPIlStIznI
        bq8CDzGZ89FL3uyT1KSwPXKMtWDYVyCW3gTEKgeBejXLyJ81upEFjsacsqb44HOy5Id+x1
        rowaE6yoU6fl/Ad0+sft8c4qlHW4ubtONphEwh3Cs4mwOVdji8JPJxLnSwzVaglKNO+2/2
        dzVM9IGdqa1VCCpyYNS8vU9+jnCH99I3Hp2Zu+YggLueZUWTM66IbyAVXWAAvsksH9TDOr
        pe0IXr8fL4sqVHXAM9lddmSdviSQg4NNCGCMpiLf1cDFhvWyndluUjykMiGnyQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: arm: amlogic: add bindings for Jethub D1/H1
Date:   Fri,  3 Sep 2021 09:00:33 +0300
Message-Id: <20210903060035.844758-2-adeep@lexina.in>
In-Reply-To: <20210903060035.844758-1-adeep@lexina.in>
References: <20210903060035.844758-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for JetHome JetHub D1/H1

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF163FEE76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbhIBNNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:13:48 -0400
Received: from mx.msync.work ([95.217.65.204]:51318 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345090AbhIBNNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 672B5D3647;
        Thu,  2 Sep 2021 13:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1630587943; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=xcwigKA/TswIEJuTg408Jja4+VnovgJK0WnN/XEuLU8=;
        b=L6qwZAOCZhoEB+u2fFGneE+taf8Qt5CnnaTiGpw/dskthLVYgafWqUX6UQ0HWgCofDTPtG
        wetOSZlzE7SkwmwzwFeSMC8szZMxFTKLilJmINy7RYuF3MtJcIC0AwfbwDMV2lbaTSXgQx
        yGqB/Fkkc3lCrHaKTz9vQVkVCcY7/iQc2swEN0VjqJQNsZnD8uStydbXeKASUeJh+siTch
        53qAlpAf1/NbtSyW4ZH7CaWAfEUO0r1Q/56rTXklt5uQzWR8B9QKw829XrGe6U7636CX9j
        Ia6VvMmdApz0Ok5G4FRX+7T4UFMy7V85LNwMJj5hrseKPph/YExHscCYQkGCGA==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vyacheslav Bocharov <devel@lexina.in>
Subject: [PATCH 3/3] dt-bindings: arm: amlogic: add bindings for JetHub D1/H1
Date:   Thu,  2 Sep 2021 16:05:16 +0300
Message-Id: <20210902130516.3892452-4-adeep@lexina.in>
In-Reply-To: <20210902130516.3892452-1-adeep@lexina.in>
References: <20210902130516.3892452-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vyacheslav Bocharov <devel@lexina.in>

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


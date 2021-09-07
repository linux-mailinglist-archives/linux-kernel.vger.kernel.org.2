Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8791D40269B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbhIGJ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:58:23 -0400
Received: from mx.msync.work ([95.217.65.204]:33258 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231225AbhIGJ6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:58:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14892DDAD2;
        Tue,  7 Sep 2021 09:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1631008634; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=kWatsbnRYouuldwb6lqvB/sV7amJutWYUknSlMpmpCc=;
        b=RhCvPNC+cBq6teI/QjU4cnw+F0T9io+50UQTKIBWnDMWV51g2G/OOpj0canF3XdRYZmx+z
        nm/eHXf8y/0jSOVVCQ/Rh+D3Fm9A1jSOAXljh3uOOR7JQ1+UAqC/DA1d3C1hIZ9amDoqun
        XEsw8uViX2W1YaueC43yvwsSkWlYWx8rxPDF6POQMDr1AhSUaOgtSqeWcFSqJ+qd3i85My
        VqgZwAnusSL0AeIEwP/GrXBfmD3nFJresqI3paXR9PwMegbBi/mBWpNeBaJotRinriUGiS
        eVSisse+X0GO2rwzM96xmpcLRFb4cTYdwo/ge/CniVlNjcaN0r2dwTzjz4WEyg==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: arm: amlogic: add bindings for Jethub D1/H1
Date:   Tue,  7 Sep 2021 12:56:02 +0300
Message-Id: <20210907095603.1520109-2-adeep@lexina.in>
In-Reply-To: <20210907095603.1520109-1-adeep@lexina.in>
References: <20210907095603.1520109-1-adeep@lexina.in>
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
Acked-by: Rob Herring <robh@kernel.org>
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


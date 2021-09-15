Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A2B40C230
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhIOI7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbhIOI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:59:22 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CD7C061574;
        Wed, 15 Sep 2021 01:58:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACE13F6294;
        Wed, 15 Sep 2021 08:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1631696282; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=riBzg7yfs/WKceqbRh7CnMdVZOOQ2QoEgRJlHcvkjSY=;
        b=JgTVbSVFBu4BpdB/IflXWld7UiT+Wnm2siehcXJ55MMksHUXAYJcedxSsrhJfo2RyQ1f4Y
        Hl0Jxl6juv5JKZQtvtZoSQxBc8gr3Q3MxYxkb4f1gfQSwaPYg5pDLsWjhl15J861+X8e9I
        qsjqlwsgxoHH0muFS2gDNW6H2aLZvmIcybb6gnSAMh7HgLhYICCG2YKhO5XQ7VlG1ZqLle
        J4IiWHKM0RnmGFkGf8JCjPmp0Pr42hvmQBKufkB5WP8riZ646uyEoxkMLhZszZq7LAKEJ0
        BoKM7w4kb3FB0ZQJ0QAom8kGQkVEP8UnKKrwQmGyI0hWBg75nMHgGMEs3T6pHg==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 2/4] dt-bindings: vendor-prefixes: add jethome prefix
Date:   Wed, 15 Sep 2021 11:57:15 +0300
Message-Id: <20210915085715.1134940-3-adeep@lexina.in>
In-Reply-To: <20210915085715.1134940-1-adeep@lexina.in>
References: <20210915085715.1134940-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JetHome is trademark of IP Sokolov P.A., manufacturer of home automation
devices.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a867f7102c35..c52f0d3261bb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -577,6 +577,8 @@ patternProperties:
     description: JEDEC Solid State Technology Association
   "^jesurun,.*":
     description: Shenzhen Jesurun Electronics Business Dept.
+  "^jethome,.*":
+    description: JetHome (IP Sokolov P.A.)
   "^jianda,.*":
     description: Jiandangjing Technology Co., Ltd.
   "^kam,.*":
-- 
2.30.2


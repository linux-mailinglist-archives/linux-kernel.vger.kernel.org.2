Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9332C404843
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhIIKNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:13:53 -0400
Received: from mx.msync.work ([95.217.65.204]:41830 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhIIKNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:13:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CFA7E380B;
        Thu,  9 Sep 2021 10:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1631182358; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=rYcxstF7M6GvEU4BC2Fn3rACJTfIsjKUu2jpC7WXlQs=;
        b=DDDwvohDTp0F4Z+dsZTEkO5/GRP18FE6KJEMbssKTSru2uRnJw0Au3uEP7WiayHD6b2Q2Z
        Hb4cccTh7ZsUTnozPnZo5XuUym8BC7TiQsX5zspqxpzgE8BoWXAqrSV/UX934aS9K0pGcp
        vyh6GamTHKLqXRvCTzqVrBGW2QWW7c1UMm455j8ZbdDDck00bsZhJ7AruSf+sp7Vgh96kz
        NLuY2Mnh5Rv3+fprKJ16FWNH+6cQfPi2kLCdlZLuDXGKT3KrE6apbczvrAtqsf6J7oA/6p
        0cMLujmZv8VXopN41/o3gS/qEzDgm6qlfnhbbaN1p2Prp9sgQfXnss32zLjDSA==
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
        devicetree@vger.kernel.org, Vyacheslav Bocharov <devel@lexina.in>
Subject: Resend: [PATCH v4 2/4] dt-bindings: vendor-prefixes: add jethome prefix
Date:   Thu,  9 Sep 2021 13:11:57 +0300
Message-Id: <20210909101158.362075-2-adeep@lexina.in>
In-Reply-To: <20210907095603.1520109-1-adeep@lexina.in>
References: <20210907095603.1520109-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vyacheslav Bocharov <devel@lexina.in>

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


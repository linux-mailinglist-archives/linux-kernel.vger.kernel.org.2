Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9262740269D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbhIGJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhIGJ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:58:59 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1171FC061575;
        Tue,  7 Sep 2021 02:57:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1EE96DDADC;
        Tue,  7 Sep 2021 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1631008671; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=riBzg7yfs/WKceqbRh7CnMdVZOOQ2QoEgRJlHcvkjSY=;
        b=Z3goJXcr3/+/pQ4+YeJ/XtcNiz4VP2WsvidPZTWNAn0yKuxXWZFON5AIREmCUsueRdWS+W
        Ld4EMqzCJCkAD8JeP8/BUPjf2CpqFAwJAedjsS9fJGePMO8IIvWMeKRH1Cm2HEfwhMnPat
        xD6GryTFeFXkHLEler5EGdEBzLPY79uq3T+GAcULoQsK/0N6S1aczZ1kNlQ/mWdrxIA1U2
        Q2rAyY4yMlqFJwzck0TdHx0sHATAdbbPKiCDL9PKQZCf87uLjfCN5ATZQjHNAT8M4/1tBb
        SyvoBAA3He5NPXli4MfiAd9of8MnhbYP60rSdYV3DwD/GjvbGAPa9iiN4n6g3Q==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: vendor-prefixes: add jethome prefix
Date:   Tue,  7 Sep 2021 12:56:04 +0300
Message-Id: <20210907095603.1520109-3-adeep@lexina.in>
In-Reply-To: <20210907095603.1520109-1-adeep@lexina.in>
References: <20210907095603.1520109-1-adeep@lexina.in>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DB040272E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245682AbhIGK3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245598AbhIGK3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:29:02 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A9C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 03:27:56 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNYKY-00CH3N-8I
        for linux-kernel@vger.kernel.org; Tue, 07 Sep 2021 12:27:54 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNYKC-00CGx0-BC; Tue, 07 Sep 2021 12:27:32 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNYKB-000COo-RM; Tue, 07 Sep 2021 12:27:31 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Joel Stanley <joel@jms.id.au>, Daniel Palmer <daniel@0x0f.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        John Crispin <john@phrozen.org>, Bert Vermeulen <bert@biot.com>
Subject: [PATCH v2 1/5] dt-bindings: Add vendor prefix for Airoha
Date:   Tue,  7 Sep 2021 12:27:18 +0200
Message-Id: <20210907102722.47543-2-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907102722.47543-1-bert@biot.com>
References: <20210907102722.47543-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

Add vendor prefix "airoha" for Airoha.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 07fb0d25fc15..e9c956535f97 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -333,6 +333,8 @@ patternProperties:
     description: EBV Elektronik
   "^eckelmann,.*":
     description: Eckelmann AG
+  "^airoha,.*":
+    description: Airoha
   "^edt,.*":
     description: Emerging Display Technologies
   "^eeti,.*":
-- 
2.25.1


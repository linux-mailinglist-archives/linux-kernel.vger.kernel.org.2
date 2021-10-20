Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1339434F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhJTPhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhJTPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:37:05 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08AEC061755;
        Wed, 20 Oct 2021 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=cIUI/bXHveWZMR9h3CdEbhAxpYfGQQQHM8NqLPkSilg=; b=NQZEQoYyrcI8/h8BjsnLOmTZkp
        Pl2qfCJah9DM58+XAsUHNx4D+7zA087HBqJatVCUXqm/LwiPA1ChBe/na7VooPqA01dDgRI9TnpsQ
        QhjuyphbNDhYpdk9AY414QOjQlzbDNnnKwM1XEUR+5vdl59Kjc8RukekiaJSoo6GvEua9RuVLRQTa
        yjxlkOO9/iC6EHNHkga5Qba2wpoAucEylHEAcGAtx/bJe7j4BAfOF9EC5n1YUJL2soZwoC6p143mr
        bXYgmOqU+TIrFsZWy0Or2fY8eQL7BgMnZJXfKckkltRw/Gv/a8sC1JF6YrpC1Mipke0jV5klAH606
        /QWTJH4A==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mdDc1-00043j-3n; Wed, 20 Oct 2021 16:34:41 +0100
From:   John Keeping <john@metanate.com>
To:     dri-devel@lists.freedesktop.org
Cc:     John Keeping <john@metanate.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: ili9881c: add missing panel-common inheritance
Date:   Wed, 20 Oct 2021 16:34:28 +0100
Message-Id: <20211020153432.383845-2-john@metanate.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211020153432.383845-1-john@metanate.com>
References: <20211020153432.383845-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The properties below refer to items in panel-common.yaml, which means
that needs to be referenced in the schema.

Signed-off-by: John Keeping <john@metanate.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index 07789d554889..032bae7891ad 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -9,6 +9,9 @@ title: Ilitek ILI9881c based MIPI-DSI panels
 maintainers:
   - Maxime Ripard <mripard@kernel.org>
 
+allOf:
+  - $ref: panel-common.yaml#
+
 properties:
   compatible:
     items:
-- 
2.33.1


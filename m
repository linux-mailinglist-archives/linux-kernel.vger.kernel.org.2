Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269F8434F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhJTPhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhJTPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:37:05 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBC6C061753;
        Wed, 20 Oct 2021 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=9wQxL1mQCD9KGWokSJt4JLAUUu9p5wZhKYOiCzkRPr8=; b=Sqc32ZaSmRhE4g6JHhpl9FhuZX
        6m1+KBe285RfgiuN0/zH4Sx6THM9mdlS9aGD5WICZIAnSyFEQCTksXV+MUQxQo1xRjRYG4l1tOfB3
        zXGUOxeSGfGDko1T9Ngifrc8LILHmdKu+ZGQmUPwh2MgDrZNTXqJ9t9yHQ4bFE6qRaEZSmeV77oSV
        C4H+eNoktjxvCUB8VcG/yfz2OTRr/Q0taNyA9E/McaJyZiCpG4n8D4a4/aENocqymNFr5Y2Y02qWi
        2CO5hmz1p5jiCXHSBHRzMlzrMmgaLfhNnF6W3f1SycM1dkaQEeDpDoI/PY0d/yLZ6D9XOkCK5jiic
        sx/eBjHw==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mdDc1-00043j-Qh; Wed, 20 Oct 2021 16:34:41 +0100
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
Subject: [PATCH 2/3] dt-bindings: ili9881c: add rotation property
Date:   Wed, 20 Oct 2021 16:34:29 +0100
Message-Id: <20211020153432.383845-3-john@metanate.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211020153432.383845-1-john@metanate.com>
References: <20211020153432.383845-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the standard rotation property from panel-common for ILI9881C
based panels.

Signed-off-by: John Keeping <john@metanate.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index 032bae7891ad..c5d1df680858 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -25,6 +25,7 @@ properties:
   power-supply: true
   reg: true
   reset-gpios: true
+  rotation: true
 
 required:
   - compatible
-- 
2.33.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6441A177
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhI0VsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:48:08 -0400
Received: from ixit.cz ([94.230.151.217]:32994 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237009AbhI0VsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:48:07 -0400
Received: from localhost.localdomain (78-80-24-171.customers.tmcz.cz [78.80.24.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id B972E23B26;
        Mon, 27 Sep 2021 23:46:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1632779186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iS6TSh/x26e3Xty4xcu1zsYhQ7HEjDLQaU5989GXvhg=;
        b=ws808cCAZxxCbuirgJxzA6SVsOTuqTk1ej8A0MaPNaH6TVeY9ZqB05dyhLJ4rlVmJFc2pi
        7Ql4Rpy5hq5TYj6A7IK2Y6do1Qt5fKGesgtFd3Hkjnjn6Fqh+X3xhfnipsZ76bxrj4KsOC
        vyjOPDilN1PFiTCqFqquuhdfeU+F100=
From:   David Heidelberg <david@ixit.cz>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH] dt-bindings: display: simple: hardware can use ddc-i2c-bus
Date:   Mon, 27 Sep 2021 23:45:03 +0200
Message-Id: <20210927214503.36012-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both hardware and driver can communicate DDC over i2c bus.

Fixes warnings as:
arch/arm/boot/dts/tegra20-paz00.dt.yaml: panel: 'ddc-i2c-bus' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /home/runner/work/linux/linux/Documentation/devicetree/bindings/display/panel/panel-simple.yaml

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 31f678636717..e4d93e0ddfc3 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -319,6 +319,7 @@ properties:
       - yes-optoelectronics,ytc700tlag-05-201c
 
   backlight: true
+  ddc-i2c-bus: true
   enable-gpios: true
   port: true
   power-supply: true
-- 
2.33.0


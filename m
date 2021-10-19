Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5304330AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhJSIHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234776AbhJSIGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A1F861374;
        Tue, 19 Oct 2021 08:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630673;
        bh=CTjNTHuzm1+dw0qCGQwqzQ2l6G0E8eItZGg614Pb4Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgeVgKTHdLBKbMHUOio8NWHZBo3Mguyd783BpVUtfL5AkWYgS4V9BINR3aZLEIbfz
         TJvV5SQcWQjsmBEhYVvr7R8WWzXkcmHr49glfaSEiVkh/9XB3AXYCWNDeLDqm7gq8E
         GdzQtzW8+iRsYm3+aK4J/M/NEpCmMGfkBwTU7jgIvGwO0ubmgtRPxIGc4HQQ/a6CqR
         urdXTPW+aX8wosr6xxPhafTfK30w2gQ0lKMGNnpMHmlTZCFwx09ANp/P9ev2oyu7Xk
         nEtx7By+7zNG+BcIBOMxPnxIjvtQf7RnHg/y//+/GCP5mlPcgRGBF5FPhQ7UC7t9Ho
         rSUubAE2d9m1A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJs-Ap; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 22/23] regulator: dt-bindings: update samsung,s5m8767.yaml reference
Date:   Tue, 19 Oct 2021 09:04:21 +0100
Message-Id: <63f3ac8bc958d65e4f31ad4a0060c21a7038cbde.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file name: Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
should be, instead: Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml.

Update its cross-reference accordingly.

Fixes: fab58debc137 ("regulator: dt-bindings: samsung,s5m8767: convert to dtschema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 .../devicetree/bindings/regulator/samsung,s5m8767.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
index 80a63d47790a..4281f670c775 100644
--- a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
+++ b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
@@ -15,7 +15,7 @@ description: |
 
   The S5M8767 provides buck and LDO regulators.
 
-  See also Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml for
+  See also Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml for
   additional information and example.
 
 patternProperties:
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BEA43309D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhJSIHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234658AbhJSIGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7B256139F;
        Tue, 19 Oct 2021 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630667;
        bh=gsKBaH9q3OVaMoNE0kvFdv7QLCiWctt440OZf7GewRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UI8VyPCJfjmi4BGaSboi3ejg7uCkGueU5dvpqeKAT1pLFxoVaVK/MPiU/0gtdggza
         BJTyCb013M0erUVrsJsZQvGZlrPrQMQARdaz7LWXm0S7KA+UTeiYTRXdtG6INc3cmL
         IdQpZ4AqIQ3UFK012tUXoxXE/ilVHXlRq6nWLWYSkDZx8W3foJRgoH3g6/GRZxIgWG
         3YoGyvDBSVXK2lEEPVXtcC4htyqIF9ILSSiYaQI9mtJr8pflqyXq37NNVNFPvfqWW4
         N+KJYwSTyKy6EA4lYn00FOaBR4vGoN9wNqIrp6PefQClKQLME66YxU6prPmLqgtckW
         /1Jirl6BMqZyA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJO-6K; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/23] MAINTAINERS: update mtd-physmap.yaml reference
Date:   Tue, 19 Oct 2021 09:04:11 +0100
Message-Id: <cdf3891ef686eca67c6072da8c1d027eedc1ef3e.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
renamed: Documentation/devicetree/bindings/mtd/arm-versatile.txt
    and: Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
to: Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.

Update their cross-references accordingly.

Fixes: 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66c6c27d2209..d74b08c4fb1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1421,7 +1421,7 @@ F:	Documentation/devicetree/bindings/auxdisplay/arm,versatile-lcd.yaml
 F:	Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-versatile.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
-F:	Documentation/devicetree/bindings/mtd/arm-versatile.txt
+F:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
 F:	arch/arm/boot/dts/arm-realview-*
 F:	arch/arm/boot/dts/integrator*
 F:	arch/arm/boot/dts/versatile*
-- 
2.31.1


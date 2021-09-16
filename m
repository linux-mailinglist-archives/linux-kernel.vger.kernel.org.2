Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1AA40D5BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhIPJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235461AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79A4361250;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=ObUOrN8DkpMRmrNjKqFNjb9vwSqgX2e1RpBmk3V2pTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qb9mUf7hlN3VF+F6jzNkEQnPZayRGKlsqC4W3xgKjz+bBlsYXBlWvyy/5rESclkNi
         mG3VSg7Skop9cIAK5RgJcqqM7sOj3gVt/oZaHxJ4X0pMAQRoS5S3u1nAXcwTRCGfaf
         FecQqB8kKRhGy0K06OcyH1icDZx7B3d31CHIyfhRw+udI6/CXR+6PLLRNzN5npL7iw
         J/40LQybQDD69DOQbxaJFh89aORSDtmoa8Q0y4+3u11I20tzdSpT2ZhEoqrurlVCLR
         mCae/JAQNTNA60p1EdOX4BukYrT9F1d2CFzWg77uFpAMlsWskAZSeFoK9+vv51id9t
         q6/7KaDr+6uig==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTH-001sLK-MO; Thu, 16 Sep 2021 11:14:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/24] MAINTAINERS: update mtd-physmap.yaml reference
Date:   Thu, 16 Sep 2021 11:14:04 +0200
Message-Id: <bec831b1bc9ce6e4f6e051e7f5a784c23f5a3822.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
renamed: Documentation/devicetree/bindings/mtd/arm-versatile.txt
to: Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.

Update its cross-reference accordingly.

Fixes: 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30f75af400f3..0ea4cd772a0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1411,7 +1411,7 @@ F:	Documentation/devicetree/bindings/auxdisplay/arm,versatile-lcd.yaml
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


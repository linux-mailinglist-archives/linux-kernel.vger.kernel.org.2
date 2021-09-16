Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E1C40D6EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhIPJ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236277AbhIPJ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A57FA613A5;
        Thu, 16 Sep 2021 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631786126;
        bh=dsZWgNF0NwzkjR4lsYvCv7jdzTQGzPygTc9zHU0E0PM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xr87Yz8bwIwCZnu1pTjnJEib1G8vUl8L1ZkSjKOrvw0Q/k+bUwSYmhY2YMHxXaMTK
         TcArMJbHaMwdHCx84reqyucyekP1k9oBVQdvNJ/Da/eNeGRaxixOW8r176idW7wG99
         SaWfYoXS+BgYW50XedjiVXuNasr3uDwbm7jGLBjY3vmpVj57coPa+Y39Ak2K2oqtf2
         Z46/7uPa+4lGfcCOAMcOZ/2LidnAQ7x0P+r6F9qcEV3vDXIrelYJQoFF7q+silWmpy
         WUkobwmb5Ye4rydpoTccApNSQ5sZNzlkneac4YKqVfL/IU2otXFsR9tp+uim+tk54n
         LnjtdsfGBPaSg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQo72-001vUk-V0; Thu, 16 Sep 2021 11:55:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/23] MAINTAINERS: update mtd-physmap.yaml reference
Date:   Thu, 16 Sep 2021 11:55:21 +0200
Message-Id: <bfb8c8a4625ff59a91bcc57b84c490cf686df37c.1631785820.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631785820.git.mchehab+huawei@kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
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
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 819b9711dd77..067ae42b53aa 100644
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
@@ -8724,7 +8724,7 @@ S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
 C:	irc://irc.oftc.net/mtd
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git cfi/next
-F:	Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
+F:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
 F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
-- 
2.31.1


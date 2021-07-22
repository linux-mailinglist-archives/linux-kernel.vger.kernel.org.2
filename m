Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BC43D2199
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhGVJUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231569AbhGVJTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D80376127C;
        Thu, 22 Jul 2021 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948021;
        bh=u0WPNC8wo05c/mR6al+UtB2v1oU8vNnHVxOUiCzMQTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehl+WoGvWhtdC1VmESqxGw5eQ2xdD+PS0j0QuCK8gSF4NtQwZJCu8CxwQKSMNqAP7
         o+zwO6pb0WBtzgL2OTccXKkX7+TcQUONGiZ7AkgPhwGuCc9WDjnUZYlS+5+VLaX3m4
         BbvP1msM4P2EGmQHgPlXu4Tuy8KjbJZmyhsUFzT8gTkKT2084R3ybjRHjVKtBW/km5
         HGgSk3jiX56bdXidLVj7YZ/jUcAvnoRe3oADRc9PHDQrZAfdnJ9LuN0CMhg6NlcBvl
         kLYgdF4KkPxt9G6Y29rzT84vT7xpet6ZjiaDKHuz2IhMb1ZDdChgWprdM9HN/lPpjt
         BwkkscYSUqiEQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VUz-008mHa-LM; Thu, 22 Jul 2021 12:00:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] MAINTAINERS: update mtd-physmap.yaml reference
Date:   Thu, 22 Jul 2021 12:00:01 +0200
Message-Id: <24957d89f650521bfe27c64722110d6fb0d26921.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
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
index d69b2d4646be..76acb9fe0622 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1386,7 +1386,7 @@ F:	Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
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


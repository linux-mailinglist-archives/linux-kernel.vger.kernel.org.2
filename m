Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CCE433099
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhJSIG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234573AbhJSIGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F7D16137D;
        Tue, 19 Oct 2021 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630667;
        bh=WbIS3zLX4b+lpey5llTk11BCK1Eue7IkhNgcT2ZExL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wir53G9ijpvM6IQlaK2oaDYBKlDDhIohgSh0yId8zsCd+4kDpCicV1iox8x1Wl+tV
         Igk4i0BbM49Q4q/JXqoVXy84dKJXUarieX9nKlDgixIQjJIwIc9VOO/PUm2X2UccxK
         55JRPb+dRFwojeoyydLOoiXR/+TasKTT8PVJx6aiW6dawXuS9OrACONcuVhHuzrmyI
         wA4Xp9PfmblPRw57w9zqsqqP+r30VXs0mHUfWPUj1Ub9zyEp/MpiK9P++nqs4DJu7B
         Ly2E1BxVkE3q2pQ7a4kT9zPBSvYiV7Ba8CKSDuqKO38PByEOoPtuQzRQboNK7A7UK6
         XvI10o7b2jxgg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJ3-2Q; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jamin Lin <jamin_lin@aspeedtech.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/23] MAINTAINERS: update aspeed,i2c.yaml reference
Date:   Tue, 19 Oct 2021 09:04:04 +0100
Message-Id: <02d5ddbccdba665901221b9a2ff512e23f9aa4c5.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 810e4441946c ("dt-bindings: aspeed-i2c: Convert txt to yaml format")
renamed: Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
to: Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml.

Update its cross-reference accordingly.

Fixes: 810e4441946c ("dt-bindings: aspeed-i2c: Convert txt to yaml format")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 22efd0c518a1..fb898af23d0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1758,7 +1758,7 @@ R:	Joel Stanley <joel@jms.id.au>
 L:	linux-i2c@vger.kernel.org
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+F:	Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt
 F:	drivers/i2c/busses/i2c-aspeed.c
 F:	drivers/irqchip/irq-aspeed-i2c-ic.c
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E33D219D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhGVJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:23:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhGVJTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89B9C61355;
        Thu, 22 Jul 2021 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948021;
        bh=R1KJ8qW4vHKhZHhaTSE7lbeQx1ryVxlFuUpdT5Gf3jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8bXm+PXO9s65o6vrLTxPlAgAPZeP8KL8C03G3uX3sWMnogpKJ+NG0tZYQC6/X3BC
         sL1DKPccyDy3U8RK+6Vg3PPgI+UR77IdHfIZAZ64np+yaaR41IwnqXXUqRXLHXVfNO
         DTdc8bc4vMWn/O6afPJkoIKpmx7RkjRRNPRizAHlHxT840p6B0ztmM5iTXpH6GKbLf
         91zLvHtocmNKxlKvx3MMDezlW1bdgs0d0iaM9VIYrqRN+lH7DsulHNAGxRF9T87iQl
         VnbJNM+N5FUMkZVVP/Iwye/nKWFYO+a7Lq/hsyVNVZPq8vBY0Ndgjj7g878sLum3U8
         GL4pDXNgRrBNg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VUz-008mHh-Pc; Thu, 22 Jul 2021 12:00:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jamin Lin <jamin_lin@aspeedtech.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] MAINTAINERS: update aspeed,i2c.yaml reference
Date:   Thu, 22 Jul 2021 12:00:03 +0200
Message-Id: <4641b7cf54d76ce8948d801cfd87d456f50947d8.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
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
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91b4da27226f..6b1cab4f01f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1720,7 +1720,7 @@ R:	Joel Stanley <joel@jms.id.au>
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


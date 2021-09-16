Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E535840D6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbhIPJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236091AbhIPJ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53F4F61251;
        Thu, 16 Sep 2021 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631786126;
        bh=f7KEII6zbM/s1ow9VZn6Ba4YgTKnQf1/xmRqyKEMF40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEPLS+Z/BJdnRBvbblkvqFIASGvTDHgxGmID6SANMowySg5p1upNFEEhgr1dGi2lL
         NqRFb8MJzZzpAppBqqvJ+UOMr/JXRoSs/qNjUdURVhrIjVWiOp4cD4ial6UQd3T06v
         ajzhlWT5BctbZwz7tEunoQHnq2DzVKciv3Bxiw733cprOCNaRqakr+HfefouckmyN4
         KPRE2jQCPEoFcLzy6IMq2bCq+6gVSRgMopMMHYKeTPDyKjnolKU7jG3pdc6PX3X3DM
         /QjYft5aYmXfbLt6dH4+3Feq4u0J9UCxIt9VBM64c7nevThfxzHpO3pgvtw7boCKvf
         qV13GautZo10Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQo72-001vU4-J7; Thu, 16 Sep 2021 11:55:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jamin Lin <jamin_lin@aspeedtech.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/23] MAINTAINERS: update aspeed,i2c.yaml reference
Date:   Thu, 16 Sep 2021 11:55:11 +0200
Message-Id: <3e3b05f4a2517f3ed784dfb441a13ba0cfb6a7ea.1631785820.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631785820.git.mchehab+huawei@kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
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
index ddea1f2cdadc..e63f3c4fceb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1745,7 +1745,7 @@ R:	Joel Stanley <joel@jms.id.au>
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


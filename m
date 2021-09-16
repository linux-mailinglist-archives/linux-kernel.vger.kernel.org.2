Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B800640D5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhIPJQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235492AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A37861251;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=bRgMV4i6m9yXmuxMfYJLee1TTDJlFbfPlFciIHY/MLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEHSEUocJmhQOzi7Sg0c+qVDXmF1Yye/rlGeC+lpvLtnXX2V25jqpBHemYHN6omJ3
         2dZ0HC1PVPp4k+r47HjRI3hteIIdOIIYAra3ma6IVWI2ukFIj7wZwDRngr+dqSjAIB
         sKRvqb38XodU3jXYdqHbNwUwyhNid4Tnh2lutt3dcbsHEZpHJOzoykJVkWkeAHyVZB
         Iifk0Kl2EwdTIoyfRIvXCB1YVy/4RbiFxVZE7/NjbS2PY01vMtUOCEnnipX6jAf/JT
         NKKP87mM1Ykw98R5oHnn9+mxn3QyX7SscEckiSujn143bQ553ch+zs6aXe0datkvUY
         4RIO33zJWS1Bg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTH-001sLS-Ov; Thu, 16 Sep 2021 11:14:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jamin Lin <jamin_lin@aspeedtech.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/24] MAINTAINERS: update aspeed,i2c.yaml reference
Date:   Thu, 16 Sep 2021 11:14:06 +0200
Message-Id: <353981f4356be2a1ad34a67b7db6a357345c0ccf.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
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
index f02d1c94a219..d0f4fe1481da 100644
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


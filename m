Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB6B40D6EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhIPJ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236269AbhIPJ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AB126137C;
        Thu, 16 Sep 2021 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631786126;
        bh=JVvfHe0KiYhsG/mCyqJLwBz0y1PfNODhYQyxxhAuzZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VIIefiv8eYdIJ1481qE9+vYQT1Eo/0aVyjC1jDCTmIxBYZZILyDmjS6T6Xttfdb9H
         lACYViAH7DZA0aG4tdgcwbBG+UU1bc3CI5COpyeK3Ntu1OZF/KpQPFzGe33nLfLO84
         tMJyJeeBes+eRAOWseEQ2opfdgruBMZZb0++53amWrJ2DDG5v/Vamlygtmd67SE3zE
         WhtGtGDICUCcXikArDazIJiZd483/Zao+8CcIwv4E1te7rRO9+TFBuXLOeaB1485P4
         EOcZy2ndlwk/R9hH6dBKvNF21r1ENZe8f8T4ZD4T2eyNk2d1cEI+/4MowJAS/hPqh5
         Y8RUFaJrIpg8g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQo72-001vUY-RO; Thu, 16 Sep 2021 11:55:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/23] MAINTAINERS: update brcm,unimac-mdio.yaml reference
Date:   Thu, 16 Sep 2021 11:55:18 +0200
Message-Id: <b70aba14263e0cc4000c2c3c1c7bb2d29e343ed9.1631785820.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631785820.git.mchehab+huawei@kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 5d1c5594b646 ("dt-bindings: net: brcm,unimac-mdio: convert to the json-schema")
renamed: Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
to: Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml.

Update its cross-reference accordingly.

Fixes: 5d1c5594b646 ("dt-bindings: net: brcm,unimac-mdio: convert to the json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b18e6ad7842..3b66ca83e29d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3757,7 +3757,7 @@ L:	bcm-kernel-feedback-list@broadcom.com
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/net/brcm,bcmgenet.txt
-F:	Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
+F:	Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
 F:	drivers/net/ethernet/broadcom/genet/
 F:	drivers/net/ethernet/broadcom/unimac.h
 F:	drivers/net/mdio/mdio-bcm-unimac.c
-- 
2.31.1


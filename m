Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44EA410BE9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 16:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhISOfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 10:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231918AbhISOff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 10:35:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D505661242;
        Sun, 19 Sep 2021 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632062050;
        bh=WoouPmq+CPdPKhHXFQWp/vcbua8J623iHs79C3Sw2u8=;
        h=From:To:Cc:Subject:Date:From;
        b=frVgdtIag8Vtv3Vt5Ep2zYBLsWjCANpo+hzTmYepGu0GkMLkZqI6l8ZHhQMpmDi1x
         pyDXvUnTAO1eguoMnF9IhuTA3OCyBRWsRpNAcozCqs6+p6ScAzQKbl8MpkiV6icAhr
         gx1cD7uFsvwCr1zaGVd4Z+QifJZwQLazuuSVOrvXpALReZkBe/py6CCJFKTAEvWzat
         /aGxVQYLo4QXGiltTxiVUXZ3nzoAljNfOdbsqG/ZBvy4rFE8I+qaEKhvoGWjQ76YMW
         dLvLgSfJ0/1jsZt7K4qFsEjWcdH8kHnTgcpIY6HIF6tgOnt22FC1ZcB2X0Poc+zxps
         I6O4MukCAf3MQ==
Received: by pali.im (Postfix)
        id 30632879; Sun, 19 Sep 2021 16:34:08 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: arm: marvell: Add Octeon TX2 CN913x Flavors
Date:   Sun, 19 Sep 2021 16:33:48 +0200
Message-Id: <20210919143348.24338-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell put CN913x into Octeon TX2 family but they are different from all
other Octeon TX2 products. Instead CN913x is evolution from Armada 7k/8k
products.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/arm/marvell.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index f9b09b06e1d6..c3d3f27edfbb 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -244,6 +244,23 @@ EBU Armada family ARMv8
   Device tree files:
 	arch/arm64/boot/dts/marvell/armada-80*
 
+  Octeon TX2 CN913x Flavors:
+	- CN9130 (AP807 Quad + one internal CP115)
+	- CN9131 (AP807 Quad + one internal CP115 + one external CP115 / 88F8215)
+	- CN9132 (AP807 Quad + one internal CP115 + two external CP115 / 88F8215)
+
+  Core:
+	ARM Cortex A72
+
+  Homepage:
+	https://web.archive.org/web/20200803150818/https://www.marvell.com/products/infrastructure-processors/multi-core-processors/octeon-tx2/octeon-tx2-cn9130.html
+
+  Product Brief:
+	https://web.archive.org/web/20200803150818/https://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-infrastructure-processors-octeon-tx2-cn913x-product-brief-2020-02.pdf
+
+  Device tree files:
+	arch/arm64/boot/dts/marvell/cn913*
+
 Avanta family
 -------------
 
-- 
2.20.1


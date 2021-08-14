Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF73EC2B6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 14:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhHNMtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 08:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhHNMtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 08:49:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFAEF60F42;
        Sat, 14 Aug 2021 12:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628945361;
        bh=3a2DqnHkFv8wV9SsKbEkq8hLczh5zK3yjNrGavfdJEI=;
        h=From:To:Cc:Subject:Date:From;
        b=Ir21AnhMMG4ip9WHAxgXt2fSh09oa3pOoOt8fqEv0M+GJ7THJpamNcO4TQMTjuIFE
         g2gTpGCbabUekdXRc8gvHOvpRa8ysh4q7GKHFGe0ZTiRGX/IDyybytyJMevsVyMnlf
         vdYAbrtWGqnbRAA8Y3l8zxFrhdQSwPuSpBBeXFyKjcG2XrBM/awIiIp9L8g2XA7QpL
         MSuEH5jkDHZGS69WB78mD35FXdb3xv+KTOzYaY40lIhCJwpV+yJG4erHMC/QMfjJ6Z
         wmpOetpr1Vcr1A8lU0o4fvfmvdRzWqiuUWKn/eoiHBzpc4hr1/UBBswoJ5YIAttFt1
         s6T0TplG55Xxw==
Received: by pali.im (Postfix)
        id 2DD7B741; Sat, 14 Aug 2021 14:49:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: arm: marvell: Add 88F6825 model into list
Date:   Sat, 14 Aug 2021 14:48:05 +0200
Message-Id: <20210814124805.14568-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

88F6825 is just 88F6820 but without encryption acceleration hardware and is
used e.g. in DTS file arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Depends on patch: https://lore.kernel.org/linux-doc/20210625215437.2156-1-pali@kernel.org/
---
 Documentation/arm/marvell.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index 85169bc3f538..56bb592dbd0c 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -140,6 +140,7 @@ EBU Armada family
 	- 88F6821 Armada 382
 	- 88F6W21 Armada 383
 	- 88F6820 Armada 385
+	- 88F6825
 	- 88F6828 Armada 388
 
     - Product infos:   https://web.archive.org/web/20181006144616/http://www.marvell.com/embedded-processors/armada-38x/
-- 
2.20.1


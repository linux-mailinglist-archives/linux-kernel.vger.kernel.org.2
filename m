Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FE531C3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 23:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBOWKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 17:10:04 -0500
Received: from mail.v3.sk ([167.172.186.51]:58250 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229780AbhBOWJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 17:09:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D31D5E0956;
        Mon, 15 Feb 2021 22:04:27 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GJ_cfyN5orb0; Mon, 15 Feb 2021 22:04:17 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2FC87DF8B1;
        Mon, 15 Feb 2021 22:04:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZhqBefqwG2QV; Mon, 15 Feb 2021 22:04:16 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9AFC7E0C4D;
        Mon, 15 Feb 2021 22:04:16 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 3/3] docs: arm: marvell: clarify some unimportant Armada 6x0 details
Date:   Mon, 15 Feb 2021 23:08:39 +0100
Message-Id: <20210215220839.423709-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210215220839.423709-1-lkundrak@v3.sk>
References: <20210215220839.423709-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMP2 is used in XO-1.75 and MMP3 is now supported in mainline.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/arm/marvell.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rs=
t
index 615dd8a13807a..7f96068a9eae2 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -356,13 +356,12 @@ MMP/MMP2/MMP3 family (communication processor)
              - Product Brief        : https://archive.org/download/marve=
ll-pxa910-pb/Marvell_PXA910_Platform-001_PB.pdf
              - Application processor with Communication processor
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
-        - PXA688, a.k.a. MMP2, a.k.a Armada 610
+        - PXA688, a.k.a. MMP2, a.k.a Armada 610 (OLPC XO-1.75)
              - Product Brief        : https://web.archive.org/web/201111=
02023255/http://www.marvell.com/application-processors/armada-600/assets/=
armada610_pb.pdf
              - Application processor only
              - Core: ARMv7 compatible Sheeva PJ4 88sv581x core
-	- PXA2128, a.k.a. MMP3 (OLPC XO4, Linux support not upstream)
+	- PXA2128, a.k.a. MMP3, a.k.a Armada 620 (OLPC XO-4)
 	     - Product Brief	    : https://web.archive.org/web/20120824055155/h=
ttp://www.marvell.com/application-processors/armada/pxa2128/assets/Marvel=
l-ARMADA-PXA2128-SoC-PB.pdf
-
 	     - Application processor only
 	     - Core: Dual-core ARMv7 compatible Sheeva PJ4C core
 	- PXA960/PXA968/PXA978 (Linux support not upstream)
--=20
2.29.2


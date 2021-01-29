Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3696308CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhA2Sli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:41:38 -0500
Received: from mail.v3.sk ([167.172.186.51]:56790 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232752AbhA2SlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:41:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C2F90E0B4B;
        Fri, 29 Jan 2021 18:36:01 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id X0SaR8wHjwAX; Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A0B4AE0B3D;
        Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xAAcudTr8V9m; Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5566DE0B42;
        Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 4/5] docs: arm: marvell: clarify some unimportant Armada 6x0 details
Date:   Fri, 29 Jan 2021 19:39:49 +0100
Message-Id: <20210129183950.75405-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210129183950.75405-1-lkundrak@v3.sk>
References: <20210129183950.75405-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMP2 is used in XO-1.75 and MMP3 is now supported in mainline.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/arm/marvel.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvel.rst
index 0c291d1091f1d..43f2fe407796e 100644
--- a/Documentation/arm/marvel.rst
+++ b/Documentation/arm/marvel.rst
@@ -392,11 +392,11 @@ MMP/MMP2/MMP3 family (communication processor)
              - Product Brief        : `Marvell_PXA910_Platform-001_PB_fi=
nal.pdf`_
              - Application processor with Communication processor
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
-        - PXA688, a.k.a. MMP2, a.k.a Armada 610
+        - PXA688, a.k.a. MMP2, a.k.a Armada 610 (OLPC XO-1.75)
              - Product Brief        : `armada610_pb.pdf`_
              - Application processor only
              - Core: ARMv7 compatible Sheeva PJ4 88sv581x core
-	- PXA2128, a.k.a. MMP3 (OLPC XO4, Linux support not upstream)
+	- PXA2128, a.k.a. MMP3, a.k.a Armada 620 (OLPC XO-4)
 	     - Product Brief	  : `Marvell-ARMADA-PXA2128-SoC-PB.pdf`_
 	     - Application processor only
 	     - Core: Dual-core ARMv7 compatible Sheeva PJ4C core
--=20
2.29.2


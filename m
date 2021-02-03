Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66530E7F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhBCXyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:54:08 -0500
Received: from mail.v3.sk ([167.172.186.51]:51480 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233704AbhBCXyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:54:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 25D82E09D2;
        Wed,  3 Feb 2021 23:49:05 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cf222fCPs2SU; Wed,  3 Feb 2021 23:49:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D41BADF61E;
        Wed,  3 Feb 2021 23:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MHbLF_hR1Woh; Wed,  3 Feb 2021 23:49:02 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A0648E070D;
        Wed,  3 Feb 2021 23:49:02 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 2/5] docs: arm: marvell: fix 38x functional spec link
Date:   Thu,  4 Feb 2021 00:53:02 +0100
Message-Id: <20210203235305.506528-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203235305.506528-1-lkundrak@v3.sk>
References: <20210203235305.506528-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one went away, but the document is still available.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Split this off from "[PATCH] docs: arm: marvell: drop some dead links"

 Documentation/arm/marvel.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvel.rst
index 502a1b89a2c85..ab0c38dc108a8 100644
--- a/Documentation/arm/marvel.rst
+++ b/Documentation/arm/marvel.rst
@@ -124,7 +124,7 @@ EBU Armada family
 	- 88F6820 Armada 385
 	- 88F6828 Armada 388
=20
-    - Functional Spec: https://marvellcorp.wufoo.com/forms/marvell-armad=
a-38x-functional-specifications/
+    - Functional Spec: https://www.marvell.com/content/dam/marvell/en/pu=
blic-collateral/embedded-processors/marvell-embedded-processors-armada-38=
x-functional-specifications-2015-11.pdf
=20
   Core:
 	ARM Cortex-A9
--=20
2.29.2


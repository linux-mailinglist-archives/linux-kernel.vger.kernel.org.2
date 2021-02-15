Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAB31C3EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 23:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhBOWJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 17:09:37 -0500
Received: from mail.v3.sk ([167.172.186.51]:58214 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229662AbhBOWJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 17:09:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CDB83E0C6B;
        Mon, 15 Feb 2021 22:04:18 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ugoN-FwRmlng; Mon, 15 Feb 2021 22:04:16 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 601FBE08B3;
        Mon, 15 Feb 2021 22:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y98dMimiO0jm; Mon, 15 Feb 2021 22:04:16 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 109E9E0C4C;
        Mon, 15 Feb 2021 22:04:16 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 2/3] docs: arm: marvell: drop a dead links
Date:   Mon, 15 Feb 2021 23:08:38 +0100
Message-Id: <20210215220839.423709-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210215220839.423709-1-lkundrak@v3.sk>
References: <20210215220839.423709-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one has gone away. Remove it; there's good chance there wasn't anyth=
ing
useful there anyway.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v2:
- Just remove one link; the rest has been replaced with archive links

Changes since v1:
- Adjust for removal of "[PATCH 0/4] docs: arm: marvell: turn the automat=
ic
  links into labels"
- Split off the hunk that fixes 38x functional spec link

 Documentation/arm/marvell.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rs=
t
index 796158e90334a..615dd8a13807a 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -399,7 +399,6 @@ Berlin family (Multimedia Solutions)
   - Flavors:
 	- 88DE3010, Armada 1000 (no Linux support)
 		- Core:		Marvell PJ1 (ARMv5TE), Dual-core
-		- Product Brief:	http://www.marvell.com.cn/digital-entertainment/asset=
s/armada_1000_pb.pdf
 	- 88DE3005, Armada 1500 Mini
 		- Design name:	BG2CD
 		- Core:		ARM Cortex-A9, PL310 L2CC
--=20
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14440D5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbhIPJRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235527AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95DE46127B;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=rjLiWJgk2yMj/S7r71sJy2g79U/d7k/74OPJEDQKVzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QD9j+ZTsKNOrjlrO9T7hwXRBaq6Hw++/Y2gbCp2d2kn1WRT6b6e7QW3z+MY/X2lnl
         jb3lmsVNdMrNw415n4AoaCruyfPIZsaHwYrtSISGWtYOC1+HYVcSv+j8pMeiQeItVD
         4WGVNesgxU7bEcmkyebV0SlBeadtX/FT4CxI1nnel/0t89pTkXlyymTT7uK7aoxkPM
         Wg8rv0Nny97Pz8sJamcY7v1t0741V/MBfzL1Yjl1lt5LR8X7akuuavoNC1uIquVnlj
         O56pbtinmPsGzCS9khuXlq9z1LOy0EPY/zxS+it94R5cx07q9ntH29WiqtpyRPVmBs
         KQOife3xvrJhw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTH-001sLi-Tz; Thu, 16 Sep 2021 11:14:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/24] MAINTAINERS: update ti,am654-hbmc.yaml reference
Date:   Thu, 16 Sep 2021 11:14:10 +0200
Message-Id: <493ca3863809a371633e95889eec586856d45dbf.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 6947ad674944 ("dt-bindings: mtd: Convert ti, am654-hbmc.txt to YAML schema")
renamed: Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
to: Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml.

Update its cross-reference accordingly.

Fixes: 6947ad674944 ("dt-bindings: mtd: Convert ti, am654-hbmc.txt to YAML schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bb56ac849fc..5154c8578ea4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8725,7 +8725,7 @@ Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
 C:	irc://irc.oftc.net/mtd
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git cfi/next
 F:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
-F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
+F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
 
-- 
2.31.1


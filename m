Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70D3D2197
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhGVJUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231508AbhGVJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABECF61353;
        Thu, 22 Jul 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948020;
        bh=JElE2Z5tQcxTgD4aLoG2OsWdGAwXlidtjaHeeFzBRvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddImT33rEgPbY4yymsYelgClWwKdXjrPvdv4RQq5P4C872V7G0zrXhHWoTWdgGO9o
         ILPI1ZQWY7TrgvESDnTWRoF85uaFYqnIrXIHlLQ+Hx9Bvl6qqhOK/v2RZ4kzekUDCn
         rnmvP8vV0uSPGyJHc/MXYKI7aYZwjIeBYxrwjQL67hJ3ga2PhdKwTKcFe2HfNCo6C8
         nUyjlDSpcq3PpywcArDVGsOa15vGvjCeP6XZESH7+WANpgnUUwmuP7KKRcWA0wkTIS
         a20b1A13NqcKLVy6M/X1PsCiSrlC/TwckYUlsxLIj9QHx72HUilcBrsiOC2wgXWp58
         IijkO7UO+EadQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VUz-008mHr-W0; Thu, 22 Jul 2021 12:00:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] MAINTAINERS: update mtd-physmap.yaml reference
Date:   Thu, 22 Jul 2021 12:00:06 +0200
Message-Id: <fa6e84084c3517bf9118f6b8ed1e440429f31636.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
renamed: Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
to: Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.

Update its cross-reference accordingly.

Fixes: 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92be68e3efb5..bf8843b778a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8633,7 +8633,7 @@ S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
 C:	irc://irc.oftc.net/mtd
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git cfi/next
-F:	Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
+F:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
 F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
-- 
2.31.1


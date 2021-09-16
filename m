Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A15B40D5E6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhIPJRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235525AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A5CE61284;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=ncFQJiN7xnW0Bx2T0VJOOp9uxYpOD3H7ambGKqSCalc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEwhHM0/Tn7Z/vHuAaRM75CWdizf9sm2J214ECntTggNqimg4W10ri5ifs/+VcEpW
         EmaB2yAV3mjhPKcWYq3Pazjbth9YMAa4g6GjYUPfF4T7dJaRSdLxanPfGvP16mFtmi
         L8u0PErxfPPv9n9imaLjlVcFqgpZ6U1OlF2TyfHmSd3dE1E1UpPFcGI0fYUaJMqYm5
         uSWuQh9CcKvVEl31rEt+cn9OCunbjGM/UsZ3Oiaq8K1XD3c0yCR6/gxAjvyBoJoXmR
         am38tN1U1EP8pus2TdDiZ2M4yR23YRhp89I6KsLnLO3u4Dq9rhTBRnJ+hzM83CXS1T
         T6X76oOi/4kVQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTH-001sLe-Sh; Thu, 16 Sep 2021 11:14:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 16/24] MAINTAINERS: update mtd-physmap.yaml reference
Date:   Thu, 16 Sep 2021 11:14:09 +0200
Message-Id: <c7769fbbad82a31a410d8aafbc044dba90677d5b.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
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
index 0ba88743af92..0bb56ac849fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8724,7 +8724,7 @@ S:	Supported
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A033D218B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhGVJTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231418AbhGVJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BE3761249;
        Thu, 22 Jul 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948020;
        bh=ySHyngj8BQfRImnbhVXrrY08BaHnVT+eBhyA2ssUUZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YdJHxWE86ahQ6kk2xqMgB/xREFnlXex2SVJAUrMS+Mb/uwn9YITN2dallK03mOI8w
         ltEl5FKCsFSDRUfV5lzpFO6XE9ZL5l2HiDkGfZ169PLPKFr1CRWkT1Hvt8AsnCg/L+
         0w9OeBQCu/UKueQZVbjfQd0VJaGAlLyk8b5PdmMCdFnXwHy5t1VBwYPoQHNXhF/D1v
         Oo/paBEmyhVF46lT4FGAhBnAEZ9FXo8UGT6iXTeUEuKIz9AVvsJI/ANFzYkcACRhUt
         XM3/t3FGWyE/0sBbzEZc9I7YbS4eirIlYKcPgU9bXieG1ghgS/ceq+T+jQePEzBt28
         g2kBZmsQE4oWw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VV0-008mI3-8W; Thu, 22 Jul 2021 12:00:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] MAINTAINERS: update arm,pl353-smc.yaml reference
Date:   Thu, 22 Jul 2021 12:00:10 +0200
Message-Id: <1a9b26e4f9f7a01bcd676d7e7a3a929085fc2adb.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file name: Documentation/devicetree/bindings/mtd/arm,pl353-smc.yaml
should be, instead: Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml.

Update its cross-reference accordingly.

Fixes: 813d52799ad2 ("MAINTAINERS: Add PL353 SMC entry")
Fixes: d3d0e1e85711 ("dt-binding: memory: pl353-smc: Convert to yaml")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e1e5385d971..0a571273f308 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1488,7 +1488,7 @@ M:	Miquel Raynal <miquel.raynal@bootlin.com@bootlin.com>
 M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/mtd/arm,pl353-smc.yaml
+F:	Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
 F:	drivers/memory/pl353-smc.c
 
 ARM PRIMECELL CLCD PL110 DRIVER
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB4343306F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhJSIGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234590AbhJSIGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 872D06136F;
        Tue, 19 Oct 2021 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630667;
        bh=ZPztEb+aAIBl2ebvem6ZZULgawaz8syRbV8Jk6E7RbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJBxO/7uvItTeCrVH636EiNnFihlnVO5mRJnrk+/q7muX/7JIZaAVP6HZGUPp0igH
         kFwBKOncNObcolcPlPBc9GuT1tOXPE4pYpqPGWJj8dUz77tYcglqpXRp5XPTIx5wL4
         hpyjME+tmFEzWamTW79VokNA4C0a/7ktHmz4C4lxVijYdhBODR6xn7t21+YiXQBZcG
         IbOFqePL014yQJsrZ/Sk/SasCZwpIsK1pFhuHknLTbORjZAh9i9NWNmiHR1BfUeH6f
         B5cnTudcqGr6YwXENYL78QYkLdCqiBPbmkczg8m4xR5c2dFA5rEdVjgoEm8PAWzfOx
         FqfWrYQDHe/DQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJF-53; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/23] MAINTAINERS: update nxp,imx8-jpeg.yaml reference
Date:   Tue, 19 Oct 2021 09:04:08 +0100
Message-Id: <70f3d37561b5ea4770a9f10c70ca2d29f99208b6.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file name: Documentation/devicetree/bindings/media/imx8-jpeg.yaml
should be, instead: Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml.

Update its cross-reference accordingly.

Fixes: be157db0a3d8 ("media: Add maintainer for IMX jpeg v4l2 driver")
Fixes: b16ed1e66008 ("media: dt-bindings: Add bindings for i.MX8QXP/QM JPEG driver")
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 843cb9779f4f..33147a1495f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13702,7 +13702,7 @@ M:	Mirela Rabulea <mirela.rabulea@nxp.com>
 R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/imx8-jpeg.yaml
+F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/imx-jpeg
 
 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
-- 
2.31.1


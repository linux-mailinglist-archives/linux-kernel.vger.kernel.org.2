Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9A40D6F2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhIPKAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236254AbhIPJ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F9FD6135A;
        Thu, 16 Sep 2021 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631786126;
        bh=qLKz4HVUCvJ0MHG9DQ0uex7hwYC82qsle5WpII/Tc6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdnbVjQsvH7Mqjfch0YA2vPpYrq4IBaY5eCb51ZJ44JbxMtXiWapU8rvFwlBweVfy
         ViuG3O1hh87U+tReOCyNGRQUP/DamPfLE6Svx6etOEExkAxebcndCl7FoTm2cp2Fqp
         bimdOi00jA6buvQTtPp4lAOA1rVuWLeCprnW6hf3Jp9yEc/bJdWdlbGP/8i0/irrzF
         +pcS/MQJ5s64xrr15eX7K2ElboIEsBGxCfHuOcF8A018l30/itO3BJiBhgwOIQbQHl
         lnTqLhCz63EF3X8wSu+o8Bg/+JM0dpD7Unuf6Plt7HJWH0nJoRwjR/tW5pRtIQibXk
         RywXIuzJSrZVQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQo72-001vUQ-P5; Thu, 16 Sep 2021 11:55:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/23] MAINTAINERS: update nxp,imx8-jpeg.yaml reference
Date:   Thu, 16 Sep 2021 11:55:16 +0200
Message-Id: <2ddb2ce7b64b333b64b968bef9ae9d69ad23b1ef.1631785820.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631785820.git.mchehab+huawei@kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
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
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91663dfd5af7..151a05f77873 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13545,7 +13545,7 @@ M:	Mirela Rabulea <mirela.rabulea@nxp.com>
 R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/imx8-jpeg.yaml
+F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/imx-jpeg
 
 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A9398EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhFBPpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232229AbhFBPpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:45:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D327613D2;
        Wed,  2 Jun 2021 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622648602;
        bh=dfyq1ej1GuFOxiozvo87VpGxQt5FWXfaH6ex5RqWXkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9/vBKNARuxY5c1d+I9KFGWW9QFxo2xQ+8ItWSqP8nj4UkWk6TnZN7fT4U0+OB35N
         OGez8D1CMidIQ7hjzq9E3Frg7blMdzqYBQ5HCQr0DanwcCx9it50HKmJWbci7Ywl64
         Y5ky4LiEj0umY+7F9QiOo2PO9gQxfKDC77F4+JjmsxsjYlkq6DFESmkRXtqFYU4erA
         pclscoFpHj/1iK5I4U3JQxYBgEadrx+zDFuVPw5Uaza1+A+O9ZRinuBEYYZlnTWyHf
         icerDaoWJYcg45+laJBOFlRvW3EHTm/+m8aoMN8bhk1lj81JI76a84R6uUyC84O6C8
         QGr9JskQRxTJQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1loT1b-006XcJ-Ni; Wed, 02 Jun 2021 17:43:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] MAINTAINERS: update nxp,imx8-jpeg.yaml reference
Date:   Wed,  2 Jun 2021 17:43:18 +0200
Message-Id: <7b6df64c2c5af0990b9644acad18d4a4b700cce3.1622648507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622648507.git.mchehab+huawei@kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
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
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a737ba26bdcd..37baabb1e7a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13303,7 +13303,7 @@ M:	Mirela Rabulea <mirela.rabulea@nxp.com>
 R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/imx8-jpeg.yaml
+F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/imx-jpeg
 
 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
-- 
2.31.1


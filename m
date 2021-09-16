Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BDD40D5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhIPJRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235561AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAE716135E;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=lHn4637B5e/jFaJBDdCh8aiW0KLG7lqukybu/aoHo3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VjjyUBCrpIjn5fDIINOoa4XFYgQ6sVCz4F2T+nE5SyeIqVuUvIAcywtV7FBzI1yOO
         0HYyqKE0MJkw49oC4LXPGraUYPj2JvKd7Vu/DXAWl0+Wn/1I1iZtw8ORQJzz/9WxP9
         abC+1EjAVa6X9D4H/41lzd5RtdgVx9W3fUaPXclzT/ciXoF5Kzhjo63SEmVEMiJ4Eh
         tddyDGeFii5H5s97vWE23yVTsmdvhn1MDMRezZ6+8X4mP3/tbH9rzqBYVsBW/asMfW
         Zq7T5Pzz+FRQLuwGoaZ98V/5NAd4U6DMgKcISU6vRm9HlpeGvQ9cJLLkiE8euqDLsQ
         +2oTa8LpvWubQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTI-001sM1-0j; Thu, 16 Sep 2021 11:14:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 20/24] MAINTAINERS: update nxp,imx8-jpeg.yaml reference
Date:   Thu, 16 Sep 2021 11:14:13 +0200
Message-Id: <6504efb2d4eb3a89e4b77fca741a6cb143af0b95.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
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
index da9658e24496..9f1d2b8a769e 100644
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


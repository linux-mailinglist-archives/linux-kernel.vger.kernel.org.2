Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99D351E32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhDASgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237351AbhDASNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:13:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4561861183;
        Thu,  1 Apr 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=Mdamr4cxdx743E/PcWsls8xJxN+1vCKqivKjSf23cbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LX0x6r5AJ2Q9T6eovPCphcP4O8b04T96+zeEj9/w8xA3CyYpJ4SQs42XsXAa24Ati
         Ds2oQjtbFzBRy/kEn/1VKV6sI6maoCGyvJJbODMOgI/K1f8/Rz3r1/bjj4MXsFyLWs
         /W10D07jzrUfGiDYu+l3AeS0YJ4268H9s5wrRJpWGARL1gVH+Y2Gc3YFMO5hP4fvBB
         U0L8UfLl80YoTlcFddz1w3kvYVps6rKad/sh0PYUPTXi4+bvXBksXxezDbqk3ucxnj
         6ru8J5u3KhEDrfEJpIXRa06TJjlTjRjiuw0uAyzYtKYoEPrCvQVA8OArtdn6cdeJJX
         V+UjVryhEMxJg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c3J-9t; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 22/32] MAINTAINERS: update nxp,imx8-jpeg.yaml reference
Date:   Thu,  1 Apr 2021 14:17:42 +0200
Message-Id: <c597780808b30d85360cbfc59ea00efcc469fa38.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
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
index 2f63ebd2cfc8..0ee42d68a269 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13073,7 +13073,7 @@ M:	Mirela Rabulea <mirela.rabulea@nxp.com>
 R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/imx8-jpeg.yaml
+F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/imx-jpeg
 
 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944753D2192
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhGVJUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbhGVJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97AA061264;
        Thu, 22 Jul 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948020;
        bh=yFXn16NkBzlsfO+DUe4+E5BqYVGA9Si4dzWZdnC0EvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fy2ygCq57s9l5A7zqtT6lDZeXHRTr9B0puG425TmVKIVQUbq8gxUkzQYIWb6L229o
         yDecQq6o3VD1wHEh8L7Xvl6CnekSrHpo1NFHpcOhHEDjx8mF1/VuR7jkiLDlxTJhwb
         tgzRqIvMtvqPY0N+u2Kb0XlMCBkJjSTLsu6ZFy5si/6/HISiISyp05YsprodSQIUp1
         6Cbwb21QZdzOZ7WbLGMpugiigQooVHetdkzZUYcm0euGUWTM9te0d05W1qfDWaDj2z
         Qv9oBvh1ZJ43xmpzFrC7e60pOaSoyzJlaqtpbKdN4G/8Y8jzDba5L3FSXwUejjTctw
         9wsXUv7eqt83g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VUz-008mHo-Tr; Thu, 22 Jul 2021 12:00:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] MAINTAINERS: update fsl,fec.yaml reference
Date:   Thu, 22 Jul 2021 12:00:05 +0200
Message-Id: <3df6b6353f49dfe6fe76a0d62b504ce4744e80f0.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 96e4781b3d93 ("dt-bindings: net: fec: convert fsl,*fec bindings to yaml")
renamed: Documentation/devicetree/bindings/net/fsl-fec.txt
to: Documentation/devicetree/bindings/net/fsl,fec.yaml.

Update its cross-reference accordingly.

Fixes: 96e4781b3d93 ("dt-bindings: net: fec: convert fsl,*fec bindings to yaml")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9339d4c8a17..92be68e3efb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7365,7 +7365,7 @@ FREESCALE IMX / MXC FEC DRIVER
 M:	Joakim Zhang <qiangqing.zhang@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/fsl-fec.txt
+F:	Documentation/devicetree/bindings/net/fsl,fec.yaml
 F:	drivers/net/ethernet/freescale/fec.h
 F:	drivers/net/ethernet/freescale/fec_main.c
 F:	drivers/net/ethernet/freescale/fec_ptp.c
-- 
2.31.1


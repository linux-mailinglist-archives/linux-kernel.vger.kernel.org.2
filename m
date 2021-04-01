Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6C4351E21
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbhDASfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238946AbhDASPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00C1A61132;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=l+mL5BpPGfeWzWDAZNCmerTIcbe0IWaxG9GKHVVTbq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQ52ACo8pH5+z5vL31dm2vroqqROkX1rn29iRXqWAoK3wxT4XypPiAEjas46cG4WO
         AoA0sxLhPztA7+uQV4Rp1AyB9lgkKN2mhTti2C9vrMhb/StMHFS0mB9NDVFOtoUFqp
         N2NDpzZdsaOJRt0bQrRlCTHBHDm8HHA8uAsYlpqi7W+STbVdnnLDLmF7ENlf8adxpB
         0CHcIUfYRO8UGjgiZz0PlosFMCw6jtIlGTkHCMqzTViyZjo3s3kMY6eN02gJzxEU+P
         zUriqWsYaoZWTYqR9+Y+e3Mnthd87G3fK5A0JcDR491TjEHwyzGb6PbXNP1FQqudKs
         6ZZL0NWAHB53g==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c2w-0w; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/32] MAINTAINERS: update mtk-sd.yaml reference
Date:   Thu,  1 Apr 2021 14:17:34 +0200
Message-Id: <da5057521e04b47b103c9e9790ead0732a525375.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset c626695ecd8b ("dt-bindings: mmc: Convert mtk-sd to json-schema")
renamed: Documentation/devicetree/bindings/mmc/mtk-sd.txt
to: Documentation/devicetree/bindings/mmc/mtk-sd.yaml.

Update its cross-reference accordingly.

Fixes: c626695ecd8b ("dt-bindings: mmc: Convert mtk-sd to json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17bd389b7985..576d1bcabb20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11410,7 +11410,7 @@ F:	drivers/media/platform/mtk-vpu/
 MEDIATEK MMC/SD/SDIO DRIVER
 M:	Chaotian Jing <chaotian.jing@mediatek.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/mmc/mtk-sd.txt
+F:	Documentation/devicetree/bindings/mmc/mtk-sd.yaml
 F:	drivers/mmc/host/mtk-sd.c
 
 MEDIATEK MT76 WIRELESS LAN DRIVER
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60204351E40
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbhDAShC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238945AbhDASPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFE4F61107;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279475;
        bh=VxV7a1BDK09gUV3E/njBQ9kxTgw4vACvYtSp+lMu5Xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUxHnM1NH3sfPYy4tBsrkCmLCFgZ1ndvZYvQ5hK77lIMZO1IDt2R7c0ZS6AZAT61T
         XtblBxQHNa4cK0v/TiQcfhPdjKuEHn8arm3XTamCXrLuAzuC6gZMGLlHpMy8cRIoIe
         jVA3av7g5JeUmfgnbr4llY7cKXYF7ZVpWOGpH3toDFkmoj+q6QS9qdl+8yufo1TkUX
         YiIowEfbynGujF/gagd6ZWmN2+oRuccJ6TDPliWwN2xWV93Df3YZD/asm0sysPFw9g
         RYxX7sDJQ6bJNljI8qutpSOv3NjR3fUkaFQoOs4NjsBUY644gPUAs5mVHLyt64niba
         UIwXgmX7TH0tQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGn-001c2n-TR; Thu, 01 Apr 2021 14:17:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/32] MAINTAINERS: update invensense,mpu3050.yaml reference
Date:   Thu,  1 Apr 2021 14:17:31 +0200
Message-Id: <1c99edf0f5c78e78bbec71fa2a5d7bc6087edddd.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 749787477ae4 ("dt-bindings:iio:gyro:invensense,mpu3050: txt to yaml format conversion.")
renamed: Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
to: Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml.

Update its cross-reference accordingly.

Fixes: 749787477ae4 ("dt-bindings:iio:gyro:invensense,mpu3050: txt to yaml format conversion.")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5110f47ebf85..ce675a0b3819 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9414,7 +9414,7 @@ INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
+F:	Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml
 F:	drivers/iio/gyro/mpu3050*
 
 IOC3 ETHERNET DRIVER
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE832351E5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbhDASj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239668AbhDASQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B81761156;
        Thu,  1 Apr 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=4m1LMXNQLKEULRzw9a/ker9aMb6QrWwHEPQ0MMmnRwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYlmrc4nlyup/WyuOh1UF0vhkGPngnnNqQhMdqEks+S3AbthKuIQ3dNw0b8QCDn/n
         8fWeFf73zEL9ePe1aQFuF98OcBqyBNITeAn1Hq6apx2pS9MfEVBFQQdL6bY/eVIZ/K
         hm38mRws9r/DT9XQI4ov+jSBuEQxU9LIYPJj9+s09q/y92amO2x00AMXcElqygCEXj
         pAJLhE6Qz6x3m84ngCHbrgquSEvgBVQpinLqSBGR/n9lF0kHY1L2J1LKO/qXwbyF8C
         f4PXEPptWCmi9IPKh19ZB4tXCEOIGE+YqjqOqqL3LQ+JPU02+q11jha9NvoWto7fNJ
         fHtWj9scguwbA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c33-4G; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 17/32] MAINTAINERS: update renesas,rcar-gyroadc.yaml reference
Date:   Thu,  1 Apr 2021 14:17:37 +0200
Message-Id: <aa999b76bb0b6c3ca4cb0c1a8679c22c91690429.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 8c41245872e2 ("dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.")
renamed: Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
to: Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml.

Update its cross-reference accordingly.

Fixes: 8c41245872e2 ("dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 636b29fd2d4b..97763e68b8e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15437,7 +15437,7 @@ RENESAS R-CAR GYROADC DRIVER
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
+F:	Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
 F:	drivers/iio/adc/rcar-gyroadc.c
 
 RENESAS R-CAR I2C DRIVERS
-- 
2.30.2


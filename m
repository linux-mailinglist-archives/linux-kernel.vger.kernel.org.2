Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB0A351E1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbhDASfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238941AbhDASPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0D89610FC;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279475;
        bh=ZVqkqrRzsnqvatptdV3JtB9vGyjykIcw84TAnIHuXZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0nbihXMUCovcH5RoKHdyOg6EkjtYka+6SFeDdO25ou7sTmhAc8Qymfial4WLeiIj
         owdJLkhZkl87U9MXUQrS/6MbnJgNOfs67cXVgggrrt2O2NM5H/u9IYAclxMTAwwNtY
         jbx+rB8fi5C7WnmHs8oyUr4S9HEp7UZZu91sWpuwqnaRxSqw5k+xGf+TNEyLZLLa5T
         ivN7RIk+LpK42Zmzi+jH8pqwc2zLhPtPc0ICIZDjI1eLtxkogibtDTB1lx+GBpbAZG
         VLuCfnT6DhtHU3xtuc9OZD+P5opfz3i8PC7eOD6p+adaNG1jm23AQxs2S/7o/vTbE6
         1GnNiOZ4+CwkA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGn-001c2a-Nu; Thu, 01 Apr 2021 14:17:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/32] MAINTAINERS: update envelope-detector.yaml reference
Date:   Thu,  1 Apr 2021 14:17:27 +0200
Message-Id: <d4ccc625ccb89730c03204b7aae98fd94ea97fc2.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 66a6dcc20e63 ("dt-bindings:iio:adc:envelope-detector: txt to yaml conversion.")
renamed: Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
to: Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml.

Update its cross-reference accordingly.

Fixes: 66a6dcc20e63 ("dt-bindings:iio:adc:envelope-detector: txt to yaml conversion.")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 52ce258fab37..82220a72eba2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8761,7 +8761,7 @@ M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
-F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
+F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml
 F:	drivers/iio/adc/envelope-detector.c
 
 IIO MULTIPLEXER
-- 
2.30.2


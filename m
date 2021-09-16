Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1FB40D5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhIPJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235509AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D70161260;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=EfSEPvAIlcpmhHsnVHD6WhtDDost7aNu58XXoESLtgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cL+jRoHKOE53akLnckgtY2+1Si/BK3/e+pNtGm73I2lw3W0E9yFk5qnggqyJ/uD0W
         XX0sAqyxttLTyeL7TROz5twT9n3rV6jpKPleLUoVPhBOgSsAOTmk1+RtfnZWN+gLKu
         Zz2e577Z99Pc8T6O0d6V3mCimeaOjvlcPttkKlMKOetJQlI+cIqH6CCxP55Vq5hX4x
         TwE6BvL+x7d+RVNQ57krMrqx9suzrZPb85BWfnIGOJIwNgjhDRhgAVKMcHYGyFTxrT
         F0NXzl/wnhUqDnojfYgixcgL6pUgyttjiPhIqdKo+mAyxDrIf19dhqdyJJYxwEAek8
         QprBm0qi8O8Gw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTH-001sLW-Q8; Thu, 16 Sep 2021 11:14:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/24] MAINTAINERS: update faraday,ftrtc010.yaml reference
Date:   Thu, 16 Sep 2021 11:14:07 +0200
Message-Id: <59b2f6dd8f4ec587dad2d80f4e0f99686b051a21.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 8df65d4adca6 ("dt-bindings: convert rtc/faraday,ftrtc01 to yaml")
renamed: Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
to: Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml.

Update its cross-reference accordingly.

Fixes: 8df65d4adca6 ("dt-bindings: convert rtc/faraday,ftrtc01 to yaml")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0f4fe1481da..dce6cafeedab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1875,7 +1875,7 @@ T:	git git://github.com/ulli-kroll/linux.git
 F:	Documentation/devicetree/bindings/arm/gemini.txt
 F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
-F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
+F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
 F:	arch/arm/boot/dts/gemini*
 F:	arch/arm/mach-gemini/
 F:	drivers/crypto/gemini/
-- 
2.31.1


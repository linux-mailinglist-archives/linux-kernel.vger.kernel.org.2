Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C98D40D6E2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbhIPJ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236222AbhIPJ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 518E761250;
        Thu, 16 Sep 2021 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631786126;
        bh=5NDlzf4eP8l4M2S6FcMNJNFMEBZhMmg9s4MM+7P16Sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1mhDDpjzJPE+BMZ01iDY43t4CSuZ4T/jC9IZF7TsH8OJaLMWwlPj4288bX2K+XNM
         qPpXYVNugTvbdQMC8uWMj/aDPvGagQi8LaKy/UrqekDnZXWm3k6al8xt380lNKndll
         T22bAcaAIG5zVeXEINf4Jrz/JhgAstAMMzhg9UPeKWLxmXMlt+A9iBIftJc5Ao9k68
         L7IzdxiZMQjUPqoBm49AIuI0ZW54snjZg2eSIo+sZ5NNGlnrLdZUL2km5AHu9234U7
         Tuh8RbcEksTEmocK9wN3pwLmf9UeoPHF/s4piLdmCQJKQz5AjKdOeuk0dlguj896OL
         OjjyKtQDiK9rA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQo72-001vU8-KJ; Thu, 16 Sep 2021 11:55:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/23] MAINTAINERS: update faraday,ftrtc010.yaml reference
Date:   Thu, 16 Sep 2021 11:55:12 +0200
Message-Id: <b3da577ccfafb60841a945011535b3662ba3c1f1.1631785820.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631785820.git.mchehab+huawei@kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e63f3c4fceb9..edf8d4253142 100644
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


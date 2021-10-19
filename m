Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3802D4330B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhJSIH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234723AbhJSIGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AFFA61264;
        Tue, 19 Oct 2021 08:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630669;
        bh=IWvn8RRqDzm5qEzi8S9uL4gb1CkZcVS2+WnletImKAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ANeqkPQE3drySNmtIxndBy/lDdkj8yYwBvqo6+tYDZF4EH2aRF8fG7B8zfbApuE1N
         9mB2GpUAUtAnqmBIdxI5YNhnYwLeJY2tdkR6qL/cg0B8iLbDq+nG6mP1dgGubC4LoF
         rBXPIPJstCDT6yDnLoCbV70jxOT9yC1pl/8O2fmtxEjejonLkUQOP+Zcw8urVYd97O
         hT0itaW8idgu8eW2GFo4UtLF2zzNz4SEQlRuW3IWXs1hsYCgnaLC8J9/6bpVTXVS1b
         5kv85Pcf6AQhXTIdYqDogCkKfLT7+StzI26veI6xtYEmGgRrzMTnK3e7sjFMd94OFL
         iK1J///QNIz6w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJ6-3Z; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/23] MAINTAINERS: update faraday,ftrtc010.yaml reference
Date:   Tue, 19 Oct 2021 09:04:05 +0100
Message-Id: <56737d183299294c840c8308c1427c3385d88a1e.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
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

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb898af23d0a..d1721a65d79b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1888,7 +1888,7 @@ T:	git git://github.com/ulli-kroll/linux.git
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


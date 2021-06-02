Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64B9398F13
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhFBPpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232322AbhFBPpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:45:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62D8761404;
        Wed,  2 Jun 2021 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622648602;
        bh=ocwVEIpoeXcTa2LTaCyPcINdIg3LJ/xtNe9HnPgfd0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRebjkaBkJwiCPY26I4Ogsx2dkSmbvK4gB/4vedJQq4WTD0wrZvZj6PddQNLD7ESe
         w9lDkxyooSvAXXIdkI2ndPs6OPBZ4p347kJgXsAq/lgmeMUmT/wthywnKaRnl2A2Zn
         hczsyBPLoyCnY5sCATcUd8xDPUU3V7D1+TgttTIBpEaSXbRh+dhFdLQ96MNZI8oEoo
         0usUfu6zAy+p8LGTXiVwSnTspcHk6LXGoveGI7o0LjkKpKBdshS4TcmibCSbEwx6+b
         sDKPWK0RyHXQFo+rx6yid5Qn2boxPLI0maPL5bwvUvowAN4ahNt1YKujAkj2/zfNgw
         kOQna8qNyIPrA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1loT1b-006Xc3-Iy; Wed, 02 Jun 2021 17:43:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] MAINTAINERS: update faraday,ftrtc010.yaml reference
Date:   Wed,  2 Jun 2021 17:43:14 +0200
Message-Id: <0d437806f3f8d2c930656872be482820ef1c2301.1622648507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622648507.git.mchehab+huawei@kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
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
index 2800307082a9..8b423b7246a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1818,7 +1818,7 @@ T:	git git://github.com/ulli-kroll/linux.git
 F:	Documentation/devicetree/bindings/arm/gemini.txt
 F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
-F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
+F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
 F:	arch/arm/mach-gemini/
 F:	drivers/net/ethernet/cortina/
 F:	drivers/pinctrl/pinctrl-gemini.c
-- 
2.31.1


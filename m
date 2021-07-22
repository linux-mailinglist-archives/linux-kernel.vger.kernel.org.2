Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54413D2193
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhGVJUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhGVJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A24361283;
        Thu, 22 Jul 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948020;
        bh=pVBkAW3UaW40R77GioNci6Ib4btLYmcuRV9OgHl2IdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxaIv8NB2z50e2VaijTmY1WHrN16GSSdNH6+xPQJwnZyH9cB3l2zri45Nten+SHUS
         1siegNac4XaIVvW23DWoPpQgFUni9/kdS1s3V/lFPoo4+QQyfs4puN0V3OLrJPGDgX
         VYifCZ0XHQqd6NfIvdyCF9+iCPah1tctyhJfz13f/oMgdR6ni8xOylxFT518j48CV+
         O9A9ymePqyrxTqEg/zQliazKjH93pz8P+T9E12gbkz5NTnSlGaBWXqabYD1xH+90ov
         ev/piMI+pwqOgeyvpxOaSXK98E8+jan/+5TS4GkieT6TWP0Ji89k6wwyP63O+aWpUF
         oan7T+quH4UCQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VUz-008mHl-Rk; Thu, 22 Jul 2021 12:00:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] MAINTAINERS: update faraday,ftrtc010.yaml reference
Date:   Thu, 22 Jul 2021 12:00:04 +0200
Message-Id: <a8e0e3227480fa8a5a045ec1ee06a08183a0a8b6.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
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
index 6b1cab4f01f8..b9339d4c8a17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1850,7 +1850,7 @@ T:	git git://github.com/ulli-kroll/linux.git
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


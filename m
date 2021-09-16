Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F7540D5E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhIPJQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235607AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7ED56137C;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=QX/TeP1Up2fv1mURikMxAXqlLxKM5NI4Xwq7REw08Q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2Sctvuu11a6dCuVcnGVsCzQL/1WWj1LJh5vJbdi7UBypPWP0DKIsWot9KXsxphdm
         aFktjaUJtSe43KQnJk8J0VECcjRNgX004XWLxfWeG6EBZ1/y9zRzvDPIjP4wnxWB97
         v01wY8g8y5S/sfoD/ecXcrtWXtkyHyMbnoiax7aj0t2QOcI4qR9JLlrGSVzlw88NSJ
         Rz4750HEEnfdLCNBJQDG61xTVUotPE3REEah+aDTRJ8eNNGVklxpN35CmihNHrpW1I
         ho2J/cEGEmf8LZ5k4AG7scWSaeWpNZD6329ubJVINXA+gOQpesvs5BjaWqa48AsSkQ
         dc8qrQec4y8qQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTI-001sM5-1h; Thu, 16 Sep 2021 11:14:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 21/24] MAINTAINERS: update gemini.yaml reference
Date:   Thu, 16 Sep 2021 11:14:14 +0200
Message-Id: <fa3ae6ac15fc49ac63360d00f041deee5983b4fe.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 7da6ebf5f5a5 ("dt-bindings: arm: Convert Gemini boards to YAML")
renamed: Documentation/devicetree/bindings/arm/gemini.txt
to: Documentation/devicetree/bindings/arm/gemini.yaml.

Update its cross-reference accordingly.

Fixes: 7da6ebf5f5a5 ("dt-bindings: arm: Convert Gemini boards to YAML")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f1d2b8a769e..de18144b8c52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1872,7 +1872,7 @@ M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://github.com/ulli-kroll/linux.git
-F:	Documentation/devicetree/bindings/arm/gemini.txt
+F:	Documentation/devicetree/bindings/arm/gemini.yaml
 F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
 F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
-- 
2.31.1


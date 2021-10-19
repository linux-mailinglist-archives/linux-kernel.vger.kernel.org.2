Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9E743309A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhJSIHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234655AbhJSIGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9582A6138B;
        Tue, 19 Oct 2021 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630667;
        bh=Om4KyLtBf6nDzVXmp3HH5sIpq0Cb+KlmBASKG0hOI1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PK4XHJnvjVVHEYGcZnwd8lKhMu9Q5sujV7+r9RnH+fPlbi283NbKYyPXB60xzG+dA
         SEna7md8RVnwrn+xuZLNutmRhmydh51xv+BUPzPs2rjsFV0a8CrpylKisFzGKCtBoZ
         7hcHIodB3U4HIfDpuxJVcq5PY2e4L+FkcyMBNBB9G3MhDqAsz3yXbZoXIiU5/jexep
         X53sF7lcWwDEPO+QrRx0+1UTS67ufDZrxNTxUWvAxBN+P2os7e15s98oUIA9vIyHB9
         JnRnu2i2WFVnTFGj8G/Djfllt1K/ee7Kg1eMUQUwgWzPDi+cSDZ6iE8qp2L0Ex2CLA
         aKAmA44BFz5hQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJI-5V; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/23] MAINTAINERS: update gemini.yaml reference
Date:   Tue, 19 Oct 2021 09:04:09 +0100
Message-Id: <dd52c97597a073a5830ecf115d4a6516eebc6d6a.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
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

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 33147a1495f5..74428ad1a74d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1885,7 +1885,7 @@ M:	Linus Walleij <linus.walleij@linaro.org>
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


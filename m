Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFF9398F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhFBPpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232372AbhFBPpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:45:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7741F6140B;
        Wed,  2 Jun 2021 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622648602;
        bh=/2cYtSG3djNsCF31B1KP1LGyKIeygzLAJvXtYbi8Djc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bt8gCF8ovJHzq4l5JTHjhYrIw/KhB+cpW3OXcNYyuYzpkmHgUcKfKFKDWP/n2xDDn
         TyAsAUIReAKsKY3R0qgxSKLvegegML4y8cuBpv6WJBZGRsmtQ6LsBLBZtWQRCdtHdB
         FoupKXiWQzcHVfpnJPzPxpv9RIn+XjAd6H6AWsULF3HCZmsActvLD5egDG9qvlwVsZ
         0tOBFvqSNqz1BUesKXM+E09bTeqT5mZPgiT92Do0F7SremUmu1EKiYchhXZenToivN
         976If8V0/gKXCGPrPJiUU/yl4nm7G9BxBvffCfaG2zFx8hIMg9cbfnv7J2kXgGwt/o
         bIaWxYqDJMJyw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1loT1b-006XcB-Lc; Wed, 02 Jun 2021 17:43:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] MAINTAINERS: update ti,omap-gpio.yaml reference
Date:   Wed,  2 Jun 2021 17:43:16 +0200
Message-Id: <832058f088a30e44cf25a81f1d4b9b4e0ed0904f.1622648507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622648507.git.mchehab+huawei@kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset bc3aca5393c4 ("dt-bindings: gpio: omap: Convert to json-schema")
renamed: Documentation/devicetree/bindings/gpio/gpio-omap.txt
to: Documentation/devicetree/bindings/gpio/ti,omap-gpio.yaml.

Update its cross-reference accordingly.

Fixes: bc3aca5393c4 ("dt-bindings: gpio: omap: Convert to json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 644572ab4b2d..7d65784df8c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13412,7 +13412,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 M:	Kevin Hilman <khilman@kernel.org>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/gpio/gpio-omap.txt
+F:	Documentation/devicetree/bindings/gpio/ti,omap-gpio.yaml
 F:	drivers/gpio/gpio-omap.c
 
 OMAP HARDWARE SPINLOCK SUPPORT
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4473D21A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhGVJX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231506AbhGVJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A95B96128E;
        Thu, 22 Jul 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948020;
        bh=6IPH25C9vzcuR/I5tfwXne4cmfhpz+Luj2fIPVB9860=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egDwAhyhref47GfkfAsw4PensCNe4+w/JqIm8rNgYN9cCmVBys7ss+PX1N6cIR00m
         mnOyxt9+C6nk05cgOPoIkDFirMSykxyvFgstVNxSxgrrTCXy7rT2dLNG8RQb0A33QE
         s0lRUrdsjiWJ+a/EM2Au/MJyIG3rbHbrVZq2LLrGn/8C+umoGJOWy5FwzQSt3C8NpM
         +oslaiim/+mqNGCAdTsBrWExqV3oTvz6zomEMyK4Vhkrzekp/iLCB4IHTrquWuLkoo
         pNqgfgS7VKqHnJ0e7NRR+tB4sAedvuJxzEKYixVit+VWakvluO0A8b9smYwxp5XJSj
         ZkKf9tgskOVcA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VUz-008mHd-NU; Thu, 22 Jul 2021 12:00:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] MAINTAINERS: update arm,vic.yaml reference
Date:   Thu, 22 Jul 2021 12:00:02 +0200
Message-Id: <7dbff9673e8703cd60e78f8b2110349d86d60a87.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
renamed: Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
to: Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml.

Update its cross-reference accordingly.

Fixes: b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 76acb9fe0622..91b4da27226f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1525,7 +1525,7 @@ ARM PRIMECELL VIC PL190/PL192 DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
 F:	drivers/irqchip/irq-vic.c
 
 ARM SMC WATCHDOG DRIVER
-- 
2.31.1


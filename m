Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DCC4390E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJYIOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhJYIOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:14:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36137C061764
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:11:53 -0700 (PDT)
Date:   Mon, 25 Oct 2021 08:11:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635149511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBju08sPNWEzn9S1qb46kAXe+qTtAMWBdY3k6iEy3RE=;
        b=SIVTYaNZhwyMu+hi8kZQEni/kxZ+ZCoSFQjTPCtwHixYXajh/mjfsR/DtJ+PKeXsKNenD0
        qDKHdTsOX3ijpXrLVUNNndWHizFRr1E8SYwZTMF5kMVVx+jIyruyNqVNW3boF9JdwTRgXh
        vvOWfJe6mMUxHDHkCdtPBQr7Y77y0A3h9nZdqr201AY3jlYfHnmarAY5kAnJ7uQfbVh6vf
        xBVBjnLbh7cp8S1QSUBGK97hbnQNcdyc7y08hAR+DarzJHD2tmNGUmYInjrTIiuHFnopxo
        bNLDKiPXka5tkg1xxiENS1sMpUnERZpbwCZj6G888UWbfhD/D+jbJcijusqZnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635149511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBju08sPNWEzn9S1qb46kAXe+qTtAMWBdY3k6iEy3RE=;
        b=DGnFUsEoV+K1pyP7G9bO/wV9ijx+Ciw/2tTz7Hi1IzcXRznrfpHwSQpdG09WrAWN31WSs3
        VYTr8KgM92qdUDDA==
From:   "irqchip-bot for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] MAINTAINERS: update arm,vic.yaml reference
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3Cec54d0aa65a3b98ae425721663f196b499a59513=2E16346?=
 =?utf-8?q?30485=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3Cec54d0aa65a3b98ae425721663f196b499a59513=2E163463?=
 =?utf-8?q?0485=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <163514951095.626.7377380061264789321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     21ce6992f38764430b134c15fa861f9ac4973340
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/21ce6992f38764430b134c15fa861f9ac4973340
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Tue, 19 Oct 2021 09:04:03 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 25 Oct 2021 08:49:30 +01:00

MAINTAINERS: update arm,vic.yaml reference

Changeset b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
renamed: Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
to: Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml.

Update its cross-reference accordingly.

Fixes: b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/ec54d0aa65a3b98ae425721663f196b499a59513.1634630485.git.mchehab+huawei@kernel.org
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index abdcbcf..b5d5499 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1551,7 +1551,7 @@ ARM PRIMECELL VIC PL190/PL192 DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
 F:	drivers/irqchip/irq-vic.c
 
 ARM SMC WATCHDOG DRIVER

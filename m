Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A251332159
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhCIIwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhCIIvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:51:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CB2C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:51:44 -0800 (PST)
Date:   Tue, 09 Mar 2021 08:51:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615279902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=poR87By4NkkdpqwArIo+z41wrL0AD93KKo6AP+GsrCQ=;
        b=p4TwTqpI9lYuGRO8mnOLvDSq0z1IZHE2AR5eG3RVbm4p2H4nVDmho1SUEfOhJHuSjd87Wg
        Q+zifh1UFgYhH172/vPrPTC/7i+8LedUu9hMLzh88knKa0tOS5bRWFdoHh5m16rL8SVIwk
        Qz+IMT2DtWpZOPouiBnLHA8YYGKRY+Brdye+CXvNi1m6Z1r6rsbug+0oMAChcA8yu5khAz
        ORsP0chcFyRGom0BXUPYiUrLWMvWQasYWSyzUIzsQsc5U4wUW4WIiPVFtUvJilVbuNd2+Z
        sXC5jATOtED0/wOy5LwsSHzKAveMR+gFcJ4xy5KJmiwF5dsaS7hW7L9Lix3EAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615279902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=poR87By4NkkdpqwArIo+z41wrL0AD93KKo6AP+GsrCQ=;
        b=D2ld29fxUr7jQ/8SuP4S4hMobxZvXWoI0b0jbUNxu351/J5eUNYyDVyFqZdhHZZ1Dz7Vw0
        BDFxRuebya75CxCA==
From:   "irqchip-bot for Paul Cercueil" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings/irq: Add compatible string
 for the JZ4760B
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210307172014.73481-1-paul@crapouillou.net>
References: <20210307172014.73481-1-paul@crapouillou.net>
MIME-Version: 1.0
Message-ID: <161527990212.398.14965555681449757699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     673433e7c288927f7244658788f203c660d7a6f6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/673433e7c288927f7244658788f203c660d7a6f6
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Sun, 07 Mar 2021 17:20:13 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 09 Mar 2021 08:45:11 

dt-bindings/irq: Add compatible string for the JZ4760B

Add the ingenic,jz4760b-intc compatible string with a fallback to the
ingenic,jz4760-intc compatible string.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210307172014.73481-1-paul@crapouillou.net
---
 Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
index 0a046be..0358a77 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
@@ -23,6 +23,7 @@ properties:
           - enum:
               - ingenic,jz4775-intc
               - ingenic,jz4770-intc
+              - ingenic,jz4760b-intc
           - const: ingenic,jz4760-intc
       - items:
           - const: ingenic,x1000-intc

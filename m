Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3D33FFC75
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbhICI52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:57:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49324 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348524AbhICI50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:57:26 -0400
Date:   Fri, 03 Sep 2021 08:56:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630659386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4zzbUu60L+uoU3jPBVr6mkR+KvkuFv2/ifguhktpj8A=;
        b=VDzykxx4rj72nQ2f6Kp1QvPiVMtC7lhiK9f1GX9cySevd6Q8Aa8fiKh2vkxCFPJTFQc1ce
        APxT2AbvK7AdwLKrbSB4A8e9TyG1IOr7FLHjM1Jwp2hJQmFeOH7fPFQRB/BYZ7keU7ZNM6
        UtlHPGhUWa986m/gjb3cR7v3N+09A1vppFcmwx1C9Wb/ZEda9vclI9KfKew44ORofCW1eq
        ZIFBUAfF5bE2iyjZKfgrJQbtMy7XFTTWxjlf8UcP0/QDiPIogS7dXdkqNYgufTgN55+ACn
        QtrBKJKtuhgBx2W08kFHqu9lywVQGrCnovlmvqiF74WnlzvqXpqx+OyIgsPk6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630659386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4zzbUu60L+uoU3jPBVr6mkR+KvkuFv2/ifguhktpj8A=;
        b=dW1PppzdS/v2Ml/1IU5pQg8to0ZNlfDEZDJbqpWCJW8/JTw7aEGffv3IhrBNQn/53WtUGi
        PY9Rp4cOVenxruAg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] Documentation: Fix irq-domain.rst build warning
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210903085343.923036-1-maz@kernel.org>
References: <20210903085343.923036-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163065938533.25758.4368842802000552625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     0ddc5e55e6f1da1286fb2646f4248bf7da31a601
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0ddc5e55e6f1da1286fb2646f4248bf7da31a601
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 03 Sep 2021 09:29:07 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 03 Sep 2021 09:54:15 +01:00

Documentation: Fix irq-domain.rst build warning

Correctly escape the * not to be used as emphasis. Also take this
opportunity to clarify the fate of the rest of the legacy APIs.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210903085343.923036-1-maz@kernel.org
---
 Documentation/core-api/irq/irq-domain.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 6979b4a..9c0e875 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -175,9 +175,10 @@ for IRQ numbers that are passed to struct device registrations.  In that
 case the Linux IRQ numbers cannot be dynamically assigned and the legacy
 mapping should be used.
 
-As the name implies, the *_legacy() functions are deprecated and only
+As the name implies, the \*_legacy() functions are deprecated and only
 exist to ease the support of ancient platforms. No new users should be
-added.
+added. Same goes for the \*_simple() functions when their use results
+in the legacy behaviour.
 
 The legacy map assumes a contiguous range of IRQ numbers has already
 been allocated for the controller and that the IRQ number can be

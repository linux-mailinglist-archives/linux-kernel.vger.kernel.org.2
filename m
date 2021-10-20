Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BA8435503
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhJTVO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55480 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJTVO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:26 -0400
Date:   Wed, 20 Oct 2021 21:12:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9M0gvzfqwUseG1mNMNjsmLVZ2kLqEcxGJ2nDYTmOao=;
        b=yWYR4sdQMUplAvU0fixsdjuGW9VMLgeIZz8aseyjJyYLN/NtSjWnptzTt3nYPHDT9bRqjl
        9X0qsn8c5B1+Agujg/IZF1E6ciuvUOM0carOOnypFnJ74MEwxOTGSWWxbVOPjiLT3eQVQf
        djHzgIMOuwd3L6NO5Xd3TdM9kAXWQ/AxQkzNG2jM1DQ7jFmYxAEbUEmR4jeqrGjqGmKGZn
        O1AqM1WkBNXwxHMXnVwF0p28CcBsuwcVdi4ckUNBMk6kQlM6K8btvDcNTcHAPpDYNdNFJr
        BwCZsbOA+R54GiJy0vAH+AqiWV3P6/wyN5O9yul5Edp7kImn2HJoRrTncLF0Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9M0gvzfqwUseG1mNMNjsmLVZ2kLqEcxGJ2nDYTmOao=;
        b=honDrZjJI4a5o4wWncNzr7ewDAdV1AVcD5a6AQyYElY1Y+LgcFEIxwcYqQV9XnyB6HGE9a
        TcsRkIc0ZfuofqBg==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Fix kernel-doc parameter typo
 for IRQCHIP_DECLARE
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-14-f.fainelli@gmail.com>
References: <20211020184859.2705451-14-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476432879.25758.5525222216777072660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     b8419e7be6c6029eee3448fda45f4f9ad340c4ca
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b8419e7be6c6029eee3448fda45f4f9ad340c4ca
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:59 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:07:15 +01:00

irqchip: Fix kernel-doc parameter typo for IRQCHIP_DECLARE

The documentation refers to "compstr" when we have the parameter named
"compat", fix the typo.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-14-f.fainelli@gmail.com
---
 include/linux/irqchip.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 5de0dfc..7f007b9 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -30,7 +30,7 @@ extern of_irq_init_cb_t typecheck_irq_init_cb;
  *
  * @name: name that must be unique across all IRQCHIP_DECLARE of the
  * same file.
- * @compstr: compatible string of the irqchip driver
+ * @compat: compatible string of the irqchip driver
  * @fn: initialization function
  */
 #define IRQCHIP_DECLARE(name, compat, fn)	\

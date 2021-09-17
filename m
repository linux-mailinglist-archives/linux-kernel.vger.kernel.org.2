Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9990040F5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbhIQKc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:32:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbhIQKc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:32:27 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631874665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IR8Ng4fhoQHPpGURW+GUb6/Kndm5lOFHod7KuVPCeo0=;
        b=Bg8fCl51xwdHOJoKkzMCKmnLcEI9ul1E138mmixwE1ws5vg7UXlYAJ8cYTMpqE4FY+cbTw
        RLypLzM4vNFxL2VcZTRiLdmi+n4UVFWHsp/gEVU/nLm4Du4Ss1PYyGe6RCZorLMLUZ1y5D
        Utpo+jeegQbTDc5br6GZoIFPMfWtCqHQuWxPptCs1M1hxz+NGt0jgZs9tGrTwqLTgrICIj
        Q5/pCpnfp8dVFRWvQcO8rHgvHTMqVNcNRnqUxVifvd1K1zffQlcoUNywvGCijO4Rl2irp3
        Hsh+EdRA27a0hSl42Ys3FASLIh/LAhYKFs8+leZF6ULzO02y1SodxLqBcTy0eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631874665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IR8Ng4fhoQHPpGURW+GUb6/Kndm5lOFHod7KuVPCeo0=;
        b=cJaaYOeuBvPFZLkYRZQLHDjMLlAEK+90WPRHRppxIJqXfShIvPuTsNhyis1ooZLSP6ghPW
        vtbP8bcs8cOVVTCQ==
To:     linux-kernel@vger.kernel.org
Cc:     Josh Cartwright <joshc@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] genirq: update irq_set_irqchip_state documentation
Date:   Fri, 17 Sep 2021 12:30:55 +0200
Message-Id: <20210917103055.92150-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Cartwright <joshc@ni.com>

On -rt kernels, the use of migrate_disable()/migrate_enable() is
sufficient to guarantee a task isn't moved to another CPU.  Update the
irq_set_irqchip_state() documentation to reflect this.

Signed-off-by: Josh Cartwright <joshc@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 66d51963e8375..7405e384e5ed0 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2827,7 +2827,7 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
  *	This call sets the internal irqchip state of an interrupt,
  *	depending on the value of @which.
  *
- *	This function should be called with preemption disabled if the
+ *	This function should be called with migration disabled if the
  *	interrupt controller has per-cpu registers.
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
--=20
2.33.0


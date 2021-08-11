Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A2D3E969D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhHKRPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhHKRPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 13:15:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E21DC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:15:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w14so4553668pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3lgVTDmn4REk4t2oeucExyGZOCRsT1uMYJwLq6FhDY=;
        b=B4hYOwUHJTDjeHffrgREh5JvbeliZf4NEzbkiQR+9n0PyE9RCJNHkLuhdJ2tkf3bBU
         d5PgdZ7hxQoffqr2nZ0nK/TCh1AmC3h2gm1YLK7GHTjYxdYIA2OVVcwIk6DOUaEmsKlV
         EZCw5flmfbhqU5oM6lqK6lvOvhsBUl98KoEsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3lgVTDmn4REk4t2oeucExyGZOCRsT1uMYJwLq6FhDY=;
        b=SoZYLYKSJXN6rGQ9t4Kr1LM3uNHo+Fl7IAPJXfpLeWbVScyDJ/swfLTDZokD6eDox3
         +BmcWWP6v/cukatl10O0zDVkh0s5fgKrP3ScHVNTjjoIodo4VvU8CfqyoYmzgdLzfkjO
         SSCArv7Jxlgy1zoJuZ/pXjdTU6VAALA7ksg78Up0WmlXxZMaqJ7rBfgO6q7UfcELqJCz
         qEynxfCKW8tLe2ApAgf8wpKoNdywIuHroB+RUVAWE1/MRyJOOjX2CKgYpnia0BiIDyIl
         GktkLeRwhsxkR98fUMajfuI9LAl4oMDqHaNR336DpvuBfElAoHaqKXpgMMnlP7vJBE5f
         qYzg==
X-Gm-Message-State: AOAM530t9Y1Byx/ydHp/4LPuSFh9w/jiyz7bzrQofbntkdSrIro2MIFS
        +6zxgGTnZQWkWOKatxAijxF4xg==
X-Google-Smtp-Source: ABdhPJxzS41HJ4lI8js1Vi/wUD8ZXHL+vcSufocIoSsgrBqNub2ovhtvFZiNvYILdOLUa6Tdz7WFlw==
X-Received: by 2002:a17:90b:1bca:: with SMTP id oa10mr40013310pjb.177.1628702115738;
        Wed, 11 Aug 2021 10:15:15 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:293c:bdfb:3e50:5db1])
        by smtp.gmail.com with ESMTPSA id 21sm65163pfh.103.2021.08.11.10.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:15:15 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/gic-v3: Fix priority comparison when non-secure priorities are used
Date:   Thu, 12 Aug 2021 01:15:05 +0800
Message-Id: <20210811171505.1502090-1-wenst@chromium.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When non-secure priorities are used, compared to the raw priority set,
the value read back from RPR is also right-shifted by one and the
highest bit set.

Add a macro to do the modifications to the raw priority when doing the
comparison against the RPR value. This corrects the pseudo-NMI behavior
when non-secure priorities in the GIC are used. Tested on 5.10 with
the "IPI as pseudo-NMI" series [1] applied on MT8195.

[1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-email-sumit.garg@linaro.org/

Fixes: 336780590990 ("irqchip/gic-v3: Support pseudo-NMIs when SCR_EL3.FIQ == 0")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/irqchip/irq-gic-v3.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e0f4debe64e1..e7a0b55413db 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -100,6 +100,15 @@ EXPORT_SYMBOL(gic_pmr_sync);
 DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
 EXPORT_SYMBOL(gic_nonsecure_priorities);
 
+#define GICD_INT_RPR_PRI(priority)					\
+	({								\
+		u32 __priority = (priority);				\
+		if (static_branch_unlikely(&gic_nonsecure_priorities))	\
+			__priority = 0x80 | (__priority >> 1);		\
+									\
+		__priority;						\
+	})
+
 /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
 static refcount_t *ppi_nmi_refs;
 
@@ -687,7 +696,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		return;
 
 	if (gic_supports_nmi() &&
-	    unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
+	    unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(GICD_INT_NMI_PRI))) {
 		gic_handle_nmi(irqnr, regs);
 		return;
 	}
-- 
2.32.0.605.g8dce9f2422-goog


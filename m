Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7313AADA2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFQHeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhFQHeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:34:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3ECC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:31:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c9so5536193wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gi6VSwXeRkWircnKRkb8WzdX9UHQQumd7SfNBS3WbXU=;
        b=y9LYgUJL9DncX/5lwcu7u/q+wUa0LE4TYSruQy5W9GWFyUanKsd5zY0UzmR4rTXP3Z
         lDbJaR/kfKHs2wOrX8+bVYYCrt0XdYnxluGGNZjC7xn8fnaXsaR85JSjlPSmym4qoWij
         xiGzmy60Ic9AULnXbwXzQ9tJmEIn58ZPd/rMdX5I81dPNyT+l4rjyIEHWObEelsD/vmh
         cZFiSlH0Vxa9jAd6B0qogCevBZbRPLpmu+k2Td+1Cy1T+DpM2dn7Bpgpqq+k9n0uSLhc
         TSovaef9TxcBceVqDhZW4v0ag1HcHNiWWzMBAY/7UJZpArqygfXgjhYG68QdftxOzZbu
         CtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gi6VSwXeRkWircnKRkb8WzdX9UHQQumd7SfNBS3WbXU=;
        b=SopJDxlqKazC27Znx4RUFq9c61wy4zZIpr8Sz8WpQ1hmY7rVe+SbxHdue+pgzPhlQT
         2LWTufSN9+LSULUCahh5ShwcOl59a10Pr8YwNY2/gKpsyl+4eoqgJDvo6NcvfGsDSVJR
         ErxnfHE2WBCDZCLYqU9hKXbZ1kSH1DnDRpmvF4S93MXduNhp5TqT9otz1CofhYWVi3jl
         dEpScvR6GYpWiRrhGcOyJ83nNlpXzN0pAGMzBlUMOF427oOSOHXkVqbDUDZmyoSFEkUu
         lVE1yivK/xkyTXnAXiVsKU6N/DGOwcT4H2PzBkp+4Ovj5T2BJKJxlZ2NVWtUF35/ddIB
         WpOw==
X-Gm-Message-State: AOAM532uNnvE3vjs6SVwsQ8/shC6Z/QIOox7Y5pSkE9wXTIPSV5vn9WU
        Pdxr4hJH+hSnpQ7Y0bb/yurSfg==
X-Google-Smtp-Source: ABdhPJzPdXP61PISzkq7XKF/R2BEaYbnm79dsr5XUPY1po+lwsMsTCTjyCb3SFmHnM7eqev3mY4QSQ==
X-Received: by 2002:a5d:6546:: with SMTP id z6mr3981844wrv.100.1623915115309;
        Thu, 17 Jun 2021 00:31:55 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id l16sm6656741wmq.28.2021.06.17.00.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:31:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/1] genirq/cpuhotplug: Bump debugging information print down to KERN_DEBUG
Date:   Thu, 17 Jun 2021 08:31:36 +0100
Message-Id: <20210617073136.315723-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sort of information is only generally useful when debugging.

No need to have these sprinkled through the kernel log otherwise.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 kernel/irq/cpuhotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 02236b13b3599..cf8d4f75632e8 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -42,7 +42,7 @@ static inline bool irq_needs_fixup(struct irq_data *d)
 		 * If this happens then there was a missed IRQ fixup at some
 		 * point. Warn about it and enforce fixup.
 		 */
-		pr_warn("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
+		pr_debug("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
 			cpumask_pr_args(m), d->irq, cpu);
 		return true;
 	}
@@ -166,7 +166,7 @@ void irq_migrate_all_off_this_cpu(void)
 		raw_spin_unlock(&desc->lock);
 
 		if (affinity_broken) {
-			pr_warn_ratelimited("IRQ %u: no longer affine to CPU%u\n",
+			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
 					    irq, smp_processor_id());
 		}
 	}
-- 
2.32.0


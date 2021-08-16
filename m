Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6503ED7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhHPNsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhHPNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:48:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59CCC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:48:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f10so8506599wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aOZq7haa28HxJOsDG45n72j3IBKWOPu0CSWifhcKI1s=;
        b=x/moQxu/mru/i/InL+xv4AiuJNMPwxutpKUROhLaGj2DmctU04/8qaXcHzCFCPhVtG
         7ib7jf86Z8X33wHWPUeremY9FDGtgLlQiHJpacNbTJ87YE1hQ4ot0fbhR8hIJ1XHH0/3
         WATGxt1eztmjyzl0Fp2I9vEcH9wYy2ptPeZrQHAuA+gz09eaB2/y0mR2Opn8KLpxBWtN
         TWcnGdyGNxbg4UNotlkuJGJDwzwRnQ1oJE+gI3/TXHttJmeB9/WjRBxNlQCOhQaRL3yX
         0qQ9YD5n90iv2NLt2exq5hfESCPJucoM96v1wErPVgTphvsrdbI9a5tCaHnpnat5XrC7
         iGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aOZq7haa28HxJOsDG45n72j3IBKWOPu0CSWifhcKI1s=;
        b=KZmxs3mWJ5Hhvwwr0zDZhyw6Dq4pYK+WBkfGPV06nkb3fnrud+ondi14kMcY1Ov3sa
         WitTlceNUwiayrMs4sMuhs30atRCexc11qm16nG9A7fcGCuIJAZtUtdLjeFQx4qCJBLR
         w+ByGaG0TdY6DgybXx+whvGaMSj11OF0BradLFCRgfHzvxm0q6TER1qWOvFK0FePHY9v
         NeESPLfOSbhgpH16sblVApIHJxEtCnjVIoIw0KG2fXP/q+zGcNOByo8LqUq6zUpSnNbp
         TMkR4y5h0SbrRvEhdzxNHHuAxSgmq24nQDbpp8mlk2P+CM98xySGqxtegzGnM5+kzmRg
         BVJw==
X-Gm-Message-State: AOAM532Vb31GEHfAtuXVp0pI4YfBdt4UTGx2AQYSgnAxW6eV0hIEsZCS
        SDCS8MjPqiOOfLTuySLpDN8zsQ==
X-Google-Smtp-Source: ABdhPJy7oTM9/Vj6Zhdw8hb0CagxPEYNyA4/FpzgKtVgmlwKw0Md09LmI6oRbZdwMjSb8d1094VEKA==
X-Received: by 2002:a7b:c106:: with SMTP id w6mr15616128wmi.152.1629121701423;
        Mon, 16 Aug 2021 06:48:21 -0700 (PDT)
Received: from localhost.localdomain ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id u10sm2630690wrt.14.2021.08.16.06.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:48:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 1/1] genirq/cpuhotplug: Bump debugging information print down to KERN_DEBUG
Date:   Mon, 16 Aug 2021 14:48:17 +0100
Message-Id: <20210816134817.1503661-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sort of information is only generally useful when debugging.

No need to have these sprinkled through the kernel log otherwise.

Real world problem:

  During pre-release testing these have an affect on performance on
  real products.  To the point where so much logging builds up, that
  it sets off the watchdog(s) on some high profile consumer devices.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Change-Id: I1ad66f05c33431e2a2b0765733c5536e835108e1
---
 kernel/irq/cpuhotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 02236b13b3599..39a41c56ad4fe 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -166,7 +166,7 @@ void irq_migrate_all_off_this_cpu(void)
 		raw_spin_unlock(&desc->lock);
 
 		if (affinity_broken) {
-			pr_warn_ratelimited("IRQ %u: no longer affine to CPU%u\n",
+			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
 					    irq, smp_processor_id());
 		}
 	}
-- 
2.33.0.rc1.237.g0d66db33f3-goog


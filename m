Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A3E4199C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhI0Q7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbhI0Q7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:59:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E153C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:57:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso342415pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVNQ/TSsFCpHmH8roUzHH7XvMBrRFI54b0VHaTyCBAo=;
        b=H2Xr5yJsBofJ/L/K2Flfee0MrlLW+ZGJJrFO6lbGWTaUDBcZejvtb2ieSHb+Bbw2ZZ
         Vk4gxdiUZvSLZIs2Le2caEJehi/oaWfRhLnDG4pxebjQmt0k7zkaAXOxpiaFG4rZv3p3
         hiyXHRhWeepe9Bpde8CGoev4fTdTy/KAzSAMCFJm7YWiJDj52u/dklOyA2ofzWqKC9uN
         3u7FjBj3BjGrs9gfk9onOkssEoetu96nAlDI+qzitgSTbEr3LOEuyVIZKVgF0R3h2UYn
         Z+7ssBzfqMlg/NLIeJwACpOeRZvwjvirJnriJMZjNVKzeD+4XQnvJO6Ug7nRU288Gb/w
         Zf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVNQ/TSsFCpHmH8roUzHH7XvMBrRFI54b0VHaTyCBAo=;
        b=f5E41XSZ52jphiSHPrGnKDTNL0mpX3I5wdsQtRiI8wZOQCNOtS5+UEGiiuHr/WECRe
         83emKcB3WbRukh70R95b4JLIlwvznopPIiDl3N9zoWSeP9yduLHe3r7Y/f8Oge0F/SVP
         cSAZnyOgIpuAnNuahJf1yhQrYwezLsn7VmSzwg6gR4//grI9uUPRWWuYWv7SMN6EJKBk
         /+1BlKL2n/XfXEz1Mj/13wiaJ1lHTh90DLKKaBBu2JbHs/C+0eq26pE0hA1Kgfq3e2JA
         KMHdd+7kBLo3EHkpW6Fi639HeegWvN7yKAQXkvDruhRiodJHEYJfQXWMydh4AO8CIun1
         NcyQ==
X-Gm-Message-State: AOAM533BtMnHVbVdYj80AS9gnyIBMKvdSDCsOQBZnGKXiJ85pl/xjY7h
        fNKsWAE+9uP5FJfUUCK47BP/08l0uDE=
X-Google-Smtp-Source: ABdhPJxJXBOKwYLop10cvnqJmzrtdGdUQxPxtN2GE6+btno8uowYMKey7A3sNNHXf7NdbYYeSdH+dQ==
X-Received: by 2002:a17:90a:1a19:: with SMTP id 25mr145642pjk.34.1632761847787;
        Mon, 27 Sep 2021 09:57:27 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:ecea:c8ec:ff7b:52])
        by smtp.gmail.com with ESMTPSA id n22sm2686769pfa.220.2021.09.27.09.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:57:24 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: call irqchip_init only when CONFIG_USE_OF is selected
Date:   Mon, 27 Sep 2021 09:57:06 -0700
Message-Id: <20210927165706.22938-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During boot time kernel configured with OF=y but USE_OF=n displays the
following warnings and hangs shortly after starting userspace:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/irq/irqdomain.c:695 irq_create_mapping_affinity+0x29/0xc0
irq_create_mapping_affinity(, 6) called with NULL domain
CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc3-00001-gd67ed2510d28 #30
Call Trace:
  __warn+0x69/0xc4
  warn_slowpath_fmt+0x6c/0x94
  irq_create_mapping_affinity+0x29/0xc0
  local_timer_setup+0x40/0x88
  time_init+0xb1/0xe8
  start_kernel+0x31d/0x3f4
  _startup+0x13b/0x13b
---[ end trace 1e6630e1c5eda35b ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at arch/xtensa/kernel/time.c:141 local_timer_setup+0x58/0x88
error: can't map timer irq
CPU: 0 PID: 0 Comm: swapper Tainted: G        W         5.15.0-rc3-00001-gd67ed2510d28 #30
Call Trace:
  __warn+0x69/0xc4
  warn_slowpath_fmt+0x6c/0x94
  local_timer_setup+0x58/0x88
  time_init+0xb1/0xe8
  start_kernel+0x31d/0x3f4
  _startup+0x13b/0x13b
---[ end trace 1e6630e1c5eda35c ]---
Failed to request irq 0 (timer)

Fix that by calling irqchip_init only when CONFIG_USE_OF is selected and
calling legacy interrupt controller init otherwise.

Fixes: da844a81779e ("xtensa: add device trees support")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index 764b54bef701..15051a8a1539 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -143,7 +143,7 @@ unsigned xtensa_get_ext_irq_no(unsigned irq)
 
 void __init init_IRQ(void)
 {
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 	irqchip_init();
 #else
 #ifdef CONFIG_HAVE_SMP
-- 
2.20.1


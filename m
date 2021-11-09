Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADE244B921
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241621AbhKIXAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 18:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238765AbhKIXAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 18:00:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD224C053743
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:54:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so1053156ybj.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LBlVjryW+79tXVvH13UTzbDUQSm7cCLNaSBlAthv3Ns=;
        b=ONXZ3E8D4m9iq/1BnQusbBYhm3eIGGIZh2DH3IfHICKLv9h/wE2Wi/3f3YYQOllROV
         /apxLceTSCBCeMgf636oXhs47b7EW6cF1xtmS/pI2Gvekhe7Kq0AODESGb0svrPCXxu0
         /LQ6jE1Uyi24kxvbJ3t3akmsdf9dVhX0moNt6RCIuCbBwiW7CboVb6f7zVJqGK0aeSqm
         8TRk3sQWAWez//crt3Ih7hmc3cNxbirGr5q4+lyalUGi5SyvgH0Xj2axglhXoRUQBDil
         DTrgudbbBEw8axm+UbIPrPzycjNsfLzGOl7veP1B+5lnh139Qzd3vqQ0bEiKV4Wocw6u
         M6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LBlVjryW+79tXVvH13UTzbDUQSm7cCLNaSBlAthv3Ns=;
        b=0h3/b9oYx0HkO0TPskgnxn8XnokFmdlmM8JAzJQseHOqv3RNtD1QghPGo86O5hNSXu
         o9bSj779uZldpZcikPsaXAxZgdXrt3dDkOXcpBNBFDQ7rJUdAWuq+QMJzoKtrIZ7+kG3
         lO8Lbo2ZJMbJMPWFxgSwa537Jr4K+mdE4xUC1MzLL9uXyD3VL0IdD8qsZv1BvVCeTdJS
         gIlnGBHu+4j1qf+gkRJX7DTRWmUb8lpIrvcc8I0VBjMT1IyMEaSQnIPPvLaMqB0zhVeS
         EDY+XN6X2vfx3Xf6xm/kZj2dRalJeOC1Cc9rjC8HOjTY4Yrb2A2hcXSmK/uYVqwIA4S/
         +lOA==
X-Gm-Message-State: AOAM5302FmSlSFMsceqjMDhoE3P55Tx10MlnbwbbefI+4XX+ektAKU9t
        kK/nz+avCBvIFxoV2+EKCe+r2OPEIUQFD07K3HmKgjgFkwQS5nk3QhBPqtjufQBX+1/4qilKquF
        lwpmXMqC0V+uzxgLeWTySmqAyh6koKZrTrqOMnOYlvPo0/SGjuN3sRAJdTDNXTNUPV9T6hSXH
X-Google-Smtp-Source: ABdhPJynItl5RurTuKrMN7GYmpjvirG0fiqzYQz2SOfedGV6voSegwZUjzYYvWvXcXYMKJEh+NdLv7NOoPdt
X-Received: from suichen.svl.corp.google.com ([2620:15c:2c5:13:7559:12f5:de29:c918])
 (user=suichen job=sendgmr) by 2002:a25:8e04:: with SMTP id
 p4mr11969997ybl.165.1636498454015; Tue, 09 Nov 2021 14:54:14 -0800 (PST)
Date:   Tue,  9 Nov 2021 14:53:21 -0800
In-Reply-To: <20211109225321.618688-1-suichen@google.com>
Message-Id: <20211109225321.618688-3-suichen@google.com>
Mime-Version: 1.0
References: <20211109225321.618688-1-suichen@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC Patch Resend 2/2] add npcm7xx debug counters as sysfs attributes
From:   Sui Chen <suichen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sui Chen <suichen@google.com>, Tali Perry <tali.perry1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds npcm7xx debug counters as sysfs attributes using the
i2c_adapter_stats_register_counter function.

Signed-off-by: Sui Chen <suichen@google.com>
Reviewed-by: Tali Perry <tali.perry1@gmail.com>
---
 drivers/i2c/busses/i2c-npcm7xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index 2ad166355ec9b..def044207cae2 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -2224,6 +2224,14 @@ static void npcm_i2c_init_debugfs(struct platform_device *pdev,
 	debugfs_create_u64("rec_fail_cnt", 0444, d, &bus->rec_fail_cnt);
 	debugfs_create_u64("timeout_cnt", 0444, d, &bus->timeout_cnt);
 
+	/* register debug counters in sysfs */
+	i2c_adapter_stats_register_counter(&bus->adap, "ber_cnt", &bus->ber_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "nack_cnt", &bus->nack_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "rec_succ_cnt", &bus->rec_succ_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "rec_fail_cnt", &bus->rec_fail_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "timeout_cnt", &bus->timeout_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "i2c_speed", &bus->bus_freq);
+
 	bus->debugfs = d;
 }
 
-- 
2.34.0.rc0.344.g81b53c2807-goog


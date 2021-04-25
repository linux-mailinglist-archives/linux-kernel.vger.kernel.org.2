Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B9336A7E4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 17:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhDYPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 11:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhDYPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 11:09:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47EAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 08:09:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v13so14000648ple.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHlGHrrVXtk9PyuNnHPbkHmoxxzuCU4xw3xKGDcLefE=;
        b=PwW1NXTB+lRzMAk6pg/yZyqkjDjzUz9mBqtFiiyHaustu5oLV1FSWi50riU2mmxrlt
         vM4wEIP7MwXexti9vkJdwfEoOA8KPaf0FcXM+Pe0Hb7emfgH64VXzBPflqEP5jk5u+bc
         UV77c1gYddnjxzMDGaCnWly4PzZqECyoFNjgjf0zQhFeJb2MXuh2TnyJ5KVwWgrGOut2
         MxdEZPAua8HSdaW/Y/FsMAwkGZ5hIYNZKpXc3Mm9uk3xx7+a/eZ9B5fu/6uzTK+1Dveh
         q4xCcoHuQOZBKq/bDzVp8msBzM12hALbYN+xMChnLQDQVCWKO09fRZ4a35L/1kkuEgac
         5j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHlGHrrVXtk9PyuNnHPbkHmoxxzuCU4xw3xKGDcLefE=;
        b=BrhtMWVmOEk4d8zf4bnqRH4+P4scZ2Cv/CUi5xPF2N+o9s30EClkAD3P3eKxcMR0DC
         IZP4IpveZxCkAiv5AsTF3QUoOXsgn1Yl3WCl0j2pTrFNt5s8XyVGXhuSQnIWDzUsTZU/
         KLbPxF9yZOeGs7F4Vimmpfh+7rJ8zHPsVDfOlUAimKWoo2sFb3XkuU20TLmYwxmLAiqa
         QofIM2CobcjGqQJacDXytnOsJ9SUClgyKZCB+L0xTuzEWfRG2zKzI3bYZ/1e43sulHSJ
         9vkI4/tS/xqGZ+Xqro/bM18bVfrgVS9QbcIQeyxglYXjg5Yx9vCKx+6tn9NyVAnyppZD
         m/cQ==
X-Gm-Message-State: AOAM532/ukz9ilLec9i4OtsvLyb9gL5rMm8OCQfe83tkXk2IK7BxiVhv
        1JcUBFQC17N16zP6xVLM7jo6RAXUzeHftt4ciI0=
X-Google-Smtp-Source: ABdhPJw3yq1HH7o+ixENDzThz1DUj3VsrIrvra3OvLY0H6yn+Tim8cmCGSs0yQT25H9pBnmW7N73CQ==
X-Received: by 2002:a17:90b:3796:: with SMTP id mz22mr16609803pjb.80.1619363355135;
        Sun, 25 Apr 2021 08:09:15 -0700 (PDT)
Received: from localhost.localdomain ([223.72.62.201])
        by smtp.gmail.com with ESMTPSA id z26sm9098171pfr.106.2021.04.25.08.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 08:09:14 -0700 (PDT)
From:   Ben Dai <ben.dai9703@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Ben Dai <ben.dai@unisoc.com>
Subject: [PATCH] genirq/timings: prevent potential array overflow in __irq_timings_store()
Date:   Sun, 25 Apr 2021 23:09:03 +0800
Message-Id: <20210425150903.25456-1-ben.dai9703@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dai <ben.dai@unisoc.com>

When the interrupt interval is greater than 2 ^ PREDICTION_BUFFER_SIZE *
PREDICTION_FACTOR us and less than 1s, the calculated index will be greater
than the length of irqs->ema_time[]. Check the calculated index before
using it to prevent array overflow.

Signed-off-by: Ben Dai <ben.dai@unisoc.com>
---
 kernel/irq/timings.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 773b6105c4ae..6990490fa67b 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -453,6 +453,11 @@ static __always_inline void __irq_timings_store(int irq, struct irqt_stat *irqs,
 	 */
 	index = irq_timings_interval_index(interval);
 
+	if (index > PREDICTION_BUFFER_SIZE - 1) {
+		irqs->count = 0;
+		return;
+	}
+
 	/*
 	 * Store the index as an element of the pattern in another
 	 * circular array.
-- 
2.25.1


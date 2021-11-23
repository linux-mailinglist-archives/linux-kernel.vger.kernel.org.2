Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BA9459D01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhKWHsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhKWHst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:48:49 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981ADC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 23:45:41 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r5so17572622pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 23:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=nR91k261qT24h7vuSe+HJVMGhh9hCNxJOAQfhKWdYwg=;
        b=NAHsrFiZQyKfQxlKtTk2TDbBXiPZWoxY43IvPRqiQHQfmUbsBHHMvnjLGZC3Fv1LQB
         saZv+ZB/2mlmXxP6CciagRnTBrC1qRVsRFKG/ch9dTChQXUub4VTEH3XqQNcIFvrgOob
         ErvQ2ajtoiv5Jie8Oc3OYI/SjYiH0ne0cojrj89Vm7IKehYdrENXULlABj75CfqjYYHC
         yWQ6GLbG8VErvqn+EMJGn7WQr/Tz9JyB5jvgUa/7P4sY8ElMdu3cMDuIR62HGtczo3Z+
         ynmGTzH6nj20h6O80RWwdDWeL8137DbQk/n0ljwZmzlYq5uj1hW8z95GsUZa3FHrEeKw
         Mv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=nR91k261qT24h7vuSe+HJVMGhh9hCNxJOAQfhKWdYwg=;
        b=2tlW5OLuMcBDtRRdAjPKc1LnZSW5geJPIiSTxvA8WeEd5A7izhAA4UuuaMDO3V/cdV
         hN+z9LhbtPAFheJPM6H3RDK34cT2YE1fLuEorv59ZcSAh3dZUvQRD0bBIMRKuu5gSXaC
         tH01KJAnQ6JefnL/388fMMv9b9kyOo0TNnQQ8Aft0nlBbgiZdu7Cpv9ejXtX78a9ciwZ
         aFy0q+woK17g7VwLSVfVRCzqbrz7k6M9Pl3TIkcNQPTk3E13Bi/PkcaJZVE6mnDUESZH
         rvqlr3CqtTQ5hAy5Em9j7ueZ+x7M5+YOwO8GWuLoQHLQywRHII+KVRmWC7mSiY/A4xeS
         DRDg==
X-Gm-Message-State: AOAM5304lq6P5o6DWW8N1FkzR5jQRNgFe6okOWNMwaynCyPwyqIXv5T7
        CR7znTpoR7IBHh6pGWd7O/haTBZbB1NfpWwWZB8=
X-Google-Smtp-Source: ABdhPJxvGMXNQy8eRQMPHVJ375J5Hb86G0B6G9Oq/0cPFkB8gqS/OooUvOah4XkhwLbqXZDK3BiCew==
X-Received: by 2002:a05:6a00:1305:b0:4a2:75cd:883b with SMTP id j5-20020a056a00130500b004a275cd883bmr3610052pfu.44.1637653541238;
        Mon, 22 Nov 2021 23:45:41 -0800 (PST)
Received: from localhost.localdomain ([43.128.78.144])
        by smtp.gmail.com with ESMTPSA id s21sm11377062pfk.3.2021.11.22.23.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 23:45:41 -0800 (PST)
Date:   Tue, 23 Nov 2021 15:45:35 +0800
From:   Aili Yao <yaoaili126@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, yaoaili@kingsoft.com
Subject: [PATCH] sched/isolation: delete redundant housekeeping_overridden
 check
Message-ID: <20211123154535.48be4399@gmail.com>
Organization: ksyun
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

housekeeping_test_cpu is only called by housekeeping_cpu(),
and in housekeeping_cpu(), there is already one same check;

So delete the redundant check.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 kernel/sched/isolation.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7f06eaf..5c4d533 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -56,9 +56,8 @@ void housekeeping_affine(struct task_struct *t, enum
hk_flags flags) 
 bool housekeeping_test_cpu(int cpu, enum hk_flags flags)
 {
-	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & flags)
-			return cpumask_test_cpu(cpu,
housekeeping_mask);
+	if (housekeeping_flags & flags)
+		return cpumask_test_cpu(cpu, housekeeping_mask);
 	return true;
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
-- 
1.8.3.1


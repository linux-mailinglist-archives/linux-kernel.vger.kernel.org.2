Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4523F26A0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbhHTGFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhHTGFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:05:04 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7D8C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:04:27 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y144so9827151qkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Jckvcf3C20dkUkR430dMT0n5l1VJJXPeVONNZC1DQk=;
        b=n2GIKcUq+jvN5SwC/OjK0d1S2XQfINia2fG9I9fI8akguI0ZTtvbVw4oOL3fjgYQ8b
         JesaA+ARI5bBAA6fPiNPRVqbWwGKn3algF4QNHqGmHFyDjtIP0Of5HEDlWk/F0EyRH3g
         h8agZP7JPOT0reDJFpo1+fm5UuQ770wgx3qeQ6vpcjzya+6yloJMH+CalVjQt3zCxGdz
         UuRwUsH6zBUaZS3oRPTgqi9chfBAGHozZRF/4jdNI4CwiRYn2OqR+RkliAQfiugR/FEb
         yJ5Y15D2X0tNgm6G3R/QRYsRhXaUYDZItDlY8weMan0XInlxD5CazKo2ZUc0jtzda3/s
         rIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Jckvcf3C20dkUkR430dMT0n5l1VJJXPeVONNZC1DQk=;
        b=sRueD2QBonPBrXyPpfupXbE86HtBh4NpTEdcU0XLJkIJeBxxRubA1ZsquTG1RvT5rC
         qSG0taR7O+ESC+gRmZeV4xmdD0e9YztQApZHKsR26wt+P7vR7vNoplTeVk95Cx+/HjeN
         6mBrpGP+4kB7zhZEbWSXIf5GY8h4YHSm3HrJFvSBw5WsJXRPwgvg4IocKF4BHvA/4q41
         TkIR2YFvNXb/oa9PsFRjkWRxJ2jg4iAb00N4ApvMfEcWgNmVu/DJ93TWL0Qwc2SJSCI/
         pwfOa90l1vYQUPuwpkVCNPTYntKYY2bKftYglch9XCpgCkKewYqbUcfbkD5GMBnsLcbN
         9Row==
X-Gm-Message-State: AOAM531EjSPjNvjJiinL9n97+9ikbjuZ4QQGNWMe+TwVwk7hTcq4E3nQ
        cZJUCvKp9ujwRnXz3ODVB7kSxxfpcKc=
X-Google-Smtp-Source: ABdhPJxjM6x3zs1JiE0G7VfPLKZB4uHXHpTbiad0WFtH6rsY8Fp/LpmIpq7TA/i2C4xIBj1/vQWaGg==
X-Received: by 2002:a05:620a:318f:: with SMTP id bi15mr3536217qkb.4.1629439466303;
        Thu, 19 Aug 2021 23:04:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y2sm2846478qkd.38.2021.08.19.23.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 23:04:25 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] x86:iormap: replace a printk + WARN_ON_ONCE() to a WARN_ONCE() Replace a printk+WARN_ON() by a WARN(); this increases the chance of the string making it into the bugreport.
Date:   Thu, 19 Aug 2021 23:04:08 -0700
Message-Id: <20210820060408.14207-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 arch/x86/mm/ioremap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 60ade7d..f2ded4a 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -195,9 +195,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
 		return NULL;
 
 	if (!phys_addr_valid(phys_addr)) {
-		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
+		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
 		       (unsigned long long)phys_addr);
-		WARN_ON_ONCE(1);
 		return NULL;
 	}
 
-- 
1.8.3.1



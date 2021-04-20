Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CAB364EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 02:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhDTACK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 20:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbhDTACH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 20:02:07 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6EFC06174A;
        Mon, 19 Apr 2021 17:01:37 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o5so37770336qkb.0;
        Mon, 19 Apr 2021 17:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dNsqeGv2CjMAPvl9VxW5Vyc9Hyz/R+VIVig8yMnDck=;
        b=Z2ZTfD+JpoBTssxkLMiPLdClzlrctpjggkVNnx0dCA7dTToOxMZxNyOII8HB26xsq5
         tLVtg/tlVgSKbLzl2THozeAu0WTSTk5N7Qkd3jS0uVsEvHLocrqKQB8YVFD7DAAI6EYG
         14ZhLoPGyoOB8Or6GypLqg8L905dxpekkA2fhRxld0LX7YSKLj4N9PZdVXq7cFsXnhfI
         ZDvPW1zctUkCma2JwEv7z17tzmVMKYevyD4ylwq6jpuNlsWoY6Un2Srgrymx4yNwEn3h
         4ux6SRYOECy52PPBka67LbQ+i6wTpp/hRAb3rdxSy+95z/0IeYpJXbzD+NYvV+g5H/Nt
         wBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dNsqeGv2CjMAPvl9VxW5Vyc9Hyz/R+VIVig8yMnDck=;
        b=dm7ij4opyCbkR7oDFtE0ghUyeSqkMeanhZ9625iQJWgPNt6itSZv/SOJd5j8jig7fE
         z/DIg7srLkPJooAJO4OpuDBuqJzIqc6FqQ01+nFvQybk4BjZA+xyn3rV91VduPNe8Xk2
         H4xGjf7KtqLhewYvoakirHFEHIS74g4WcgE9eak2/Q2Sm4IzMQeLN+qkStWAprhXij1J
         kroxIVBpPULAYAgv+knQhu8O0wqi2TXpj7uS3UGbqK8hyy4dfZfwGxU+I3GCbbGXONGs
         FJIfsbn3ipD3h651Kt12Jajv7yCOno0PFDYyF1s2bsHx4PTM1GAy5xwz6EidDBIjLR8G
         rijg==
X-Gm-Message-State: AOAM531mAAfNVukmBmc6hzzqGHw0xicGT93cYi1ty+jH/nLFsUxQnN3q
        y9r3Hnm8pH/G/hyGwX85gAi2cxJZXB0=
X-Google-Smtp-Source: ABdhPJx7tyWynZK0k4yh68/qfQE4XWe9FMG5MBiP5D/eiR1cGPghkGtEfumVUhD2jFc/ILzy+a72Nw==
X-Received: by 2002:a05:620a:a19:: with SMTP id i25mr2028337qka.416.1618876896413;
        Mon, 19 Apr 2021 17:01:36 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id b23sm229838qtp.17.2021.04.19.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:01:36 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] rcu/tree_plugin: don't handle the case of 'all' CPU range
Date:   Mon, 19 Apr 2021 17:01:31 -0700
Message-Id: <20210420000131.21038-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420000131.21038-1-yury.norov@gmail.com>
References: <20210420000131.21038-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'all' semantics is now supported by the bitmap_parselist() so we can
drop supporting it as a special case in RCU code. This patch does not
add any functional changes for existing users.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/rcu/tree_plugin.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 464b16132866..334eaf4d561f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1511,13 +1511,10 @@ static void rcu_cleanup_after_idle(void)
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (!strcasecmp(str, "all"))		/* legacy: use "0-N" instead */
+	if (cpulist_parse(str, rcu_nocb_mask)) {
+		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
 		cpumask_setall(rcu_nocb_mask);
-	else
-		if (cpulist_parse(str, rcu_nocb_mask)) {
-			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
-			cpumask_setall(rcu_nocb_mask);
-		}
+	}
 	return 1;
 }
 __setup("rcu_nocbs=", rcu_nocb_setup);
-- 
2.25.1


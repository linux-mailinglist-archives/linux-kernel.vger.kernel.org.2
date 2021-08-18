Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351033EFCD4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbhHRGca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbhHRGcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:32:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5B3C0613A3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:31:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v130-20020a25c5880000b0290593c8c353ffso1821574ybe.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ObPkY95BgccMVOXBvY8W42OB1HqUP7YDieqWubLPiME=;
        b=Jtstdp0V+Xh88MSFciGZx/6Crwh6uax0pLuw3AXs+D9oj1KbSd4HzqBIam2qrHZk5g
         s6jTCXgbdB9PNkW+XseCkH6f/SPnpj+XnPohW32F/qWDIdj7SKz1f0lnCEZ8LmwdB716
         Rvc1f56BY2VSkf0TJZ2KH2yJfDtj+1gU2XMmm4u5Bt6jYwhCgsspJjhwVZKFfJUTrCz/
         XZVzMwPQYhql8Y8pTREUZGN5i0txpFG5vvusnI8qF9fCezySVG3pknbNJwrstN6Q+nbI
         0vRgf5epo1QPD4Pm/Aj6L2XrjBdYdKaX+yhcs/uRqo5Y444dTY1fVQPIgzKndV2ESXHr
         EBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ObPkY95BgccMVOXBvY8W42OB1HqUP7YDieqWubLPiME=;
        b=n/UOwzFjmjITSr8psj6WICr0cEV1q1Z15F2g7coh8yMpS6IhjrJ1uC9bfGSNYf/FNR
         5L8gUNrD1Xs6EQ09ktM13OB3hCp9nK/akvb/h1fCgZ0xfwVTskQGm1bjaOCdtHtSSxT5
         fBWZr1duGUF34NUOoPtLREoNradn/2T6YL+93COO9i2cCwwInuf4LrPYw4aeA09jZsbL
         3KTyiQevM7PrJM032bmwU128fK2+6XA3t4kl56cMRKYlfvGL252ZYg3iPkMYAMYip3D/
         vOmnytNH+Idnuo5wWsozZ8PvOrqv3PlvUWXUnmRhkyJ+ZTbGRy3dNbpNQvXW9JYMfZxF
         G93Q==
X-Gm-Message-State: AOAM532KyRMV+Xzx0hRMobG9Rc7OAdBh/9ofB7jMtuBht0uBVjE4Yrt1
        OYqC5otHBRfwm+ae7+5RF4WODuawuD4=
X-Google-Smtp-Source: ABdhPJxfsOO100ggYeO0sY++gqlc3MsdnvEUTquZH6o+BnI8n97BCwdldFsnuDGXBQoFBIYNUCH/1sFG8Qo=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:41f0:f89:87cd:8bd0])
 (user=yuzhao job=sendgmr) by 2002:a25:42d8:: with SMTP id p207mr9419451yba.270.1629268285077;
 Tue, 17 Aug 2021 23:31:25 -0700 (PDT)
Date:   Wed, 18 Aug 2021 00:31:06 -0600
In-Reply-To: <20210818063107.2696454-1-yuzhao@google.com>
Message-Id: <20210818063107.2696454-11-yuzhao@google.com>
Mime-Version: 1.0
References: <20210818063107.2696454-1-yuzhao@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v4 10/11] mm: multigenerational lru: Kconfig
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configuration options for the multigenerational lru.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
---
 mm/Kconfig | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 40a9bfcd5062..4cd257cfdf84 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -889,4 +889,63 @@ config IO_MAPPING
 config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
 
+# the multigenerational lru {
+config LRU_GEN
+	bool "Multigenerational LRU"
+	depends on MMU
+	# the following options may leave not enough spare bits in page->flags
+	depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
+	help
+	  A high performance LRU implementation to heavily overcommit workloads
+	  that are not IO bound. See Documentation/vm/multigen_lru.rst for
+	  details.
+
+	  Warning: do not enable this option unless you plan to use it because
+	  it introduces a small per-process and per-memcg and per-node memory
+	  overhead.
+
+config LRU_GEN_ENABLED
+	bool "Turn on by default"
+	depends on LRU_GEN
+	help
+	  The default value of /sys/kernel/mm/lru_gen/enabled is 0. This option
+	  changes it to 1.
+
+	  Warning: the default value is the fast path. See
+	  Documentation/static-keys.txt for details.
+
+config LRU_GEN_STATS
+	bool "Full stats for debugging"
+	depends on LRU_GEN
+	help
+	  This option keeps full stats for each generation, which can be read
+	  from /sys/kernel/debug/lru_gen_full.
+
+	  Warning: do not enable this option unless you plan to use it because
+	  it introduces an additional small per-process and per-memcg and
+	  per-node memory overhead.
+
+config NR_LRU_GENS
+	int "Max number of generations"
+	depends on LRU_GEN
+	range 4 31
+	default 7
+	help
+	  This will use order_base_2(N+1) spare bits from page flags.
+
+	  Warning: do not use numbers larger than necessary because each
+	  generation introduces a small per-node and per-memcg memory overhead.
+
+config TIERS_PER_GEN
+	int "Number of tiers per generation"
+	depends on LRU_GEN
+	range 2 5
+	default 4
+	help
+	  This will use N-2 spare bits from page flags.
+
+	  Larger values generally offer better protection to active pages under
+	  heavy buffered I/O workloads.
+# }
+
 endmenu
-- 
2.33.0.rc1.237.g0d66db33f3-goog


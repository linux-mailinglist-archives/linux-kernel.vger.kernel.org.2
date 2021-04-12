Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDCE35B796
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 02:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhDLAHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 20:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDLAHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 20:07:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60236C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 17:07:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h25so8029484pgm.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jiuyang-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YnVs6iXJw2PnHXM+FTaBmQjNfh0kVz1yzJWe9NsSwR0=;
        b=2FCp0QcA9KMN1+FvWg1Rjg8sWToiad0gBkN3N2EJetKRzsEwU0L4kPzDEai8bniM5Y
         1NVCO/N1/LVjMevSq5/++QC2mWE13WL+cstlo1xdFy5yI9PjlFw6lKtmpDJE5UnX07du
         LU9HykuIrJlfQluE876DA+/3BBY7T4Rk0fAAVCxOEXK/zjS/l/iQacIilwGNYBWWKZfh
         H/c1KZbbV68QbSvvQUSRZ4X9R6eLrRxDdNo1mpaiUlPBa+f0QqLRbX0ytoZsusftsxWG
         f9hbkOaUPzMDQ6PDCOanlBwjxxopQJgn8K/hCnoRMVQq7/944pDsE+rTJXjWdZ3LhBQI
         lPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YnVs6iXJw2PnHXM+FTaBmQjNfh0kVz1yzJWe9NsSwR0=;
        b=N9ZGE0dqtmAeu+60Q+7oJZ50ha0UAVYrqmpuhVooQtfLyloIJiW++qy0MMkmoy7sgE
         c8vnXIc6UdGXAcsT2FmZIyC95g011l4hGWguMaL7oIevuIDC9NFY1n5dSgZpCk/sDGcY
         YmkK/DMbccNUvxekTrg2xrfR8mNK1611WsCDjw2vWMPV6+qfDYhcE42QnFj6QjhZsg60
         SUIk1Sl0CWEFnj4neq7Axapa7C2ymQkJ1eyavfvhMmpQs5AIXWlvGUYYOTQe1iC7+DCU
         BX368jYetIFUfVHPZxDS2c1aNYtCxlLk8KYNs4Ev1tDIV3h614Ca7WdyvEnCIA/1xRSK
         iicg==
X-Gm-Message-State: AOAM530z+TPjlNQgU2uJayFhBaZIkSU2w5rtqVPKGbi76OXcquAj71nJ
        J/ETGxadUEQMBdYEeSIUtPjqXA==
X-Google-Smtp-Source: ABdhPJzDdTFa3CC1zKUIwEJQdDfwZ4tO3Fj5p3nGBQapMaKymcm2Jj7S+Ovc6enFWYjZC8kcHAi6bQ==
X-Received: by 2002:a63:30b:: with SMTP id 11mr24078481pgd.245.1618186044990;
        Sun, 11 Apr 2021 17:07:24 -0700 (PDT)
Received: from nuc.. ([193.110.201.196])
        by smtp.gmail.com with ESMTPSA id 14sm8544872pgz.48.2021.04.11.17.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 17:07:24 -0700 (PDT)
From:   Jiuyang Liu <liu@jiuyang.me>
To:     Alex Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Jiuyang Liu <liu@jiuyang.me>,
        Andrew Waterman <waterman@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] implement flush_cache_vmap for RISC-V
Date:   Mon, 12 Apr 2021 00:05:30 +0000
Message-Id: <20210412000531.12249-1-liu@jiuyang.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements flush_cache_vmap for RISC-V, since it modifies PTE.
Without this patch, SFENCE.VMA won't be added to related codes, which
might introduce a bug in the out-of-order micro-architecture
implementations.

Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/cacheflush.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 23ff70350992..3fd528badc35 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -30,6 +30,12 @@ static inline void flush_dcache_page(struct page *page)
 #define flush_icache_user_page(vma, pg, addr, len) \
 	flush_icache_mm(vma->vm_mm, 0)
 
+/*
+ * flush_cache_vmap is invoked after map_kernel_range() has installed the page
+ * table entries, which modifies PTE, SFENCE.VMA should be inserted.
+ */
+#define flush_cache_vmap(start, end) flush_tlb_all()
+
 #ifndef CONFIG_SMP
 
 #define flush_icache_all() local_flush_icache_all()
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E12A34C188
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhC2B45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhC2B43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:56:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 18:56:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id ay2so3655774plb.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 18:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jiuyang-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZpbsboO00+NGpd7nPfABOl4VUqqJUF8OMrvGKrRJGlk=;
        b=DNY7oU5AuNEygQnIMijS7RCHjJwRewCPsfUSQFe2h5cCOuJ+ifFY8DW4QRTPk93+If
         bMHPE7IjFB2U6W+c2yzimU9uZt5TfHUjRGaUvDkm7npWoRMfZGKNzDIf6xDMUX5bu6oe
         wpl/fN+0Q+n2ziyPey6y1Noy3ufYTE6y0a88c2J322sjbuMaPrr4UIvVI1fHpQaFvcDZ
         POjsafTleR+VKvsssby9efnaPkcq66PSyONjY23mW37FtglEdAMacem4urvS6iWN7Bfs
         YfjIjm80E6/m+aMwFYPD0FvKecvaGJEarz8dNzhv0aY4SNsq+aUeLZQFdhWMZUoKgq3c
         AyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZpbsboO00+NGpd7nPfABOl4VUqqJUF8OMrvGKrRJGlk=;
        b=GrET5oArjWzZWEfYzt5wz1Xu511+21gTS4GGhW3il4yAn1f+KZSaSWP8cPMElQ6fkq
         SxI5/oUa52f1JzdbAAYNhWLMm0QjqsmykbPkKGsaLXoyK1JnEUbpQz0pyse2/STrdkgd
         ZB2hb0Us/fgb4RfazynAIv14hcgerUsdBQez1Y+WJJW9OJ8SL96BJpKJprwLUXyVVjhz
         t6Gc8+ZrMz6dEf3MMAJIomeJ2o3P1og1uTPs49/8RXzKY0fp/cD5gxjFmlc1+QZokJhi
         lbR+mJbFa4KI3WEdKIP+JxamkHM8fzSLm4ckihN1zel1W/JBFzMQmW2XUUheDWgOPBUM
         Ro1w==
X-Gm-Message-State: AOAM530ysmZCFSym/vWeGCdHExJ/ibetjzFuyL4psWYdTdlR+QN2Ji3l
        +KaS1h/ILUo52eRbzNGipPyz34MpUHOC3DEhjAvQgA==
X-Google-Smtp-Source: ABdhPJxUl/aFR80aVf1TQMBBpMuXPSOYnn6M6PkezmdoM4iqg409vk+JH1z0TKOcUvtNW4LNoXO2gw==
X-Received: by 2002:a17:90a:f98e:: with SMTP id cq14mr23359357pjb.60.1616982983564;
        Sun, 28 Mar 2021 18:56:23 -0700 (PDT)
Received: from nuc.. ([193.110.201.196])
        by smtp.gmail.com with ESMTPSA id x11sm18202652pjh.0.2021.03.28.18.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 18:56:23 -0700 (PDT)
From:   Jiuyang Liu <liu@jiuyang.me>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Jiuyang Liu <liu@jiuyang.me>,
        Andrew Waterman <waterman@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] implement flush_cache_vmap and flush_cache_vunmap for RISC-V
Date:   Mon, 29 Mar 2021 01:55:09 +0000
Message-Id: <20210329015510.44110-1-liu@jiuyang.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements flush_cache_vmap and flush_cache_vunmap for
RISC-V, since these functions might modify PTE. Without this patch,
SFENCE.VMA won't be added to related codes, which might introduce a bug
in some out-of-order micro-architecture implementations.

Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
---
 arch/riscv/include/asm/cacheflush.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 23ff70350992..4adf25248c43 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -8,6 +8,14 @@
 
 #include <linux/mm.h>
 
+/*
+ * flush_cache_vmap and flush_cache_vunmap might modify PTE, needs SFENCE.VMA.
+ * - flush_cache_vmap is invoked after map_kernel_range() has installed the page table entries.
+ * - flush_cache_vunmap is invoked before unmap_kernel_range() deletes the page table entries
+ */
+#define flush_cache_vmap(start, end) flush_tlb_all()
+#define flush_cache_vunmap(start, end) flush_tlb_all()
+
 static inline void local_flush_icache_all(void)
 {
 	asm volatile ("fence.i" ::: "memory");
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D767E33B3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCONUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:20:52 -0400
Received: from foss.arm.com ([217.140.110.172]:39916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhCONUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:20:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D4C011D4;
        Mon, 15 Mar 2021 06:20:35 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB04B3F792;
        Mon, 15 Mar 2021 06:20:33 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v16 3/9] arm64: mte: Drop arch_enable_tagging()
Date:   Mon, 15 Mar 2021 13:20:13 +0000
Message-Id: <20210315132019.33202-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315132019.33202-1-vincenzo.frascino@arm.com>
References: <20210315132019.33202-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_enable_tagging() was left in memory.h after the introduction of
async mode to not break the bysectability of the KASAN KUNIT tests.

Remove the function now that KASAN has been fully converted.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/memory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f6d1ae69ffb3..a07923eb33c5 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -245,7 +245,6 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 #ifdef CONFIG_KASAN_HW_TAGS
 #define arch_enable_tagging_sync()		mte_enable_kernel_sync()
 #define arch_enable_tagging_async()		mte_enable_kernel_async()
-#define arch_enable_tagging()			arch_enable_tagging_sync()
 #define arch_set_tagging_report_once(state)	mte_set_report_once(state)
 #define arch_init_tags(max_tag)			mte_init_tags(max_tag)
 #define arch_get_random_tag()			mte_get_random_tag()
-- 
2.30.2


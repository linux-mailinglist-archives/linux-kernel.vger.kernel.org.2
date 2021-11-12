Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B57744E3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhKLJXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbhKLJXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:23:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDCCC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:21:04 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so5805204pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=TXyhI6ZNw+Pl/TFoBoEd6+kAJZTjqmZS/HvSrvOgA+A=;
        b=Udsv5nFmG2Lgs+UffFeRimciscQKhmznKMf8m+Bwdd+UEknozr4HeRxSW95peGh+Z9
         FHmfQMyIuehSJXrfU4E+U4FhmHXyzNiX5KwMNBqK2AWLSuubvc03BirwOkOcRyNXv8yb
         +H6f0thX/9vvTyD/uHlP3tDhq3yf3H8siQ9eM2CEEZJe7u2s3XmoskM3R13yC1+fd3NU
         UfFSzI4XX/PYHfdTVZrdt03FY94OQlimDUOPxkJ2A/ChPgVx3djtL8+8monGnvCND5v5
         KNqGNBjbltfjxrNZYBgEjPAF82foxElJry/JhEZvYYT5dpfq/IYkbD5m49CDzYbWlrUq
         IDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=TXyhI6ZNw+Pl/TFoBoEd6+kAJZTjqmZS/HvSrvOgA+A=;
        b=RbQ2YcM9xtdSGOXrUoPtc6NHgZ+f7cBsWrHAVwIt2CerC6800SkFGwVNDRW2I643Dx
         owNvzsY7Y0yqq/rC8npmwnRHAnSs8j8WOOm9PGvFryM0nrgrxevTjIo7bMtolIRzVXEw
         XYmM37VrrAmnZwSvvrcgvZAUw6RR3JHfFepvBtm0qUrnTrRrbT9/cabnXW/EmmNrnJMw
         GWwjxZ7RJMI72G+NAJNiw9XCcMwQiLoHM8Yt86Une/STgOZ0YoGVUwNtC1Ulk24rvqZE
         8JGA0VjV626U/ZCRg+F+w6jkFGhlzXVFiDTTviKFRlk0A9uK4VQmDEKZOtGTH4G0aPD1
         g7zw==
X-Gm-Message-State: AOAM530H6e1IXHnjuCdwtVvdPCSt3PWwrqP5fkFQ8kiIXn32ze263AV4
        456/5qpuxf+7xdWSe5OYUrKLU6uofsNnjA==
X-Google-Smtp-Source: ABdhPJwWp7s8EKiynQ0JAxWuWI1Bp624xvZvFfTkhMU03kKAHWOhornq4AiW/Tpi92FRzU5pgTiBng==
X-Received: by 2002:a17:90a:1f45:: with SMTP id y5mr16350571pjy.138.1636708863237;
        Fri, 12 Nov 2021 01:21:03 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d19sm5876922pfl.169.2021.11.12.01.20.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Nov 2021 01:21:02 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Marek <jonathan@marek.ca>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] arch: arm64: have memblocks out of kernel text use section map
Date:   Fri, 12 Nov 2021 17:20:42 +0800
Message-Id: <1636708842-25787-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

By comparing the swapper_pg_dir with k54 and previous versions,we find
that the linear mappings within which the addr is out of kernel text section
will use the smallest pte. It should arise for the sake of rodata_full, which
set all memblock use NO_CONT_MAPPINGS.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 arch/arm64/mm/mmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cfd9deb..14e1bea 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -252,6 +252,8 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 	pmd_clear_fixmap();
 }
 
+static bool crash_mem_map __initdata;
+
 static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
@@ -259,7 +261,15 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 {
 	unsigned long next;
 	pud_t pud = READ_ONCE(*pudp);
+	unsigned long len = end - addr;
+	phys_addr_t kernel_start = __pa_symbol(_stext);
+	phys_addr_t kernel_end = __pa_symbol(__init_begin);
 
+	if (debug_pagealloc_enabled() || crash_mem_map || IS_ENABLED(CONFIG_KFENCE))
+		;
+	else if (phys > kernel_end || phys + len < kernel_start) {
+		flags &= ~(NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+	}
 	/*
 	 * Check for initial section mappings in the pgd/pud.
 	 */
@@ -483,7 +493,6 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
-static bool crash_mem_map __initdata;
 
 static int __init enable_crash_mem_map(char *arg)
 {
-- 
1.9.1


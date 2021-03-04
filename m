Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E477A32BF48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577966AbhCCSBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:01:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1447604AbhCCPEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:04:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F35F64E02;
        Wed,  3 Mar 2021 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614783830;
        bh=1dr+btPYpniJbMjRIotZWMFL1lmdGAXZ0F3sj1DRbOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acVIUdHV0Tsbgga2BOB3BhqjpZiKE3kBXXf+mqnqAMH6u8tI2Pq4rdEqsWbLR9rsi
         lJOgQS2VyT3m8lprGDQ3l9YMzZdCvpaaM0XVQqJS9Xdfas0vewBmxinbc4FoKTZ/9M
         h5H8XKx190w+X2e8wlt5FRiWmbikHpFjs9EvJQfrv9yteStXWQide5+4bDK9tdrqV9
         81BszEb70u7i12YNPHIwbeAo8IbGO0HUk+MYcYGjakCoDk+uH+uEqpKPGUzMV9lrht
         9f+Fh8r238JW4S0CnAbnFV2BE+TjYHaQ7UUEgket4HwCfx3su+AE8tDfNSAQszqAK8
         t1rA1IlAyYnxw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] x86/sgx: Use sgx_free_epc_page() in sgx_reclaim_pages()
Date:   Wed,  3 Mar 2021 17:03:20 +0200
Message-Id: <20210303150323.433207-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303150323.433207-1-jarkko@kernel.org>
References: <20210303150323.433207-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ad-hoc code with a sgx_free_epc_page(), in order to make sure
that all the relevant checks and book keeping is done, while freeing a
borrowed EPC page.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/main.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 52d070fb4c9a..ed99c60024dc 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -305,7 +305,6 @@ static void sgx_reclaim_pages(void)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
-	struct sgx_epc_section *section;
 	struct sgx_encl_page *encl_page;
 	struct sgx_epc_page *epc_page;
 	pgoff_t page_index;
@@ -378,11 +377,7 @@ static void sgx_reclaim_pages(void)
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 
-		section = &sgx_epc_sections[epc_page->section];
-		spin_lock(&section->lock);
-		list_add_tail(&epc_page->list, &section->page_list);
-		section->free_cnt++;
-		spin_unlock(&section->lock);
+		sgx_free_epc_page(epc_page);
 	}
 }
 
-- 
2.30.1


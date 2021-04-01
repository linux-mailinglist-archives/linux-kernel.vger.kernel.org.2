Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CA1350E64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 07:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhDAFVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 01:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhDAFVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 01:21:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EF1661055;
        Thu,  1 Apr 2021 05:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617254478;
        bh=DVhvbkayKQRZoHCJPwVZHRfMdZrxAA8cxJGn4nwa/Jg=;
        h=From:To:Cc:Subject:Date:From;
        b=sWuyqWT9+1oXv9+Y5HpjGz/fSXg4LA7MKtBPoOro6e6HLQVj3JxzNLjPLoBrxqAwX
         sCA1ppqxUYKmMcDbTMJouP9h0p/RcLZTFsUtajufo6MZhZzsR2/bmIgdc/05Wh/0dK
         SxVWobdD8usjOwc+q7UIb4RAoFNk/LoQuCB+pwMu1XJQigbBsrGSiQjT/n+73CA6yG
         zGFf2yeQwlrK9BD1zS9xcIPHvw9neIFdJKFQLiBhFFYWVNjHnMzmCaNajSDAbbPFG7
         6G8pTB2SE8Itu710/guyiiy7Gmms2Yvaobr3aEd/PbqajTSgUJQTAzX+ASUj64kUpe
         xgc+BI5wXVZ6A==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/sgx: Do not update sgx_nr_free_pages in sgx_setup_epc_section()
Date:   Thu,  1 Apr 2021 08:21:13 +0300
Message-Id: <20210401052114.697432-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the sanitization process will make pages available by calling
sgx_free_epc_page(), sgx_setup_epc_section() should not touch to
sgx_nr_free_pages. This will result sgx_nr_free_pages to contain 2x the
number of actual free pages. Simply, remove the statement.

Fixes: 51ab30eb2ad4 ("x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 13a7599ce7d4..7df7048cb1c9 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -657,7 +657,6 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
-	sgx_nr_free_pages += nr_pages;
 	return true;
 }
 
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23A344D57A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhKKLFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:05:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232918AbhKKLFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:05:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C341261177;
        Thu, 11 Nov 2021 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636628572;
        bh=5UUVF4ExqL7pKP10PDVQXSYPopPegnrCP08wJ9W6RSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVuypa3o6b/BV5V4QJKW6wPASH0V7WOM1Akk7Wpm2cyXcz+lbhwh++YxG8ZFs6Gud
         9Dy6mivPOtiE/lul7TMGCvOroVgnMg1GDWgIzYX71lq9uRCC7QsWjUblYdvmvrhyeY
         2XzEO9N78VOtqCpiMOZtDDRRU4iIXTGIc3fuXTKzFI7YdbfO85Wz0dJ8SdGw0aqihk
         FER4cvjdZijeOfRdZD9YiLJ6z68GeCfTotrZtMX2QAwVlZbOvhSqn6Ll2K2MZFbHbV
         xZv4v5cESemrreCVbAsFn4Zyz3oUpsnospT120x5+2cjtxr6jisqDa1SC2GyDcYAE9
         eA0tNY2R9+/BQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] x86/mm: make init_trampoline_kaslr() __init
Date:   Thu, 11 Nov 2021 13:02:38 +0200
Message-Id: <20211111110241.25968-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211111110241.25968-1-rppt@kernel.org>
References: <20211111110241.25968-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

init_trampoline_kaslr() is __meminit although it is only called by __init
function init_trampoline().

Make init_trampoline_kaslr() __init.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/mm/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 557f0fe25dff..d40bb4feeda3 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -138,7 +138,7 @@ void __init kernel_randomize_memory(void)
 	}
 }
 
-void __meminit init_trampoline_kaslr(void)
+void __init init_trampoline_kaslr(void)
 {
 	pud_t *pud_page_tramp, *pud, *pud_tramp;
 	p4d_t *p4d_page_tramp, *p4d, *p4d_tramp;
-- 
2.28.0


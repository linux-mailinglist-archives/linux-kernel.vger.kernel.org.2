Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD83F43B3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhJZOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbhJZOQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:16:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B07C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:14:20 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h193so14274128pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vnLo8nRGURPjjod70p5B9U+vosN1RZ1Olin9TSfC/G0=;
        b=XD0QdEMMe8uqyIEuOVlI7g6g2rBzPQWkXDKACCJddCEfiJ0Kj7UGLVzN8OY3+o+xHx
         MsjjvU0y8VtN0glxsgwHTI7K3lFbmF3ttbcaEqjXbGiEicIP7x49wG6pC39O1ZcnfEfa
         Hveasq7jT3foooXaONc8pG0fQsK2JOmVMovw1MjC05p22eYZE0bkH8KcUWtCK+3omXBT
         SC9jUlX0sl3I6Id80vH7FDJmKRQgetBvcjcCjkWMpmlxANDNMhGefACBzHMrJMjfUiYq
         oNC9gYZCDhsvThyJRrzY57YAJkzpdY/rHxTRAxIOZM5OGc2UtIZDWkU7QBPu2VHxnlCH
         Qxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vnLo8nRGURPjjod70p5B9U+vosN1RZ1Olin9TSfC/G0=;
        b=BJYtGS/nLRHi/MRIYp+3JImewedqXzrfyTvhQiUwDsaZj94tjt+Cnrk1XSDAsmYcy6
         HU0m6HPcyfujVzIJUKmHfqi7/cJbUIyxGAGu4u23FdwabnhiZ2IvWuwM8GV40qwoNShy
         4ZJ9srk92gWNNYf9yrSdfwM7/SEWTxbXQfuarbys2J6UhsU5E+iVC4D5d3nBZvr2R8uL
         T2aybhp3/m0+3O5rBc69+Uo7ojZNBhIhhjBBAt29ETXx3IaZFi433ZGqOPFotlOGC3tp
         wtYgAVrxrW+h9mFCtTL6kXcDW22MdYlgvfGg2B8Ul9h1lt39d2n927pUP2VtXAlcwWzZ
         lCig==
X-Gm-Message-State: AOAM531DNdwkRoR+uy1nXPuKyWBUM8YilqCMu6EJKWh0BifwIwDHpd+k
        LmYCpjLImVdSOUCFfQ8/Jc4TIx8GmOk=
X-Google-Smtp-Source: ABdhPJxul3KEt9CppWWG0OaCgcUcOWZJpkv4GFAe7LEe1HWiMZgqVJzN5R7AhInanrNqhH9e680MFA==
X-Received: by 2002:a63:941a:: with SMTP id m26mr7152379pge.25.1635257659535;
        Tue, 26 Oct 2021 07:14:19 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id on13sm1233152pjb.23.2021.10.26.07.14.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:14:19 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 01/50] x86/entry: Add fence for kernel entry swapgs in paranoid_entry()
Date:   Tue, 26 Oct 2021 22:13:31 +0800
Message-Id: <20211026141420.17138-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Commit 18ec54fdd6d18 ("x86/speculation: Prepare entry code for Spectre
v1 swapgs mitigations") adds FENCE_SWAPGS_{KERNEL|USER}_ENTRY
for conditional swapgs.  And in paranoid_entry(), it uses only
FENCE_SWAPGS_KERNEL_ENTRY for both branches.  It is because the fence
is required for both cases since the CR3 write is conditinal even PTI
is enabled.

But commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in
paranoid entry") switches the code order and changes the branches.
And it misses the needed FENCE_SWAPGS_KERNEL_ENTRY for user gsbase case.

Add it back.

Fixes: Commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in paranoid entry")
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e38a4cf795d9..1f98188e83ef 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -898,6 +898,7 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	rdmsr
 	testl	%edx, %edx
 	jns	.Lparanoid_entry_swapgs
+	FENCE_SWAPGS_KERNEL_ENTRY
 	ret
 
 .Lparanoid_entry_swapgs:
-- 
2.19.1.6.gb485710b


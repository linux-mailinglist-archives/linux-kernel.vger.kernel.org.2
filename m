Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2C242D0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhJNDQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhJNDQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:16:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2FBC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:14:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t11so3167496plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vnLo8nRGURPjjod70p5B9U+vosN1RZ1Olin9TSfC/G0=;
        b=U0QWpWFj/fgRzufewZ1UMTcbZkyOUOQ10JKjlqi9fC4tnRVwtSeZLHL+0kaXegdZ7P
         2Se6blAc/29VYJgXSAoTC4T+xWS70WTImPbXrklHvUcA/dJgMEt4Sx7vth5X+895zrcS
         GydQYAjWG0bhO7cWc8ur6c8HN8UFs8ZGY1CfS1iwzDVrAm30zL7nMyqZtMCD7c+8gIde
         HPt3/Q492CTBBWEy94Z555tIz7de72/TmWSDOgpkXKGUNw9y0aAZy4MpRR3dqMnbnW+W
         YIulCltgh90pmeVDZLdnkScteLjUUn6QM3+xaadCly5dqgfCGPL1G+Yi8Z8A8dZoCBJe
         K3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vnLo8nRGURPjjod70p5B9U+vosN1RZ1Olin9TSfC/G0=;
        b=pvRXJSOiBX/dlH7CQ1dx5SUI50zqzNrGtj1zpTOc1tB3lpSx91uL4UFSM8Xcg4Gbu9
         BQja+UVwFAFY7M+68VYFKU+fdPm8qv44kkaDaCjY8XYL3PwnmhtI5YWhZZj98U7u3oS/
         C5fle9g/V5B0XptbrS2ippFMwvQK/QsDXp/WU6hmLiPKYOHtuYsdbQcbu8+5nwEMecad
         dezrMCekp/qejbN9uBGfiURdtyB+ygeF8HoxwiYgQ1a5ECFzDZ+7cNaPDRllL4+c7tQl
         /OAk3xOHKPI04dV9+9NXHCmj+Rj7/YLr0lClptvVUMXG8++NdCrFtJTp/Aa2akGB6HhC
         CNUw==
X-Gm-Message-State: AOAM530eNcU3nQPi9JUz6p1BXOgIYakO9NTDMN1r/W+1ygkwlnJB5sSx
        qHLHNNh7OxYMXHe/0JMgy3qmPgbUuck=
X-Google-Smtp-Source: ABdhPJzO1qxCa57+UeMEhUOYCBeixhUmWCnE7gQSPj02qJ8RhZNfOg8xue9FIcD+FVGSDVEt+OPbAg==
X-Received: by 2002:a17:90a:c58e:: with SMTP id l14mr18095996pjt.213.1634181275667;
        Wed, 13 Oct 2021 20:14:35 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id c192sm789099pfb.110.2021.10.13.20.14.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:14:35 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 01/49] x86/entry: Add fence for kernel entry swapgs in paranoid_entry()
Date:   Thu, 14 Oct 2021 11:13:24 +0800
Message-Id: <20211014031413.14471-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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


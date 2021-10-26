Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E828D43B44F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhJZOiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbhJZOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:37:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97115C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oa4so11106338pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/VEIBCWf8eZkwgfgrE3MrvMN5GhRK8VB75123ohWZZA=;
        b=JHIidcQTgtvRlKoZnFFQ9pFiNKgWZ1jqztS+TLVf9yvD6DmdLgn/hQTNn4qTjk8v0I
         u/02BwPsNp0+vrm05U2jVHkcpDoryONI8EFxuBRmbuMy4LP5yNE+T/XhTGjf2qhsStjQ
         lap6KjuXb7sjLYMKJKf8ScStAYOXm0IgCuvFbuw6ERsv6UyDc8qgYaRFLkbpIJ95N//D
         qxE8XzaAyp4AOpNRESWuWlcrv+sbcSP/o/lhUpBB/XOUe8EoeqU4nuIn4UP7bswXIRUm
         SSB5+ecttCzx3qoNcvj6sVIU86dNVKiVdpNxTmRcxMr5K/PSa9HwQHi3oMyWPkgYw68n
         tK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VEIBCWf8eZkwgfgrE3MrvMN5GhRK8VB75123ohWZZA=;
        b=dz63V63q95M29+GFCIJQCSItOYj39IVdKtzPAtMN0Ga4LZdWAI31eSatKAj5jPwnnJ
         bWeYpnjfuMhbSyCbOC0oOHscktEva73IvVsQ12bPGuDqv6fzPQUkwKZurRNI940E/dem
         QtfsEVllA/1cP9TzE9R7l8aU8S3Saq7Ispn0ymACRRjm06DbplJHEKHEXCvWutEfc89X
         tJZwxfTql0qJTibExWO291e2Wzt145jsrZ+7NcwH9A1v3z8oVYjr41ZpQ0+nA7A3i9yj
         bUhWiPkHcnPj2kZZs0kIyVZNnjl0qG1XSmfltujjCr8XBc8wZFZi5plWT5xmCwPFFK7U
         Vv5w==
X-Gm-Message-State: AOAM531OG3ImfSNuaOk6DKrQv27j3pKIrJAVfVZoVAoiwQUxsKF4otgu
        WOA4yA5TbjgBW76xj3GeO5wqMBPNRFs=
X-Google-Smtp-Source: ABdhPJyK5LZdrlPq1YY6VIlGq967YbdZ5zBib/EqkZRt7DUl5Y5j9jia34xK4FOGkBVKA9bp1PTB4Q==
X-Received: by 2002:a17:90a:488d:: with SMTP id b13mr22776824pjh.152.1635258934976;
        Tue, 26 Oct 2021 07:35:34 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id q18sm25457485pfj.46.2021.10.26.07.35.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:35:34 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 32/50] x86/entry: Skip CR3 write when the saved CR3 is kernel CR3 in RESTORE_CR3
Date:   Tue, 26 Oct 2021 22:34:18 +0800
Message-Id: <20211026143436.19071-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When the original CR3 is kernel CR3, paranoid_entry() hasn't changed
the CR3, so the CR3 doesn't need to restored when paranoid_exit() in
the this case.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 996b041e92d2..9065c31d2875 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -231,14 +231,11 @@ For 32-bit we have the following conventions - kernel is built with
 .macro RESTORE_CR3 scratch_reg:req save_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 
-	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
-
-	/*
-	 * KERNEL pages can always resume with NOFLUSH as we do
-	 * explicit flushes.
-	 */
+	/* No need to restore when the saved CR3 is kernel CR3. */
 	bt	$PTI_USER_PGTABLE_BIT, \save_reg
-	jnc	.Lnoflush_\@
+	jnc	.Lend_\@
+
+	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
 
 	/*
 	 * Check if there's a pending flush for the user ASID we're
@@ -256,10 +253,6 @@ For 32-bit we have the following conventions - kernel is built with
 	SET_NOFLUSH_BIT \save_reg
 
 .Lwrcr3_\@:
-	/*
-	 * The CR3 write could be avoided when not changing its value,
-	 * but would require a CR3 read *and* a scratch register.
-	 */
 	movq	\save_reg, %cr3
 .Lend_\@:
 .endm
-- 
2.19.1.6.gb485710b


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB644C09C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhKJMDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhKJMDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:03:36 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F391C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m26so2469872pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/VEIBCWf8eZkwgfgrE3MrvMN5GhRK8VB75123ohWZZA=;
        b=D/9xAO2P9sR448Bu17ScY52ajZkr0h8NEsif2AGDKmhTcPArnYyt1J1RuwZdskjSKv
         l6U6lsrrVHf71SJFZmtqI76ywDlDvZTxRJNFKkIPhUyLYLK4HDIiyeys8DTdi7+ou1eY
         I/iJlDfvxYIGN1Uwi6UsSUK0sB/ZV1XEQBdkXT7YqzqcLAuUSOyoubA0t9ILBSgoLAuI
         rsNPPfbfTQKUjfRGOqV2GISthWy1U87f4Cs7arnjlWNm4nNXr7izMXtGiT808LYGbagg
         PW0m1SgQl/9cRlE+LJQfBZpBEC3Ql7doSvwYnPHXU71KkcH8L6QC390s4nh7d3qJQGT7
         Ik+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VEIBCWf8eZkwgfgrE3MrvMN5GhRK8VB75123ohWZZA=;
        b=BjjES2yRtLyNhZZ0fbKOxxAWnIRxEHe/R36jtjsZ34+Jcj2/qaAo8a7UcIjwLb8jPQ
         UQk2wlhbttp6pd4p9atxAd0JBhLgUO9k8Aq+pArveptHu/V1Zr/yLYOcQefCWg5L7KPh
         hU/1cRPDau2o3i2p1bsUdnPQWwnHE9HyeuP5hYkrLkCL9YPwMsDNKjq5XCBgfvIL7PaV
         LWhagRI8d9R9wu5GlA0tjVPv+oLpDAZuQWgzjglCxmU2maCmszi52pYzr3zr44vY/HKQ
         C2qOgdyZJ5VYca+qRlG0+1qsZwj97XnbNJZJ/KPlyyRYyEuYn3skMArr96NsGR6bvoMB
         Gx5A==
X-Gm-Message-State: AOAM530SW0G/q3bf2foxj+hknorF5Hn1DcZAQ1F0aZRVGLghtXF6mIWD
        NP3H4jSCRPMARw3UvsiiJlVeqSPbnFs=
X-Google-Smtp-Source: ABdhPJwyhvbr34Zan1fExHTn61cKizROUZpxovreV4DE5tzNMIz4Gz/5a3XnRLQ+XR4LPgUKqUE1fQ==
X-Received: by 2002:a63:7d04:: with SMTP id y4mr11386992pgc.131.1636545648411;
        Wed, 10 Nov 2021 04:00:48 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id pg13sm5953411pjb.8.2021.11.10.04.00.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:00:47 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 32/50] x86/entry: Skip CR3 write when the saved CR3 is kernel CR3 in RESTORE_CR3
Date:   Wed, 10 Nov 2021 19:57:18 +0800
Message-Id: <20211110115736.3776-33-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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


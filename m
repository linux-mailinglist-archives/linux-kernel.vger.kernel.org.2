Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C717C44C066
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhKJMA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJMA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:00:27 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84729C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:57:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so2831192plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6r1eVU03shX+XyWglyZPq99KC5HgEfz8IXfDj2wGJnQ=;
        b=NcVHxlHKUduiVA+iT56UkF4bI/etR7I6cjS++zG0SBK8OvdyQOoIw6UWT8xN8fGbo7
         9g69txymvBoFY/luej48S2QXS4lUx52AeN8Y8ndCHNVw8erF84hUsLweDiZz1p0Ajdnh
         zE2SSwuLCytP/wKy3Ltj3iX6dUtQTGkUMTThX+PkoNSY3pR70Al9oeIyZ2AaNuBVUkkj
         eTGlyaVJJgOLQ6Q7GjmIzkEQcSmkJqTXyjYq8qb8zEbiEoTXFLwsL1I30UJ6YrZen4aC
         AW6lUobGpGPG5bHAI1R20XgJEBEDH/T8JHh29AbF2PQksxywmUBir16b3I9SBXp9tbt1
         8PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6r1eVU03shX+XyWglyZPq99KC5HgEfz8IXfDj2wGJnQ=;
        b=eBAnMWpSlW4Nsk7HSbilNaJtdrXqITp7rmtnpkK6SH0mxT1geWZGRt571UMAN5kIWx
         lh0Tm+v5oIjIaspdYqyVflMT97oY6eTe0BiI0Ira1nOCmKhT2LnDHP0Ogr0hKY40TpO+
         c4gZNVULyDZ0UsUv6mNZDN69+C/EdtcUmId9/TSB3vj/WdIAr2WHuc0++Ls1LtoqukZQ
         JVHP2yGVMPoFKsA6aqskJF0D15Dbc/hbw8I+JyYtn4ICBC1cbqN4CeJt7OoNRuBDxZEs
         ve+5RWboTE9bucAgziulVq3GZlRELFfh1D+IE4KYMaYnRndPvkEjmGFVsG3vaEHirPbx
         F9Eg==
X-Gm-Message-State: AOAM5339RjZ6C0q2M8EMT+EAxU7OBvQwKUvW1QqmDxGy8699HPuoffL7
        kQ0QKTDOStw0jYfFMkALb4C49K3tJig=
X-Google-Smtp-Source: ABdhPJzg777WEUHQvJBHxF/yXs8BL0+LLtEli51n3bxUD1KKgKQNUbpx6ntx3JHSroFB2m3EdJmFrg==
X-Received: by 2002:a17:90a:657:: with SMTP id q23mr16175601pje.21.1636545459930;
        Wed, 10 Nov 2021 03:57:39 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id 145sm22079212pfx.87.2021.11.10.03.57.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:57:39 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 02/50] x86/entry: Use the correct fence macro after swapgs in kernel CR3
Date:   Wed, 10 Nov 2021 19:56:48 +0800
Message-Id: <20211110115736.3776-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The commit c75890700455 ("x86/entry/64: Remove unneeded kernel CR3
switching") removes a CR3 write in the faulting path of load_gs_index.

But the path's FENCE_SWAPGS_USER_ENTRY has no fence operation if PTI
is enabled.  Rahter, it depends on the CR3 write of SWITCH_TO_KERNEL_CR3.
So the path should use FENCE_SWAPGS_KERNEL_ENTRY if SWITCH_TO_KERNEL_CR3
is removed.

Fixes: c75890700455 ("x86/entry/64: Remove unneeded kernel CR3 switching")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 14ffe12807ba..6189a0dc83ab 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -993,11 +993,6 @@ SYM_CODE_START_LOCAL(error_entry)
 	pushq	%r12
 	ret
 
-.Lerror_entry_done_lfence:
-	FENCE_SWAPGS_KERNEL_ENTRY
-.Lerror_entry_done:
-	ret
-
 	/*
 	 * There are two places in the kernel that can potentially fault with
 	 * usergs. Handle them here.  B stepping K8s sometimes report a
@@ -1020,8 +1015,15 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
 	SWAPGS
-	FENCE_SWAPGS_USER_ENTRY
-	jmp .Lerror_entry_done
+
+	/*
+	 * The above code has no serializing instruction.  So do an lfence
+	 * to prevent GS speculation, regardless of whether it is kernel
+	 * gsbase or user gsbase.
+	 */
+.Lerror_entry_done_lfence:
+	FENCE_SWAPGS_KERNEL_ENTRY
+	ret
 
 .Lbstep_iret:
 	/* Fix truncated RIP */
-- 
2.19.1.6.gb485710b


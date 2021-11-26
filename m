Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA845EB70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377216AbhKZK3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376839AbhKZK0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:26:48 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AE2C0613F7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:36 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id o4so8449716pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WphTuTVslZby+oDEm50XCSesh2uHM5bzyfp9NXbgOWI=;
        b=k0X6V4metHesMtIJSF8o+z2oobK3Q8suSwWHGWR0iaDaQhFiMAGThtshq+9iHc/T9v
         eiB8O38T/07bEzSFsX5s9FI8fEQqu2ZDWsjJ9PicJU1COIfVI8o3tpINx1GZDUEmB4nU
         eaVZ7LGEcKRLzC10cPWDIyfADjVLLhsniYJgv06isyUZdoL3zmoLdWUIxXsilVgPxCr/
         X2TOlHGGumweA4x4QnoOkWE0dGsN7KPRXcPePkm750f9VCQMXoM2FxOCjkaTVg/MjcVj
         cHaN8zgzfILo3WYTuQtDpbEcd+fU7UjRDHawK/y2rFuesMya62bZeXm9iiCmprlwaohd
         h+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WphTuTVslZby+oDEm50XCSesh2uHM5bzyfp9NXbgOWI=;
        b=a4viWz8iiBVwAx4fIWCrIUC/SIqh7EDtDPCkt9F5qJJNrvUaBPRJ3sqxhO2I7kDahC
         uMAjcIkjnaIgytUckm+rxKP+I1I2x6oi7KYC1qzspAQ0h50nmJsI63x4aMO1CudY23gP
         yzYj/K3C+3VPKWt+lRkrATS47Xk1P0BAzgck4UOgDN90f46D9trHs31nW+9kBjLkHBo+
         1Z3h3xpZU9NPui4np41coqi5i06itsvPJ7KCBwOcXyqKLpOGO/hfowVEPYaXkpbfGSUH
         Z+DMjwEtaZE0gokoa5APR82yQNgTdHxADPVqnuSVlPmmiEDh7Ua0IqkrSaqpGOPrci5s
         uXZQ==
X-Gm-Message-State: AOAM531X/piyPghvDPpeQv5YITMTjzFTo3byVDOVcz1GYPyVW3wtATNT
        lfJwsfdhRnkRQtBHWyDXbDc+rhjZ6xo=
X-Google-Smtp-Source: ABdhPJwoVWVLcfzgaUEczHZbGpGFB0hvuuLvKmyVFnc3t1mKep89/lgZIso2Af7CuhkjyctjDFHoRA==
X-Received: by 2002:a63:844a:: with SMTP id k71mr20750151pgd.101.1637921676119;
        Fri, 26 Nov 2021 02:14:36 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id z15sm6210770pfc.2.2021.11.26.02.14.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:14:35 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 25/49] x86/entry: Convert SWAPGS to swapgs in entry_SYSENTER_compat()
Date:   Fri, 26 Nov 2021 18:11:45 +0800
Message-Id: <20211126101209.8613-26-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

XENPV has its own entry point for SYSENTER, it doesn't use
entry_SYSENTER_compat.  So the pv-awared SWAPGS can be changed to
swapgs.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64_compat.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index a4fcea0cab14..72e017c3941f 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -49,7 +49,7 @@
 SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
 	/* Interrupts are off on entry. */
-	SWAPGS
+	swapgs
 
 	pushq	%rax
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-- 
2.19.1.6.gb485710b


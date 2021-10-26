Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E80343B44D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhJZOhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbhJZOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:37:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF5C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so10477162plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0H+JeGyJkw7+XsD6B9OKL2nsE7tddxNDSdsOksbRkDw=;
        b=iYbE6NM2VfivMGfnm0SIojXzDcCB9R4Gx8q7YZSnHsKyyyY0LfmUcMJWYYZjdt9rV8
         nzpOmbqFbpP5mZlsAY62HTh0TEZ5vA8pBs3Vw2TgkGqU9Vg6x9w1Y2Cl7NsMxej1EnZk
         Tdso14s1bUbd5xlz+fqP+S9gzW+O36yK2F10TEoYTj16cwycAAbKD1VXgyIoFTRoVjAd
         WSQn4B2WYNKQf05oenFhwfiPUAfFcpIun2K9oFXmm2DkhEOzJdL2126S9PJsTbQ+dSl+
         fGrZHcJy5QqxJvR2luSQqVk3QcJmAyG1Y8TF+llwWcVU+dydjZjpAjFmpgLQKSXrlu4i
         fafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0H+JeGyJkw7+XsD6B9OKL2nsE7tddxNDSdsOksbRkDw=;
        b=RV4IkUzEocEVJ62b/OnV1mVLORxSrhS2bKdXLVucV6BrfqSduZ3XBqFFwN4a9bZGMj
         HXzuxxP6mcnAc1DcvCIqw98DrSbKTFEuJhDdwyABIqUekQLr0GDDAPTouzgCfROYdeQe
         JwinKkYVPEOPDM8Tka6GSS9tVMbcWmsUJdna5KYhwCHgItxtWLcWzkFcd7iXlS0ldfoF
         wkGxah6XJq8J6QZz8hXSvf3MxWJrS/DeLk5t0LZC5QrITsM+xu3HEDLfnFMmWIQ1aYdL
         9mgTFGhbgcK6t9a3yl3ntaT8OKTkc8z/Tt5Pd0vpn+GQnotJ4rDcopI9Wbq0ewlSiIY6
         mfxQ==
X-Gm-Message-State: AOAM533exN1nNZMHPxi5rWwg3wvMuhoj2XvIS9S1k569TUAA8N0Dkn0z
        9h7zyIrrZAynRO1Fl29hUr2KCiH2/zA=
X-Google-Smtp-Source: ABdhPJzKBcB65ckjU5QVeM0TLyd+lmCe9qg2F5ldEq7wB4Atjl8lsTTo1fZbfwHOBLJaIXYkfETHng==
X-Received: by 2002:a17:90b:4c88:: with SMTP id my8mr28875183pjb.49.1635258929462;
        Tue, 26 Oct 2021 07:35:29 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id n9sm2580522pjk.3.2021.10.26.07.35.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:35:29 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 31/50] x86/entry: Add the C version ist_switch_to_kernel_cr3()
Date:   Tue, 26 Oct 2021 22:34:17 +0800
Message-Id: <20211026143436.19071-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It switches the CR3 to kernel CR3 and returns the original CR3, and
the caller should save the return value.

It is the C version of SAVE_AND_SWITCH_TO_KERNEL_CR3.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index a8e59ae41794..1d6ed444fee0 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -35,8 +35,23 @@ static __always_inline void switch_to_kernel_cr3(void)
 	if (static_cpu_has(X86_FEATURE_PTI))
 		pti_switch_to_kernel_cr3(__native_read_cr3());
 }
+
+static __always_inline unsigned long ist_switch_to_kernel_cr3(void)
+{
+	unsigned long cr3 = 0;
+
+	if (static_cpu_has(X86_FEATURE_PTI)) {
+		cr3 = __native_read_cr3();
+
+		if (cr3 & PTI_USER_PGTABLE_MASK)
+			pti_switch_to_kernel_cr3(cr3);
+	}
+
+	return cr3;
+}
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
+static __always_inline unsigned long ist_switch_to_kernel_cr3(void) { return 0; }
 #endif
 
 /*
-- 
2.19.1.6.gb485710b


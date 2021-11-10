Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E3C44C06E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhKJMBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhKJMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:01:13 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F42FC06127A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:26 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id g28so2055322pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rggk4Wz28/tanhWvVYfUkI6dZy0E3llR541aTdNtC5E=;
        b=VwmKYK7xfRxU+1574c4cIjXd4PdN++MlHkoKej35h9Vkx7m3czMZ8/aR6vhst2VZTK
         Qq1sbIJMWBQPlp3JAbUsVxr/FzcEQKckdMO4TxS7K+1J+2NB3nRB04hs/cezSY6pNeG3
         3cwJU4wEMzKDooX/bzbKVmTvxMgDzufnvxzcJPLPHpEr0kHzEHuhlu3or0r/T1liipDm
         eAPwX5OTtYnyFYA40d0tb3i8FTd+CuzIjDLesPrgmZwTqYgZCgWWt7EWVk+REpqB5I1I
         GVg66Jl19QdW3McJ0uqMJbU4IcWXy8G8trCVXR/vGF5urn4U+PRVk95j1dcGjEfiQYSD
         54TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rggk4Wz28/tanhWvVYfUkI6dZy0E3llR541aTdNtC5E=;
        b=N9S59fmxe9ZoG5imi7ULUM7Wmjo6XVQWlOOllMHRecQ6Z0wikXlM0XAfvbnnIz65Od
         Y+FYD7BH6VgrCPXa6cUIU/LjHWCLSwpuVz7vDLGbPtW290x8bcg2+GaFNam3q/LchglN
         OawAp4FPkLd/UOrkr5a85FnFxeCylaAOj6f4QH2bc/z3ttesH8j73LI9VohyOIsJD0ND
         d+3pda2jqMVGPag/a9/jmlv3Eo0N9JS3E2RoHknyNUWRL8s7OHv8oz8JYDCkUIxUJzas
         f7OIyqw0KyZ4TIg0mZJzzp0B2KtIunC2ZJCehzvW+OZ1CZ2ipcPspTZRBwp5g73E5t8l
         LLjQ==
X-Gm-Message-State: AOAM533acHfbkDYVpM0MzCO1Sgc1SQsQTE3aGrxBVy1Cfi0sulGfI0c5
        6Sb3V6YvgrVut5kyMBgoXDhXlyWwxm4=
X-Google-Smtp-Source: ABdhPJxbI0ueaEJxer8IUktEMZmzztN71btfB617MI+oSHcpYaI0mkkfr2xT8WEfxzgPA5UEEkdP4Q==
X-Received: by 2002:a62:16c7:0:b0:49f:a6cc:c77d with SMTP id 190-20020a6216c7000000b0049fa6ccc77dmr15625640pfw.23.1636545505616;
        Wed, 10 Nov 2021 03:58:25 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id l11sm24254717pfu.129.2021.11.10.03.58.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:58:25 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V5 09/50] x86: Remove unused kernel_to_user_p4dp() and user_to_kernel_p4dp()
Date:   Wed, 10 Nov 2021 19:56:55 +0800
Message-Id: <20211110115736.3776-10-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

kernel_to_user_p4dp() and user_to_kernel_p4dp() have no caller and can
be removed.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/pgtable.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..65542106464b 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1200,16 +1200,6 @@ static inline pgd_t *user_to_kernel_pgdp(pgd_t *pgdp)
 {
 	return ptr_clear_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
 }
-
-static inline p4d_t *kernel_to_user_p4dp(p4d_t *p4dp)
-{
-	return ptr_set_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
-{
-	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
-}
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
 /*
-- 
2.19.1.6.gb485710b


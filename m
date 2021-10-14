Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616F042D0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJNDgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhJNDgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:36:50 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A910C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:34:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n11so3210047plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rggk4Wz28/tanhWvVYfUkI6dZy0E3llR541aTdNtC5E=;
        b=BvN3CHyqeVyegTdIBSTZFh0/lFf3pgqbgCAP4r3z6O56nzq3GairYC1aRNSqF6JovU
         U5+VzAnBHnsoK0jPAGaepG9r29NInmi0YlqQ1YLsqnnwdF77qOzm141NDKiXIdKk6XDK
         CBUUBjW8TRfy9ifHfXLBLu+nlYsfBXFYVZ7tZiGBh68WqZKvetVhFwMso5z0JMkFA7TH
         rgqAW0oUugi0jl/AklgvD9edUVagGAaFkUL7up08QU4bZtNRzkwapG5kfPAXaAqfF3+s
         JOJchd5st/I7yYTAAowhVUYo3xpva9BqHmpM3aQyvQUKpzeBxbXZ06uiUsaxJ9Qdffga
         aDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rggk4Wz28/tanhWvVYfUkI6dZy0E3llR541aTdNtC5E=;
        b=JMc5J2l8FVTdb4wUK3Yx07A2Q/j9vtdKh4BNe0CBNXM4HzzYGd+OwNmhBqBz9RM2jf
         uQA3OThtGktFRAyWY/ACTaWj2l3UTaWjE/brIb7fuiMXq38Uj0tzVTV+JlfM5YJ8CXC8
         P4HajEL22qnafDttQN4bblz0OEkX1zaRS+YSOg6L5cPORb3oR6j8jzWey0nzYodjAv4T
         CMwfyihLZ+xT0V6Eutwh3fT3NCQq7zW4bunkdkw3lW49CuTkCo+rzZ5wv9sQ6Wo/pqM3
         B0cUvaM44ScxB2orf3OYixDcz4dJZ7wUwE3HhXHheTGP97AA9N+cJwjlzBrN4zTzoQDA
         WyXg==
X-Gm-Message-State: AOAM530YDOlhBY5qzBdxluiqE36J/vfE+IaQZlMy6n7CiVplVxEJyVpJ
        NT5yaSMkS4i57zBKZHylTIhm8jRrJqY=
X-Google-Smtp-Source: ABdhPJzf6GfNN0LOEp6iqkLCmkAE2hFZ2TCq5P98xb1+dcLn6HSjcxTEVAgKySQ/se6oRAMqc4tUYw==
X-Received: by 2002:a17:90a:bd08:: with SMTP id y8mr3557444pjr.123.1634182485898;
        Wed, 13 Oct 2021 20:34:45 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id u9sm832123pfk.82.2021.10.13.20.34.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:34:45 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH V3 09/49] x86: Remove unused kernel_to_user_p4dp() and user_to_kernel_p4dp()
Date:   Thu, 14 Oct 2021 11:33:32 +0800
Message-Id: <20211014033414.16321-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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


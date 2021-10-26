Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAAD43B3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhJZOYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbhJZOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:24:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3021AC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:22:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s136so14299980pgs.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rggk4Wz28/tanhWvVYfUkI6dZy0E3llR541aTdNtC5E=;
        b=AV8vvC5bm3acvy8vBmCs3y6hXVTHSJubLJbmUCOnC7UbN0rziLdO2BUN84R9if/y9m
         dyHwPgCV47OOGZQk1B7jKzI9sz/nMDCH1ifXTjjJR8wmFHJCaZWJWswa5E6v9gvVYusX
         IkrQsFucQTzXRu2Q70Y/DEZdg3VG6jJG18xMI7VVVrrDMPqsmbUXDVM+9EbKVq6hcN/G
         wUtGPAQxO5wUhxuRSFsagza5tG44IDycUBJ/DgOjJI20qU6bPjZJ/HYKeZFem+SQBwlf
         5fYTBd1w6Vw4u9eiPRR77h5AU4y+p0bwbEdnloEgg/2EyfcnzNUriEQxLv3iWRedIG1U
         Ymlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rggk4Wz28/tanhWvVYfUkI6dZy0E3llR541aTdNtC5E=;
        b=gFSk+qTg2k/WdV9ZGoAgM4wAzypTQyJB67K6DAEN2NJKAoLSwjqzUSW84U4IgXcyNh
         OGUnP45CwN0RLqbBH5QitzncXKSnPzpDB8Efzy9S+TbrMeJovdQAD+0FBGEN2zLUkNI/
         EI52wajxMh6IKT7ApX40COj5EdF1XCSgA19Rq1tMnXY7RMgzSjXAY8+6wOgks6bktf8x
         qPTAfU0ZjvHpaLilSSI8dlkfvxI56G7cH7oP6gPrzi4zBNNRDuxp2PIRygQwwyaYMQZF
         YAE7TjBFtSntzTNcT7d+eM+J6wCmMrkOs1w6uEviUnP6RDEUGkFTyZM8k9PlDNzCHmVB
         bZWQ==
X-Gm-Message-State: AOAM533AhM/+9LMUpl2b9nq2dPBQCF4RC9z4c6A2HX02GTHjo0KKZf7K
        qEuNfy3JYd8PDqnbqpD2h0ldGg/vVR0=
X-Google-Smtp-Source: ABdhPJx0ixJk40aLnmJi+LUq82xT7l9NqIv4H38gMXk/g9Nq+s2uX8eJCcC8/zi4ExZSIUCGGqGilQ==
X-Received: by 2002:a63:1d53:: with SMTP id d19mr18864969pgm.85.1635258125522;
        Tue, 26 Oct 2021 07:22:05 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id f7sm12699661pfv.152.2021.10.26.07.22.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:22:05 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V4 09/50] x86: Remove unused kernel_to_user_p4dp() and user_to_kernel_p4dp()
Date:   Tue, 26 Oct 2021 22:20:17 +0800
Message-Id: <20211026142058.17702-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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


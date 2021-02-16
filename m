Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1F31CC94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBPPEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhBPPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:04:36 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58650C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 07:03:56 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z190so3706084qka.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ay8uwB0CTxM9fLlpwvadwe5o1xh2kfirYugdARh6qzo=;
        b=k7EqMg9kJLL8nPXc1g1KYll31mwbGJqR7byNIl86kDtjVabbkoZ7qaxEpL8T2Qi0js
         aBg+YXVaFEAV8qfY0kQ9bW8iILxOa1qcgm8kDV6aj1yQgs+IbNNcjwmlwUCBMu6psJZw
         DyRx+dAideXVRR/cyE/z606e+HmEu2WpuO5pbKeaqchwN3QaU+7kICmcJRPCEfOgLj+X
         UNF4Kv+OgR9qVixgnMdDa+Mu4pH8IN9+32jHuuPNKZD3FOqy2EQ5jj4qL4nv8f0ia7Og
         GNxcF27O/P6g9AAwfjAAvuOz+PG6RpD/ydI4PIpSPjAVUYVbbILns1LltVdl6e+dmS6R
         EtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ay8uwB0CTxM9fLlpwvadwe5o1xh2kfirYugdARh6qzo=;
        b=GlEHxDJjEsnLSb7r3SKhfDujjt1gONBtBTV4FyPFyNdYTEnpfWnz3LY9PTpqxiBRSP
         IkQizJ1RDhzEobpZIJS12D4dcWr1PwxkXnPhJB9cHpmgqa9eZFZj/6hNO6BcJ8FSl6ab
         SYTio52wkY0RwnZ7mJGH0h+IxNcUExcYpGoFW6O6AloO/l3Bya/k4z0n93zP/20jcbm9
         c8ik49L6x3DpnJCYS/lEMJqM0tNvLnJ+B7cj7tnxdNauSU78aLjanJq2A3myIxGzJ6UW
         i4GEZGIBetZWVS1sxhYV4SnMaguVXl5oQnMo9un/6a63dd0mbMLTC20sE1Zh2JU+XETR
         wn/Q==
X-Gm-Message-State: AOAM5339rjchGVFRxZuKFqDC918DojnWa5wegNIZU5KDllDYs3RODRoM
        SlXHPRnC0Wig7rqn85HxDmbNWQ==
X-Google-Smtp-Source: ABdhPJwW7utT/hOP1SW7omxfaCEy7a+KeblzASdzbL2doa5YFxaGaz/wCRpe30wAuw1/8Zizt98i4g==
X-Received: by 2002:a05:620a:145:: with SMTP id e5mr19950557qkn.293.1613487835630;
        Tue, 16 Feb 2021 07:03:55 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id t19sm14974271qke.109.2021.02.16.07.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 07:03:54 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        jmorris@namei.org, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        rppt@kernel.org, logang@deltatee.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, linux-mm@kvack.org
Subject: [PATCH v3 1/1] arm64: mm: correct the inside linear map range during hotplug check
Date:   Tue, 16 Feb 2021 10:03:51 -0500
Message-Id: <20210216150351.129018-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210216150351.129018-1-pasha.tatashin@soleen.com>
References: <20210216150351.129018-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
linear map range is not checked correctly.

The start physical address that linear map covers can be actually at the
end of the range because of randomization. Check that and if so reduce it
to 0.

This can be verified on QEMU with setting kaslr-seed to ~0ul:

memstart_offset_seed = 0xffff
START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
END:   __pa(PAGE_END - 1) =  1000bfffffff

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")
Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 arch/arm64/mm/mmu.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ef7698c4e2f0..0d9c115e427f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1447,6 +1447,22 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 struct range arch_get_mappable_range(void)
 {
 	struct range mhp_range;
+	u64 start_linear_pa = __pa(_PAGE_OFFSET(vabits_actual));
+	u64 end_linear_pa = __pa(PAGE_END - 1);
+
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
+		/*
+		 * Check for a wrap, it is possible because of randomized linear
+		 * mapping the start physical address is actually bigger than
+		 * the end physical address. In this case set start to zero
+		 * because [0, end_linear_pa] range must still be able to cover
+		 * all addressable physical addresses.
+		 */
+		if (start_linear_pa > end_linear_pa)
+			start_linear_pa = 0;
+	}
+
+	WARN_ON(start_linear_pa > end_linear_pa);
 
 	/*
 	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
@@ -1454,8 +1470,9 @@ struct range arch_get_mappable_range(void)
 	 * range which can be mapped inside this linear mapping range, must
 	 * also be derived from its end points.
 	 */
-	mhp_range.start = __pa(_PAGE_OFFSET(vabits_actual));
-	mhp_range.end =  __pa(PAGE_END - 1);
+	mhp_range.start = start_linear_pa;
+	mhp_range.end =  end_linear_pa;
+
 	return mhp_range;
 }
 
-- 
2.25.1


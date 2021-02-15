Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3535431C26A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhBOTX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhBOTXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:23:21 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E925C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:22:41 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 81so7382901qkf.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jQ/sRmVJLQf6vZhL8n+vvwrkXkH2FJ5o+f5Rn4ud6SM=;
        b=KnI7VDWwFDBXDNaQ/PgxE3dGe4hVu2B1QGjEVaOCQyYDQO/6aaU26Zi0D5LHshGxqk
         p2BD42e+v3UB3x0GFRdBrRfraXuk1Bbl2rWEVJ9UowYK8KBaQOKllTCcK0zZZFpMKmHC
         9h5Ct9kF2s73QIW9UcMt8z1ArHi6VOmL5IJ/1FdRrqf+raowzM643IRtaMUeV1Z48hPy
         bOF6i+xj1+4QlsRLrbtXiY3CzLqD5kPGtNcutvvyGOoHMmGaYD9c5RY1MKIUTXAPh1Lx
         TSa06GUlsPPDhZ7ASD5fupqGDOapQbB/2H/rWGV+yK6P+O42psyarwJGAuT5vRUbN3dO
         YO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQ/sRmVJLQf6vZhL8n+vvwrkXkH2FJ5o+f5Rn4ud6SM=;
        b=Y0pbNkRJp02GAcHAzvdnr9CpHKQ0pngo9Bl08cI0ZNUQzvF+UgXx52UaOHaXY/YQGJ
         DTHkFQ6RsSpXSBumjhPtIQq9oW1NDGx2WhkGEQKXpg0Cd5y+nNcDkKW/w+dqW+dHPBRM
         6glnZ8/IGbENCMuTcfzPCJePSuIcMWKx5QGVPyOKDKMITQfXqScSPINo1/ek3WRzsOHA
         SdfCG1bWNYh4cueTXWNcPby0xVss+5uY5T/wJVn2rf2fzVuaZbevFDLnRTDIq0vh5Qsb
         2GBiMDKDMVnFb6jaAvy9eSonxmaRVpe3RWgGqtefawmwK6Y2rtSw0YlMgodxycgd7M8c
         NnQw==
X-Gm-Message-State: AOAM530fEKmNOgoTWIJfW5QrodVBS8zsTgUnDsav9sW/+SuXrlDkl/sq
        J3Spc2Uzq2DEBlEQq6TUva70dg==
X-Google-Smtp-Source: ABdhPJzZRJRjqasuMeS1hejv+g7Zzm/rLY4SFGdLLz4dzY/2fE1iICmzvOZ9haQyadjzj2HTShxJoQ==
X-Received: by 2002:a37:6358:: with SMTP id x85mr3630382qkb.70.1613416960788;
        Mon, 15 Feb 2021 11:22:40 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i20sm11631668qtv.73.2021.02.15.11.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:22:40 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        jmorris@namei.org, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        rppt@kernel.org, logang@deltatee.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] arm64: mm: correct the inside linear map boundaries during hotplug check
Date:   Mon, 15 Feb 2021 14:22:37 -0500
Message-Id: <20210215192237.362706-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215192237.362706-1-pasha.tatashin@soleen.com>
References: <20210215192237.362706-1-pasha.tatashin@soleen.com>
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
 arch/arm64/mm/mmu.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ae0c3d023824..cc16443ea67f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1444,14 +1444,30 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 
 static bool inside_linear_region(u64 start, u64 size)
 {
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
+
 	/*
 	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
 	 * accommodating both its ends but excluding PAGE_END. Max physical
 	 * range which can be mapped inside this linear mapping range, must
 	 * also be derived from its end points.
 	 */
-	return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
-	       (start + size - 1) <= __pa(PAGE_END - 1);
+	return start >= start_linear_pa && (start + size - 1) <= end_linear_pa;
 }
 
 int arch_add_memory(int nid, u64 start, u64 size,
-- 
2.25.1


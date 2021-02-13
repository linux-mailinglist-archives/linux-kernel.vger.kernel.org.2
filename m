Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D540831A97A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhBMBYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhBMBX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:23:59 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CA6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:23:19 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id r77so1423221qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NEklPruRwHnzdB6BiLjyxJgAELcX7pwjnZyGp7KbdM8=;
        b=KkoSsN4QzI935NbGZf/zZOfNBQn/mXT/6eQ99NSHnNWydOpLe7Odb9OQScSdxH2Ta7
         ouKi3esRtSy30M4iHh/c9dMdwz69ar9oaYdruLllzvOssAzoT7kuQuefj/DcfTqzvvYF
         pa+7Z6Nd5vdDI7RGLRd5ddYThJqGsaWuu0KHq2gqbPByeTjicXkqpThIPeHvlahpp7RE
         bxkksOtEKwYKcl42jiCfXEH4OAzjUBLzLIdCnMRFWd5B9RiABBpcUiU9ERwNrGYVSkFM
         KWBgYshwsvH2E9ecjRsBeDbvqNw+91isL4Ik33fkMAlM9c/a7LnAfEsSIWryakMsW7tV
         iWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NEklPruRwHnzdB6BiLjyxJgAELcX7pwjnZyGp7KbdM8=;
        b=Wb3TY7eP82HGmsgUgaTGYPSZbTaAd8nGPbpXmM0jgRX2DMYBZkrSVUkXD/CyWeX/uT
         2LefunWgNzGBasr2kjgAu8EiK/l0sjhJxei70F0mSFn8O9kHuHKKxKwXACpXOgldwKza
         VkMrkcpGFF9j3/6n7hcI2bHOLVSwzm47dwUzDDtOCJ+IqHF98sLku+fYzXo3LNVr5Q81
         9k+Ahktg3Ec+O/K4d0EJaF7FYr7K0t/cf/TQZCN10ejkcOdcCFjft8BMg+FyyPNBn9ZC
         49xYvCdrpSIufOIJqn5y71hwRuFBE0Wk2EWVsMVOz7BDBG2hye+QOEmN3nPbdSlt6qwK
         sH0w==
X-Gm-Message-State: AOAM530cXRtJcO3ryeI/QTIN+R8B4G81Wo49a6q48/aAEUT4ftvK9te+
        iJ7Em7TJbYZRp3IejU+EUmwwGg==
X-Google-Smtp-Source: ABdhPJyUj/byycWSZvEKqv1kcYlwMXA854ADSxDmK8Ojmk5DFLenn+sXu4Exhn9FyK09WvXJ9tgTXg==
X-Received: by 2002:a05:620a:48c:: with SMTP id 12mr5324955qkr.290.1613179398441;
        Fri, 12 Feb 2021 17:23:18 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id k187sm7477484qkc.74.2021.02.12.17.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 17:23:17 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        jmorris@namei.org, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        rppt@kernel.org, logang@deltatee.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: correct the start of physical address in linear map
Date:   Fri, 12 Feb 2021 20:23:16 -0500
Message-Id: <20210213012316.1525419-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
linear map range is not checked correctly.

The start physical address that linear map covers can be actually at the
end of the range because of randmomization. Check that and if so reduce it
to 0.

This can be verified on QEMU with setting kaslr-seed to ~0ul:

memstart_offset_seed = 0xffff
START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
END:   __pa(PAGE_END - 1) =  1000bfffffff

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")
---
 arch/arm64/mm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ae0c3d023824..6057ecaea897 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1444,14 +1444,25 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 
 static bool inside_linear_region(u64 start, u64 size)
 {
+	u64 start_linear_pa = __pa(_PAGE_OFFSET(vabits_actual));
+	u64 end_linear_pa = __pa(PAGE_END - 1);
+
+	/*
+	 * Check for a wrap, it is possible because of randomized linear mapping
+	 * the start physical address is actually bigger than the end physical
+	 * address. In this case set start to zero because [0, end_linear_pa]
+	 * range must still be able to cover all addressable physical addresses.
+	 */
+	if (start_linear_pa > end_linear_pa)
+		start_linear_pa = 0;
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


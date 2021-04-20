Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94E13651D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 07:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhDTFfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 01:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhDTFfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 01:35:06 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31D1C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 22:34:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m12so5112707pgr.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 22:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=187MCoIPXpaJH9wXIfv1D4RfPEKy9wfY5kI0RoKayqY=;
        b=kKH73qBqCs17YlrGPWGz+DvfO4xUHi/6tF1OZQVuEg9Nkv18uH9xahcRfT/GfYNdEp
         fEuT9kZdMSfKdqTla+VYmuF5QB5XSOwZO7ZQ3O2JddZK8qDTqDJ+EdDje6p9w7T4Nlpw
         vW44SYFyi6gLDMHvnjn3igzYF/IdjA6YdFQoIBYFuS//iI6FLKAP86lJ9tzTSr1dRFjR
         BUByyiWp1KndQITXTNphxZ48ZZIZgH+Fh0FS1n5LITxN3KdCxdJkgHEWWPugWskWwOID
         g9oZriZHHX8RDVoMg5wFa5QQC2lgvAzwl2HfwhJlfW35UIcvDkPYjO1M3CUYcU3ggOOY
         m2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=187MCoIPXpaJH9wXIfv1D4RfPEKy9wfY5kI0RoKayqY=;
        b=Qqnr0Qjwb3Ino1X0CO8w1MGh4akqw4TeoE8UWAMdi5vJSSTE8b5Jo1nGt9Oy9XehtJ
         Q2wMLhy5Gaw/HCxua4yjl8l6ECkcUmgzLdbr2PWsP23QrQ/Iwj/S+NYfBxSPeVxQn3uJ
         gMayfFNogzkpbgORxmseWQylXI5lSlhINiJDkfIFZ0TIJyJ1dITnFhbYBClAlumoUdA1
         +vT17Y0hN9ddq2DCZIKhrx6dt62ofp5vp0PJ+rT55BDYEK3vUsRhLiIF5eKmuO08MbLY
         LSHUY1OFI/vWRU73jbYNAVy9jJ8f8KxBzENmEZmfiOTzLZB26vwqdgz9pxnjpoJxHlms
         KCGQ==
X-Gm-Message-State: AOAM533rULUyyObUuDoHsGWmZCradnW6N8gYD1PJ/VHz3EfdAhSscF1g
        bxMMTUpRt1ERQ4K1kHL/uoSQRlvS06t5Sg==
X-Google-Smtp-Source: ABdhPJw6+iHDkrfLgS9WIhXS11uyH/9iUXZ7DCEnmyeRf/nfUYDIeR1fEIzJ8vYHN0uPGLDIrHBYEg==
X-Received: by 2002:a65:43c9:: with SMTP id n9mr15139505pgp.19.1618896875061;
        Mon, 19 Apr 2021 22:34:35 -0700 (PDT)
Received: from localhost ([222.112.70.84])
        by smtp.gmail.com with ESMTPSA id f65sm1130035pjk.2.2021.04.19.22.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 22:34:34 -0700 (PDT)
From:   Cao jin <jojing64@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        Cao jin <jojing64@gmail.com>
Subject: [PATCH] x86/mm: Fix copy&paste error in comments
Date:   Tue, 20 Apr 2021 13:34:32 +0800
Message-Id: <20210420053432.4842-1-jojing64@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct page mapping in bottom-up way will allocate memory from low
address for page structures in a range, which is the *bottom*,
not the *end*.

Signed-off-by: Cao jin <jojing64@gmail.com>
---
 arch/x86/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index e26f5c5c6565..bc2f871c75f1 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -663,7 +663,7 @@ static void __init memory_map_bottom_up(unsigned long map_start,
 	/*
 	 * We start from the bottom (@map_start) and go to the top (@map_end).
 	 * The memblock_find_in_range() gets us a block of RAM from the
-	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
+	 * bottom of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
 	 * for page table.
 	 */
 	while (start < map_end) {
-- 
2.30.1


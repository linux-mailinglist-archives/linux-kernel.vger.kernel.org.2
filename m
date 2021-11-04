Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0EE444ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhKDG0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhKDG0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:26:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DDEC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:24:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s24so5665603plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITNpx/7v1kdW2PebNDx55PzumFTIDCyKv4vKp0sRsX4=;
        b=aY7BJfVj4tZDlqOswU4WWN4EZgUAhNQC3dq4mQY+2YrEPqjfJLsGvZGFa5WCqpF+kB
         qsj49TWcdT91W+N7ECk1sHjdYgr2fdaYK2Nys9Qj0GO2sNvA5+OdZEwGE2/6NrxgVtQq
         foLMdeUJUubpyUNEk58dcUWQQIGzrPRFiwcrJjob+PmiNOB0EKonAPXHrj76q9Ay67yx
         CPx+M9fB10GowPa+ghaiBbdwPMIO9Ypuk8s80c6Ea4ojmbvx3U8pViBY96Pq6wlixfJO
         EY32XhTAR3EBXCfrsokaM+CkOIr9oq0zZy+Gb12jC6hvT4r96rQc/eJ8p3jjCB26jEUK
         79SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITNpx/7v1kdW2PebNDx55PzumFTIDCyKv4vKp0sRsX4=;
        b=dxaoBd6c2njRp3RMhXnQ2J9j+R5rsfYGmU3cNrzSF5gy21uVxfjFhQ7hSS+0LCWyjs
         myyIRs5Kh8NOPwF7Jwxkejp9roG8OSIEXSKWWN/q826UB1tHkGdpBhqELtvbWNv4K/TX
         Ufl+oipUM/KJlZ909MhczcG5VFcg+00fYGY5S2/47wxfE9l7rXusxJ8OewLtipxPJRVs
         XpeNS9uuyopuKYdNZVOJ2Naj/qW2TuAzlvffWBX3aCyf17rwfhrtIkHbDHJKmIyu2YV8
         7Zy7zWuzTcJPaSPe50FS8PYD0neQUh06q8GCY5ofpXaOAFjgzTHUZzh7jtLKW1teytGN
         TTAw==
X-Gm-Message-State: AOAM530XQwXf10VkHhgneuWzaMCAwY/OSRZUQ4vpkV2grfTYkSMV+wH4
        xddrmMVax76SlKH7YuTPoUfu4aNUrBQ=
X-Google-Smtp-Source: ABdhPJzjO8cPS2Fm5mDFGJYJdIta8DjCG4zDUiL4XonrPFZMC1kmVD49NM7AuRRG36Bx7qMkPSvmOA==
X-Received: by 2002:a17:902:e405:b0:141:b2fa:b00 with SMTP id m5-20020a170902e40500b00141b2fa0b00mr35537165ple.22.1636007052170;
        Wed, 03 Nov 2021 23:24:12 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p6sm4395781pfo.96.2021.11.03.23.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 23:24:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] x86/mtrr: Remove the if statement
Date:   Thu,  4 Nov 2021 06:24:05 +0000
Message-Id: <20211104062405.2463-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The "if" here is only for assigning the highest_pfn, but the variable
will not be used later. So this if statement should be deleted.

The clang_analyzer complains as follows:

arch/x86/kernel/cpu/mtrr/cleanup.c:950:4 warning:

Value stored to 'highest_pfn' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index b5f4304..2c896b4 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -946,8 +946,6 @@ int __init mtrr_trim_uncached_memory(unsigned long end_pfn)
 	if (mtrr_tom2) {
 		range[nr_range].start = (1ULL<<(32 - PAGE_SHIFT));
 		range[nr_range].end = mtrr_tom2 >> PAGE_SHIFT;
-		if (highest_pfn < range[nr_range].end)
-			highest_pfn = range[nr_range].end;
 		nr_range++;
 	}
 	nr_range = x86_get_mtrr_mem_range(range, nr_range, 0, 0);
-- 
2.15.2



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5DB391937
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhEZNxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232932AbhEZNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622037118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DCcVaBxhcbgaehz8vTuBVb/8+1PT3tCpcBtJLuUH4T8=;
        b=bbzkdU/p18t8YvBiNu9ICstcOFJxxUAoRWgHP/BJv9mZPWdm1Ksd3rJo4LuEoAbuoLHNQb
        W8ju8vmF7yAt1l0UwgK83GjBBiwNI4Q2nCVPAZes93Z+28uan3wBQlYg/Qqv0y2/Qpii9F
        Ipz30j9GuXudxO2qSTVTrJ7eG7uywWE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-1WZpxX-_N7-DQWzvJV1m_A-1; Wed, 26 May 2021 09:51:56 -0400
X-MC-Unique: 1WZpxX-_N7-DQWzvJV1m_A-1
Received: by mail-ot1-f71.google.com with SMTP id i25-20020a9d4a990000b0290304f00e3e3aso693610otf.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCcVaBxhcbgaehz8vTuBVb/8+1PT3tCpcBtJLuUH4T8=;
        b=dI5Wy25EDA21+udZd7+Owg5Im/R57pcXyf1EZBmZpQchDdJV9BD+C8IQe9ZEqHApFC
         /hITVCSe2D1k4pk0IZrZG8DkcHc2DVBdI0pOhY8B7iFg8PdpG1xAiO7P1FNLcb4hQEF1
         RLtIrk98wq1VJ8OB8fP9pi0fvSM8w+wSo1o1OgquvuIkw1IevAbjc7L6mMoOBSKdqlvQ
         HYNoSOTYxvCJM9lo5lc4A60eZFLZ8QR6fTAUKM5RkvN3QjBkxZyNOsDf0enXYw/e1Ngg
         M0sPwNWsDjPyxRtPjS828VN1h2uNaQhLZ+sIoN/2fDYoO0wSF1pLtzSkibllixRwLxvQ
         K25g==
X-Gm-Message-State: AOAM531tS0vpouxpJtj7TtSCsszUVw/cO285Jvv18whBNkZVm38WKSZJ
        ghMh2RALlLOo8+3fw87DRBARqO52QGV44nr6/j2kmGMCPtkIIpEri4sYt3qQIWGLmPswPvf+zKR
        imfFeFT7lkDROCn2dj7/SlVTP
X-Received: by 2002:a05:6808:13c9:: with SMTP id d9mr2017465oiw.142.1622037115428;
        Wed, 26 May 2021 06:51:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQe5R+wkwIYkUyw04XU6nhnkV9UEzK9e2/fc8SlwYh3zvakrFwC97ESECe1Zy6d5NtnJa9bQ==
X-Received: by 2002:a05:6808:13c9:: with SMTP id d9mr2017444oiw.142.1622037115277;
        Wed, 26 May 2021 06:51:55 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w6sm4467633otj.5.2021.05.26.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:51:54 -0700 (PDT)
From:   trix@redhat.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        peterz@infradead.org, ira.weiny@intel.com,
        rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        jgross@suse.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] x86/mm/fixmap: rename NR_CPUS to CONFIG_NR_CPUS
Date:   Wed, 26 May 2021 06:51:50 -0700
Message-Id: <20210526135150.2332379-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Fixes this build error
from arch/x86/xen/platform-pci-unplug.c:11:
...
fixmap.h:103:48: error: ‘NR_CPUS’ undeclared here (not in a function)
  103 |  FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,

This block used to be conditional on CONFIG_X86_32 which also
included linux/threads.h which defines NR_CPUS as CONFIG_NR_CPUS.

Since CONFIG_NR_CPUS is already used fixmap.h, instead of including
linux/threads.h again, rename NR_CPUS to CONFIG_NR_CPUS.

Fixes: 14df32670291 ("x86: Support kmap_local() forced debugging")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/include/asm/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index d0dcefb5cc59d..4d1f5cc448b98 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -100,7 +100,7 @@ enum fixed_addresses {
 #endif
 #ifdef CONFIG_KMAP_LOCAL
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * CONFIG_NR_CPUS) - 1,
 #ifdef CONFIG_PCI_MMCONFIG
 	FIX_PCIE_MCFG,
 #endif
-- 
2.26.3


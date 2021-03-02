Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FDA32A4AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838453AbhCBKyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349623AbhCBKnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:43:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13013C061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:43:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w11so19301287wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16ndR0culV70eBRfrAIf/Iqsopy47tMS+8Hc4+8NLq4=;
        b=LNIfD2/9kUa5gsShvPrj9HSoAezE4hGXMEtjwCwql99NspoIMcYCDiJOmWmzlZWr3N
         FflwBo7hbWoZgs62C+5WCMzHmnHq6N8sDITI9X+XJSFfbNZ2+Hs8zMsnoksPTCiZlC1s
         hA+AeEL/HCd0lwgXSH/pOhgTJSFYYFAYVdit12hO9ZsH7L5K7vqdbWoiMBfQGc1GcTHz
         mQV1e+EysS6POIx+8gQkbMAkf+pIEheLVw2qYJ5StSJ1EGORwlLuBGucducX5xG/RvXZ
         21FASigLJUog8BQl/tn8D6rshtfS0KNvdtHOYjhsKD49Oj5oY2HDOkfLDwd4Oanb55Tl
         SLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16ndR0culV70eBRfrAIf/Iqsopy47tMS+8Hc4+8NLq4=;
        b=TKpIYHBABv9SiMbI3TJ/4dK6g1+Tu1GrfT6ugUnJGTsA2IUxuu/skP+MA/MhWnvanQ
         ljP6naRdFfOPYvob9vdjLnwmJlL7y/6C2h/2QZ60Hrf635/Eoj8MvTYri7RY2SbgGth1
         le8GtI31bCaoVM9oxItOS5utOM41ZI85WTuPDMLmh0WtBa2KtYbSHofNIyWcDyhvtFC6
         6SurmxLmNeym8jClE4lOvYLoimqd5eN+JdAptLXT3DGa8wjtexqO3TCode1JRSJ+6FXd
         LojGj1gA9T0kf3Kon5mUeoqwCcBJ5L+1WujU6R5CwmwqiBL6erfkU7cN2l5QJ6q3bEmu
         0wOA==
X-Gm-Message-State: AOAM5337V0BF62cvBUYikiROtGJEFHYkVh0M/00zI8y5ht0v13i29bCI
        2K72X8ktRYpzHoKaL9LbRjRf/w==
X-Google-Smtp-Source: ABdhPJw/LEgT2VB6PYvwcSM0I19tDQNUmxKIzuQ2IHCBj9pgXC2hbaDJkSeAiI1c7DsPknzgbrGKhg==
X-Received: by 2002:adf:fecc:: with SMTP id q12mr21077411wrs.317.1614681783671;
        Tue, 02 Mar 2021 02:43:03 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u63sm2146457wmg.24.2021.03.02.02.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:43:03 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, zhangfei.gao@foxmail.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        jacob.jun.pan@intel.com, fenghua.yu@intel.com,
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] mm/fork: Clear PASID for new mm
Date:   Tue,  2 Mar 2021 11:38:40 +0100
Message-Id: <20210302103837.2562625-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

When a new mm is created, its PASID should be cleared, i.e. the PASID is
initialized to its init state 0 on both ARM and X86.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
This patch was part of the series introducing mm->pasid, but got lost
along the way [1]. It still makes sense to have it, because each address
space has a different PASID. And the IOMMU code in iommu_sva_alloc_pasid()
expects the pasid field of a new mm struct to be cleared.

[1] https://lore.kernel.org/linux-iommu/YDgh53AcQHT+T3L0@otcwcpicx3.sc.intel.com/
---
 include/linux/mm_types.h | 1 +
 kernel/fork.c            | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0974ad501a47..6613b26a8894 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -23,6 +23,7 @@
 #endif
 #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
 
+#define INIT_PASID	0
 
 struct address_space;
 struct mem_cgroup;
diff --git a/kernel/fork.c b/kernel/fork.c
index d66cd1014211..808af2cc8ab6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -994,6 +994,13 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
 #endif
 }
 
+static void mm_init_pasid(struct mm_struct *mm)
+{
+#ifdef CONFIG_IOMMU_SUPPORT
+	mm->pasid = INIT_PASID;
+#endif
+}
+
 static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
@@ -1024,6 +1031,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
+	mm_init_pasid(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-- 
2.30.1


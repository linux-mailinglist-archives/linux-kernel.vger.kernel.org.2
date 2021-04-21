Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AB336633B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhDUA6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhDUA6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:58:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50073C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:57:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g16so13738329pfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykSjY95cqkRXggeKZ48gy3dH7XwchqBVjMxlboR4Vf0=;
        b=i9MK1MbRoL2svXM3fLPYJa68MIZAR2O8jBzW0qTKgkc0G5kVL2RFQmC++wbYq7tCl+
         c1/1iWr1tB7CSeCfmYA4x+Ev8FMT9qOCvPGMdoihgEnGpvQUwe5QXZ52fGDzZHgj+NIY
         00y/x/BuJ5ezpZfZLXPLI0kDX1vdV5c1N+TvY+xEbytAtrA88bHXTw1hA97SMILuYGEk
         GyzlMoiPqZb/xIxlO+mCpN8tio3KFIFPhPrqWITKZ9gy67/rYdr6ob/u6P5m2izvgiyY
         XxapFWLx013eqSAdnJT/adrjP0copP/zC6v9IDejqa6cVxLAAK2C7DfoAeEO1dTtnqEm
         rEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykSjY95cqkRXggeKZ48gy3dH7XwchqBVjMxlboR4Vf0=;
        b=d6S/EMRzJOfJw1Cz8/HjnNf2QU0T0SjwvwE/U3suRzV2UAeS77Va404Tri6iql7fhP
         +D8BDoRza3F93x1UbCNCqu/3+01Q1fhWQ00xwQJPDsgeey7BfFahBd73AgoHsuXAHf+6
         vX5OuX5bPDj/0fBMlcjteJAzqfPQtqxRhlIE5Qw6Y86oq0C7wkaC8SoXjOWZBb9Q0jTG
         jl6ZzsyphNXJOAwUy2VKNNBqZKWqsq/0bKTjUafk8ez4l0yAdoR/BVxzWOqcXpsWf/cp
         tnTYkeNkO16mQFnojpffOxalPv3wEsmm5Tsmn3IVrdEMzChYeexhi1KXAs/60jxWydIL
         zc8Q==
X-Gm-Message-State: AOAM531v5PZsPkhGwO1sOT6FAJgxHYkOiPTQpU+xJsdFe8BzsR3ZEFov
        x7o9UD4XY+g6tHV2BcMWOw==
X-Google-Smtp-Source: ABdhPJxR5nyNxQS5ervGrHw4rorWmK1JFla9w4YOeUKrYHxk6hRWcvt52rQ4HI2IPtti5inBvSXy4A==
X-Received: by 2002:a62:3086:0:b029:248:16e0:7c6 with SMTP id w128-20020a6230860000b029024816e007c6mr28088086pfw.19.1618966664818;
        Tue, 20 Apr 2021 17:57:44 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id e13sm178278pfi.199.2021.04.20.17.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:57:44 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] mm,hwpoison: return -EHWPOISON when page already
Date:   Wed, 21 Apr 2021 09:57:27 +0900
Message-Id: <20210421005728.1994268-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

When the page is already poisoned, another memory_failure() call in the
same page now returns 0, meaning OK. For nested memory mce handling, this
behavior may lead to one mce looping, Example:

1. When LCME is enabled, and there are two processes A && B running on
different core X && Y separately, which will access one same page, then
the page corrupted when process A access it, a MCE will be rasied to
core X and the error process is just underway.

2. Then B access the page and trigger another MCE to core Y, it will also
do error process, it will see TestSetPageHWPoison be true, and 0 is
returned.

3. The kill_me_maybe will check the return:

    1244 static void kill_me_maybe(struct callback_head *cb)
    1245 {
    ...
    1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
    1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
    1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
    1257                 sync_core();
    1258                 return;
    1259         }
    ...
    1267 }

4. The error process for B will end, and may nothing happened if
kill-early is not set, The process B will re-excute instruction and get
into mce again and then loop happens. And also the set_mce_nospec()
here is not proper, may refer to commit fd0e786d9d09 ("x86/mm,
mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages").

For other cases which care the return value of memory_failure() should
check why they want to process a memory error which have already been
processed. This behavior seems reasonable.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git v5.12-rc8/mm/memory-failure.c v5.12-rc8_patched/mm/memory-failure.c
index 4087308e4b32..39d0ff0339b9 100644
--- v5.12-rc8/mm/memory-failure.c
+++ v5.12-rc8_patched/mm/memory-failure.c
@@ -1228,7 +1228,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(head)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 		       pfn);
-		return 0;
+		return -EHWPOISON;
 	}
 
 	num_poisoned_pages_inc();
@@ -1437,6 +1437,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
+		res = -EHWPOISON;
 		goto unlock_mutex;
 	}
 
-- 
2.25.1


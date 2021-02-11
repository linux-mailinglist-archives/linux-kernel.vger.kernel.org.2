Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0E3190FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhBKR0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhBKQ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:27:39 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B42C061A28
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 08:24:47 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id j13so2809475qvu.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 08:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KnIo6b0mEfBi+N6pkBoUNy3tWIMzelUSHiTa3+9/dts=;
        b=n8Eu1wdTAh9Eu4OjEcbbsCdcAWsoWpPR6r6oYR8mtb7+gOiuwlw5rBoFjWAUF1aD4T
         TXzqZomyaBngyAVAPOpRH35SWz1FaO7N8eyisU1iXK+yeL/CmG3GjMM0lbDi1VM0RU5Y
         xl005mxCvoNcjB/gA8lU6/08bS7TVoKdrR9atqFIUZ2MFTaxrnGWK7+GJeJrkaj2eBvn
         8DCsb16/e8ik7AkLva5ru4YCK7qz3//jrh0fkfWuQ2cbWV359i9AoN1BOgCZbBmwvJQ9
         I2cGyZMZKHROPHbFEIIs6foth/8gNgH54qY6OhsqfuemiSCeodc9J6/bdG1jjwja7/V9
         OaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnIo6b0mEfBi+N6pkBoUNy3tWIMzelUSHiTa3+9/dts=;
        b=t1zZk7ULJ6tSziCGgVmz/T8IoKcKJy0agesd9nzgmaiGj65ElsMFIoUlzy0p/kciLo
         K99gSC2IhLTJYwJXPGBOqUGcsvPjuRMnURGtKT18aTpt32hin9N2J64ApJb2c7g53Fxy
         LWsoLasH58YZK2ZkqkDUp3xJ5icRKSJ09MhZu28jLxdhxdddUytqpnbDA9az43JeaoZi
         0w7OvnXorQJD7MRUhgMSCS/e+MNCFI8m9rJ19pD09LSGx+ox87PEDFC7AFIsnTo9HeL0
         qqTXNkowfBb+fLWHnzlA9zIIJLc4rPoZSbm1V6d8UcYE/AEYceU5fBvxEl5e1LMiNDz6
         EsVA==
X-Gm-Message-State: AOAM531A4jDH4lVWYKm1lkcpKcoxjWf0eLXVIo/uU8S9cJHWdxyFa7MW
        B6KJW/57PYb41FaD55ZBf6Qhyw==
X-Google-Smtp-Source: ABdhPJzIeLzlqhbbKblTkU8XD7cXmkgY30iiBxIBBLyWnV0dtEAESq464td/C4isJdlFAK5z34rDsw==
X-Received: by 2002:ad4:554c:: with SMTP id v12mr8612729qvy.41.1613060686722;
        Thu, 11 Feb 2021 08:24:46 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i23sm3831778qtq.42.2021.02.11.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:24:46 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v10 11/14] mm/gup: change index type to long as it counts pages
Date:   Thu, 11 Feb 2021 11:24:24 -0500
Message-Id: <20210211162427.618913-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211162427.618913-1-pasha.tatashin@soleen.com>
References: <20210211162427.618913-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __get_user_pages_locked() i counts number of pages which should be
long, as long is used in all other places to contain number of pages, and
32-bit becomes increasingly small for handling page count proportional
values.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index ced2303dc59e..9d303c8e907f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1471,7 +1471,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 {
 	struct vm_area_struct *vma;
 	unsigned long vm_flags;
-	int i;
+	long i;
 
 	/* calculate required read or write permissions.
 	 * If FOLL_FORCE is set, we only require the "MAY" flags.
-- 
2.25.1


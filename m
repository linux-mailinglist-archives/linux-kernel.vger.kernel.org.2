Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1D730ABC3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhBAPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhBAPkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:40:43 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D4C061225
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:38:50 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id r20so8949361qtm.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mjWbyN3QlCSRxacF3EdFD9Q6Qqvve11XewDvx8+hMpo=;
        b=OAiVj8EUaBhRyXc5Me6CxkkQ4JJVwN6FcXMZMtlbhDja2FZkfFfbZUQ1PV61FJ8Bxh
         2qgpQslo1yfXRnpnaXy6AMqLdZo4lI69UbWuvi1JbU/mO7Eq03VkKh3tm3nN2kSYrbNc
         m1+m9ejmNWrz2xa17nl3fdFICPvoujm7g+JFNXAZGZEYBBFfjvjrns89jj1CryT0oZLE
         nb7cN2BbJezLQYuJ/RmdUItZgpcGYUEiAlCaLgYl17uHU1gNtYi6ehSL9P5GPWhRDJ2l
         wgSAinJkk7pCkLG+zVr0RMiDZnPOFJxLchCltU+ktnNkpd+AUWYjAi6UELgens7aoVf2
         46eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjWbyN3QlCSRxacF3EdFD9Q6Qqvve11XewDvx8+hMpo=;
        b=YIgRHTdiOwVjt3b+/zpRdc4KGigCYL2SU5NZEyV+2cD0tfrNT56lbmBFXAS9MS/EMA
         kxNoG4OhnMb1GIvyJeGS1v41ln3GCZcsvFQFSjJsjeh/MWcbhjq6h0FYZdK4k+ZQPDNf
         7/dK+DybBzvhIxP7zbD1BbW9DYQgL5P4+HrYLeXntyFFERmtD90lOGJFVWasO7+c6c/n
         3Y8qhbmb8vxaM9pO0wSCB5uXxiqURJj2Qwmg5SKruoOK0zUlS6Lwoj41EOhFMpO/Rior
         yW4MJ3WdifvtyaVhMo6kj7v2mwpjC9cVcLKooqgIzVgDIC1Xa8ROGZsHQLE8airxwlnK
         vNlA==
X-Gm-Message-State: AOAM530XWxgU4WKumyHggfQbFX6NNHcmO8itAVGtcglrxfFQUtF4WVMt
        vKX6kpw/VPf0eBvQGWev8R/wyg==
X-Google-Smtp-Source: ABdhPJzNq3NrBsdgUGhvNMpGvQtnn1ipFJ+9G5L4EDS9p0pLvxVzoDtfLf/6zBoa3mZCddCTnis+MA==
X-Received: by 2002:ac8:4d59:: with SMTP id x25mr15779216qtv.369.1612193929474;
        Mon, 01 Feb 2021 07:38:49 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 22sm14853307qke.123.2021.02.01.07.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:38:48 -0800 (PST)
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
Subject: [PATCH v9 11/14] mm/gup: change index type to long as it counts pages
Date:   Mon,  1 Feb 2021 10:38:24 -0500
Message-Id: <20210201153827.444374-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201153827.444374-1-pasha.tatashin@soleen.com>
References: <20210201153827.444374-1-pasha.tatashin@soleen.com>
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
index df29825305f8..f98af75dab0f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1479,7 +1479,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 {
 	struct vm_area_struct *vma;
 	unsigned long vm_flags;
-	int i;
+	long i;
 
 	/* calculate required read or write permissions.
 	 * If FOLL_FORCE is set, we only require the "MAY" flags.
-- 
2.25.1


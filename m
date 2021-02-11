Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA262319103
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhBKR1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhBKQ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:27:39 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014CAC0611BE
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 08:24:46 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id e15so4532730qte.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1y8YVJPfrTUIiLzCoLZfzLsb38Z+1ZQwX7g2yPLqtWE=;
        b=BMZBD7oFx42XW1Uk/eIT+ek2yqmO2Unwl542eAk9EtAij5sF54ALjQ+UxIzV6fseqn
         9KHoTP/AkRo/I9nUl/bckx72sPe9TsPWqhTnETapUUtoMI91yr0quP6I2g4jL9ElIwQI
         qlZT7xirvXSEQOXrLZ8Glpk4Dt2Y6sD2Vo7KfitLgkUuUXK0jU1Rhp+kNsDhVjc8oyTr
         UatAl1MdhuE/8fWIVU9acVXddvE7Yvu1P1HbnVuDAEZ3oRvBX5RSCzPGZplfL9STagRw
         YC3vR6mguTAhApUEkxNsXoKWoXBOMgXWuvtlZNOD+cHwfHFMlDheS5Kyw2acUXRC6opX
         Y2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1y8YVJPfrTUIiLzCoLZfzLsb38Z+1ZQwX7g2yPLqtWE=;
        b=f31+pbCJOGENn0c0odWSoWX0l1F5uDrTxojcr8JdQm8eKFfpv6runPwyTJ2f0i6MyK
         WFrYhb+tybO6xuQuvcyXSPFQpLK6uHLgBB5rUkB2w+TVCJujhPG1JAVdVDUXAxwdhzp0
         B1/mtC27H7EoUlrDr76ccRKf3NpKZbCUyRhHI/BRI5eDIZ54XpaMcig2+5bejfLoI75E
         bmFbKNr4YlEDTmQd3vMg1xAGxueR/3GMDbNW3OPWLqQBLu7hejivUds/rhBe9AzRgUXw
         HZHKRSRD2A6nIVJQ1LhD+uDcMsxZ5oSisf07J+NKSCytpwAQXOhQYfAkg/OftUUiFdYr
         eB/g==
X-Gm-Message-State: AOAM533ivUa84Ro5J//Y/xGlu30Rj4sIniskeaEzGMnMgaqNcZJB6Cdq
        3z9UuzPFqbloRXC2IzQtdIeoeQ==
X-Google-Smtp-Source: ABdhPJywW3R49OtwqHgSlgYoPuSklhjeeJfwnn3touZTrtXT9dvY7n8wJc0mz/T1j2uyZvz6BoDYwg==
X-Received: by 2002:ac8:4d43:: with SMTP id x3mr8211573qtv.17.1613060685225;
        Thu, 11 Feb 2021 08:24:45 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i23sm3831778qtq.42.2021.02.11.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:24:44 -0800 (PST)
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
Subject: [PATCH v10 10/14] memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
Date:   Thu, 11 Feb 2021 11:24:23 -0500
Message-Id: <20210211162427.618913-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211162427.618913-1-pasha.tatashin@soleen.com>
References: <20210211162427.618913-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the special handling of page pinning when ZONE_MOVABLE present.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/admin-guide/mm/memory-hotplug.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 5307f90738aa..05d51d2d8beb 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -357,6 +357,15 @@ creates ZONE_MOVABLE as following.
    Unfortunately, there is no information to show which memory block belongs
    to ZONE_MOVABLE. This is TBD.
 
+.. note::
+   Techniques that rely on long-term pinnings of memory (especially, RDMA and
+   vfio) are fundamentally problematic with ZONE_MOVABLE and, therefore, memory
+   hot remove. Pinned pages cannot reside on ZONE_MOVABLE, to guarantee that
+   memory can still get hot removed - be aware that pinning can fail even if
+   there is plenty of free memory in ZONE_MOVABLE. In addition, using
+   ZONE_MOVABLE might make page pinning more expensive, because pages have to be
+   migrated off that zone first.
+
 .. _memory_hotplug_how_to_offline_memory:
 
 How to offline memory
-- 
2.25.1


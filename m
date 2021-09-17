Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F96740F227
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbhIQGQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbhIQGQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:16:56 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84800C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:15:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q68so8612903pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLxAgvPiwV4LgGOV9DMw00Rt94l7Vhe8/b9r97CCM90=;
        b=kNHv+MrElC2vzdt/M+tEutVmMvcn4Y/4N67GSh8mSsmx0BDCp8lQBi7teNv/SjiMtP
         pNhs+obL+RbCO9mFdmamid2DtQfqN+Em5ht7d8brGpRaWuZLsnCEC8gxdyx1MJLocthd
         7sqMy2xrpH5xC/bGCiQFwS1a+182w9QrnMCk7LRQezO2Bjpl4psj5lvhILZWIpxexRM7
         oY8dnvOSYhXGxD3P37IutXjAaV7VvKZuYZpDxTm6Sz8bCw4T2ELeWvThQN1zNZqEqVIi
         Y8cR/QVx9XKxxGBg6LcxnAA9Sh8+3XjCUR9IFK6nxI+TasXbHBsbMOhFSuEdFkH+ZiI+
         F9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLxAgvPiwV4LgGOV9DMw00Rt94l7Vhe8/b9r97CCM90=;
        b=6e658XoCRgSKc82uqnIZpZz7ZwO/abyVHGMTo+BocCQXXMcsuMXj1JvGHmblR5WOOQ
         01SXFvp6LstO5yZtaCvJoj9oa+RXsfiMMQl9dH30HIkaPZzn7IaqXspeedgjIS4qxKeH
         /KRUZHd7a+iv+TQzAhzSNmPwyPSxBGfQvwMU+Eoub8Ozy88wTYYC41d0Q178iasEcwx4
         TIn7NbEEefPU0/VZ5+gg75/AzP+njxSvpLvnQApCu1FbmHU/7DtVze8zjuMpqimteg/m
         TEShHrvjUKVfJtaySTIEFKpwMo6tdlsiaaxu/hWw0785ilJD08Hj69B+X+JUpow+HjgA
         o8bQ==
X-Gm-Message-State: AOAM531vsVnnpaF0L6+RJN+njQhrTKSvGHbjhqFz7/zI3LlUmA2OB6M9
        qQu13WCurz9NVg3qA7EaOPE=
X-Google-Smtp-Source: ABdhPJxAC3zURinRFHp2WXJpKcQ0on1CNnXu8SmOYf/foorYI5wHiUoA+xLAiUIkMkKNgBzUjyfwlg==
X-Received: by 2002:a63:4f43:: with SMTP id p3mr8287107pgl.435.1631859333842;
        Thu, 16 Sep 2021 23:15:33 -0700 (PDT)
Received: from ownia.. ([173.248.225.217])
        by smtp.gmail.com with ESMTPSA id h15sm4687274pfo.54.2021.09.16.23.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 23:15:33 -0700 (PDT)
From:   Weizhao Ouyang <o451686892@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Weizhao Ouyang <o451686892@gmail.com>
Subject: [PATCH] mm/debug: sync up latest migrate_reason to migrate_reason_names
Date:   Fri, 17 Sep 2021 14:14:32 +0800
Message-Id: <20210917061432.323777-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After related migrate page updates, sync up latest migrate_reason to
migrate_reason_names, page_owner use it to parse the page migrate
reason.

Fixes: d1e153fea2a8 ("mm/gup: migrate pinned pages out of movable zone")
Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 mm/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/debug.c b/mm/debug.c
index e73fe0a8ec3d..733770b0ed0c 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -25,6 +25,8 @@ const char *migrate_reason_names[MR_TYPES] = {
 	"mempolicy_mbind",
 	"numa_misplaced",
 	"cma",
+	"longterm_pin",
+	"demotion",
 };
 
 const struct trace_print_flags pageflag_names[] = {
-- 
2.30.2


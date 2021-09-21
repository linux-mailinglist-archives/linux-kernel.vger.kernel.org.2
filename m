Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB60412ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhIUGsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhIUGsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:48:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A48C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 23:46:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m21so10618927pgu.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 23:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6oTXrjPbExj9E3UFA1PYlNf37y3ZhK96brFnlr68vX0=;
        b=XolRtbTLpdTfq/4v1+yt+8zmN3QAcvXP7hAzvuDooqQkpTH4nSnQzyoV784qK53fJt
         9BWM4Y8nKasbVfmwH0TJ9TslR/owQ8irBj3vygM+6SgkRf4euqsgxa6TZPvTmF84ayrX
         Y2WGyts1qA2KiYzlg85IgmBrTZJgAyYISrGdvRZpO5C5s5FeVCmOCEWVabas3J+7L1xV
         ww/xDeMM7emdWd55ifqkDYKkVZzX/IwunkoHxhrFakxPdqO3ssceJPx8v0yLTww94sIZ
         lB5lJLgiWBOk2lsWnO8A38TIAkgL7kVqQVnfuz6VcaqpNHLB0mpzebToXrkkgCOnLxMS
         CmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oTXrjPbExj9E3UFA1PYlNf37y3ZhK96brFnlr68vX0=;
        b=e53Q4DzMfneLvDhwFekeROs3hOEWsGseClarjpkD+GBuQadz83A5kG4dGJxg9LLwyi
         xnbioV3+mLsQ8icMYagy2Xw0P338+GLpK6Ff7L5g3guXvIWJ/wnjE3PNeZ20lt4JHrNv
         A7JlBnSIROXJE5/F3xzFlD+v0GZke+ycVCVJUaBRZMqZCwlC3pyeQh8uUiGyyKwvg6zQ
         itxM7KWW83+0oCHnrmx9OWrfRSuhlQ2iwddtcVhT1DdmqeTZ8Fc8xfc08a8CnXLpTRDf
         ude3ZVXMbNirhQzErgyUCHynfGh5R7EKPyft2ZevaBu1cmyAKlvzKEaCozy5QJEwtq9r
         A+9A==
X-Gm-Message-State: AOAM531SI8VHSM7A62xnCGQOJad4ZW/nYdUiooJGhW+O20dDINvl+4T6
        Ep9k+iA+NWXw9gN1W/Bkgts=
X-Google-Smtp-Source: ABdhPJzqbHJz/HRSdsP3LbXPha6p/m5fcMEQ9rl3YMbfV+DSl1V+gCYTNcprlJqipTU1S5c4tF1HPA==
X-Received: by 2002:a63:4344:: with SMTP id q65mr26792470pga.364.1632206813834;
        Mon, 20 Sep 2021 23:46:53 -0700 (PDT)
Received: from ownia.. ([103.97.201.35])
        by smtp.gmail.com with ESMTPSA id a1sm1413101pjg.0.2021.09.20.23.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 23:46:53 -0700 (PDT)
From:   Weizhao Ouyang <o451686892@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        Mina Almasry <almasrymina@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Oscar Salvador <osalvador@suse.de>, Wei Xu <weixugc@google.com>
Subject: [PATCH v2 2/2] mm/debug: sync up latest migrate_reason to migrate_reason_names
Date:   Tue, 21 Sep 2021 14:45:53 +0800
Message-Id: <20210921064553.293905-3-o451686892@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921064553.293905-1-o451686892@gmail.com>
References: <20210921064553.293905-1-o451686892@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync up MR_DEMOTION to migrate_reason_names and add a synch prompt.

Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 include/linux/migrate.h | 6 +++++-
 mm/debug.c              | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 326250996b4e..c8077e936691 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -19,6 +19,11 @@ struct migration_target_control;
  */
 #define MIGRATEPAGE_SUCCESS		0
 
+/*
+ * Keep sync with:
+ * - macro MIGRATE_REASON in include/trace/events/migrate.h
+ * - migrate_reason_names[MR_TYPES] in mm/debug.c
+ */
 enum migrate_reason {
 	MR_COMPACTION,
 	MR_MEMORY_FAILURE,
@@ -32,7 +37,6 @@ enum migrate_reason {
 	MR_TYPES
 };
 
-/* In mm/debug.c; also keep sync with include/trace/events/migrate.h */
 extern const char *migrate_reason_names[MR_TYPES];
 
 #ifdef CONFIG_MIGRATION
diff --git a/mm/debug.c b/mm/debug.c
index e61037cded98..fae0f81ad831 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -26,6 +26,7 @@ const char *migrate_reason_names[MR_TYPES] = {
 	"numa_misplaced",
 	"contig_range",
 	"longterm_pin",
+	"demotion",
 };
 
 const struct trace_print_flags pageflag_names[] = {
-- 
2.30.2


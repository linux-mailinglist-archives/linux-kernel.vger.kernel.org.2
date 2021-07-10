Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA21B3C367F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 21:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhGJTos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 15:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhGJTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 15:44:47 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044A2C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 12:42:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h19so3750803ljl.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 12:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5T7KVRU9KQXhZHkbGTMG0QB7ScyZp9VJ+DfUGpWKfso=;
        b=iT4HivcxPYzkkCyPgPmIxyUsIKTne09svC3gu67YfZlMhGzWnwrZZfOXhLmLX2i6e/
         4yZJbjhERU76g5Shx/9nqJJBen657KiF9SHkN2N0HvachGxI2YvRPLL8pv9D7OW6Om4E
         LDK5fmqYhP/tQVRM4GtqVIfPF7yXIVVFrhj0K2pAIMIBNGup4AZvlNd09dJTWDlQ/5OT
         4QOdi2OatiJ5cjQqHt1Ck/heWms/YcfV12CzUTAHYgnCa8QwXMtWO9vCss1pbbRWfXKj
         rUHZC7FIEZMDvardTBKiV22EEJH0m1ZeXmJLwcvvjWKwRnLK6zvhNdHL4dI/WUYVgOWp
         mZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5T7KVRU9KQXhZHkbGTMG0QB7ScyZp9VJ+DfUGpWKfso=;
        b=Wsu9i3GeE57piaGlDJY6+36HvjkR231xREM18v2GT8zfwXF77z11z3dd0alPGyLmI0
         aojtMx/GkVlJ9pabG3dKDXRPUKti1sBa+nT43LZamcgj6No3VWk/HrCURNyo7sZYzUsy
         tyVQIp1y2jmoYaKA1skGYMmsSxv3S6f9kdupeilisa/JCPoDb5Vi0Qz5R47L/GKErHLZ
         otFe8cIAICKzwPnjR4ALNEGagkPVkoY18RANGAWtDCX5GTzKX0wVX753AixgfsNiWVyF
         H/p/+d9qu588qSbQ0E9L1WeXqNGGoiDdhTVPVT82KjYT7uE9afgYwRqkPfrGJzvDrUP6
         2l4g==
X-Gm-Message-State: AOAM5301tvaTwsQaOOYSXfZXxFEAdEFUnWAD1ojGxVoAFwQ2vaVFhmMA
        H/1FJQygOHkrwQ1TtKyXdNVg9KKax+E=
X-Google-Smtp-Source: ABdhPJwESs8X8plCCr55C322Zv2e1Sq2tLbYcDiIUOFGtGp79fG9KfBlP/BCeYVlEKE+xzmOa1dx7g==
X-Received: by 2002:a05:651c:b0c:: with SMTP id b12mr35235398ljr.190.1625946119294;
        Sat, 10 Jul 2021 12:41:59 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id q21sm775523lfp.233.2021.07.10.12.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 12:41:58 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] lib/test_vmalloc.c: Add a new 'nr_pages' parameter
Date:   Sat, 10 Jul 2021 21:41:51 +0200
Message-Id: <20210710194151.21370-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to simulate different fixed sizes for vmalloc
allocation introduce a new parameter that sets number of
pages to be allocated for the "fix_size_alloc_test" test.

By default 1 page is used unless a different number is
specified over the new parameter.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 01e9543de566..e14993bc84d2 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -35,6 +35,9 @@ __param(int, test_repeat_count, 1,
 __param(int, test_loop_count, 1000000,
 	"Set test loop counter");
 
+__param(int, nr_pages, 0,
+	"Set number of pages for fix_size_alloc_test(default: 1)");
+
 __param(int, run_test_mask, INT_MAX,
 	"Set tests specified in the mask.\n\n"
 		"\t\tid: 1,    name: fix_size_alloc_test\n"
@@ -262,7 +265,7 @@ static int fix_size_alloc_test(void)
 	int i;
 
 	for (i = 0; i < test_loop_count; i++) {
-		ptr = vmalloc(3 * PAGE_SIZE);
+		ptr = vmalloc((nr_pages > 0 ? nr_pages:1) * PAGE_SIZE);
 
 		if (!ptr)
 			return -1;
-- 
2.20.1


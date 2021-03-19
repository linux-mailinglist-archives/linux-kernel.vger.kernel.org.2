Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2064342923
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 00:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCSXb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 19:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSXbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 19:31:32 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F8CC061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 16:31:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id j7so8125221qtx.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 16:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4MwivssdDeTOOf4NlUgU3u4clY3jrfk9rBV7iONoIkQ=;
        b=apJwdLJhcOeNIy+OY5T8d3HyFP7l5M4bxAqZdyf2JyUGQ5RKVMERPg5QpOScfORwig
         2Mcs4MFi9Z3OYFnQr3eJKJGO2Zba6LFJ8A/bm5xGSqgxAjr9qsnmBkm9UzQnue6h0suo
         wZ1wHMk2ODXr9p6JFTvdjW6KzBJBTskm/IhLyG3F2vGXL4Tn8sV4VRtJ0wuvXrJzxN2M
         wDqBu6L1+zTKlJRC3ToDMKjwANk5LMPdej5LTL5ss/CufplrjWtmPb2/hZp/EaetqARY
         JMLbQ4Bn2IHxSQ8toC7d6HC+R6Y7fWPinYI/fI/+5KyBOV1hKvykAikggd68cSPRcsK9
         Uj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4MwivssdDeTOOf4NlUgU3u4clY3jrfk9rBV7iONoIkQ=;
        b=N+bfOX568NjCC2whpAsm+4s6kAhfRh4KmXrnYXc0Q3226iHm9LwK7BwP6VmVJRHWdF
         ygFdJ1XncwfjMELxhw7JlCIpif5dgK2ApGEHt8c8ztGJSrbPARBeW5IGSl7m78gW7PZD
         4J8GXNmQ5NL63Ow+5fWOHya8gsP8HzAjW+KrIgJucB1W+ZFFJMd7NlmmLD6jx72kju9t
         9cyPUYilWo1MC4x6zfdpJAb24WBXi1BMTNODPtvmIBMC/jTh2L+Pr7GXCxxJdLM6d+fM
         1+4Xzef6qNx5shF9hmvVTd2TvoZuYWck3yMY+YK5UGtZXZ99NGKeCJcyCtpTJh5D5jPd
         +tYQ==
X-Gm-Message-State: AOAM530i8Gng2vhZEWQgUD5lT6AHsOPIhOOs4Wd6DCEJ3zQ6iDC7kpte
        GOOVy3z1X6N3sRjKYDWBxSo=
X-Google-Smtp-Source: ABdhPJx5LYbLxlRoXBnR2W9dM+oKdsbLr9TT0AzxWCnt+v8DYmI5kcfn8x2lU/d20Qjep3Gf1Kt8NQ==
X-Received: by 2002:aed:2c22:: with SMTP id f31mr1002161qtd.219.1616196691319;
        Fri, 19 Mar 2021 16:31:31 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id i9sm5679414qko.69.2021.03.19.16.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 16:31:30 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] perf/builtin-c2c.c: Fix a punctuation
Date:   Sat, 20 Mar 2021 04:58:24 +0530
Message-Id: <20210319232824.742-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/dont/don\'t/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e3b9d63077ef..af1c1b89e769 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1813,7 +1813,7 @@ static int hpp_list__parse(struct perf_hpp_list *hpp_list,
 	perf_hpp__setup_output_field(hpp_list);

 	/*
-	 * We dont need other sorting keys other than those
+	 * We don't need other sorting keys other than those
 	 * we already specified. It also really slows down
 	 * the processing a lot with big number of output
 	 * fields, so switching this off for c2c.
--
2.26.2


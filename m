Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E223CFA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbhGTMhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238689AbhGTMeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:34:05 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962D7C061574;
        Tue, 20 Jul 2021 06:14:42 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q190so19964909qkd.2;
        Tue, 20 Jul 2021 06:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4JGp05b24ihTRHgklBj4UKyWFFV1V2kZsG7t8cqA7wo=;
        b=jYobwTtDo3NVFwh2/V12GOKGtD3WnOJKH8wi9aW9n9EE4lNglOClw++Igx3yDrJVrf
         S58vCPA8O+wOVncPXOzKMP/9n5qCaCgVyDIz0+RNgQ6dNV8mHu4gxzmYoQm7CQut/o14
         h2Um4lXcjH2SgXGcBjxgceVA/dQ269Pf90MkyAd7DQW8FhVhCqNByGvS59aL5HHiYXlu
         EbIJacrudRnd+8lmAmAYyYjBX5agXgVaZzpr+KfljjozLMM8q0Nmc+AZR073z9u40oCe
         4VVBDu5o4NBvVy6VkzaJn601x4I94VIH+KituqkfQKMR4Lyutg//L8J5hjpYhToaqOYk
         xLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4JGp05b24ihTRHgklBj4UKyWFFV1V2kZsG7t8cqA7wo=;
        b=TX9PFZ/L80PLXrTZcMWa1WQtRgfhAgdMjIsZSHPCG34yRAeJuWvahM93clhtKTMRvb
         Gt8HgQHwIxa9Niyup4sLApwwwvY4pz2NFMkOHqURF7EgnvIJEtSmYe67OLidETqgnExu
         VTHBj1qQ8t88wxthWnFhazrSyxix8/mZL1UQI6Hj3CqlQkIAcWxdPnWDBcKDRpilTqHJ
         8rLFSLtjqa8qzfZaahdz813eeIJnpw/+RAU/HQs3uz8rfk012KkUkuEdDw5uvZQ/QWRe
         UZWwyw0Jn74sJr8ZFchGJEwIphfjqEoEJu+RHn74VRJE0dAh8ZI+bsqzazYrS4XiIuir
         0MNg==
X-Gm-Message-State: AOAM532iQ1HXpjuiHe/hFFSGCy8KUvSXnHGn3MF/F2+xRxsoGhXdo6zg
        bXfae40SX0cOtDn7uQyGNRQ=
X-Google-Smtp-Source: ABdhPJzhnbTUOjZXn+05iSY6IRs7WUNu24W17TsbD/hSW5y6sEDFtOjgxQpkq3qOjfN0u4cR9ga9SA==
X-Received: by 2002:a05:620a:d5d:: with SMTP id o29mr29562774qkl.157.1626786881788;
        Tue, 20 Jul 2021 06:14:41 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:41 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v3 13/15] selftests/damon: Support watermarks
Date:   Tue, 20 Jul 2021 13:13:07 +0000
Message-Id: <20210720131309.22073-14-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates DAMON selftests for 'schemes' debugfs file to
reflect the changes in the format.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/damon/debugfs_attrs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index 4c69d8709e3b..154f9f76f84a 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -78,10 +78,10 @@ echo "$orig_content" > "$file"
 file="$DBGFS/schemes"
 orig_content=$(cat "$file")
 
-test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0 1 2 3" \
+test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0 1 2 3 1 100 3 2 1" \
 	"$orig_content" "valid input"
 test_write_fail "$file" "1 2
-3 4 5 6 3 0 0 0 1 2 3" "$orig_content" "multi lines"
+3 4 5 6 3 0 0 0 1 2 3 1 100 3 2 1" "$orig_content" "multi lines"
 test_write_succ "$file" "" "$orig_content" "disabling"
 echo "$orig_content" > "$file"
 
-- 
2.17.1


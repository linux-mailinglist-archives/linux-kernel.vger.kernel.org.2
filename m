Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B183CFA78
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbhGTMk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbhGTMd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:33:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F36C061574;
        Tue, 20 Jul 2021 06:14:32 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m3so19939740qkm.10;
        Tue, 20 Jul 2021 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4OySLzN00OyxAmBozCmrLJ4FDwzHDu/TgQ7eqRxySc=;
        b=L4iKNe414B39IjYtYRV+736mv2j5dwbTHDQDz9OhJ+YCqXFJivxcxVtLLgmYptKayY
         ICY4eEAdTgYvcHLm4FvGg90Mb/bCZRsiId9X/7f7cfcljtYuq461c3ucbUHdqLzloodK
         zkGwYwKbyVgjjh80pwe3GkhGKZvkWMHZoMqwunOPBRR+NRH/xM1Ymx2BycOrcrbQZYN/
         9H+LqlyRWbMBPJrmEZ51NJrE6M/PKMeX7c91Zy9EI+UdN/LrWpCiofceIcfaTfuz42GC
         E657VxPLlhVkuXXFNHdWSccPUCd8q8MjUucAr6weT3oxUlebuy4UR0CzY9zQjHL+cse1
         wsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N4OySLzN00OyxAmBozCmrLJ4FDwzHDu/TgQ7eqRxySc=;
        b=GfytDQnfRySv8LulbRh+9a6a1kxwRJNyK2HhIP7lu0aZiTpClmjtiZiTCb+Sk3vMQF
         Zaj5Ah6R+DpDGAWlWx9b12mGFaOa02QHkPMzjsiGU1f9N3X3zv0hSLCPHBYvlKx8FQlq
         bxluq6CXefQpkBZZX11AVRjQ+zRQI/y4n1RG3GRXMMesgkWR3Akd7wvK4JCiZHh6RBIh
         KweCFpvpVJF8iJDsuhDKhSPA0lbPcO8x4ZUfjigKQ0TZyfF7Us+xz+ZqtoZRp3ymTu4x
         UO4RiJioKGocImXn8G60rYfHEty9ZK+JXLR+Nq0SMAmxbRbXF8umEs6MeI+a60lScPDl
         5wWA==
X-Gm-Message-State: AOAM533sC2rXtE5W702mijz7FBVq6reavy9bxOdrPOBrBFw/bo4YCJSw
        YvuoaAabnR7JXjXvDNmqVR4=
X-Google-Smtp-Source: ABdhPJxUFKWtsMXkkyZQ8/2AFphId8tuwlo+lJcqhyphDa44DBS0Yw9n1wF3tMxCY49TNhlpMKT1Sg==
X-Received: by 2002:a05:620a:4e1:: with SMTP id b1mr29376604qkh.363.1626786871796;
        Tue, 20 Jul 2021 06:14:31 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:31 -0700 (PDT)
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
Subject: [RFC v3 10/15] tools/selftests/damon: Update for regions prioritization of schemes
Date:   Tue, 20 Jul 2021 13:13:04 +0000
Message-Id: <20210720131309.22073-11-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates the DAMON selftests for 'schemes' debugfs file, as
the file format is updated.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/damon/debugfs_attrs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index b6a09ed6a1fc..4c69d8709e3b 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -78,10 +78,10 @@ echo "$orig_content" > "$file"
 file="$DBGFS/schemes"
 orig_content=$(cat "$file")
 
-test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0" \
+test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0 1 2 3" \
 	"$orig_content" "valid input"
 test_write_fail "$file" "1 2
-3 4 5 6 3 0 0 0" "$orig_content" "multi lines"
+3 4 5 6 3 0 0 0 1 2 3" "$orig_content" "multi lines"
 test_write_succ "$file" "" "$orig_content" "disabling"
 echo "$orig_content" > "$file"
 
-- 
2.17.1


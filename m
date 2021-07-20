Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0585B3CFA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbhGTMli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbhGTMdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:33:46 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4D8C0613E4;
        Tue, 20 Jul 2021 06:14:16 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d1so15315728qto.4;
        Tue, 20 Jul 2021 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6X6ejMAiX1gTqZemYodAPU0FplHO/tuxF/5lomt1hjU=;
        b=tf4s/IAcedqyKa5fvHgtNtrGASUG219LraSto3HNwbBVrNJU+nMFn+PkEJbLd6nXlQ
         98/KaDnk2ND9d7mbHxkV5+hEM9s/CXsVNf/qpGkxzNtsDgZ9xjNHzBW0aU2uZFXbu/kg
         7+gcPwUTvewHHnOYexqtadBZVxY3lJAniiYEAaKrq/V+RR7K3pbRh4aWJCHNHiPnnjmD
         y1hR1ll5fyIu/w0y2naIiRn59RBzWEjGWbCsRd6UYh14W97IeXyEHGwXC50f0+P80b0d
         EtuFPqgBSv3TG8VeWFea5gValIaA0VFcEDcIWC1JcGPuCuHM8pWkyGJtiBAfsn5haanv
         0wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6X6ejMAiX1gTqZemYodAPU0FplHO/tuxF/5lomt1hjU=;
        b=ry1IKelKUCFCy8qQ9ydS2uD1dQqiS2YBETAGXwB5G1xZqz9N9t/Iu1l6QIV+8cFr8i
         ce7omQwIbOogM1QprF8+R8dGoi+5OQJv71B7O1uMHkZi0WRcBWQZ0moFDXcleEiyAYZP
         HW5NgsoyVXqoBPlCc4uT+s52fnw5m05k/kpBEU+aYJNdE8Ost704SsuQOMD9u2m9d3cT
         09eGOfDGWFdoS6q3rq6jNW/exZEw07vKFJ6dk7lLMeg0Btx6E70cLBoEqNqDmtYES9nG
         Ll+h9h1iRAZ8TBw1OxKYznmst443R+nTKIfMJLWKYQte9q2/d8Owi9d/LEapdnxGSsg+
         gBmA==
X-Gm-Message-State: AOAM532AGS/4ka7yGT+BYy2AsJCWtnfb+Or9i8OWAwRYW1uadBNtnfeN
        r7N4hkK2VPSxqWGcWrz7AQQ=
X-Google-Smtp-Source: ABdhPJwsAlEOMXXQ2Y7PmLM2hx/Iw/tBsTpoGx1Mclm+eVfAI860b1H7MueLWvBl2anRMaE2Ex9fHQ==
X-Received: by 2002:ac8:734b:: with SMTP id q11mr26406393qtp.105.1626786856080;
        Tue, 20 Jul 2021 06:14:16 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:15 -0700 (PDT)
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
Subject: [RFC v3 06/15] mm/damon/selftests: Support schemes quotas
Date:   Tue, 20 Jul 2021 13:13:00 +0000
Message-Id: <20210720131309.22073-7-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates DAMON selftests to support updated schemes debugfs
file format for the quotas.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/damon/debugfs_attrs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index 63908a4c397b..b6a09ed6a1fc 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -78,10 +78,10 @@ echo "$orig_content" > "$file"
 file="$DBGFS/schemes"
 orig_content=$(cat "$file")
 
-test_write_succ "$file" "1 2 3 4 5 6 4" \
+test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0" \
 	"$orig_content" "valid input"
 test_write_fail "$file" "1 2
-3 4 5 6 3" "$orig_content" "multi lines"
+3 4 5 6 3 0 0 0" "$orig_content" "multi lines"
 test_write_succ "$file" "" "$orig_content" "disabling"
 echo "$orig_content" > "$file"
 
-- 
2.17.1


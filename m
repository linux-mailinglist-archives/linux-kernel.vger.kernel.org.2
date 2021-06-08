Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3110639F5A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhFHLzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhFHLzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:55:16 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF7C061789;
        Tue,  8 Jun 2021 04:53:23 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id t6so4702030qvp.5;
        Tue, 08 Jun 2021 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4ZGpG/OoDyFj8zWzsVNZahhh/PU2Xw0WQnYylGT37eU=;
        b=Yq42KPRH05BimDLNJKHdfHTmPCD/zIWdkIN6o+96suXi52Za+1HZdprMUeI5P+427S
         AEqy4LePzL2ryEKdqpcE4J98KUIVG4QY5h83SDWdBQfV5BOP2gulJgm4yAWQApUiumXo
         qzUEKKLq/VNGYJB1Y4FBTxNXM2oZMlHeFDNuwsyqs7kUJcmgzIdLwvZcLLwcHcPxmxSq
         VxLhAu9eLYgyfDhcBnCJv7V9o9gaKsU+rE7KMlucNQ939EfHDtb5RlpAg4mYxB/JGTiW
         lUjyT3mD02/BMiv49C2TrYj04olrTuDDS807u03bHDn6/ePDwndCtnrLg1OAW/7QpziZ
         DKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4ZGpG/OoDyFj8zWzsVNZahhh/PU2Xw0WQnYylGT37eU=;
        b=COceIao6MLvDhV/S8WwruDyrdJuL5US0TKC6h7Hws0ARksk3pj+cR6a5gM4Bi2/pBx
         uNrq1jwPTyVGFh0Zju/d8ElYTY5/EkV+WGgoyeDpUxVD20A/zTRtvOfKNil76dF2YxUB
         dNuxkkZLdWhoAhGaKutWR/KJmvrvNJbi1iKLIvOjV99uCe87dUl4okNomPbjlD+glZNH
         2PoLI/Ct4S5nZTgfxOraY2cAPtGmaGx8FF/yqiNSsph+AuoGCxkBG6prYKeQGB3WU9Po
         61tXAfdQ9sFYvmRkbDqfITIG+8WqzYHIUzpsvhPAdyvmTvCNp344fOND/nZ3G9MJi0gx
         /8ZQ==
X-Gm-Message-State: AOAM532+JzlnW3EvHIXDTrAKoKEYaGNrfApy0SwldSBeI98utQ98H0LI
        sIMrPcSSoPDb7ex8VknV7GU=
X-Google-Smtp-Source: ABdhPJzgDOgfXw9JK8azbDW7zgdkh/TmBzWQYC3OVdiC73Izm7VnyBqSB9ks1x4aSR7N2SPdb6QUKw==
X-Received: by 2002:ad4:57c4:: with SMTP id y4mr23083873qvx.12.1623153202673;
        Tue, 08 Jun 2021 04:53:22 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h4sm2133927qth.66.2021.06.08.04.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:53:22 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 05/14] mm/damon/selftests: Support schemes speed limit
Date:   Tue,  8 Jun 2021 11:52:45 +0000
Message-Id: <20210608115254.11930-6-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608115254.11930-1-sj38.park@gmail.com>
References: <20210608115254.11930-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates DAMON selftests to support updated schemes debugfs
file format.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/damon/debugfs_attrs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index 61fd3e5598e9..012b0c1fdbd3 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -101,7 +101,7 @@ echo $ORIG_CONTENT > $file
 file="$DBGFS/schemes"
 
 ORIG_CONTENT=$(cat $file)
-echo "1 2 3 4 5 6 3" > $file
+echo "1 2 3 4 5 6 3 0 0" > $file
 if [ $? -ne 0 ]
 then
 	echo "$file write fail"
@@ -110,7 +110,7 @@ then
 fi
 
 echo "1 2
-3 4 5 6 3" > $file
+3 4 5 6 3 0 0" > $file
 if [ $? -eq 0 ]
 then
 	echo "$file multi line write success (expected fail)"
-- 
2.17.1


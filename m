Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9DB3962E1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhEaPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhEaOGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:06:08 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA79FC08C5E6;
        Mon, 31 May 2021 06:38:38 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o27so11178799qkj.9;
        Mon, 31 May 2021 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4ZGpG/OoDyFj8zWzsVNZahhh/PU2Xw0WQnYylGT37eU=;
        b=pDt4zE99viBj44AstGjPiszYYAkwNJ4ZHBceFJsKNw59RqyfxitBWkeB5tgx9yh6JT
         a0lAezOFcjqApYXPDF2j6PpwImhBRMvdVLuZN8yymjcUGaY/RFyMoTI67JOdFS9S0Ycg
         3qS6nrgQcO3V1+miRUuzzL8wKvCgUDUspN8GCr4jefBDXiERkyJHha94pMvN8d7MZjBX
         WoF3pWEwGK9xabYfM5TrBMGdE7YGNNXCju3+UvAzdlDMjHmorp8vD5Ao5uM5SxRGUJfW
         59x3AL1Kg575rx/85r76hIYRKws1S2CovOYRjaoz7N1zzgdbrg1m89rpuknisGMI81kR
         JdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4ZGpG/OoDyFj8zWzsVNZahhh/PU2Xw0WQnYylGT37eU=;
        b=UO1UsyjZILVh0MEIbE5yc7lLOsHdTwt/ZolRN6vb7bQ8/S5uUIPJhyhinaZacy5r2d
         EQ7tXZymAEvQbd5LyoKGve0BwwB/juHjtd8gn2qh8DVFxS9vqgq4xeA1qEzCgZvP06Rr
         MxYHgskifR1cDIdSvqcQDqWoHXFtTrA5jQ0FHMT1ASGNAyx0V14yrVWMaBPunwq5Z7W2
         EqDRaMRbOHFzlim51db7g3JrER9w+O+Xd7L/wOpDWdTZlno2fpnnKCvZ7/m7vYz6Wnyy
         pYY4b7QauEBPy6ovC7G99QA9Gy56tXHOuTXHcR21NbJJ79DBXRwrG7OWNsTiaDs5pTtu
         Mr1w==
X-Gm-Message-State: AOAM531mks4WZVn5HxwJZKyrVd1lNffCqgo7ksv+o+fjrUZ/tjYE+eqI
        dFXcvfZhsCydgE+mU6t/3ps=
X-Google-Smtp-Source: ABdhPJxMxdrq4DGJnXTH3mdDG2L99ni5OtkSmNP5AAdhhXnD2XPKUsLWkRpyhxmlNE/QU8W92vGHnQ==
X-Received: by 2002:a05:620a:165a:: with SMTP id c26mr16569876qko.259.1622468318065;
        Mon, 31 May 2021 06:38:38 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h8sm8293085qtp.46.2021.05.31.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:38:37 -0700 (PDT)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/13] mm/damon/selftests: Support schemes speed limit
Date:   Mon, 31 May 2021 13:38:08 +0000
Message-Id: <20210531133816.12689-6-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-1-sj38.park@gmail.com>
References: <20210531133816.12689-1-sj38.park@gmail.com>
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


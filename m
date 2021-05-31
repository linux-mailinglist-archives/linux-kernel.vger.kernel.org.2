Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADC2396314
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 17:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhEaPFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 11:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhEaOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:07:37 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598DDC08C5F0;
        Mon, 31 May 2021 06:38:52 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i5so11169343qkf.12;
        Mon, 31 May 2021 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AiQc0DD6N2aSgRO8sD4OJ1ER+4IqRjuDkiQMrkgaEeg=;
        b=OWuBw7Xbn46LGzkcPX0maGceNLxP85ho0kEXArJFfMg/NKobMBiLbBr4M/kq/cMcI8
         v8WLNC+VNvTqGqTa36QV90I1ShlpaTBOHeL6BwdCP1fN8zdac79QEq0po1q8dh5oGTNE
         VXJ0mfGlE+vp327I1erikfZR60iBQpS3dvuMzJqElE0jl+01XIQR3Yvlr8ozeQR4Xl42
         LNpkBnaKlCGT9B+k0sIgJiK2njVfvnqVO2PYBA+XWqhz9PVH+Tg4MDUm45jHeYKlyYCE
         42A+6ztlWjn6bYu2DJYDDjxXhPqqRFrNE9pU6bt1rhr/QDqAJhkhfEK59m8HcmYzRDuE
         l9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AiQc0DD6N2aSgRO8sD4OJ1ER+4IqRjuDkiQMrkgaEeg=;
        b=d1wRG2dupK0ZYh+6kbUeimsH5NaU5XIj0qPkV8h4bYQ6aWQ467SUP4fhsJzOvgxFPy
         ZiKrSSkPFcV+09MEjVPtqksML2SzJ47wfN+p32srRYq2Derl8YrFos2YoAw062Ka+64W
         0ylaBO/qLS8pBCbzuNTQzE+vDHGseRiYEQrfDQ398GyFlTULb+MJOt5KTBDJ1CpxwS/8
         XTx2tASRPSEyiFZ0/2dEOztomatdynF4pA0K2FQaaiu9qE4VyEBS2ReBRmy3ck3dM+e8
         oaucR2vpqkQsvu9waqEkcnzVntWBMYGLirvgkTP2IL9Ozx6ZJjPkitwyGvz/VwXYgaOW
         rTAQ==
X-Gm-Message-State: AOAM530+0zTWCzUKxzHjSgLPRRhdb78oeWBkw1QwNc4cEaKurl1kYOg9
        bkFe1v0SoQjOOys+Nekaz+E=
X-Google-Smtp-Source: ABdhPJyGSnELb7iXcL4G3uA5bSk9wlgE1Vj5P2s0YYjM4HK4RM2gIfGgWOJIm6EyWL15p67XLltqgw==
X-Received: by 2002:ae9:e890:: with SMTP id a138mr5710059qkg.2.1622468331569;
        Mon, 31 May 2021 06:38:51 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h8sm8293085qtp.46.2021.05.31.06.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:38:51 -0700 (PDT)
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
Subject: [RFC PATCH 12/13] selftests/damon: Support watermarks
Date:   Mon, 31 May 2021 13:38:15 +0000
Message-Id: <20210531133816.12689-13-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-1-sj38.park@gmail.com>
References: <20210531133816.12689-1-sj38.park@gmail.com>
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
index 262034d8efa5..90440cb3aee8 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -101,7 +101,7 @@ echo $ORIG_CONTENT > $file
 file="$DBGFS/schemes"
 
 ORIG_CONTENT=$(cat $file)
-echo "1 2 3 4 5 6 3 0 0 1 2 3" > $file
+echo "1 2 3 4 5 6 3 0 0 1 2 3 1 100 3 2 1" > $file
 if [ $? -ne 0 ]
 then
 	echo "$file write fail"
@@ -110,7 +110,7 @@ then
 fi
 
 echo "1 2
-3 4 5 6 3 0 0 1 2 3" > $file
+3 4 5 6 3 0 0 1 2 3 1 100 3 2 1" > $file
 if [ $? -eq 0 ]
 then
 	echo "$file multi line write success (expected fail)"
-- 
2.17.1


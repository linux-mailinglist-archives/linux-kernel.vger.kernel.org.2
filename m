Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E42A396303
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhEaPDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhEaOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:06:37 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB5CC06123B;
        Mon, 31 May 2021 06:38:46 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ez19so5514618qvb.3;
        Mon, 31 May 2021 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D58QvjfAEUuFa2sQo4m4/NULizMsxON2k/Lqjog3pKs=;
        b=Sb5wlROKyGa7ebc1TSnHZiiEM0GmUVztuPXQFadnTpfDreOGmYiXxd7GPuD8whOaqs
         BTHrkCniBbgJlycI/rvrdQgouNSSKtFcYriG6eptQ24PfIWugVPPPu5f6BPfApv6RyHK
         AC5wnh6h6fGtk9Ml51vRhpDggZ8cTyCFTQyszpkp0uwygCDJEYsQbLEEImOEtGXHcCyp
         pi2QECksebCF7lJTiCKS7VyIkEd6yuAd06i1+d+QfFbY2dfw3GhlBmtHUkMXl6C0Dayx
         vVWL2YhicDgRXzNXMbdegWLokr6K7xGrpYRxyZdi4eAQKiWBekWSD9ha2GMuWTPrxMDK
         Oraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D58QvjfAEUuFa2sQo4m4/NULizMsxON2k/Lqjog3pKs=;
        b=ht5zWlaBrO07eLoyW51iEZmFQHjZUURxWzpDo7OYYAZtYxZYSoY9gA2IJflPwkvKdR
         cAWBIs1GCp8u/pjXYJ9KLdKHm4+Dlr2DBH+GzUCgQAZ2U2EM7YM8CPchG1iSTggiqJNV
         2Alv4bC7XvwyyaMVsMUiTSNnKhKF8Cf3eRpEdDoceiCkM5FSwW6KMUr0syB3Go32ag6J
         CNQgszYe0/yEplzzYg1DEjWvc6kswCell0HzUX8MKJmW5Sht7wP449Uzl0ISrpPgGgi0
         CcffCloaipLVkXYF76qBA9zu4QiPErB0fMmyAi2S0bJHrI4IyXi1V88OufFa6HA46YD2
         Lqgg==
X-Gm-Message-State: AOAM531Je/FxgJb6zIUwvwQLZZmV6dg/CVW1AFS5GJ2066V0EqmqSa0t
        SqSG2dL8oGFXMGzgYk1WFDU=
X-Google-Smtp-Source: ABdhPJzYr1lC/HnAn/6hbJ1bN8omhDutmVuLbZzqnsrWuI/uBGV6yhXg3p/7ntVvun0ZPb9g0IONQw==
X-Received: by 2002:a0c:9e50:: with SMTP id z16mr14961287qve.31.1622468325835;
        Mon, 31 May 2021 06:38:45 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h8sm8293085qtp.46.2021.05.31.06.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:38:45 -0700 (PDT)
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
Subject: [RFC PATCH 09/13] tools/selftests/damon: Update for regions prioritization of schemes
Date:   Mon, 31 May 2021 13:38:12 +0000
Message-Id: <20210531133816.12689-10-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-1-sj38.park@gmail.com>
References: <20210531133816.12689-1-sj38.park@gmail.com>
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
index 012b0c1fdbd3..262034d8efa5 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -101,7 +101,7 @@ echo $ORIG_CONTENT > $file
 file="$DBGFS/schemes"
 
 ORIG_CONTENT=$(cat $file)
-echo "1 2 3 4 5 6 3 0 0" > $file
+echo "1 2 3 4 5 6 3 0 0 1 2 3" > $file
 if [ $? -ne 0 ]
 then
 	echo "$file write fail"
@@ -110,7 +110,7 @@ then
 fi
 
 echo "1 2
-3 4 5 6 3 0 0" > $file
+3 4 5 6 3 0 0 1 2 3" > $file
 if [ $? -eq 0 ]
 then
 	echo "$file multi line write success (expected fail)"
-- 
2.17.1


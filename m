Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC839F5BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhFHL4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:56:43 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:36744 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhFHL4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:56:38 -0400
Received: by mail-qk1-f172.google.com with SMTP id i68so16231188qke.3;
        Tue, 08 Jun 2021 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D58QvjfAEUuFa2sQo4m4/NULizMsxON2k/Lqjog3pKs=;
        b=ShuEUzDpgEGR2MxV12KhZZRzCcu1EdFYf3mzV5BCeU1K6sktfwuBpq3jXPok+eJYfP
         Wag9ue5iMXqj96twwC5Pp1lfV6Wo7cFpfxfknl83s4ZsoRm4+00TbMdo6eXh73DZY4xv
         RyBF/QOH79FLuYYiwrROMm0FbnB47S69UIkNKePmXmjc86jwCM5Aj+BIcZAWYYkOHwt/
         oAbrRlBqpNsnWodJXJMVE4Nkgin/tg49WmLvzSVkhkourZ8PqVS+A6O44PtJE04+P/Si
         W81wvhAAJp2es8cdX5Q+MS7G91Tm26cX+N3TXWt/aKWggARqaMQ4XIfz0vZrBpdExjwt
         165Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D58QvjfAEUuFa2sQo4m4/NULizMsxON2k/Lqjog3pKs=;
        b=URd60yaYhckJwIbLDFONnfXEG8l/8RzPKm0ZqAUCKkWZ7LFqFnvJXEf0PXjUWjag4K
         vJjpIiUGcxMeXu+Q7AI61Nz/7Y9pouuD6IbrbKk84BsvrRQFRRZtkYh6HMq+65MgYB6D
         UEO2BXFP6dCE2dYxnHwYOiXMOiwuNokAMZbeJYnVYkaVJCm9cvNcgQ0+bdLBvyR1HiTy
         au5PSaFadn0z0fG8d7tGI/PCaMyGxCceWxm3gpzvhzIFaDDYSuuTuLWWhCAQFpGFzb9z
         HUpC5jeDiPCAxNH/+yFVB/6vg0V/HxaS+lZ3b5YY5SRpKxRiAnS3vT3+uvmoq/u7mEwI
         fipg==
X-Gm-Message-State: AOAM530fVLlz+/9Af2YDdSkoOXLqIq2o3AAGwQ6WfqawnCirvBte2dXT
        awFgyXIGUdBE84FzS+PBbe0=
X-Google-Smtp-Source: ABdhPJySXLhnY1lAPd5sDJ+FjzYt3zkT5ln+T3NwujiPhhhQ8CUb3OuZ6Hz97KH4ZYFpjvEbU5PK9w==
X-Received: by 2002:a37:43cd:: with SMTP id q196mr426583qka.486.1623153211595;
        Tue, 08 Jun 2021 04:53:31 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h4sm2133927qth.66.2021.06.08.04.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:53:31 -0700 (PDT)
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
Subject: [RFC v2 09/14] tools/selftests/damon: Update for regions prioritization of schemes
Date:   Tue,  8 Jun 2021 11:52:49 +0000
Message-Id: <20210608115254.11930-10-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608115254.11930-1-sj38.park@gmail.com>
References: <20210608115254.11930-1-sj38.park@gmail.com>
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


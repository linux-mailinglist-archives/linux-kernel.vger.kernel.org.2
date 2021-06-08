Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A95D39F5C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhFHL4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:56:55 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:38864 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhFHL4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:56:43 -0400
Received: by mail-qk1-f179.google.com with SMTP id c138so6940417qkg.5;
        Tue, 08 Jun 2021 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AiQc0DD6N2aSgRO8sD4OJ1ER+4IqRjuDkiQMrkgaEeg=;
        b=k5//IFbGlIuVgYSa6FzehkG51crKgMNwddzs48OKNhdq41KBFjeAc+d7IqqQanR+0a
         DKyHTYSqwqOVCjiW+0JrTEJe4UI1VVQxU3hEaZJaD6Y2QVZexa/U0m14kDJ0B2M/Q5E/
         PSFiG/H3D3E8jZX+0LrBj147VcDHTkjLwXBv6e18EhssO1JyUiaGZddqu/ucyXDZE/Sc
         Dt0fSbVBy3JQp3tHob9U22nwtWx7uAtEtHu6eUudqNySnSwYq0jgAWMn48oz/b6r0EnT
         Upae5mE3BZS4haahHto74ofLD2O3ePKTvj2OCusuWHSSp4R0rt8pCqCTSMtFtlH0DVJw
         PG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AiQc0DD6N2aSgRO8sD4OJ1ER+4IqRjuDkiQMrkgaEeg=;
        b=Vuxrp4k9+oKMI5XwH4PuSEuofiFsr47p9qU/mfC5NooWToPxMWMVmSM33258d4Njdq
         2OIsf3R0PyJmOTSK9GElWxaexwLGkxtVcB9Xqe8sG2tAfljRrBXaIF5L23JrcEQ396eW
         osIdl2ukOb59KZo+jvrei80/6fdq8bPQ+otHyC9OkaVhBPDPV2BKs1MLMc1mN+7sY/yL
         PCeDpNujGRWfWGcpCoFe1iBYZQHvcWoxaHs8wXsMmKz/r8jwxOvpltpxvyxngKbjlP9q
         le6GA5jyo4UQqJr9CEV6O24A33dgMSO2qyJVBj51Yg19eCS6r9+auFhEin8m8XS/e2zh
         8svQ==
X-Gm-Message-State: AOAM531NytjGsyU05dscfM2/W8Dalms1tTetnLwtYMut0Br7fH+3UCuJ
        G5DE1z7ndAr1v9bnLDtYzn8=
X-Google-Smtp-Source: ABdhPJxDkNGIe9IynLDSfOi1J0bg0wZyaqtIp1Vv08ZHqor0JrhzLD/Dfg735w4QdgnUypSVRdqjsQ==
X-Received: by 2002:a37:a143:: with SMTP id k64mr19898791qke.356.1623153217698;
        Tue, 08 Jun 2021 04:53:37 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h4sm2133927qth.66.2021.06.08.04.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:53:37 -0700 (PDT)
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
Subject: [RFC v2 12/14] selftests/damon: Support watermarks
Date:   Tue,  8 Jun 2021 11:52:52 +0000
Message-Id: <20210608115254.11930-13-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608115254.11930-1-sj38.park@gmail.com>
References: <20210608115254.11930-1-sj38.park@gmail.com>
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


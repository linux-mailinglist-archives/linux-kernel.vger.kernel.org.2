Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484FD3AA7A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 01:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhFPXr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 19:47:56 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:40958 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhFPXry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 19:47:54 -0400
Received: by mail-ed1-f45.google.com with SMTP id t3so1376860edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 16:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzUMEQYvL+jhpMNshqeqScu9YLr3Zn9hu3v/FgDxduI=;
        b=GqNaJDs7NF5y8MMYRk6VM6gJTNtNSxpiBe/5VTKUZnxWUSE7O9Lbysl4fGcskAQTpw
         UbfpfUPTwleYoBIJ6p4zcbqPdsCMByaH70s1KYLVvQCzyuazJXIiaX9W5081+W119ofZ
         JW9dhZO2yzXzeRWtY4gEVV8PUguzXuNKd4bhqMCA0fhvkMpnJWPh9/g1TvKGGinvDLoi
         aoJhqyliiC0xEEKpgt8ARCNEEyo6sprOGXIh55AmGXmZnzevpP2hBt5jsxkTENwGCdgf
         SJqlfA8n38396+Rwv7dWNWqrZ28+qWoX+0AIRtiav3htZPN53NIY0mXeb8vi3tX3637L
         JYuw==
X-Gm-Message-State: AOAM5332eNMqFpMHFUyS9rJf8mdznRNtPRiKvcmDq4aQIhdfE9u2/mKw
        jIQpa1lsPHRux1KED9tBcLaS3OtB4yg=
X-Google-Smtp-Source: ABdhPJxNkq/RRITmZzJrhMO1pMYnrWVhYbCMJ3YuzHDmnDA+NQCUx8Ftil7Wq3KjsxectgvGHYprKQ==
X-Received: by 2002:a05:6402:220d:: with SMTP id cq13mr2726895edb.52.1623887147299;
        Wed, 16 Jun 2021 16:45:47 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-37-119-128-179.cust.vodafonedsl.it. [37.119.128.179])
        by smtp.gmail.com with ESMTPSA id f4sm170875ejj.49.2021.06.16.16.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:45:46 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib/test_string.c: allow mode removal
Date:   Thu, 17 Jun 2021 01:45:03 +0200
Message-Id: <20210616234503.28678-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

The test_string can't be removed because it lacks an exit hook.
Since there is no reason for it to be permanent, add an empty one to
allow module removal.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 lib/test_string.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/test_string.c b/lib/test_string.c
index 7b31f4a505bf..9dfd6f52de92 100644
--- a/lib/test_string.c
+++ b/lib/test_string.c
@@ -179,6 +179,10 @@ static __init int strnchr_selftest(void)
 	return 0;
 }
 
+static __exit void string_selftest_remove(void)
+{
+}
+
 static __init int string_selftest_init(void)
 {
 	int test, subtest;
@@ -216,4 +220,5 @@ static __init int string_selftest_init(void)
 }
 
 module_init(string_selftest_init);
+module_exit(string_selftest_remove);
 MODULE_LICENSE("GPL v2");
-- 
2.31.1


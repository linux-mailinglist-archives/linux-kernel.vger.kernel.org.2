Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA30355A64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbhDFR3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhDFR3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:29:24 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10886C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 10:29:13 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a7so10868429qvx.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WY0464vhNIAqC43+lzSsh1rIIOgxPL3xjkkDU85detM=;
        b=oZ47kUX5UpS/DRNaxvnO4zZQuUVqPvuA8SmZoN2qvnLnvGH5ndNl4e3FnQuzOo1Cep
         NwSl3wscmcWjKwFetit7h0p4snRkgV6WQ3eiaZuSWLTrMC2PEkzXtsRJO6iZCAIX/lsc
         r9ZyON6I3Wehbn1RvprrziaZ68DmiH/Jp6ONZFM4nEXzTU0rx8NGylKh3oSoM0KsxECT
         UQ1hkIR3H2QXHTJ8uv6Iifwl5JQ4FgoO/AHzDtOD2jsgu8RgEOW4WTa8hZ4GigzEgOYw
         3qp6BJpOJMRpmzeuMbryjoYond/h/TzNC4cvHQtTF/RHJiKpwvISsDrK1DChn0OpEZ7x
         OEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WY0464vhNIAqC43+lzSsh1rIIOgxPL3xjkkDU85detM=;
        b=q3w2R5XdCK2SoSGnOQ+WOZnt+QC3XQQsAWgVa1hBQUObRJHU+eZvTSyRVvRxQoWiyN
         QoZtBhCA0GqSabEU2lq+AD+PbjKMsBrJM9hK9zG2Itsx6TkYN3LziokGJ+SmFM41O++1
         zr/tTLc372q7iC7iAtb3n4T+TFsilG6dZ5gDg2utnJujZEZUb6oUlP3N5dzznVzelCnE
         61A3DsaONNAZV7u+dk38k79Xud9fGwpW5h3efJcyUw9YUGQ740MGH54cgKg8cexnZxVe
         a9UV76qSBsvcflu2qe6jFNu8beMWq7upz82eKOVv7aouz3vTiAEGLF3U6YFBJ1UDIWdD
         y59w==
X-Gm-Message-State: AOAM533fMuJmbhVU+NbnKr+l+hdvHkf0xV42StE7irYBEC0Y6o8VbhD3
        Ab/ZTcMZGJ//3Pw1+86x9fVrAbQqBNQcmg==
X-Google-Smtp-Source: ABdhPJxdmWDI96bW/cZQgF/mseMZzpySOdCyNYQZi+codgvKD9VoLUMuszsRysUf4TqmolAWryPCgaBvC44y2A==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:f46d:9fde:7b0b:e01a])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:d65:: with SMTP id
 5mr29702299qvs.56.1617730152184; Tue, 06 Apr 2021 10:29:12 -0700 (PDT)
Date:   Tue,  6 Apr 2021 10:29:01 -0700
Message-Id: <20210406172901.1729216-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH] kunit: fix -Wunused-function warning for __kunit_fail_current_test
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, sfr@canb.auug.org.au,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_KUNIT is not enabled, __kunit_fail_current_test() an empty
static function.

But GCC complains about unused static functions, *unless* they're static inline.
So add inline to make GCC happy.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Fixes: 359a376081d4 ("kunit: support failure from dynamic analysis tools")
---
 include/kunit/test-bug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index ce6f6edc7801..5fc58081d511 100644
--- a/include/kunit/test-bug.h
+++ b/include/kunit/test-bug.h
@@ -19,8 +19,8 @@ extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
 
 #else
 
-static __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
-						    const char *fmt, ...)
+static inline __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
+							    const char *fmt, ...)
 {
 }
 

base-commit: 359a376081d4fadfb073e3ddeb6bd6dc94d98341
-- 
2.31.0.208.g409f899ff0-goog


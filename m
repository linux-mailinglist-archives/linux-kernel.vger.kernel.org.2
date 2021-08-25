Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690DC3F73CF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbhHYK43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbhHYK40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:56:26 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944CBC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:55:39 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id u14-20020a7bcb0e0000b0290248831d46e4so1778438wmj.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FT34ZQ0Ankpx01UihRk2kfWuKXz7jz0lwTbW9XPKkoM=;
        b=EmPROQ7nz/pu/qgiO2t2bijHUR+Q/OThafpTk4NCpu0jFMJ48jvwy6gtN3TTIXusXw
         l9EH2nSd1lWvOMCxUUBHxv4CpdCYj2eeyuiNTQ2pFAYJ08MRI0qBCZ49rpsDbgkoUa7A
         MiKttpVTrZ7dDTnjOy5rdtXyBvgNdFH0MOsy0o+gEIjDFqLT6afw3oOBi3ppF+acGutW
         0hVcSzySLhRochEnevooivVK6jsOjAKPzQS87uM0qEidjlELbKPAGMrks//Tr+hLkOmJ
         Zh67h+99c9wpR84EWUBwCCTxOuNZiQDwzvAg+v30WraHBzN2w9sgw+ZhUKAXUhZtqQ4F
         hHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FT34ZQ0Ankpx01UihRk2kfWuKXz7jz0lwTbW9XPKkoM=;
        b=Q+sZ+ekvdiOL4D2IO/qE9AOsVjBCAWUKUqCkQ72WDFnFI+jox8WoKKR84FbVTgQCSg
         ZtV4Nso/JpTpc82QaNJrfM9O8nUNM0bTcRDTiKDNtn+e5j35tsfq/EM1mtKtMjwwb1hJ
         V/PL9SH5jdCLSkXkuQBPhNRmhN+FtffQ66dhoLCcn2LGYgRWPVLHsJPQpm16RgtBY7Il
         6uBkgPz5Vd9gkCqLVv0KQt9S3mMT9BSZgnfTbo1mvo9wkn6qjfiwMmnMdNu7dpzRS82b
         rPzkyfk7B1QTgK85CA9IAk6tr3XJ99sXdXdrXT2sR0WvQKg24uDczFGugu4VsmNOVrvH
         sT4g==
X-Gm-Message-State: AOAM531bmxPxsYdj/lbEGXdg5OHDpKQY/FPTV6kJL7ye3AqWZRPK0Rlb
        mCnIk8t3Caq4WS0c1VASh9p5/MNyVQ==
X-Google-Smtp-Source: ABdhPJwjv+hvsAexdUgXkmtXRGs+/Rg39W3ggk80Z2T4h/fTl7Zd2bQJnR16Dpt76+ox6JnqCUof/Y/31Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:2fcd:1452:4b71:155d])
 (user=elver job=sendgmr) by 2002:a05:600c:3b0d:: with SMTP id
 m13mr74661wms.1.1629888937741; Wed, 25 Aug 2021 03:55:37 -0700 (PDT)
Date:   Wed, 25 Aug 2021 12:55:33 +0200
Message-Id: <20210825105533.1247922-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH] kfence: test: fail fast if disabled at boot
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fail kfence_test fast if KFENCE was disabled at boot, instead of each
test case trying several seconds to allocate from KFENCE and failing.
KUnit will fail all test cases if kunit_suite::init returns an error.

Even if KFENCE was disabled, we still want the test to fail, so that CI
systems that parse KUnit output will alert on KFENCE being disabled
(accidentally or otherwise).

Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/kfence_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index eb6307c199ea..f1690cf54199 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -800,6 +800,9 @@ static int test_init(struct kunit *test)
 	unsigned long flags;
 	int i;
 
+	if (!__kfence_pool)
+		return -EINVAL;
+
 	spin_lock_irqsave(&observed.lock, flags);
 	for (i = 0; i < ARRAY_SIZE(observed.lines); i++)
 		observed.lines[i][0] = '\0';
-- 
2.33.0.rc2.250.ged5fa647cd-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4C23E44BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhHIL0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbhHILZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:25:59 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358A6C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:25:39 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t9-20020a0562140c69b029033e8884d712so12086458qvj.18
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8ypZsLoKbz6m1Ndv9rBXLhnIYaRjGdKDRIRf2rW5PW4=;
        b=eY1798OexF+BrXNULTZ+O3OY1VEElBrA1P4hpGbuIDV502XN1Fnqt9jgA8PBe2n/gn
         cu1tDsf0xbatDgaXWFlE5ZDv5uvo8ONX0jx4YnWMys3/8HwwAcRYlzzab3DHL7eon1dn
         xU4vNAO/gvKP9ylObjkkKKicIVGpp8rkBVYC3k8i1p8AYgHaK51MAZHw2nR+9Rly6Eo+
         /57Oows05J9VtL2eyltfERSD1iRHpNnkuTm3rKFe1DCzNQs0WMJhcpJ5Zs6F1OhEjDfs
         wqaJJoZA4QT5THrv58DqgsG0LqsjJCngQXWK8+s/CVPBXhVGQ9u0SEnjj9lxtKbLp8/4
         n84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8ypZsLoKbz6m1Ndv9rBXLhnIYaRjGdKDRIRf2rW5PW4=;
        b=dzegPCgqFTpnWnL6a1W+A6OSCGPcea0HYlCUc0UMuRwvReCYTHyr8gu/m0JE/qDfzP
         nOQArFE4oX8A8bUl2vfXJ1fXldIdE0xnB7fX1VE5IyIrDugQJj1GULYDltmyB0l+CzyB
         zRJU/3atPdK94SjQiM1DijHiQ1Ck1xl88z4Y+D5ZQKDpvJQZjrLrtDQvRaThBj/PCalS
         eCSKpuESi+17Kem/Or1O/i/fxna8qZs+LLOkygzJr3CClh/BlEPtTbFda8jI5a4gecrr
         auMVvfa/+TlUnR3jj9fs4EgGNbR4VuHeoMciQgnp3NE2vvgXRlTiifxMLlogcWVP/ujf
         E6Ew==
X-Gm-Message-State: AOAM531GK/Ht2Vuz4/z+jU5A11/8+dpPdJIDUg10XoCnZVt8F/YvyOnT
        Yo06Y/cEka+y4Io4GzV84gp726/aCw==
X-Google-Smtp-Source: ABdhPJzn7Cxi1EeMa2u+N2uTTp9NlJ4JDhkDuZ91J2XBY2ME17CSxpGOHDt0eXy+ydWzJQ91WVr8TlARpQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e5a3:e652:2b8b:ef12])
 (user=elver job=sendgmr) by 2002:a0c:c78f:: with SMTP id k15mr11904588qvj.20.1628508338344;
 Mon, 09 Aug 2021 04:25:38 -0700 (PDT)
Date:   Mon,  9 Aug 2021 13:25:09 +0200
In-Reply-To: <20210809112516.682816-1-elver@google.com>
Message-Id: <20210809112516.682816-2-elver@google.com>
Mime-Version: 1.0
References: <20210809112516.682816-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 1/8] kcsan: test: Defer kcsan_test_init() after kunit initialization
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        boqun.feng@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the test is built into the kernel (not a module), kcsan_test_init()
and kunit_init() both use late_initcall(), which means kcsan_test_init()
might see a NULL debugfs_rootdir as parent dentry, resulting in
kcsan_test_init() and kcsan_debugfs_init() both trying to create a
debugfs node named "kcsan" in debugfs root. One of them will show an
error and be unsuccessful.

Defer kcsan_test_init() until we're sure kunit was initialized.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index dc55fd5a36fc..df041bdb6088 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1224,7 +1224,7 @@ static void kcsan_test_exit(void)
 	tracepoint_synchronize_unregister();
 }
 
-late_initcall(kcsan_test_init);
+late_initcall_sync(kcsan_test_init);
 module_exit(kcsan_test_exit);
 
 MODULE_LICENSE("GPL v2");
-- 
2.32.0.605.g8dce9f2422-goog


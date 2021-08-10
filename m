Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B558A3E5A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbhHJMwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 08:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbhHJMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:52:26 -0400
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB9C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:52:04 -0700 (PDT)
Received: by mail-lf1-x14a.google.com with SMTP id s1-20020a0565122141b02903bf02f21443so6515815lfr.17
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=l2S3+Q0TSpzQjgS1IAlz45uFtK7NW5/mPHoPH0IioQk=;
        b=KXQ/QUEEOSS6EHsdr/Xd/9sImhJkV3kgmL5PkQKU9pSnj+3Y3r9ti617iMQhx0atgq
         eISZp/pNNIDCbpEEOHMltrtb+s/Qf4AuV0+zlnaVD1aukES3dsC9vV3Tn4R305E0V29X
         9ZVAZLBIsbVNcBFqyOhlV7/ccvIIuk/2bUlXQrNf7cHFJyYnni/kkk9uBDz1A6q1aA7p
         3VYdgxU88ns/7pYhFq79AWNSs/JH73+ZiaLVIbjplqIS8hWp59kRO34GdpZ8X9YUfCxe
         hy6TZJG0m+qzRigpBqHmDdAiBSv67qhUiUrrbEPKVNT93fh/z9g8EC98d6V4Pzw/BZHy
         MU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=l2S3+Q0TSpzQjgS1IAlz45uFtK7NW5/mPHoPH0IioQk=;
        b=RVvPjA+7xZ0L6q2C8ODZYnc/pKfLTgEJ85ZyQEWvYpjqJV33O/Q2TLzXgzS/453V+/
         2EUcniZ5jUEB9rk6fiadsCQ1gWND9h06oMUksor/zCV+tE+KBGagL9fS0KfVqbVip9RY
         0YWEqASb/KnSEZwYVbBpzwQ4btu5IsDPN2F0igupJDnwaV1lMDvuqT0LdsqJtuwgQOji
         6KPVe6NHf2P/8BnNyBzQyOsxIDTWauxsZ9QJs4bfl9Lz8nG9f79XvqOvu8uN0oUnQWXb
         Y/K5Ti3HMc/LfxzfKGLqNJ4MvQ0jKxDG5wWiUL/RFHncqC2XUNtEGe0bMLoYBIQXTB7i
         JiJg==
X-Gm-Message-State: AOAM5314H1t5oBqx1CEh0zkM+oetfz8ymco3ze/d8E1Ijq6MUevpuczL
        YHOAN91Th0v9F9p5mOQgYGtUe4zr7jnQ
X-Google-Smtp-Source: ABdhPJxjeZzYLXDfdWf1yd3iW87LcCXxOt1DH+tO/jyun0GNzCxilgO6cNkkYhyC3Mm+SmKHnkjgoLRECOX9
X-Received: from wiktorg.zrh.corp.google.com ([2a00:79e0:1b:201:9951:392d:1aa7:5313])
 (user=wiktorg job=sendgmr) by 2002:ac2:5fe3:: with SMTP id
 s3mr21252242lfg.319.1628599922529; Tue, 10 Aug 2021 05:52:02 -0700 (PDT)
Date:   Tue, 10 Aug 2021 14:51:58 +0200
Message-Id: <20210810125158.329849-1-wiktorg@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH] seccomp: Fix setting number of loaded filters
From:   Wiktor Garbacz <wiktorg@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Wiktor Garbacz <wiktorg@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value is only reported through procfs so this
is purely cosmetic.

Signed-off-by: Wiktor Garbacz <wiktorg@google.com>
---
 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 057e17f3215d..6469eca8078c 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -602,7 +602,7 @@ static inline void seccomp_sync_threads(unsigned long flags)
 		smp_store_release(&thread->seccomp.filter,
 				  caller->seccomp.filter);
 		atomic_set(&thread->seccomp.filter_count,
-			   atomic_read(&thread->seccomp.filter_count));
+			   atomic_read(&caller->seccomp.filter_count));
 
 		/*
 		 * Don't let an unprivileged task work around
-- 
2.32.0.605.g8dce9f2422-goog


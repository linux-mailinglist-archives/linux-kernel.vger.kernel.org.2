Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51650376BD2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhEGVco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhEGVcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:32:39 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFD5C061344
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 14:31:38 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b6-20020ac85bc60000b02901c2752ed3d4so6577260qtb.15
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OULdAB7SkAEJ6rQEHGBEyfNQUuilr1kpehp6Rww8NCA=;
        b=me5mS3gfsyZF7xaGkikl8wftRuuZ2OGeAKpzgUbMG/qsFra0W0N8S1KODa6Y6brGSh
         WNnA7TmrDbCabXXI8LZ5E41NAN5pNRNwDSUZcEdq9LoeDSlPWHxFqM8DDjmyngwqFJeb
         Qd/LsL1B+87lenOTJVGd3dIFeR0hJAb6m7yKHz6Ff7KNudGql7/B2VGuog25apXTCqnk
         701ebfMb4CuF1CVSuYBrBOpouUpboiIkW/Fa+1bvRVzIg/Yjla8YBFB+UgXkVowK+lcK
         uST+GIeh4l9btt3gkyCzCyIkikPepD0zoahHPGO1sj2aTXavSt3B/+TB7zhSWhIRlPsO
         +bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OULdAB7SkAEJ6rQEHGBEyfNQUuilr1kpehp6Rww8NCA=;
        b=sD2i9FFezJZHLyHNEa8YJIH6gZchr726nm4tlAlfDTLhxeSjU0/uJiU4hoB7sU192n
         7TAlBoMm/weOqJhmBBDVT77LbHwC9jjvWBTI8G4ui94wJZieAc+Y/WlvjGivz5nuPDEU
         4WHbqz+KZEaQDHR2cV1J80Y09D+ICC2RcZ0uK+hkueT0cGC8c4u8erM39Xo1tCj/tRae
         lWvOjWu6OlxZ8aUV7NcQAco6dF7nJ9hVxMWP7VmQ3IHfDVb/SOfHS0J9HfohhwSbhtzC
         rUbs9bi9V1pGeznjRufLPuqmVm+XEf81jkUrU000tA4YNEx9MrSHy5iW+eJxdJ/e1FQE
         E0ww==
X-Gm-Message-State: AOAM531BNLlzvG7vgv7nDNaRctXfcDrBA5ALSuEa6JxGrxW7nnMjW7C5
        jjHFq6tEt4DfNqmQNxAcr31c8Kr14p+4dOSgQW9IyA==
X-Google-Smtp-Source: ABdhPJwd63PkgSe6ku7lXnqxyN58PmTRRyHarAj8aC3AIuHh7xaK+l2IwwFYYBvTOCikWgPsZmwm0YSUR1eyHN7JtT9K1Q==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:8b7:10d:a11b:ba0c])
 (user=brendanhiggins job=sendgmr) by 2002:a0c:e54c:: with SMTP id
 n12mr11957692qvm.25.1620423097425; Fri, 07 May 2021 14:31:37 -0700 (PDT)
Date:   Fri,  7 May 2021 14:31:10 -0700
In-Reply-To: <20210507213110.155492-1-brendanhiggins@google.com>
Message-Id: <20210507213110.155492-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v1 4/4] Documentation: kunit: document support for QEMU in kunit_tool
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, sboyd@kernel.org, keescook@chromium.org,
        frowand.list@gmail.com, dlatypov@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document QEMU support, what it does, and how to use it in kunit_tool.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 37 +++++++++++++++++++++----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 650f99590df57..b74bd7c87cc20 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -612,14 +612,39 @@ only things to be aware of when doing so.
 The biggest impediment will likely be that certain KUnit features and
 infrastructure may not support your target environment. For example, at this
 time the KUnit Wrapper (``tools/testing/kunit/kunit.py``) does not work outside
-of UML. Unfortunately, there is no way around this. Using UML (or even just a
-particular architecture) allows us to make a lot of assumptions that make it
-possible to do things which might otherwise be impossible.
+of UML and QEMU. Unfortunately, there is no way around this. Using UML and QEMU
+(or even just a particular architecture) allows us to make a lot of assumptions
+that make it possible to do things which might otherwise be impossible.
 
 Nevertheless, all core KUnit framework features are fully supported on all
-architectures, and using them is straightforward: all you need to do is to take
-your kunitconfig, your Kconfig options for the tests you would like to run, and
-merge them into whatever config your are using for your platform. That's it!
+architectures, and using them is straightforward: Most popular architectures
+are supported directly in the KUnit Wrapper via QEMU.  Currently, supported
+architectures on QEMU include:
+
+*   i386
+*   x86_64
+*   arm
+*   arm64
+*   alpha
+*   powerpc
+*   riscv
+*   s390
+*   sparc
+
+In order to run KUnit tests on one of these architectures via QEMU with the
+KUnit wrapper, all you need to do is specify the flags ``--arch`` and
+``--cross_compile`` when invoking the KUnit Wrapper. For example, we could run
+the default KUnit tests on ARM in the following manner (assuming we have an ARM
+toolchain installed):
+
+.. code-block:: bash
+
+	tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --arch=arm --cross_compile=arm-linux-gnueabihf-
+
+Alternatively, if you want to run your tests on real hardware or in some other
+emulation environment, all you need to do is to take your kunitconfig, your
+Kconfig options for the tests you would like to run, and merge them into
+whatever config your are using for your platform. That's it!
 
 For example, let's say you have the following kunitconfig:
 
-- 
2.31.1.607.g51e8a6a459-goog


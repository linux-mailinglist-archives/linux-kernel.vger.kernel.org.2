Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6234B36F170
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbhD2Uw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbhD2UwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:52:12 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE66FC061348
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:51:21 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h12-20020a0cf44c0000b02901c0e9c3e1d0so4083539qvm.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HDU3fipI2jIYDh7sBk6Haj682lgh4FX1OTAOz5rXBjE=;
        b=VeNMi853XgTR4ZwjSKWeWZuMZT/uXhbsLUHgqCEBiTm+tUFXgXnoASbHoG35P5WbXc
         SzDwqVMcH6jW1fHi0TwZ9me6Ro1qBgGgGypMF6UkWVgyAHRlTpASDKwZ9f8cXFayswQr
         7+zODIxeNotj4t6CnPVzIxySK3W5YTet/jQyRV0mwQHOJub3U0rDuOE7t1COGeTSQwz+
         iAqgKrVHTX3oREq8abD1LJhHq8usujK5hQYp2jb7n28twW8+G+nASLqSxFFpT5PrvAcF
         YBqWduQpYUfpHDiEkmuaNrMvuMkwFC93KmWaFXT+3ojNYK9kla53DVD0EHLbjaam15lm
         EVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HDU3fipI2jIYDh7sBk6Haj682lgh4FX1OTAOz5rXBjE=;
        b=mVwF7goW5si8LNITOT5045XfNzCUIHSg06cAAgSLUcV2XyaJ9nWgodTszaEyWm+Y3N
         dDV9bazwOs111K1nV8qoltjqm+Bo9ysiQoEvSnSIG+Wjn2NTIxuuRuN9QvgsybXY+oiC
         jk77sSPMS++uclMOBVmGobiklPfQBez/Tm06678uXKfO0ryOu2krTWd5rd14xTMajulR
         57ILsf9E2sdbw/S0+l2SDesbAEnpmteQRkZn+os1Cnt5LJ90G+fij2BzOwKSJFWC4XrB
         fgP+kH7+LUb3hcDLttGSnk5G+ayMVjxkIFM66jj5+zc+LzCajRK0jyGrKVwWGUBbD8pG
         9O1Q==
X-Gm-Message-State: AOAM531B9sstMkjI4UxeL5008PEwN2OH5AAYh/B4lx9gVYvqK9LNB+Hq
        ITTqAV+NiFEQhjvI/ReHFClN0eccPDv5H7JkNEdX2Q==
X-Google-Smtp-Source: ABdhPJyczsqt0L1kdH5oIPdV6BbHXgNmTZ19a4myQKyLHjLLIPiLuVdM3HOvyO/rJh9EfN7C8i5Q/JqxLoPeuUqu81n1+A==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:bab5:c64e:5a6c:36bd])
 (user=brendanhiggins job=sendgmr) by 2002:a0c:c20b:: with SMTP id
 l11mr1999080qvh.1.1619729480971; Thu, 29 Apr 2021 13:51:20 -0700 (PDT)
Date:   Thu, 29 Apr 2021 13:51:09 -0700
In-Reply-To: <20210429205109.2847831-1-brendanhiggins@google.com>
Message-Id: <20210429205109.2847831-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210429205109.2847831-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [RFC v2 4/4] Documentation: kunit: document support for QEMU in kunit_tool
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
2.31.1.498.g6c1eba8ee3d-goog


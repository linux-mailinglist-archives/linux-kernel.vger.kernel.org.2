Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE46392200
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 23:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhEZV0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 17:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbhEZVZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 17:25:55 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765D9C061761
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:24:22 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id h7-20020ac846c70000b0290231af0e7829so1492113qto.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NCrgWD9y8dgxTwWaAeztMIx9ZvUPVidLmF2TLjSwzOg=;
        b=QslW7nZ2jdLCUQI6gauB+dNQdZU7thGetMHlphcJ4qWFxSlzyFs0cyd2icaLOL+cIE
         NTMAlx4YcSYUoYv0Ab0IJlaKT9+3YNxyXvCHAeL/XEKUqO3qNAVG7qGqsz+Pa+P6ZG23
         CBZeDO7hllQZx7dwUBkb4v1HdHi+7wsh7DaBF1in4YYdEx7kCN7YGtl40GWnKj3NeVtI
         IARdQo13n2lDu9qN5g2LeMJtSbNZGuBB9IuhVVPkSWSokmE5q8KOkcMgGY0wIE942I+U
         vdw3J7Ep4MwOv3qSV2b1cGaPnU03B3RetgNcnyB52UiA+GytXhhLajuR6aDcgUf9wbHx
         HB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NCrgWD9y8dgxTwWaAeztMIx9ZvUPVidLmF2TLjSwzOg=;
        b=NrGcdi8WgOT7mZ0FbYAUTfg9kD2tdQLSERNl8FghK5AZ0poitauqOKpVK3ol9oiUJI
         kBeXY/67SIzc8EaPay5on5xyD7kr1Od2zVaIey7j/3wBq29IddsADIJufl563rBiSbHf
         Dz8JIsxhg7xnx2dy1c6VDRjH0474OlDcMZt2cJGr5xV5gqcEOeaNEH7ccHmHidUort/3
         0fxJY+YNPyB9+qFBXhxloEsVF6TtZK81PAtjubbgzE9WDmD6CScwDXGC5koMWeNJB0sf
         7+MIDHp/pS0Xu4owyVyMNVyUCPYm857VLmRkx3v6dOXuFpUVIMJlOoRzFQNA9bC8G3pz
         NOPg==
X-Gm-Message-State: AOAM532ucVwF4Xq2ASmbXK7lXy8XxggrWQ+/V0eIat3i67l+oYIOPC+/
        GSsqascYZ2Pe4vC3URTc4Pw1B6Hi836t3ZgxzQPunQ==
X-Google-Smtp-Source: ABdhPJxv6M7g009JuA7jLC1HoD7yTESGd26LatW6n6shfJQerCtPbU+23cwdBxZQDYcHzg7K2EUC+ZfD4K52krxhKpAUPw==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:2a22:5aa3:3643:4ddb])
 (user=brendanhiggins job=sendgmr) by 2002:a05:6214:212f:: with SMTP id
 r15mr390267qvc.11.1622064261597; Wed, 26 May 2021 14:24:21 -0700 (PDT)
Date:   Wed, 26 May 2021 14:24:07 -0700
In-Reply-To: <20210526212407.2753879-1-brendanhiggins@google.com>
Message-Id: <20210526212407.2753879-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210526212407.2753879-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2 4/4] Documentation: kunit: document support for QEMU in kunit_tool
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
Changes since last revision:

- Finally, I added a new section to the kunit_tool documentation to
  document the new command line flags I added.

---
 Documentation/dev-tools/kunit/kunit-tool.rst | 48 +++++++++++++++++++
 Documentation/dev-tools/kunit/usage.rst      | 50 +++++++++++++++-----
 2 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index 4247b7420e3ba..c7ff9afe407a5 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -145,6 +145,54 @@ to run KUnit resource tests, you could use:
 
 This uses the standard glob format for wildcards.
 
+Running Tests on QEMU
+=====================
+
+kunit_tool supports running tests on QEMU as well as via UML (as mentioned
+elsewhere). The default way of running tests on QEMU requires two flags:
+
+``--arch``
+	Selects a collection of configs (Kconfig as well as QEMU configs
+	options, etc) that allow KUnit tests to be run on the specified
+	architecture in a minimal way; this is usually not much slower than
+	using UML. The architecture argument is the same as the name of the
+	option passed to the ``ARCH`` variable used by Kbuild. Not all
+	architectures are currently supported by this flag, but can be handled
+	by the ``--qemu_config`` discussed later. If ``um`` is passed (or this
+	this flag is ignored) the tests will run via UML. Non-UML architectures,
+	e.g. i386, x86_64, arm, um, etc. Non-UML run on QEMU.
+
+``--cross_compile``
+	Specifies the use of a toolchain by Kbuild. The argument passed here is
+	the same passed to the ``CROSS_COMPILE`` variable used by Kbuild. As a
+	reminder this will be the prefix for the toolchain binaries such as gcc
+	for example ``sparc64-linux-gnu-`` if you have the sparc toolchain
+	installed on your system, or
+	``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux-``
+	if you have downloaded the microblaze toolchain from the 0-day website
+	to a directory in your home directory called ``toolchains``.
+
+In many cases it is likely that you may want to run an architecture which is
+not supported by the ``--arch`` flag, or you may want to just run KUnit tests
+on QEMU using a non-default configuration. For this use case, you can write
+your own QemuConfig. These QemuConfigs are written in Python. They must have an
+import line ``from ..qemu_config import QemuArchParams`` at the top of the file
+and the file must contain a variable called ``QEMU_ARCH`` that has an instance
+of ``QemuArchParams`` assigned to it. An example can be seen in
+``tools/testing/kunit/qemu_configs/x86_64.py``.
+
+Once you have a QemuConfig you can pass it into kunit_tool using the
+``--qemu_config`` flag; when used this flag replaces the ``--arch`` flag. If we
+were to do this with the ``x86_64.py`` example from above, the invocation would
+look something like this:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run \
+		--timeout=60 \
+		--jobs=12 \
+		--qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
+
 Other Useful Options
 ====================
 
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 650f99590df57..888c341701da4 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -609,17 +609,45 @@ non-UML architectures:
 None of these are reasons not to run your KUnit tests on real hardware; they are
 only things to be aware of when doing so.
 
-The biggest impediment will likely be that certain KUnit features and
-infrastructure may not support your target environment. For example, at this
-time the KUnit Wrapper (``tools/testing/kunit/kunit.py``) does not work outside
-of UML. Unfortunately, there is no way around this. Using UML (or even just a
-particular architecture) allows us to make a lot of assumptions that make it
-possible to do things which might otherwise be impossible.
-
-Nevertheless, all core KUnit framework features are fully supported on all
-architectures, and using them is straightforward: all you need to do is to take
-your kunitconfig, your Kconfig options for the tests you would like to run, and
-merge them into whatever config your are using for your platform. That's it!
+Currently, the KUnit Wrapper (``tools/testing/kunit/kunit.py``) (aka
+kunit_tool) only fully supports running tests inside of UML and QEMU; however,
+this is only due to our own time limitations as humans working on KUnit. It is
+entirely possible to support other emulators and even actual hardware, but for
+now QEMU and UML is what is fully supported within the KUnit Wrapper. Again, to
+be clear, this is just the Wrapper. The actualy KUnit tests and the KUnit
+library they are written in is fully architecture agnostic and can be used in
+virtually any setup, you just won't have the benefit of typing a single command
+out of the box and having everything magically work perfectly.
+
+Again, all core KUnit framework features are fully supported on all
+architectures, and using them is straightforward: Most popular architectures
+are supported directly in the KUnit Wrapper via QEMU. Currently, supported
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
2.31.1.818.g46aad6cb9e-goog


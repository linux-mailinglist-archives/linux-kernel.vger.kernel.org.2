Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F8037626C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhEGIzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233662AbhEGIz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:55:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 145A461430;
        Fri,  7 May 2021 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620377670;
        bh=RTE+RF/OtWqg2Wx5hGyNi2LRIJBXKSZRvSIiGdaEYvw=;
        h=From:To:Cc:Subject:Date:From;
        b=GBCkk552wkvIigCW+ivwX5EubtCaPSBMJs5OoleJnwCeOwomZqWytNTj0f9KzoThL
         r9DyxBJXbRQF7W0FQlAp42XB6KzLKNVqcqa9giUZ0LiVTbYXUN8gCG9stuK1U+WRtX
         Clj+jf0kP4dNnvMokab4GJbszKx2L5dohFSnRJX8DszoVxbatycA66dYr1cKw4q05Z
         p6rIfuwoeXZUo4H5XgGfhoEjYL0SsKt/nJtNUZbgpLiQHwmuRukpgCV9KE+WiqNVvS
         iRmN2UeZGPCq0qjEcun3A7fqP0malHOGfkuo0NX+4JTtwcCJAPvhFPmLwoVM52Mxwc
         SiGDSlXN7FiqQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools/perf: build issues with Clang on arm64 and CFLAGS
Date:   Fri,  7 May 2021 17:54:25 +0900
Message-Id: <162037766527.94840.4323848545957010011.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Recently, I tested the perf build by clang on arm64 and found an issue
in arch/arm64/util/kvm-stat.c, related to missing-field-initializers warning.

----
 tools/perf $ make CC=clang LLVM=1 
...
arch/arm64/util/kvm-stat.c:74:9: error: missing field 'ops' initializer [-Werror,-Wmissing-field-initializers]
        { NULL },
               ^
1 error generated.
----

That error itself can be fixed easily by just adding field initializers
[1/1] Note that I didn't add Fixes tag, because I'm not sure clang build
of perf is officially supported or not, and this seems correct C code
to initialize a data structure with zero.(*)

And while investigating the error, I found another issue in the Makefile.config.

It seems to make CFLAGS from CORE_CFLAGS, INC_FLAGS, EXTRA_CFLAGS, EXTRA_WARNINGS
in the following order;

CFLAGS = $EXTRA_CFLAGS $EXTRA_WARNINGS $CORE_CFLAGS $INC_FLAGS

But since CORE_CFLAGS includes -Wall and -Wextra, the other -Wno-XXXX in
EXTRA_CFLAGS and EXTRA_WARNINGS are overriden and ignored.
So, I think it is better to define it as

CFLAGS = $CORE_CFLAGS $INC_FLAGS $EXTRA_CFLAGS $EXTRA_WARNINGS

But I also saw some configs tweaks CFLAGS directly. I think they should
modify EXTRA_CFLAGS.

My question is that this order is intentional or not. I might
miss something on it.

(*) BTW, there seems a discussion on the clang warning behavior,
 because gcc doesn't warn it anymore
 (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36750).
 It might be better to add -Wno-missing-field-initializers in case
 of CC=clang by default.


Thank you,

---

Masami Hiramatsu (1):
      tools/perf: Fix a build error on arm64 with clang


 tools/perf/arch/arm64/util/kvm-stat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7E4352285
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbhDAWNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbhDAWNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:13:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA66C0617AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 15:13:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f29so908888pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOIPmpuTpYu/DgWdR2yqBo3+vizrBGynByA8gUlCbew=;
        b=cQExDcxo3OoK2mxwYeUFka8uI9xHUTKkU8RyEKfqZ1RZN/sSFJE+2N5pbNgm/YFQ61
         6cj6rbkFPYePaSDv3GdRZpz3odVN2y73i4lw2JOJsdHtIlztHidaHZv+6srccig5fpHH
         4h0d7C3pV7Jy4Hjoc3pPCqU98NbNAjzBuZDiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOIPmpuTpYu/DgWdR2yqBo3+vizrBGynByA8gUlCbew=;
        b=I9QH34CynDWq2cCOLTnr8Yc+yUyYPICaY6Cr10VapBT/qK+9QBsgFZl7bmlQn73rGJ
         uQxDXlXLiwWa0Q9uZaZRz7D2DpjnZY9bvwvzaIrHiLVPcegJw20lm4OZn4PqGD9a/bj3
         dcWJ5EN5g3Pm9rkIPDTp0B56UiNaIeEA1CbVwTcjY+jhFakLfFDAOP6RGjcL7W+dX/ZS
         g26HHqWvF5cvkJppKmSLC0PmDgIq6Xr3nNJOMbHMcPa1ryxpoj3OPwvit/WYplYFf+5e
         cgDkn6Q0JJ2bjpVvcA7h88Ff5VCBtEuid3fovmc46jI33qox+ygPimLlUDUFLZFxuVHP
         gNxg==
X-Gm-Message-State: AOAM532iZfgRH90sKvAuwuYUPxnfzTmyZLGzXevkj1h1c6xH+OL6avaa
        6DxKfvmcy6QmrXaWvYL7x55Pjw==
X-Google-Smtp-Source: ABdhPJzqcC4ByIZFeQrIwo8KNlFb2Y/g6f2p3afwwogKHitzzyYi+ntwY6nHe5d5rZF1Se1DYCo+pw==
X-Received: by 2002:a65:41c7:: with SMTP id b7mr9147045pgq.237.1617315209553;
        Thu, 01 Apr 2021 15:13:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b140sm6508328pfb.98.2021.04.01.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:13:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v4 0/3] sysfs: Unconditionally use vmalloc for buffer
Date:   Thu,  1 Apr 2021 15:13:17 -0700
Message-Id: <20210401221320.2717732-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves the defensive posture of sysfs's use of seq_file
to gain the vmap guard pages at the end of vmalloc buffers to stop a
class of recurring flaw[1]. The long-term goal is to switch sysfs from
a buffer to using seq_file directly, but this will take time to refactor.

Included is also a Clang fix for NULL arithmetic and an LKDTM test to
validate vmalloc guard pages.

v4:
- fix NULL arithmetic (Arnd)
- add lkdtm test
- reword commit message
v3: https://lore.kernel.org/lkml/20210401022145.2019422-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20210315174851.622228-1-keescook@chromium.org/
v1: https://lore.kernel.org/lkml/20210312205558.2947488-1-keescook@chromium.org/

Thanks!

-Kees

Arnd Bergmann (1):
  seq_file: Fix clang warning for NULL pointer arithmetic

Kees Cook (2):
  lkdtm/heap: Add vmalloc linear overflow test
  sysfs: Unconditionally use vmalloc for buffer

 drivers/misc/lkdtm/core.c               |  3 ++-
 drivers/misc/lkdtm/heap.c               | 21 +++++++++++++++++-
 drivers/misc/lkdtm/lkdtm.h              |  3 ++-
 fs/kernfs/file.c                        |  9 +++++---
 fs/seq_file.c                           |  5 ++++-
 fs/sysfs/file.c                         | 29 +++++++++++++++++++++++++
 include/linux/seq_file.h                |  6 +++++
 tools/testing/selftests/lkdtm/tests.txt |  3 ++-
 8 files changed, 71 insertions(+), 8 deletions(-)

-- 
2.25.1


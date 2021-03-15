Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5933C521
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhCOSDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhCOSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:02:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B6C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:02:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so15227107pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9ES74tRjQPkQDGloZkJ7JzGqh/Rg5vOjLPTTzfWrnU=;
        b=nkyWI5GSq3VOZgbrSe5HgKjUqcwdRVsFgjMiU8cCOXgYni5mOUx2JpvpUeGfEIzjVc
         /EApzc0zoetCk9N/rKUGLhHwqdDHx/41U8LrjrtmFadM02lCoJ/nZFJdX85vtFgWgnHI
         h+0okdA6lvkzr6gdZBtYETfjATYKmdov+9h6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9ES74tRjQPkQDGloZkJ7JzGqh/Rg5vOjLPTTzfWrnU=;
        b=MFSaYxaXTCjlbWgHNy//lVx13p1TrCor9mNtkb9DglHtKGRKKwm6PBv/FbJYFdAAR7
         th7h/EyI/RY1BDBsH3jyCpjiy4/eRuTW4tHpVx0iDZGL5KUzdShgRUWIH6fv3XQ7opBb
         Ux3V2x5FCpJcz0uFX8lTdSQaNEv53pysKuNflfhZu6fCnvt3Ytsbc/0BmLPwyVPe7iX+
         4GEtJKXzBjxUjhAWwBSKnI1pRAVMS4cG0WJiiFyb5rgXqzsbqXWcXU8tro78QmMyMDpy
         dNzg+ONLujMwxcC+YJCnQDcZDTEOfBh7O7Lk01TsjR6W3xbHT5uJnl8JzWwDh2dFSS8v
         JtpQ==
X-Gm-Message-State: AOAM533XahONEvACcjUfteSXxpGswHgIGv57m+SDOWgnLLDjRIudtINe
        SqsaLQQRGLqAvqw+0uC/w2YZsw==
X-Google-Smtp-Source: ABdhPJwdcjtS5Z2P+DmTf0KAvanjziv2viUkjFPb2OQot1M+A70P++yEN5oAbiQpcrSGAjwehcCvpA==
X-Received: by 2002:a17:90a:2c09:: with SMTP id m9mr300524pjd.3.1615831356695;
        Mon, 15 Mar 2021 11:02:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l4sm13890800pgi.19.2021.03.15.11.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 11:02:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/6] Optionally randomize kernel stack offset each syscall
Date:   Mon, 15 Mar 2021 11:02:23 -0700
Message-Id: <20210315180229.1224655-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6:
- rearrange jump_label and init_on_* changes (akpm)
- add slab init_on_* static branches (andreyknvl)
v5: https://lore.kernel.org/lkml/20210309214301.678739-1-keescook@chromium.org/
v4: https://lore.kernel.org/lkml/20200622193146.2985288-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/20200406231606.37619-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20200324203231.64324-1-keescook@chromium.org/
rfc: https://lore.kernel.org/kernel-hardening/20190329081358.30497-1-elena.reshetova@intel.com/

Hi,

This is a continuation and refactoring of Elena's earlier effort to add
kernel stack base offset randomization. In the time since the earlier
discussions, two attacks[1][2] were made public that depended on stack
determinism, so we're no longer in the position of "this is a good idea
but we have no examples of attacks". :)

Earlier discussions also devolved into debates on entropy sources, which
is mostly a red herring, given the already low entropy available due
to stack size. Regardless, entropy can be changed/improved separately
from this series as needed.

Earlier discussions also got stuck debating how much syscall overhead
was too much, but this is also a red herring since the feature itself
needs to be selectable at boot with no cost for those that don't want it:
this is solved here with static branches.

So, here is the latest improved version, made as arch-agnostic as
possible, with usage added for x86 and arm64. It also includes some small
static branch clean ups, and addresses some surprise performance issues
due to the stack canary[3].

At the very least, the first two patches can land separately (already
Acked and Reviewed), since they're kind of "separate", but introduce
macros that are used in the core stack changes.

If I can get an Ack from an arm64 maintainer, I think this could all
land via -tip to make merging easiest.

Thanks!

-Kees

[1] https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
[2] https://repositorio-aberto.up.pt/bitstream/10216/125357/2/374717.pdf
[3] https://lore.kernel.org/lkml/202003281520.A9BFF461@keescook/

Kees Cook (6):
  jump_label: Provide CONFIG-driven build state defaults
  init_on_alloc: Optimize static branches
  stack: Optionally randomize kernel stack offset each syscall
  x86/entry: Enable random_kstack_offset support
  arm64: entry: Enable random_kstack_offset support
  lkdtm: Add REPORT_STACK for checking stack offsets

 .../admin-guide/kernel-parameters.txt         | 11 +++++
 Makefile                                      |  4 ++
 arch/Kconfig                                  | 23 ++++++++++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/Makefile                    |  5 +++
 arch/arm64/kernel/syscall.c                   | 10 +++++
 arch/x86/Kconfig                              |  1 +
 arch/x86/entry/common.c                       |  3 ++
 arch/x86/include/asm/entry-common.h           |  8 ++++
 drivers/misc/lkdtm/bugs.c                     | 17 ++++++++
 drivers/misc/lkdtm/core.c                     |  1 +
 drivers/misc/lkdtm/lkdtm.h                    |  1 +
 include/linux/jump_label.h                    | 19 +++++++++
 include/linux/mm.h                            | 10 +++--
 include/linux/randomize_kstack.h              | 42 +++++++++++++++++++
 init/main.c                                   | 23 ++++++++++
 mm/page_alloc.c                               |  4 +-
 mm/slab.h                                     |  6 ++-
 18 files changed, 181 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/randomize_kstack.h

-- 
2.25.1


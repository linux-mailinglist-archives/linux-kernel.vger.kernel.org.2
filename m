Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23CF333132
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhCIVnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhCIVnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:43:12 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACB9C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 13:43:12 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id a24so7294641plm.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 13:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ir1++GyLBl5f/Xqi2kq3Ks3S4B0/Ta3jdChtS1vi2CQ=;
        b=PQpY2pYxmPsNBXFkbbyfqSO75eYKbfp34/QOywDWc25NjIe3QuTej3PxF3gjC7fxze
         b8opA6Cs0pOw/2dA2QtI0IzU+nm/QM09KbOo00JckZNnZste6/TcuqqsPb8jccMu1wnJ
         hD7dA1q1g2DBqkhqSXzb6rBpP319jcb+bS9hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ir1++GyLBl5f/Xqi2kq3Ks3S4B0/Ta3jdChtS1vi2CQ=;
        b=tjUCVOym0WJsdqmcXHM2RcvpoXTTV5u2nFmRutsOfxFN3LuOPasU5+VYYuLJusSmwe
         0MdLc4bz20Dy5Nt+GZX6irny+NCa4AeuaIekJkIq1R7S9suUWnI8V+9HT9OjuU9ctiBj
         SWeoiLaszxA9DYIJ6qJhf6mGQ88hR/LEpf6WZ0APZYred5/Rki0vhzS3AzCpNRAXM/0d
         or6uSXPc9lQTKO/2tZLcZaUdqz3OsowZDtHzX+AU4sIHSHiYMmeFCrbq+/jugVoYBzpb
         nCDeiaIT98P8R1a5fEaNTBCB31L48wAgvR90Mi1QxXzhUH6eRDC4GnpCg7pVyqH34ryK
         8Xzg==
X-Gm-Message-State: AOAM530xVGOYNV+ieeFz6m0CEwcSDoWEfMVF/AWYA5nENgRUm/5KrKQ+
        TFgwYtko6VjZpKi4LPzgjRbfQg==
X-Google-Smtp-Source: ABdhPJwPbX2CP08JIvGDKPgOsOudkdGoKPD7zbVHSsyKSWs27JHzaot43YDrMLue1TNE7gbMQ141PA==
X-Received: by 2002:a17:90a:cb12:: with SMTP id z18mr6430185pjt.132.1615326191909;
        Tue, 09 Mar 2021 13:43:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t12sm3441876pga.85.2021.03.09.13.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:43:11 -0800 (PST)
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
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 0/7] Optionally randomize kernel stack offset each syscall
Date:   Tue,  9 Mar 2021 13:42:54 -0800
Message-Id: <20210309214301.678739-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
- rebase to v5.12-rc2
- clean up static branch issues introduced since v4 series
- adjust comments (Mark Rutland)
- update kernel-parameters.txt (Randy Dunlap)
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

At the very least, the first three patches should land ASAP, the first
is a minor bug fix for v5.11. The next two are optimizations for static
branch usage that Peter already Acked.

If I can get an Ack from an arm64 maintainer, I think this could all
land via -tip to make merging easiest.

Thanks!

-Kees

[1] https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
[2] https://repositorio-aberto.up.pt/bitstream/10216/125357/2/374717.pdf
[3] https://lore.kernel.org/lkml/202003281520.A9BFF461@keescook/

Kees Cook (7):
  mm: Restore init_on_* static branch defaults
  jump_label: Provide CONFIG-driven build state defaults
  init_on_alloc: Unpessimize default-on builds
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
 17 files changed, 177 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/randomize_kstack.h

-- 
2.25.1


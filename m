Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099FE3166F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBJMla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhBJMjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:39:23 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B69C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:38:42 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d13so1149281plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGgoiPc7aIBkQBFYmDE5N2+yq/mJvkB3drGf6PUnm/s=;
        b=g8sCdYH5CdMR55y7pAF0hD9UbO6qpw8vYLJ7tlrUuGFal77VWFt0e6UEViJ42Mww9R
         xjBrWpd+hpcFljmsUaiI8m9zndJltVendNmgBaIFXZIRqHYcxYz6v5XAzFnERkk1tjLW
         dJYGZgQ7w4ghMUhHr/9j2BS6gCCahfkH/LDnOhZIRa6Gv1GDUd9bAbM2UGjG6zAJm80G
         mh9ZEGH8IzNvA45cEJDRZsNtm4ssFIi8/tN2bRlWT4cbncz9vbeYakgEDuVfUyPgHLhI
         yZgdw/iYZlciXkmw93SS3tooENosRbUnZ38XqcjNAoNSurJMxUuZBmzirouVIvPDHX6J
         uxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGgoiPc7aIBkQBFYmDE5N2+yq/mJvkB3drGf6PUnm/s=;
        b=NC4EP8O9WSoqk/KISX0dqaIUGkYVzyi1t957NadNZFmvf/aKg7ROFnKnHagFtJ2wB/
         AFM7/ZCc7ZDZrWfVo8j0Q6hEIqYZqLNWwuYj+U3bG2m9Hfhp8ypyAbsVHz/5OAus8/nj
         gIPxvucVoW4IWwZv8dnKSd9SyF/1CYkuAaY3Dhw/Yt64eAJrjWgb4hP0Oad7vXseQ5LS
         HfZBjfrFRwQ8ns9k9awnSWF+zgB1G76MzsNPzTWR/217jZlv5IL2kPWpXAQFnfAIpaTd
         zToS3TEotFtyfI07ePitenXWPBh7ba2ESMWv1dkD3lJQRS5gvT9Ivev+ebW4Aufmvqpc
         lX2Q==
X-Gm-Message-State: AOAM5331NKYqQwm/dmWb7JtMQ8IBowXK4REZ6jco9YXfNnWpaYvopUMl
        JaOiGoqKbtyk5nWi01jBftq8PWr5AnQ=
X-Google-Smtp-Source: ABdhPJzOj+UG3da9yO/uTv8kGgOsB5HhJY3R/XAL4grP9eSZ/PEymR4XtLFvnDeNZNMsmUyu8e/wnQ==
X-Received: by 2002:a17:90a:6708:: with SMTP id n8mr2963745pjj.38.1612960722000;
        Wed, 10 Feb 2021 04:38:42 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id o129sm958708pgo.27.2021.02.10.04.38.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 04:38:41 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Balbir Singh <sblbir@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V4 0/6] x86: Don't abuse tss.sp1
Date:   Wed, 10 Feb 2021 21:39:11 +0800
Message-Id: <20210210133917.2414-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

In x86_64, tss.sp1 is reused as cpu_current_top_of_stack.  We'd better
directly use percpu since CR3 and gs_base is correct when it is used.

In x86_32, tss.sp1 is resued as thread.sp0 in three places in entry
code.  We have the correct CR3 and %fs at two of the places.  The last
one is sysenter.  This patchset makes %fs available earlier so that
we can also use percpu in sysenter.  And add a percpu cpu_current_thread_sp0
for thread.sp0 instead of tss.sp1

[V3]: https://lore.kernel.org/lkml/20210127163231.12709-1-jiangshanlai@gmail.com/
[V2]: https://lore.kernel.org/lkml/20210125173444.22696-1-jiangshanlai@gmail.com/
[V1]: https://lore.kernel.org/lkml/20210123084900.3118-1-jiangshanlai@gmail.com/

Changed from V3:
	Update subjects as Borislav's imperative request. ^_^
	Update changelog as Borislav suggested.
	Change EXPORT_PER_CPU_SYMBOL to EXPORT_PER_CPU_SYMBOL_GPL.

Changed from V2:
	Add missing "%ss:" reported by Brian Gerst.

Changed from V1:
	Requested from Andy to also fix sp1 for x86_32.
	Update comments in the x86_64 patch as Andy sugguested.

Lai Jiangshan (6):
  x86/entry/64: Move cpu_current_top_of_stack out of TSS
  x86/entry/32: Use percpu instead of offset-calculation to get
    thread.sp0 in SWITCH_TO_KERNEL_STACK
  x86/entry/32: Switch to the task stack without emptying the entry
    stack
  x86/entry/32: Restore %fs before switching stack
  x86/entry/32: Use percpu to get thread.sp0 in SYSENTER
  x86/entry/32: Introduce cpu_current_thread_sp0 to replace
    cpu_tss_rw.x86_tss.sp1

 arch/x86/entry/entry_32.S          | 38 +++++++++++++++++-------------
 arch/x86/include/asm/processor.h   | 12 ++--------
 arch/x86/include/asm/switch_to.h   |  8 +------
 arch/x86/include/asm/thread_info.h |  6 -----
 arch/x86/kernel/asm-offsets.c      |  1 -
 arch/x86/kernel/asm-offsets_32.c   | 10 --------
 arch/x86/kernel/cpu/common.c       | 12 +++++++++-
 arch/x86/kernel/process.c          |  7 ------
 arch/x86/mm/pti.c                  |  7 +++---
 9 files changed, 39 insertions(+), 62 deletions(-)

-- 
2.19.1.6.gb485710b


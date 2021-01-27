Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC06305FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhA0Pdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhA0Pcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:32:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C762C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:31:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id a20so1449598pjs.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dU6g9mi3ERsID3siwO0ykMtHlMa1lGIiwksNicPZPaE=;
        b=hKbj2i3Pcfc0rprG2zHmihA1wdgU6nvStL72l8TgmAgxEDakE5GljigP5mAZkOgtss
         O6upoWyP4225vJA6N+o/ZWvkzqTetM5wlxikX/Rygpz6MvAdSdc9pPpk14he1zJ5K0T4
         yd+tc/0LWGfZZ1aEvYlfM5jYP7XBdn+WX6qSrA/UwfZuRuoXlxVezavdgyecwEKzv+8f
         1rRf7oBs5Co68CedLGdwJPaMgKGKNn9zJx+A+lyoSyR7eHO2cBvt07A9a8ub71gwaNkH
         cvTb2yfHKkUZ+ZwoktjfEukgB1bZC7LE5sCFG5j36E/Sij/znfHEuQ9d/JclJ/LhxAJ/
         CHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dU6g9mi3ERsID3siwO0ykMtHlMa1lGIiwksNicPZPaE=;
        b=pF2jr57wpLlUyCBXRI0rTOVbOclybGYnFgydnXKJOV5xL/TIRIGcgpPPHBh5VEzHlk
         fEGwQOGHNC2KDNfRWhhmV/T3twYji3u7sgZNXsWowSRx6HEcq3DCG5uJ/IIfis3mwALD
         6e3lrkI9nyXJWgM0ZI9/rD64jaXPZxKerkcpgiM40Yn3iSzh8n9lieJMBFTRQuBckk0y
         YgvEm7rlrW96XHv+xpfjb7LcfagE7JYFbUzhxnfovRReTldeKWsDN+Y7dU2LoUQ2EYhJ
         7hPizXzWK9ppLunhJqr9kYC9CrPRXWsi4TB0WOG5MDPINj3T0wcSW8kFcQgkPCB0zKiD
         SjZQ==
X-Gm-Message-State: AOAM532jBlsk4X5Loy5Xsdxkw8oLbiaGquPqtHNeWfCVDXksTApUJR/N
        enjmN49FhDgT9OOe8S/V3cSU+HMrDQKWGUUr
X-Google-Smtp-Source: ABdhPJxXnsuadaVidHvrpo8dVt85uRo6ZGAGKQwbk1zQHcTrrdIIvFrWaYCUjzS4ZrWHUHz7Ef9CKA==
X-Received: by 2002:a17:90b:4c0b:: with SMTP id na11mr6048883pjb.45.1611761509927;
        Wed, 27 Jan 2021 07:31:49 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id d133sm2754059pfd.6.2021.01.27.07.31.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:31:48 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
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
Subject: [PATCH V3 0/6] x86: don't abuse tss.sp1
Date:   Thu, 28 Jan 2021 00:32:16 +0800
Message-Id: <20210127163231.12709-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

In x86_64, tss.sp1 is reused as cpu_current_top_of_stack.  But we can
directly use percpu since CR3 and gs_base is correct when it is used.

In x86_32, tss.sp1 is resued as thread.sp0 in three places in entry
code.  We have the correct CR3 and %fs at two of the places.  The last
one is sysenter.  This patchset makes %fs available earlier so that
we can also use percpu in sysenter.  And add a percpu cpu_current_thread_sp0
for thread.sp0 instead of tss.sp1

[V2]: https://lore.kernel.org/lkml/20210125173444.22696-1-jiangshanlai@gmail.com/
[V1]: https://lore.kernel.org/lkml/20210123084900.3118-1-jiangshanlai@gmail.com/

Changed from V2
	Add missing "%ss:" reported by Brian Gerst.

Changed from V1
	Requested from Andy to also fix sp1 for x86_32.
	Update comments in the x86_64 patch as Andy sugguested.

Lai Jiangshan (6):
  x86_64: move cpu_current_top_of_stack out of TSS
  x86_32: use percpu instead of offset-calculation to get thread.sp0
    when SWITCH_TO_KERNEL_STACK
  x86_32/sysenter: switch to the task stack without emptying the entry
    stack
  x86_32/sysenter: restore %fs before switching stack
  x86_32/sysenter: use percpu to get thread.sp0 when sysenter
  x86_32: use cpu_current_thread_sp0 instead of cpu_tss_rw.x86_tss.sp1

 arch/x86/entry/entry_32.S          | 38 +++++++++++++++++-------------
 arch/x86/include/asm/processor.h   | 12 ++--------
 arch/x86/include/asm/switch_to.h   |  9 ++-----
 arch/x86/include/asm/thread_info.h |  6 -----
 arch/x86/kernel/asm-offsets.c      |  1 -
 arch/x86/kernel/asm-offsets_32.c   | 10 --------
 arch/x86/kernel/cpu/common.c       | 12 +++++++++-
 arch/x86/kernel/process.c          |  7 ------
 arch/x86/mm/pti.c                  |  7 +++---
 9 files changed, 40 insertions(+), 62 deletions(-)

-- 
2.19.1.6.gb485710b


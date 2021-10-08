Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FF742688C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbhJHLUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbhJHLT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:19:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E9EC061570;
        Fri,  8 Oct 2021 04:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hmkYnnIILnrl0z+glbF3vsotGauPDPEqjLkfBoI45PI=; b=IEDn1dPSAlSouoL5XqDhyDertI
        xsDtLy+YVUXNszpoJaTAoN7qzQ8EDRKaFDzoGYnvW/DhE6QcGXddcIWlKIhKG13gFXIwPRubcch6v
        ZZ/+OyuH3MbmYMlIVg1xMsWulajyLIF31hw5oZU4YY4zfMvi0kqzl/841f43rIA2xZCfV9hUOAzle
        XJU/Yz8tDQp50Ft/23Y9tU/BInBryov4yi2aDFBDs1XhfSOOA9xHoHxxfkDAaG5eygnWhgxPqjlCp
        ExWTJaWAoUiBAXBKmaByABoFX7XRfc/y9+FFZUoPxu9FCqvk7Fhvuy+G1xWWnxVPghKPPH5btdvP+
        Z0X71f2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYnsD-008eLA-BU; Fri, 08 Oct 2021 11:17:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EEDEB300094;
        Fri,  8 Oct 2021 13:17:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CCA9E2DB84A65; Fri,  8 Oct 2021 13:17:07 +0200 (CEST)
Message-ID: <20211008111527.438276127@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Oct 2021 13:15:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com,
        mark.rutland@arm.com, axboe@kernel.dk, metze@samba.org,
        laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net
Subject: [PATCH 0/7] wchan: Fix wchan support
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fixes up wchan which is various degrees of broken across the
architectures.

Patch 4 fixes wchan for x86, which has been returning 0 for the past many
releases.

Patch 5 fixes the fundamental race against scheduling.

Patch 6 deletes a lot and makes STACKTRACE unconditional

patch 7 fixes up a few STACKTRACE arch oddities

0day says all builds are good, so it must be perfect :-) I'm planning on
queueing up at least the first 5 patches, but I'm hoping the last two patches
can be too.

Also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wchan

---
 arch/alpha/include/asm/processor.h      |  2 +-
 arch/alpha/kernel/process.c             |  5 ++-
 arch/arc/include/asm/processor.h        |  2 --
 arch/arc/kernel/stacktrace.c            | 19 +---------
 arch/arm/include/asm/processor.h        |  2 --
 arch/arm/kernel/process.c               | 24 -------------
 arch/arm64/include/asm/processor.h      |  2 --
 arch/arm64/kernel/process.c             | 28 ---------------
 arch/csky/include/asm/processor.h       |  2 --
 arch/csky/kernel/stacktrace.c           | 26 ++++----------
 arch/h8300/include/asm/processor.h      |  2 +-
 arch/h8300/kernel/process.c             |  5 +--
 arch/hexagon/include/asm/processor.h    |  3 --
 arch/hexagon/kernel/process.c           | 28 ---------------
 arch/ia64/include/asm/processor.h       |  3 --
 arch/ia64/kernel/process.c              | 31 -----------------
 arch/m68k/include/asm/processor.h       |  2 +-
 arch/m68k/kernel/process.c              |  4 +--
 arch/microblaze/include/asm/processor.h |  2 --
 arch/microblaze/kernel/process.c        |  6 ----
 arch/mips/include/asm/processor.h       |  2 --
 arch/mips/kernel/process.c              | 31 +----------------
 arch/mips/kernel/stacktrace.c           | 27 ++++++++------
 arch/nds32/include/asm/processor.h      |  2 --
 arch/nds32/kernel/process.c             | 28 ---------------
 arch/nds32/kernel/stacktrace.c          | 21 +++++------
 arch/nios2/include/asm/processor.h      |  2 +-
 arch/nios2/kernel/process.c             |  5 +--
 arch/openrisc/include/asm/processor.h   |  1 -
 arch/openrisc/kernel/process.c          |  6 ----
 arch/parisc/include/asm/processor.h     |  2 --
 arch/parisc/kernel/process.c            | 27 --------------
 arch/powerpc/include/asm/processor.h    |  2 --
 arch/powerpc/kernel/process.c           | 40 ---------------------
 arch/riscv/include/asm/processor.h      |  3 --
 arch/riscv/kernel/stacktrace.c          | 23 ------------
 arch/s390/include/asm/processor.h       |  1 -
 arch/s390/kernel/process.c              | 29 ---------------
 arch/sh/include/asm/processor_32.h      |  2 --
 arch/sh/kernel/process_32.c             | 22 ------------
 arch/sparc/include/asm/processor_32.h   |  2 +-
 arch/sparc/include/asm/processor_64.h   |  2 --
 arch/sparc/kernel/process_32.c          |  5 +--
 arch/sparc/kernel/process_64.c          | 31 -----------------
 arch/um/include/asm/processor-generic.h |  1 -
 arch/um/kernel/process.c                | 35 -------------------
 arch/x86/include/asm/processor.h        |  2 --
 arch/x86/kernel/process.c               | 62 ---------------------------------
 arch/xtensa/include/asm/processor.h     |  2 --
 arch/xtensa/kernel/process.c            | 32 -----------------
 fs/proc/array.c                         |  7 ++--
 fs/proc/base.c                          | 19 +++++-----
 include/linux/sched.h                   |  1 +
 kernel/sched/core.c                     | 34 ++++++++++++++++++
 lib/Kconfig.debug                       |  7 +---
 scripts/leaking_addresses.pl            |  3 +-
 56 files changed, 97 insertions(+), 622 deletions(-)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C1362633
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbhDPQ6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbhDPQ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:58:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC6EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:57:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w8so15261678pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=jlnVYfogtWdbo39k5goD819EtNYgqDDkFjjf5oM8VYo=;
        b=Gft+H4TMqR1sH3N7TVJvohelrIifIsea+I17CuojrRcKktIh8GSxyk1b5g4+B8YEfs
         encgAqcZpdiXdYRvdSIQETgjJ7W6NE/4UEIX8jhwXJtqpPexgz0TDHJcAEIqflcr4U1V
         lVO+UL6DvR8Rm+kDG9gmo3Jr+nQ1qJqQd9t4dvSqQ8HgYXwbMGh8v+jL/xgzhxAJTLev
         6FyJtUdeDrRLbWIlEJleai4HSP/iu5ZAeouUHnVLkLI1DuzqMZQPM1MMt7pX4M1F8ivT
         TY2x3Cvu34gEENMrdUGfZDGII53Ie21r0vwWSUaOcqHNlBLPHC+9yQypNcF+et7rMp5f
         ar4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=jlnVYfogtWdbo39k5goD819EtNYgqDDkFjjf5oM8VYo=;
        b=rPup9eOqwaVeayYtHAmSWuIWf7+LcmTXTBQuUhIuKaHMkaBnWZc+m4U3LTSjUc3mao
         b6LkW+hyih1M1vSNy/Xh3JO7OHt38sO8DtMfQyPY0ddQECJI+sftsSLQZvTdNrCyPh46
         8QYXDzZw2TfX2nfsXzSkUmYXsh9bMbwuO4/ewRHU0La2htjv9R3cNQn4X1GBo9DFL+iN
         ZgkcCQAA3niLqXr9KqMTqFKbDl3OlWMzdbZmWddbLql/isT1UCqGZcKuJGPsrK2PiZdr
         jd2KRWOut6UI7TrC1+0IQiPhruRztmo/t7W0dacmYoBr5MXNxFi/sppyOGBakUuCBmDN
         oK1w==
X-Gm-Message-State: AOAM531PmW0/+2zkWzzDbMvrDUHy+CUdKmm6/F7dWkKAbFyk0+jRhbVM
        L9a6+hTc7RDcQfWLLtfeBxXEYYwQNR2D1Q==
X-Google-Smtp-Source: ABdhPJwmHO0ap9Gb3O05B6W0Ze6a5pBvOka+XXKNfMCVq576k+Kb7TtJ8ufNe5ECT9C7jYf8NAYMbg==
X-Received: by 2002:a63:f258:: with SMTP id d24mr68955pgk.174.1618592273169;
        Fri, 16 Apr 2021 09:57:53 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e10sm5066020pfv.196.2021.04.16.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 09:57:52 -0700 (PDT)
Date:   Fri, 16 Apr 2021 09:57:52 -0700 (PDT)
X-Google-Original-Date: Fri, 16 Apr 2021 09:57:47 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.12-rc8 (or 5.12)
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-769b7cf7-7dfb-455a-9bb3-99f5cd952dbe@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-rc8

for you to fetch changes up to 7ae11635ec90072083503c6b6485cdffe46203b3:

  riscv: keep interrupts disabled for BREAKPOINT exception (2021-04-15 21:32:40 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.12-rc8 (or 5.12)

I have a handful of fixes that I'd like to target for 5.12, regardless
of whether there's an rc8 or not:

* A fix to properly select SPARSEMEM_STATIC on rv32.
* A handful of fixes to kprobes.

I don't generally like sending stuff this late, but these all seem
pretty safe.

----------------------------------------------------------------
Jisheng Zhang (3):
      riscv: add do_page_fault and do_trap_break into the kprobes blacklist
      riscv: kprobes/ftrace: Add recursion protection to the ftrace callback
      riscv: keep interrupts disabled for BREAKPOINT exception

Kefeng Wang (1):
      riscv: Fix spelling mistake "SPARSEMEM" to "SPARSMEM"

 arch/riscv/Kconfig                |  2 +-
 arch/riscv/kernel/entry.S         |  3 +++
 arch/riscv/kernel/probes/ftrace.c | 11 ++++++++++-
 arch/riscv/kernel/traps.c         |  1 +
 arch/riscv/mm/fault.c             |  1 +
 5 files changed, 16 insertions(+), 2 deletions(-)

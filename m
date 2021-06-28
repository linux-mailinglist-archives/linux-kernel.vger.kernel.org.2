Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8510E3B58D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 07:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhF1F7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 01:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhF1F73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:59:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD02C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 22:57:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id df12so24005566edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 22:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZDwMJE4yQ7gTGAaqD2+KvgjsrJdHr7Oxry9Dry3zCIk=;
        b=ZRnolCddnSmW8y9WHGbuDWRK2AsWdKprLwsIT2v+suOf5FfWWHRfH2ZrFZmluzAuWl
         uCDYftSdFmrvJqc+EkDY1k7gu3WgOvLWsy7Xjj1ceC8iVhgUDFrKfWh3Ha7A63R/wDZ0
         oVdlNRQRIKfnVLsdRzK1DGg+jYjVC4l+mTzX6RxLyTOsqx26LLcpq9C9AR4NpXIhs3CU
         gvsPTVy2KpCi74+e285heVowFSg0CKMPTNH/VHkcdgLi8POF6X35GYKRUzCKH5FMmlrj
         PjdU6Xylj3fjOsGNsV/cA/uUar8eEDOvFenxEpiIODIMD5yFsIWclSTG6cW7S4qHWQFP
         TtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=ZDwMJE4yQ7gTGAaqD2+KvgjsrJdHr7Oxry9Dry3zCIk=;
        b=tQz0vXPsXnp3L86tZd+bmStoCKbeD7iQflt0bhaPf7shT0WnvY3dX2Ovk/Mj5oLe4W
         rnfUQ01y6p27gvwqNM2xXXS4V6avmZajYHyNVbKsttRkxo+l/+plh5zPXlDh/Wzoa2nk
         v79DjG/VU6nHOFnurntgaApvqXG+fF/lSwsHeAo3sx/dZcSKG0x96vsapA3wFPup1pnz
         BJCqH1O+UAaYsjLF3pDme80+YbqYSHQ7Eb+LDrA0A6bntmNWZAm/1e4yiFL0qqmxrMHz
         vQJMTFsA7m9o0qf2HFwXkeCbqC8uMbCB74euQKpl0N0fv8IdDuXc1/LnbFJD6jYwzPKP
         LBGg==
X-Gm-Message-State: AOAM531J2Es9F8uHhNHle4O3wl+voisqXnd17xz9qkdHX7WL4cQsPP7B
        tz9+iRNolnfVlPQRKjXC1UrcsH2/hV0=
X-Google-Smtp-Source: ABdhPJzmgw3/PpD5/+VemNUsJ6eCyjDlFU9nDF31og43KXMHU8/zG6nQBhRLf34cmRnkawjcqf/reA==
X-Received: by 2002:aa7:c648:: with SMTP id z8mr18311975edr.384.1624859823107;
        Sun, 27 Jun 2021 22:57:03 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id aq12sm6247881ejc.77.2021.06.27.22.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 22:57:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 07:57:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v5.14
Message-ID: <YNlkrfFqO/bsKq5D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-06-28

   # HEAD: d33b9035e14a35f6f2a5f067f0b156a93581811d objtool: Improve reloc hash size guestimate

The biggest change in this cycle is the new code to handle
and rewrite variable sized jump labels - which results in
slightly tighter code generation in hot paths, through the
use of short(er) NOPs.

Also a number of cleanups and fixes, and a change to the
generic include/linux/compiler.h to handle a s390 GCC quirk.

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (1):
      kbuild: Fix objtool dependency for 'OBJECT_FILES_NON_STANDARD_<obj> := n'

Peter Zijlstra (16):
      objtool: Rewrite hashtable sizing
      x86, objtool: Dont exclude arch/x86/realmode/
      jump_label, x86: Strip ASM jump_label support
      jump_label, x86: Factor out the __jump_table generation
      jump_label, x86: Improve error when we fail expected text
      jump_label, x86: Introduce jump_entry_size()
      jump_label, x86: Add variable length patching support
      jump_label: Free jump_entry::key bit1 for build use
      jump_label, x86: Emit short JMP
      objtool: Decode jump_entry::key addend
      objtool: Rewrite jump_label instructions
      objtool: Provide stats for jump_labels
      jump_label, x86: Allow short NOPs
      jump_label/x86: Remove unused JUMP_LABEL_NOP_SIZE
      objtool: Reflow handle_jump_alt()
      objtool: Improve reloc hash size guestimate

Vasily Gorbik (2):
      compiler.h: Avoid using inline asm operand modifiers
      instrumentation.h: Avoid using inline asm operand modifiers


 arch/x86/include/asm/jump_label.h             |  79 +++++++-----------
 arch/x86/kernel/jump_label.c                  |  81 ++++++++++++-------
 arch/x86/realmode/Makefile                    |   1 -
 include/linux/compiler.h                      |  22 ++++--
 include/linux/instrumentation.h               |  20 +++--
 include/linux/jump_label.h                    |  16 +++-
 kernel/jump_label.c                           |  12 +--
 scripts/Makefile.build                        |   5 +-
 tools/objtool/arch/x86/include/arch/special.h |   1 +
 tools/objtool/check.c                         |  38 ++++++++-
 tools/objtool/elf.c                           | 110 ++++++++++++++++----------
 tools/objtool/include/objtool/elf.h           |  18 +++--
 tools/objtool/include/objtool/objtool.h       |   3 +
 tools/objtool/include/objtool/special.h       |   1 +
 tools/objtool/special.c                       |  14 ++++
 15 files changed, 267 insertions(+), 154 deletions(-)

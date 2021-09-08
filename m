Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD4403E7C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350241AbhIHRqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbhIHRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:46:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41356C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t20so2175181pju.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Edyz/e4g514ql9vHU35fwNHNVpA81cArT32mp5SyTxI=;
        b=HAvTjQLf7EwJ9FdZoo6sDmDc+5yPweIhLe98e6Qh/+q4ROz+d0OAvPL2n1BqebDc8R
         0LfJUyGLtb+tfTiB77RmPtV5USj44JACH9fwaoqDR2asIHCDrJU9U8QbVFeuPKRhuBj0
         17hapgW6WJz83VABoG7RbENIU1+0TlXqhuxdTVgDn2nm4ULv4AlPi44DUTmQ+gY064YQ
         lGQcAfS613B8xN3+oIYfsta/P2YllcUAZeqt/nHtdA4Kmba1cszTnuz1PE5feT51WbXE
         po+DkyF1CE67B3QGnfRPZdC2Rq4vMNza7+gud7qrWGw380QU13C6KDenQyKdo5lX3HNq
         L57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Edyz/e4g514ql9vHU35fwNHNVpA81cArT32mp5SyTxI=;
        b=ofsHTvfT8QlbKT5t6kqhqTW5BPweIfutMdQr1hbzpet8pm6Tvf6RdDZUp/Fu5Dvatx
         7CjpsJmOhczuBsowgspTQSaY797YN27vfRpbFDq4esWcTcgw1rkN0g9OQyFmPU2Jtt7Z
         ADyv4E7NlKzlu/7L9uElk5RZXe/qNxSWNAXN5HkdtmN9b8Q7inmyvxvqw1+tX4+h9uIC
         xzH/4x3D/RtRvO179hS1mBf+oLMSpUEsFjelrj8RyZ43cthhJYN8znTZgLIPNFbTGQET
         5+bZhJyFnw5ebCFacgLvo5RkcUwFGyIhm3XDxYLcwdA/AYXQmFZub7RIPXPiZH4UNTGg
         U/qg==
X-Gm-Message-State: AOAM533soReNgjnyAPl+z/9akyzAlHkw/TuzeQCoYMTfb7mk0R/78+TN
        xMdrdYIcj1AyLNvcpmRrrgTHuQ==
X-Google-Smtp-Source: ABdhPJy9QgjSQHqyF8TiQwKDG3c/JSGEnopJmBLqvi1CA7bI+x+RBeOVfDER1N/eP16VRFKvC4+IGw==
X-Received: by 2002:a17:90b:a06:: with SMTP id gg6mr5352733pjb.72.1631123135791;
        Wed, 08 Sep 2021 10:45:35 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:35 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 00/21] riscv: Add vector ISA support
Date:   Thu,  9 Sep 2021 01:45:12 +0800
Message-Id: <cover.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is implemented based on vector 1.0-rc1 spec to add vector
support in riscv Linux kernel. To make this happen, we defined a new
structure __riscv_v_state to save the vector related registers. It is used
for both kernel space and user space.

 - In kernel space, the datap pointer in __riscv_v_state will be allocated
   dynamically to save vector registers.
 - In user space,
	- In signal handler of user space, datap will point to the address
          of the __riscv_v_state data structure to save vector
          registers in stack. We also create a __reserved[] array for
	  future extensions.
	- In ptrace, the data will be put in ubuf in which we use
       	  riscv_vr_get()/riscv_vr_set() to get or set the
	  __riscv_v_state data structure from/to it, datap pointer
	  would be zeroed and vector registers will be copied to the
	  address right after the __riscv_v_state structure in ubuf.

This patchset also adds support for kernel mode vector, kernel XOR
implementation with vector ISA and includes several bug fixes and code
refinement.

This patchset is rebased to v5.14 and it is tested by running several
vector programs simultaneously. It also can get the correct ucontext_t in
signal handler and restore correct context after sigreturn. It is also
tested with ptrace() syscall to use PTRACE_GETREGSET/PTRACE_SETREGSET to
get/set the vector registers. I have tested vlen=128 and vlen=256 cases in
qemu-system-riscv64 provided by Frank Chang.

We have sent patches to glibc mailing list for ifunc support and sigcontext
changes. We will send patches for vector support to glibc mailing list
recently.

 [1] https://github.com/riscv/riscv-v-spec/blob/master/v-spec.adoc

---
Changelog V8
 - Rebase to v5.14
 - Refine struct __riscv_v_state with struct __riscv_ctx_hdr
 - Refine has_vector into a static key
 - Defined __reserved space in struct sigcontext for vector and future extensions

Changelog V7
 - Add support for kernel mode vector
 - Add vector extension XOR implementation
 - Optimize task switch codes of vector
 - Allocate space for vector registers in start_thread()
 - Fix an illegal instruction exception when accessing vlenb
 - Optimize vector registers initialization
 - Initialize vector registers with proper vsetvli then it can work normally
 - Refine ptrace porting due to generic API changed
 - Code clean up

Changelog V6
 - Replace vle.v/vse.v instructions with vle8.v/vse8.v based on 0.9 spec
 - Add comments based on mailinglist feedback
 - Fix rv32 build error

Changelog V5
 - Using regset_size() correctly in generic ptrace
 - Fix the ptrace porting
 - Fix compile warning

Changelog V4
 - Support dynamic vlen
 - Fix bugs: lazy save/resotre, not saving vtype
 - Update VS bit offset based on latest vector spec
 - Add new vector csr based on latest vector spec
 - Code refine and removed unused macros

Changelog V3
 - Rebase linux-5.6-rc3 and tested with qemu
 - Seperate patches with Anup's advice
 - Give out a ABI puzzle with unlimited vlen

Changelog V2
 - Fixup typo "vecotr, fstate_save->vstate_save".
 - Fixup wrong saved registers' length in vector.S.
 - Seperate unrelated patches from this one.

Greentime Hu (15):
  riscv: Add new csr defines related to vector extension
  riscv: Add has_vector/riscv_vsize to save vector features.
  riscv: Add vector struct and assembler definitions
  riscv: Add task switch support for vector
  riscv: Add ptrace vector support
  riscv: Add sigcontext save/restore for vector
  riscv: Add support for kernel mode vector
  riscv: Use CSR_STATUS to replace sstatus in vector.S
  riscv: Add vector extension XOR implementation
  riscv: Initialize vector registers with proper vsetvli then it can
    work normally
  riscv: Optimize vector registers initialization
  riscv: Fix an illegal instruction exception when accessing vlenb
    without enable vector first
  riscv: Allocate space for vector registers in start_thread()
  riscv: Optimize task switch codes of vector
  riscv: Turn has_vector into a static key if VECTOR=y

Guo Ren (5):
  riscv: Separate patch for cflags and aflags
  riscv: Rename __switch_to_aux -> fpu
  riscv: Extending cpufeature.c to detect V-extension
  riscv: Add vector feature to compile
  riscv: Reset vector register

Vincent Chen (1):
  riscv: signal: Report signal frame size to userspace via auxv

 arch/riscv/Kconfig                       |   9 ++
 arch/riscv/Makefile                      |  19 ++-
 arch/riscv/include/asm/csr.h             |  16 ++-
 arch/riscv/include/asm/elf.h             |  41 +++---
 arch/riscv/include/asm/processor.h       |   3 +
 arch/riscv/include/asm/switch_to.h       |  71 +++++++++-
 arch/riscv/include/asm/vector.h          |  16 +++
 arch/riscv/include/asm/xor.h             |  74 ++++++++++
 arch/riscv/include/uapi/asm/auxvec.h     |   1 +
 arch/riscv/include/uapi/asm/hwcap.h      |   1 +
 arch/riscv/include/uapi/asm/ptrace.h     |  25 ++++
 arch/riscv/include/uapi/asm/sigcontext.h |  24 ++++
 arch/riscv/kernel/Makefile               |   7 +
 arch/riscv/kernel/asm-offsets.c          |   8 ++
 arch/riscv/kernel/cpufeature.c           |  16 +++
 arch/riscv/kernel/entry.S                |   6 +-
 arch/riscv/kernel/head.S                 |  22 ++-
 arch/riscv/kernel/kernel_mode_vector.c   | 158 +++++++++++++++++++++
 arch/riscv/kernel/process.c              |  49 +++++++
 arch/riscv/kernel/ptrace.c               |  71 ++++++++++
 arch/riscv/kernel/setup.c                |   4 +
 arch/riscv/kernel/signal.c               | 172 ++++++++++++++++++++++-
 arch/riscv/kernel/vector.S               |  81 +++++++++++
 arch/riscv/lib/Makefile                  |   1 +
 arch/riscv/lib/xor.S                     |  81 +++++++++++
 include/uapi/linux/elf.h                 |   1 +
 26 files changed, 941 insertions(+), 36 deletions(-)
 create mode 100644 arch/riscv/include/asm/vector.h
 create mode 100644 arch/riscv/include/asm/xor.h
 create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
 create mode 100644 arch/riscv/kernel/vector.S
 create mode 100644 arch/riscv/lib/xor.S

-- 
2.31.1


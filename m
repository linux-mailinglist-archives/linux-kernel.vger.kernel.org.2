Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD64B409A88
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbhIMRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242791AbhIMRUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:20:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C0EF610A2;
        Mon, 13 Sep 2021 17:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631553538;
        bh=+gCyA9IN+nwQ1UVSuEX/uymvAJMBsbv0RIzV1SdyQJ4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=tETp2CoLq/yQMZppz/GuK5TNKpvuHmhGlaQPC/bo0EU6hqH11UMysofNNNX23ZV7T
         wbck8rQUh20u8c6wCHjiXNijNKd75Vd1LTH9OXUI0W70OzLJrlfnZ/Q/zEFsNVUkTD
         88Z2kWW659xlz9hc338AhUP0oq29b4P8HUzcU62m4pD5Ld6QevXGh0odJzfXrr6gX2
         1jMugB3XYuEY39cn4jQe0+KucHOG9zCePknzWGFHc8Ut04aAAE2Ni2LSR42zHFtiS5
         4RIT2qE0GJZ7bSJ59d34keaY5T6Sc13TpX1LoBEcsHxFfjajvjBczFL+QQL14iDY6F
         oFZplPx1kW1Iw==
Subject: Re: [RFC PATCH v8 00/21] riscv: Add vector ISA support
To:     Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
References: <cover.1631121222.git.greentime.hu@sifive.com>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <7719da12-31d6-ef03-1100-142348dec209@kernel.org>
Date:   Mon, 13 Sep 2021 10:18:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 10:45 AM, Greentime Hu wrote:
> This patchset is implemented based on vector 1.0-rc1 spec to add vector
> support in riscv Linux kernel. To make this happen, we defined a new
> structure __riscv_v_state to save the vector related registers. It is used
> for both kernel space and user space.
> 
>   - In kernel space, the datap pointer in __riscv_v_state will be allocated
>     dynamically to save vector registers.
>   - In user space,
> 	- In signal handler of user space, datap will point to the address
>            of the __riscv_v_state data structure to save vector
>            registers in stack. We also create a __reserved[] array for
> 	  future extensions.
> 	- In ptrace, the data will be put in ubuf in which we use
>         	  riscv_vr_get()/riscv_vr_set() to get or set the
> 	  __riscv_v_state data structure from/to it, datap pointer
> 	  would be zeroed and vector registers will be copied to the
> 	  address right after the __riscv_v_state structure in ubuf.
> 
> This patchset also adds support for kernel mode vector, kernel XOR
> implementation with vector ISA and includes several bug fixes and code
> refinement.
> 
> This patchset is rebased to v5.14 and it is tested by running several
> vector programs simultaneously. It also can get the correct ucontext_t in
> signal handler and restore correct context after sigreturn. It is also
> tested with ptrace() syscall to use PTRACE_GETREGSET/PTRACE_SETREGSET to
> get/set the vector registers. I have tested vlen=128 and vlen=256 cases in
> qemu-system-riscv64 provided by Frank Chang.

Are QEMU/Spike changes available somewhere publicly for people to try this ?

Thx,
-Vineet

> 
> We have sent patches to glibc mailing list for ifunc support and sigcontext
> changes. We will send patches for vector support to glibc mailing list
> recently.
> 
>   [1] https://github.com/riscv/riscv-v-spec/blob/master/v-spec.adoc
> 
> ---
> Changelog V8
>   - Rebase to v5.14
>   - Refine struct __riscv_v_state with struct __riscv_ctx_hdr
>   - Refine has_vector into a static key
>   - Defined __reserved space in struct sigcontext for vector and future extensions
> 
> Changelog V7
>   - Add support for kernel mode vector
>   - Add vector extension XOR implementation
>   - Optimize task switch codes of vector
>   - Allocate space for vector registers in start_thread()
>   - Fix an illegal instruction exception when accessing vlenb
>   - Optimize vector registers initialization
>   - Initialize vector registers with proper vsetvli then it can work normally
>   - Refine ptrace porting due to generic API changed
>   - Code clean up
> 
> Changelog V6
>   - Replace vle.v/vse.v instructions with vle8.v/vse8.v based on 0.9 spec
>   - Add comments based on mailinglist feedback
>   - Fix rv32 build error
> 
> Changelog V5
>   - Using regset_size() correctly in generic ptrace
>   - Fix the ptrace porting
>   - Fix compile warning
> 
> Changelog V4
>   - Support dynamic vlen
>   - Fix bugs: lazy save/resotre, not saving vtype
>   - Update VS bit offset based on latest vector spec
>   - Add new vector csr based on latest vector spec
>   - Code refine and removed unused macros
> 
> Changelog V3
>   - Rebase linux-5.6-rc3 and tested with qemu
>   - Seperate patches with Anup's advice
>   - Give out a ABI puzzle with unlimited vlen
> 
> Changelog V2
>   - Fixup typo "vecotr, fstate_save->vstate_save".
>   - Fixup wrong saved registers' length in vector.S.
>   - Seperate unrelated patches from this one.
> 
> Greentime Hu (15):
>    riscv: Add new csr defines related to vector extension
>    riscv: Add has_vector/riscv_vsize to save vector features.
>    riscv: Add vector struct and assembler definitions
>    riscv: Add task switch support for vector
>    riscv: Add ptrace vector support
>    riscv: Add sigcontext save/restore for vector
>    riscv: Add support for kernel mode vector
>    riscv: Use CSR_STATUS to replace sstatus in vector.S
>    riscv: Add vector extension XOR implementation
>    riscv: Initialize vector registers with proper vsetvli then it can
>      work normally
>    riscv: Optimize vector registers initialization
>    riscv: Fix an illegal instruction exception when accessing vlenb
>      without enable vector first
>    riscv: Allocate space for vector registers in start_thread()
>    riscv: Optimize task switch codes of vector
>    riscv: Turn has_vector into a static key if VECTOR=y
> 
> Guo Ren (5):
>    riscv: Separate patch for cflags and aflags
>    riscv: Rename __switch_to_aux -> fpu
>    riscv: Extending cpufeature.c to detect V-extension
>    riscv: Add vector feature to compile
>    riscv: Reset vector register
> 
> Vincent Chen (1):
>    riscv: signal: Report signal frame size to userspace via auxv
> 
>   arch/riscv/Kconfig                       |   9 ++
>   arch/riscv/Makefile                      |  19 ++-
>   arch/riscv/include/asm/csr.h             |  16 ++-
>   arch/riscv/include/asm/elf.h             |  41 +++---
>   arch/riscv/include/asm/processor.h       |   3 +
>   arch/riscv/include/asm/switch_to.h       |  71 +++++++++-
>   arch/riscv/include/asm/vector.h          |  16 +++
>   arch/riscv/include/asm/xor.h             |  74 ++++++++++
>   arch/riscv/include/uapi/asm/auxvec.h     |   1 +
>   arch/riscv/include/uapi/asm/hwcap.h      |   1 +
>   arch/riscv/include/uapi/asm/ptrace.h     |  25 ++++
>   arch/riscv/include/uapi/asm/sigcontext.h |  24 ++++
>   arch/riscv/kernel/Makefile               |   7 +
>   arch/riscv/kernel/asm-offsets.c          |   8 ++
>   arch/riscv/kernel/cpufeature.c           |  16 +++
>   arch/riscv/kernel/entry.S                |   6 +-
>   arch/riscv/kernel/head.S                 |  22 ++-
>   arch/riscv/kernel/kernel_mode_vector.c   | 158 +++++++++++++++++++++
>   arch/riscv/kernel/process.c              |  49 +++++++
>   arch/riscv/kernel/ptrace.c               |  71 ++++++++++
>   arch/riscv/kernel/setup.c                |   4 +
>   arch/riscv/kernel/signal.c               | 172 ++++++++++++++++++++++-
>   arch/riscv/kernel/vector.S               |  81 +++++++++++
>   arch/riscv/lib/Makefile                  |   1 +
>   arch/riscv/lib/xor.S                     |  81 +++++++++++
>   include/uapi/linux/elf.h                 |   1 +
>   26 files changed, 941 insertions(+), 36 deletions(-)
>   create mode 100644 arch/riscv/include/asm/vector.h
>   create mode 100644 arch/riscv/include/asm/xor.h
>   create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
>   create mode 100644 arch/riscv/kernel/vector.S
>   create mode 100644 arch/riscv/lib/xor.S
> 


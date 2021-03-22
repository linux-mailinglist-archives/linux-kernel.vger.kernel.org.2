Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D06D34529D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCVWxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCVWxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:53:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0881FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:53:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id u19so9786122pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMWkzrSo5KuqOR1bhr2dUZDy4tkfAgiPa5VKDqfy5u0=;
        b=WA3OUblmI3H2wHub1+U+W1gxJ7eS8+MyEgC07bP784ezCamg3DDr9UyT3patqJtzKi
         FRrTrvJdOBnVyFmoJlht1WV211XeoWCQF4/BzAPXG4nuCWObGLApOnhnK4Ya9PwevUvv
         9DxQ+Tjezp236sO1u5oSqf76vyQmfiRi42Biv23aQj5fDaP2FB34WaferzvI7Sdqkxos
         G483XQ4fR1DZRWcaxPa0twXSG4VrTgBlCVmCyBhba1grLMlmy3BIEOEomF8Z4jKRCsFF
         8sEWXGZCaUYTpg9raL/59E5pzuGos9qQJJ5MDocLzITxY/nacGeKugSfVBZGLe62NjnM
         JWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMWkzrSo5KuqOR1bhr2dUZDy4tkfAgiPa5VKDqfy5u0=;
        b=fUyP9SXPu7E1rCrMKxj6mnTHSTv74Ndc95dsoHQVHF1anPljNkK0ytC3ckwB3s/awB
         r9vo62bCuNeIQ4TDbLxoo22LZNre1ieVPwguhPkoMxCm+kXAeo9PaJ+lELRFY6wk1WXC
         CTfyrVRh1tPbBAgTNHMpmQk+TSnXCQEpLIA2HEn38ICrUWELoy1YHBpRikt4XUiqj0if
         8ovWcvTw4LqcsUrJtG7Yistl6LE6Paaj+1IGVMcy8tV7rRzjF3NC7soAzSCXG7h16H9U
         vUmQ3QQEM24cK1vuwipylqa+fWMiXTyQKdBeg4MlnBylbBgl8PGfCHQ/ZLpZq4Ql5vfQ
         mlig==
X-Gm-Message-State: AOAM533UnCLHCwWh4hzlDKt3gFos2SHQU8pxdD/KGEsEFOh8eQcPCv3P
        K2b6jEpj5yTdtZyzDISDirc=
X-Google-Smtp-Source: ABdhPJwZY1xe6/n+orT2rrli45SQZaJCH8VwdAdujySIDUQ2TjlZsLNwqHO6Rie3+LAV6U01+x8qNw==
X-Received: by 2002:a05:6a00:1595:b029:217:49e9:2429 with SMTP id u21-20020a056a001595b029021749e92429mr2008514pfk.80.1616453594251;
        Mon, 22 Mar 2021 15:53:14 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id j13sm8878211pfn.103.2021.03.22.15.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 15:53:13 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH 0/4 v3] arm64/ptrace: allow to get all registers on syscall traps
Date:   Mon, 22 Mar 2021 15:50:49 -0700
Message-Id: <20210322225053.428615-1-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two known problems with registers when a tracee is stopped in
syscall traps.

The first problem is about the x7 register that is used to indicate
whether or not the stop has been signalled from syscall entry or syscall
exit. This means that:

- Any writes by the tracer to this register during the stop are
  ignored/discarded.

- The actual value of the register is not available during the stop,
  so the tracer cannot save it and restore it later.

For applications like the user-mode Linux or gVisor, it is critical to
have access to the full set of registers in any moment. For example,
they need to change values of all registers to emulate rt_sigreturn or
execve and they need to have the full set of registers to build a signal
frame.

The second problem is that orig_x0 isn't exposed to user-space. orig_x0
is recorded at the start of the syscall entry and then it is used for
resetting the argument back to its original value during syscall
restarts.

This series extends the user_pt_regs structure with orig_x0 and orig_x7.
This doesn't break the backward compatibility. There are two interfaces
how user-space can receive user_pt_regs from the kernel. The first one
is PTRACE_{GET,SET}REGSET. In this case, the user-space provides a
buffer and its size and the kernel fills only the part that fits the
size. The second interface is a core dump file where registers are
written in a separate note and the user-space can parse only the part
that it knows.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Keno Fischer <keno@juliacomputing.com> 
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Will Deacon <will@kernel.org>

Andrei Vagin (4):
  arm64: expose orig_x0 in the user_pt_regs structure
  arm64/ptrace: introduce orig_x7 in the user_pt_regs structure
  selftest/arm64/ptrace: add a test for orig_x0
  selftest/arm64/ptrace: add a test for orig_x7

v2: use the ptrace option instead of adding a new regset.
v3: append orig_x0 and orig_x7 to the user_pt_regs.

 arch/arm64/include/asm/ptrace.h               |   5 +
 arch/arm64/kernel/ptrace.c                    | 130 +++++++++++-----
 include/uapi/linux/elf.h                      |   1 +
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/ptrace/Makefile |   6 +
 .../arm64/ptrace/ptrace_syscall_regs_test.c   | 142 ++++++++++++++++++
 6 files changed, 246 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/ptrace/Makefile
 create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c

-- 
2.29.2


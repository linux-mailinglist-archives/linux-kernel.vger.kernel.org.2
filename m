Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587BA45ECDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbhKZLrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242206AbhKZLpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:45:35 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D3CC0619F8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 03:06:59 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id i13so6898722qvm.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 03:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YWCZ3fojdi4NfKzhjDOPDnS4At+SJY9lzdeZc4JYD/g=;
        b=j2cfiWDuMVhpk1ibXtOjgctz8doYoNABZiLWwVDBMliGNaVuwOMWD2KlC4fRLoNf+E
         RD/Tu3E2hU7+2twMrWAMNfBuX/EpzJNik/QQTT9VYT64vPmnd0z+r6cnTZCU3Y703v+e
         LNqIa9IymQct3WYjn0tyhfnqYEJ87ijRUZrOnowZw9QBJpgaEfzenAV0cliWw8IT+AFB
         kdY/LCkqtnKR9xiPXl4LyEiosrUbEZMw1Bi/rw0Fpxul+pk6+YZRY5Jy+BX53Ugj52HK
         b6Tx7XbkJt0YwRxWzDyCkBjo/xscqZNbrEF1r/h7tSOhIvWZIOrGa8BlAJKG7nZs+sNl
         MWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YWCZ3fojdi4NfKzhjDOPDnS4At+SJY9lzdeZc4JYD/g=;
        b=CZiVs+Yzpq5JVzrNxQRDSbxmlSa2y0nuZ+ZF2ivrvSWM043WW2yQ528T8L6tPRk6e4
         1notfgdBNw+k9U0AgxMs7+j/nbudpYplXPdQ6bCkMJePuFivMK1F3AdW6JoqhB3pu+5V
         AD/mYqTT5HqbiQSJ3k2D9R9D/QtpU0KtSk0MGJeywuelXsvQUQ3SoMksNGCL56JN3VCz
         kDJV4vepjjd7CjVRRlolkGe6cL26nBMv05jtKlcD7PmFcePZEA0ZS0OjNUFSEtbznM8z
         ApBdLkC4h1wkYGfFFLdwRYSxb61Lwga/TRDclvnKQH74A17hmij3bnRVRVKdLJNs4mse
         zbig==
X-Gm-Message-State: AOAM5322HV8Aaa4z7n+O5pWDzQTWRrMis2cMfXgd7KNcieSrn8NHw90i
        8nfFmCfWjyFtgletJp/kij27l71AsJlR2g096XqIgg==
X-Google-Smtp-Source: ABdhPJwM3gGfu/bZI8z9rEqxh9zPLz5J5NFRwiU5rdfNRCEhS4k+U05E6m6DzKvLn/LhyEGyPSxluPG54adIQD4c1WU=
X-Received: by 2002:a0c:8031:: with SMTP id 46mr11871238qva.126.1637924818229;
 Fri, 26 Nov 2021 03:06:58 -0800 (PST)
MIME-Version: 1.0
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 26 Nov 2021 12:06:22 +0100
Message-ID: <CAG_fn=V9T6OKPonSjsi9PmWB0hMHFC=yawozdft8i1-MSxrv=w@mail.gmail.com>
Subject: Potential information leak in save_xstate_epilog()
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Cc:     Dmitriy Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Taras Madan <tarasmadan@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chang, Thomas, Borislav,

"x86/fpu/signal: Prepare for variable sigframe length" has presumably
introduced an information leak to the userspace.

According to https://elixir.bootlin.com/linux/v5.16-rc2/source/arch/x86/ker=
nel/fpu/signal.c#L126,
save_sw_bytes() only initializes the first 20 bytes of sw_bytes, but
then the whole struct is copied to the userspace.

KMSAN report follows:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user
./include/linux/instrumented.h:121
BUG: KMSAN: kernel-infoleak in __copy_to_user ./include/linux/uaccess.h:154
BUG: KMSAN: kernel-infoleak in save_xstate_epilog+0x2df/0x510
arch/x86/kernel/fpu/signal.c:127
 instrument_copy_to_user ./include/linux/instrumented.h:121
 __copy_to_user ./include/linux/uaccess.h:154
 save_xstate_epilog+0x2df/0x510 arch/x86/kernel/fpu/signal.c:127
 copy_fpstate_to_sigframe+0x861/0xb60 arch/x86/kernel/fpu/signal.c:245
 get_sigframe+0x656/0x7e0 arch/x86/kernel/signal.c:296
 __setup_rt_frame+0x14d/0x2a60 arch/x86/kernel/signal.c:471
 setup_rt_frame arch/x86/kernel/signal.c:781
 handle_signal arch/x86/kernel/signal.c:825
 arch_do_signal_or_restart+0x417/0xdd0 arch/x86/kernel/signal.c:870
 handle_signal_work kernel/entry/common.c:149
 exit_to_user_mode_loop+0x1f6/0x490 kernel/entry/common.c:173
 exit_to_user_mode_prepare kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290
 syscall_exit_to_user_mode+0x7e/0xc0 kernel/entry/common.c:302
 do_syscall_64+0x60/0xd0 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x44/0xae ??:?

Local variable sw_bytes created at:
 save_xstate_epilog+0x80/0x510 arch/x86/kernel/fpu/signal.c:121
 copy_fpstate_to_sigframe+0x861/0xb60 arch/x86/kernel/fpu/signal.c:245

Bytes 20-47 of 48 are uninitialized
Memory access of size 48 starts at ffff8880801d3a18
Data copied to user address 00007ffd90e2ef50
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

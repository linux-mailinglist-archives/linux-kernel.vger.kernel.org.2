Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1583099AB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhAaBdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhAaBdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:33:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E1C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:32:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id w1so18707397ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7qYklskUu2VAEfgSwebV/QStBWQHOQZ6mWiPbg6iHLs=;
        b=fsLveMfXsSyI5FfoEdvdrRAjraZsatgeDbdDajigaOGnuqY64N0WwDWHmk0cvnJxLK
         BBM/V8ihSKXlczpLbYKJI0M4PLlQXxrRJOxYEvt0RZiN0juJ8OEkY254cRZvPlEO21Y/
         g7B3apBianXKAoHjo4YNbonCERzYfMLdJySfYXlYZdzwj4b+eEjKJftjF1q4aXBWsWya
         0BG4hV8F99j0GXfNEkOMsaLJOoE9hzDF2YQJoflsX8dG+gGsZqp/s/ywQ0GvDjiKlmGO
         6xdAceV7P5OZumw1zoBpCDPh25S9QoZeQcIc16yYoNGJFLjM/okUlDY9+RDpZGVvFLCA
         5/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7qYklskUu2VAEfgSwebV/QStBWQHOQZ6mWiPbg6iHLs=;
        b=DfTfBS6DJ9D4zYPcHTQ3PYZEzrr689C2BNXZkHFAPNdsZTtQfZsirmTSpZ+OOhaLe+
         0LP1e53BFDxsXU/iwW7Asrf6bYBshtZLLPk1q0d+dInjrEik2Iuv+qOsFVcMg8mmb8F9
         d6BmIdBDdd49sGYyk9+CAGpvHPSk6KC86OihySrNx39lyFEI1E8yShHDFQjdj3VUuEUY
         6sDxKBH7X6QR63ybbTrRMCLTX+sd4cu6kTn1bPNzo3oehu10/ZUMPfBzxRSYGVIpRFBH
         YZyzqR8kCN9ZSnN0iNSaj+d8CM1nv9rcK9/piNRSBV2hrnVPtAkKeo5mWS3QJp+aET++
         DcAQ==
X-Gm-Message-State: AOAM533EmLuqlBXObfBCAAnZXIeLR4MwXQAo/Q8pNCgeYQCraJwYy3gA
        vE0my6dgt2jhpxDKAkBR/ct8UpCXsR9QGS0nb0XHFEvNh+Izl/6Y
X-Google-Smtp-Source: ABdhPJxXx/b7OBpWjwRFnHe/d/T0ChYaD+tBlTmZDtIPI8ANBWIOMsQwXU7Lq0Pyj5nRFCXlutZyGv46deLC+GxFGyI=
X-Received: by 2002:a17:906:4893:: with SMTP id v19mr11167316ejq.454.1612056752381;
 Sat, 30 Jan 2021 17:32:32 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Sat, 30 Jan 2021 17:32:21 -0800
Message-ID: <CAP045AoL4=6L16Nxi4TW7Jt8dqNXBQTvZZOqBEBRRcZdHCQ_VA@mail.gmail.com>
Subject: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yuxuan Shui previous reported a regression in single step reporting,
introduced in 64eb35f701f04b30706e21d1b02636b5d31a37d2, with a patch
to fix it.

However, after that is fixed, there is another regression introduced
later in the same series, in 2991552447707d791d9d81a5dc161f9e9e90b163,
that again breaks the same code.

The patch renames ARCH_SYSCALL_EXIT_WORK to ARCH_SYSCALL_WORK_EXIT,
which orphans the definition of ARCH_SYSCALL_EXIT_WORK in
arch/x86/include/asm/entry-common.h. No work was done to port
TIF_SINGLESTEP to syscall_work. Despite the code in report_single_step
that checks current_thread_info()->flags, because the code is no
longer checking the TIF values at all to decide whether to enter
syscall_exit_work, report_single_step will never be called and we will
again fail to report the single step.

I tested that with 2991552447707d791d9d81a5dc161f9e9e90b163 reverted
and Yuxuan's patch applied to Linus's tip rr works and passes all
tests.

- Kyle

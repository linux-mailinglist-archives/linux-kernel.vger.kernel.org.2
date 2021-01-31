Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804FC309ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhAaUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhAaTcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:32:00 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56391C061226
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 10:54:49 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id q5so13541461ilc.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:date:message-id:mime-version;
        bh=9EQjMFUoxwfhWgFbfFlxjta7rYQ95+kNXuosa8mQr1I=;
        b=KP04VQ4LSFM5h+wBGcNtR1X1n8c39xtd7npnVcDiQiszIZBHMCpYwZEbm/iow/J9Su
         FIdm5Ha4Wx5xA6dVDapuW2F2LAHwPnQm/xP6hOFG0lQkBqTCnlEE3AZWlycTTozXTo+B
         Ryy2xNZf0WtPd6YCVgdPrLi7SwXrpNPq3DdgDh6uR7dyUp+c0cSEIc4GZCzXvlcBNzpa
         w51pY4P9oSyq+Kl/N/nEqq5br30v9xRcsiO0wpw91kSMGeGdcsVpPla6Z3MiA+APUgkJ
         m7iznfx8xHZ2hZpAexTS2hQo/i8IT7zlofLsEBjw97oKfSArfPyw8RjFOAxyRGvDTfL4
         H4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=9EQjMFUoxwfhWgFbfFlxjta7rYQ95+kNXuosa8mQr1I=;
        b=moOo8eFXN1DkrKo6JinEfUqRXLzgDHZbLc4tpON3FJ+ZhXOnpLB7O7MJfYA0yOLTTw
         rBDdO6V3SM5pKtVX8h6nfYEJN/FKI6mMYe7Cc9zv2R4dru9vxQ9TSG/25zmhIjQOykC5
         4EKR60TtKLwaxYuHZ0IlmunAfjYTV33vSUm3VuZpIDJbJjM8Qid2yGbX5lCSUNYKhmcc
         GmydCMqHp/5J51Mb0ENv7hLi6Bpev/e1A1EbM1fSJrv6gihO/s542X/jwNmQFHlg082V
         sThW/7MwfH5atdHR9/NSC7IjVF4UeB7U9FE3gx5BhieQFRwmHaQJFhgBbk3wvj/kUkEb
         Y9zQ==
X-Gm-Message-State: AOAM531F8gCz56cjDE9g3WVZ0Cl13tbfirec7/im9EcO3DNsyyzu2Q5c
        qxVw/rCNN+VMebqquZEnA/M=
X-Google-Smtp-Source: ABdhPJyB8xbsqGnpg6KU55EQzOdq9s60r0HmAUwcKPHKbmDzpg39dsZOy90MvjWuuayBm4nsaEBMRA==
X-Received: by 2002:a92:bd06:: with SMTP id c6mr11570835ile.158.1612119288092;
        Sun, 31 Jan 2021 10:54:48 -0800 (PST)
Received: from localhost (cpc158799-hari22-2-0-cust25.20-2.cable.virginm.net. [82.3.12.26])
        by smtp.gmail.com with ESMTPSA id o8sm7905295ilu.55.2021.01.31.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 10:54:47 -0800 (PST)
From:   Yuxuan Shui <yshuiv7@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Kyle Huey <me@kylehuey.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
In-Reply-To: <CAP045ApxLJ7vXOVp5Cwx7WEyDr6v01D9YD3xGFDv3WAp6czaMQ@mail.gmail.com>
Date:   Sun, 31 Jan 2021 18:54:35 +0000
Message-ID: <87v9bdc4yc.fsf@m5Zedd9JOGzJrf0>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I didn't understand Kyle's point at first, so I asked for clarification
and will record my understanding below for posterity.

ARCH_SYSCALL_EXIT_WORK was a flag that was checked by various functions
(via SYSCALL_EXIT_WORK) before calling syscall_exit_work, which is what
reports single steps. This flag was supposed to be overridden by
architecture specific definitions. And indeed, x86 overrides it, to
TIF_SINGLESTEP.

However, commit 2991552447707d791d9d81a5dc161f9e9e90b163 renamed
ARCH_SYSCALL_EXIT_WORK to ARCH_SYSCALL_WORK_EXIT, thus x86's definition
no longer override it.  Looks like there was an oversight the definition
in x86 wasn't updated.

But renaming the definition in x86 is not enough, as TIF_SINGLESTEP is
set in current_thread_info()->flags, and the same commit has removed the
code that checks those flags. We have to also migrate TIF_SINGLESTEP from
thread info flags to syscall work flags, to make the whole thing work again.



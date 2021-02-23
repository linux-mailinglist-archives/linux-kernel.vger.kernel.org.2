Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B321B32295C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 12:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhBWLPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhBWLPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:15:11 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072EAC061574;
        Tue, 23 Feb 2021 03:14:31 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id m9so16061740ybk.8;
        Tue, 23 Feb 2021 03:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66RIJZTLOIKeO/S5DK3+EUiWHslrgEORNm6Qsur7ruE=;
        b=YtQYN+u8TzuWtr9bKLAZNvSYZa7MnFTwG9NGOekFfak0+2rGN+7A6YlwUV5qsh6DLk
         rwrg/YLq37Lh0yNUrzI3EviW9qRFBBwjBFtldDzFMTdRSpds/iZ/bDfneKbT0ZazHYd5
         FBUrG0fdfat/7d7VTKSdHLB0c9QwC5DIoC0LqG+JFtfeKgLMY6EySLanq8l+IiybjlAc
         eS29TekTxW8TgLHkzOyE6RmMvP7hRr9beYI4rZp1DDFC/neLk8Hf2TKWFpKIpPRJ6FzZ
         sCL1S5qQvMGbXu7oqiFfQF6rdRka2e5EQ5nfu4cSNV+yEUu2absZKm3OCoaNzmwhONKG
         /u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66RIJZTLOIKeO/S5DK3+EUiWHslrgEORNm6Qsur7ruE=;
        b=Z/j2sXuQ/Ozt0t/KFET1XZFd5XmD0KEJDz5CAuCLh3vgkjhj6Y01xYcuukJcp1sh0y
         xNWG+e9leT/SrEVL1sq3sho/ReKlmqFYwUVtsAHMcv+vmb3yOCfJKx3Khk5k67vh/9f7
         fwSKgRhHbRx3OUPE6CH2slQfoIRrtKLEyho/gUc2za810/ds2Mvxd4NSGA0TAUlwVVcA
         0qeZsFMprq3SjQtT7STvf6sWVQmtvq/4j/tfwc9igrhL6clpYN0/yXbkVo37QaRv5ag+
         eLxfp0RKkWslcQ6Xk8uSeCuHAEp1JyMpUL5UvO9CT6IY+5RqeXUwMT+cDr8fsG/eHZcU
         hUqw==
X-Gm-Message-State: AOAM530QSTOlx7iaUYiu396n1ETQIYrzPEDG5kvdt+YimcZiS681ZTtZ
        QLPBM2QYCqnCMoxMiI1zh+ORls+oPkSQ/e3vDuLzHIHTRgtCHg==
X-Google-Smtp-Source: ABdhPJyKsKsqB7j6CTkISkvGFigTd25VQmp+DjuGj+CD4EMpHkQ8vaPglwq5x/A8vknft22Qdhb7EkhGubrWC7MJ3do=
X-Received: by 2002:a25:800c:: with SMTP id m12mr36708237ybk.25.1614078870334;
 Tue, 23 Feb 2021 03:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20210217080000.GA25861@altlinux.org> <m1tuq9nsnf.fsf@fess.ebiederm.org>
 <20210219225030.GA23520@altlinux.org>
In-Reply-To: <20210219225030.GA23520@altlinux.org>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 23 Feb 2021 14:14:19 +0300
Message-ID: <CADxRZqzPn4yT+ZJCjAoqnKqC1MFPeKCYbhmqRAi-aD8-0Y3DQw@mail.gmail.com>
Subject: Re: [PATCH v2] sparc: make copy_thread honor pid namespaces
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 1:51 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> On sparc, fork and clone syscalls have an unusual semantics of
> returning the pid of the parent process to the child process.
>
> Apparently, the implementation did not honor pid namespaces at all,
> so the child used to get the pid of its parent in the init namespace.
>
> Fortunately, most users of these syscalls are not affected by this bug
> because they use another register to distinguish the parent process
> from its child, and the pid of the parent process is often discarded.
>
> Reproducer:

tested on my sparc64 ldom:

1. non-patched kernel (kernel 5.11.0-03615-g55f62bc87347), reproducer/test run:

$ gcc -Wall -O2 sparc-fork-namespace2.c
$ ./a.out
current: 72544, parent: 69045, fork returned: 72545
current: 72545, parent: 72544, fork returned: 72544
current: 72544, parent: 69045, fork returned: 72546
current: 1, parent: 0, fork returned: 72544

2. kernel patch applied, test run:

$ uname -a
Linux ttip 5.11.0-09279-g7c70f3a7488d-dirty #185 SMP Tue Feb 23
00:50:11 MSK 2021 sparc64 GNU/Linux

$ ./a.out
current: 939, parent: 918, fork returned: 940
current: 940, parent: 939, fork returned: 939
current: 939, parent: 918, fork returned: 941
a.out: wait: 0x9

and console/kernel logs:

[   72.204212] Kernel unaligned access at TPC[4060c8] ret_from_fork+0x1c/0x2c
[   72.204254] Unsupported unaligned load/store trap for kernel at
<00000000004060c8>.
[   72.204267]               \|/ ____ \|/
[   72.204267]               "@'/ .. \`@"
[   72.204267]               /_| \__/ |_\
[   72.204267]                  \__U_/
[   72.204284] a.out(941): Kernel does fpu/atomic unaligned load/store. [#3]
[   72.204298] CPU: 6 PID: 941 Comm: a.out Tainted: G      D     E
5.11.0-09279-g7c70f3a7488d-dirty #185
[   72.204315] TSTATE: 0000004411001600 TPC: 00000000004060c8 TNPC:
00000000004060cc Y: 000000cf    Tainted: G      D     E
[   72.204330] TPC: <ret_from_fork+0x1c/0x2c>
[   72.204340] g0: 0000000000000000 g1: ffffffffffffffff g2:
0000000000000006 g3: 0000000000000000
[   72.204349] g4: fff8000041482700 g5: fff80021a9890000 g6:
fff8000041038000 g7: 0308000108000004
[   72.204359] o0: 0000000000000000 o1: 000000001fffffff o2:
fff8000041482780 o3: 0000000000000000
[   72.204369] o4: 0000000000000001 o5: 0000000000000000 sp:
fff800004103b6a1 ret_pc: 00000000004060b0
[   72.204378] RPC: <ret_from_fork+0x4/0x2c>
[   72.204387] l0: 0308000108000000 l1: 0000000000000002 l2:
0000000000450cf4 l3: 0000000000000000
[   72.204396] l4: 0000000000000264 l5: 00000100001eb9f0 l6:
fff8000045018000 l7: 00000000006c7840
[   72.204406] i0: 0000000000efcd60 i1: 0000000000450df4 i2:
00000000000003dc i3: 00000000000003dc
[   72.204415] i4: 0000000000eebc78 i5: 0000000000000000 i6:
000007feffa56811 i7: 0000010000000ad8
[   72.204424] I7: <0x10000000ad8>
[   72.204432] Call Trace:
[   72.204439] Caller[0000010000000ad8]: 0x10000000ad8
[   72.204446] Instruction DUMP:
[   72.204449]  0aca0072
[   72.204456]  e059a008
[   72.204461]  e25ba8c7
[   72.204467] <9fc44000>
[   72.204472]  d05ba8cf
[   72.204477]  1068006d
[   72.204483]  90102000
[   72.204488]  0f0011a9
[   72.204493]  10680004
[   72.204499]


So something is actually wrong with the patch.

Thanks.

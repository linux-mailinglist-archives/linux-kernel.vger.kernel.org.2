Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F5C43E17A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJ1ND4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhJ1NDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:03:50 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0553C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 06:01:23 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso8404778ota.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6abh9rbyq5i0c3lEwL8JEp/QxYD5E45A4rzzLbAZz4=;
        b=pWoTSyChkbOfxamHokmzaQKZ7GsQOmXmcnbCTeNXe6S37NvhsZv+tFqo0RzFmaUql5
         917jXpISKiZ7VftI4/OJqsavjxHam+vA15S4blQFxRKt7t9TIqr1vcaILQi3ztDsJovk
         tyaR8wA8dZqPuBtSMBy4snBwK5aW+MMcp+NM34dH6t3Z/mKwI4fOT2zxm7RNshZunFVF
         D3KtJiaCZz6akv8AETZPQRRIyc8gyNXmu5KguqidDEM6bjDnX4dEcNf6HSssru+sQQ05
         5C8pk1ahoL4jbCYenxNIQU7I04jHjZl6nwDrX1MT/TyCtR7hDnTdwMw3F4hMEBQnrJyW
         8vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6abh9rbyq5i0c3lEwL8JEp/QxYD5E45A4rzzLbAZz4=;
        b=q0tmFt3DptCH82b3rvVT5I5yPMcV0lHUIQoo9HogmaeR9fUBM8VTqJOLwY4NdUmG1w
         8tG7ogWUc2m6+k1x1bbRuJLPuqJ9sYHVOLH5nyUa5eszuUrXbaPoHCd8MXSaw0WY+Rvg
         ii5mwK6uJW72lWZWfL4EjanNXtuMl+0TuDac1sGNkfoX44zqGjohOfyfYH01nOeygvzI
         8B7dVvkkmEguSAztyqJv84tBGJ56mh0Ur0SxxNepplLWsK4rRG2bohez01GuuyYuSP81
         /JqnVmbc7IRSd1whGV5GjM6X86sloQa9rhgco1/yYyl9gFa8Jtb/v/THmOiMpdvlANNi
         7nIQ==
X-Gm-Message-State: AOAM533xDiTKTEyJcMt/ZDviq+gWGU+OnF350zgymNDH+0ghCGPwYZra
        tvCqOaNTAi6AwWDWHyiApQD0ckGlnyexYpy0GwwXlQ==
X-Google-Smtp-Source: ABdhPJzk1S5+dO0ZzTKUta+2OCQaEcJRe9yM1hiuiSnj2JAcTu52Ni7HOMvjHdlhg0hl5n5BgSCnhR9yb13ujSQq88c=
X-Received: by 2002:a05:6830:2905:: with SMTP id z5mr3309434otu.137.1635426082877;
 Thu, 28 Oct 2021 06:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000016ca805beaf4d26@google.com> <0000000000000477e405cf4de9b8@google.com>
In-Reply-To: <0000000000000477e405cf4de9b8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Oct 2021 15:01:11 +0200
Message-ID: <CACT4Y+ZdfLfUENLBoxn8RAXX7pDqy03X4m_gvkQ06265agJGqg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in emulate_vsyscall
To:     syzbot <syzbot+2698183e871d8a137f9d@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, bp@suse.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, keescook@chromium.org, krisman@collabora.com,
        liangjs@pku.edu.cn, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wad@chromium.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 at 06:20, syzbot
<syzbot+2698183e871d8a137f9d@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit d4ffd5df9d18031b6a53f934388726775b4452d3
> Author: Jiashuo Liang <liangjs@pku.edu.cn>
> Date:   Fri Jul 30 03:01:52 2021 +0000
>
>     x86/fault: Fix wrong signal when vsyscall fails with pkey
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bb466f300000
> start commit:   009c9aa5be65 Linux 5.13-rc6
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ca96a2d153c74b0
> dashboard link: https://syzkaller.appspot.com/bug?extid=2698183e871d8a137f9d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e1a704300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125a92d0300000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: x86/fault: Fix wrong signal when vsyscall fails with pkey
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks plausible:

#syz fix: x86/fault: Fix wrong signal when vsyscall fails with pkey

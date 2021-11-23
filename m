Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC42459B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhKWFUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhKWFUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:20:30 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8949CC061748
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:23 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id w4so9325576ilv.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6wA+fTxcw8TAoeh651HUjfstV6lKGvsFMZxmdYQsbE=;
        b=LU0ZvfU9vK5eZWidIvLRF/tW0j9fzVK2tqFxAN7l+MCYBDErEndqlom8GzkX1iU1ZS
         uS6TETBuFWQRgsAxfGPLv4tab5U1m0k/oX72iqRJtV2Xot7fpXVCgXQzZrsbp+JprHIK
         gaKJFZ6rNOSav8jZTRH/P+yWHKQi/NUkGm7A8e8HZyr0mGsnB3RNmSheBlOPl6iDA8o0
         87EMLVR/0Ms9rV0IFJIGnPEL+TjVXX5YAKsTeFN+lupkfcM2CXFzfmE8ipI7I0UOwlOU
         SutZqO6K7EsNpssL0zIKdXie3Tsr0V0wrL4k0DbVN10XLcbYkga0GS3ePjm78qHkUV4n
         q/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6wA+fTxcw8TAoeh651HUjfstV6lKGvsFMZxmdYQsbE=;
        b=EWvm8IODFQ9t3YibgYSimlCDCjmy9g7vX70PkOGEyckBBP64Jsdw8lqe+F/ad75MGZ
         piMjiv+/rxVgEKPtGDv0kpKrYZhcDMA+bN1Gf+776z8r+u580/TgbCDR47WGzvmPs3Il
         oqKPpctUjg05msLUbfyJcUnh1xy6PHS+EHYrtrfsxKE9eoziPO40pGXtEOcnVbqldlLU
         A4cnnJw66DryIvQ/HHmJQXBGaEayzX/gLb7xYjWryF1hFBpYklEh+73lvoNgZw3tL1XF
         a1y3+vpgduBC6ZXi6o36LLyAN5IEy97wfC30vfcuOzfLGutTjEqJoN6LmjXNUnm7AUW7
         v21A==
X-Gm-Message-State: AOAM533qotAOK9YHguAiCukk9p5FhbrWFWA2ASY31z36zaOMheQo18A5
        C8VbZ7+WIOtC6hv8nV8FeBv3y/SR2AE3sttS6EXzNw==
X-Google-Smtp-Source: ABdhPJym9u5SF1PXPJzAgk/mV0cTda0xvKfSqcK5DnCV2QotJzY53LEERFeLrxQwzh5W8F2ocMM0QeOScZZbOHSMuT4=
X-Received: by 2002:a92:2012:: with SMTP id j18mr1185759ile.146.1637644642772;
 Mon, 22 Nov 2021 21:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20210922061809.736124-1-pcc@google.com> <YUrNdPLh+keAKPUy@grain>
In-Reply-To: <YUrNdPLh+keAKPUy@grain>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 22 Nov 2021 21:17:11 -0800
Message-ID: <CAMn1gO6V+tdFkZONFzAXyq3fgLsmpuaUcGno=Za6_ihQgNrGpw@mail.gmail.com>
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Balbir Singh <sblbir@amazon.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:30 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Tue, Sep 21, 2021 at 11:18:09PM -0700, Peter Collingbourne wrote:
> > This patch introduces a kernel feature known as uaccess logging.
> > With uaccess logging, the userspace program passes the address and size
> > of a so-called uaccess buffer to the kernel via a prctl(). The prctl()
> > is a request for the kernel to log any uaccesses made during the next
> > syscall to the uaccess buffer. When the next syscall returns, the address
> > one past the end of the logged uaccess buffer entries is written to the
> > location specified by the third argument to the prctl(). In this way,
> > the userspace program may enumerate the uaccesses logged to the access
> > buffer to determine which accesses occurred.
> ...
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index e12b524426b0..3fecb0487b97 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -34,6 +34,7 @@
> >  #include <linux/rseq.h>
> >  #include <linux/seqlock.h>
> >  #include <linux/kcsan.h>
> > +#include <linux/uaccess_buffer_info.h>
> >  #include <asm/kmap_size.h>
> >
> >  /* task_struct member predeclarations (sorted alphabetically): */
> > @@ -1487,6 +1488,8 @@ struct task_struct {
> >       struct callback_head            l1d_flush_kill;
> >  #endif
> >
> > +     struct uaccess_buffer_info      uaccess_buffer;
> > +
>
> Hi, Peter! I didn't read the patch carefully yet (will do once time permit)
> but from a glance should not this member be under #ifdef CONFIG_UACCESS_BUFFER
> or something? task_struct is already bloated too much :(

Yes, I've now added an ifdef here (previously I had the ifdef inside
the struct uaccess_buffer_info, but I think this would still leave
some space due to C struct layout rules).

>
> > +     case PR_LOG_UACCESS:
> > +             if (arg5)
> > +                     return -EINVAL;
> > +             error = uaccess_buffer_set_logging(arg2, arg3, arg4);
> > +             break;
>
> Same here (if only I didn't miss something obvious). If there is no support
> for CONFIG_UACCESS_BUFFER we should return an error I guess.

The uaccess_buffer_set_logging (now
uaccess_buffer_set_descriptor_addr_addr) function is defined to return
-EINVAL if CONFIG_UACCESS_BUFFER is not defined.

Peter

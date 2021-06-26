Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A413B3B4CCE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 07:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFZFTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 01:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhFZFTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 01:19:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA05C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 22:17:21 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g14so9206672qtv.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 22:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omobQP/IX1kTmQx8gX/JOAH5N2ogu7UgIhNdX+iiGPw=;
        b=XVUAzVFO4ejjsVn2v4yE0HpHhdDrJC74CZ0lITmtjBWjMsS8L8H0PNv+R8v4Nn4fDY
         AX6SjDhw7BUZf21YPdmzTVJuMzElkjcQAelFxXoA/YrCaIa4FnYPEDC4vIHsnjpoz8Sh
         g3viJym1kD0xNNtb0o49l+xijO5fhxV+TJG0ADH/Hq5IMJU6hAijJ2xpRod9kfxb1Tf1
         mA19mP8+aYnPoUjzXKrHZURIB94v7hV1/qF3fx3gqB9d2OTfJayq516D8jszqchQ/g1R
         NAdd4zOAdg++JOxDFs8VCTofHoHZLyUhoJW2G4mG+IFa8XTCDNGb/aiptEW/FlCBDHIi
         aXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omobQP/IX1kTmQx8gX/JOAH5N2ogu7UgIhNdX+iiGPw=;
        b=NbP5Ad5bSBP+g9o92AiN9dsXs5U4Wxgvt4F0rzR9sRDv0TzxRBCGD0pvhcNZSiYt2q
         S4n0dt1beppc3fLex3gNQMdeBp90iSPoIfBzuJXDlsisw9ArjoNMHzqdXRieTtBgITjy
         o5xXR8CgAi/q9vY7S7K0owiYNO21mFWyegKPW0jFQ8RnCCaTQltoFYeldr3OmiW7LR5c
         q1vE0mSVmIkW5UDHYPV/s233ZlKE9WaPLU6vlO5qVar0d19g+a4gyXs4crRl9B/8sN1z
         2X/kVXIvz3bb5EgamzjjBYdHpIi7OqwlZLyz6DMJmaN697ptf3AQqPStQ2QufXQ+tU3b
         9/DA==
X-Gm-Message-State: AOAM530qIbAqb+xaQSHQw+v9ubuTvmp8vS9+K7NRL8dXvwJAORTl8AVd
        XJHRnFzWxV4d8x2jrzGhHdAs9IkfSUB7DXFozO8y6njodGH/EA==
X-Google-Smtp-Source: ABdhPJzeZDAid/Zb7FvSg7V29Ap5PUijaOGz/hE//oPP/EehDlz6d1lqjVtLAeFSHLSHK/W3TgO4Ii7umxmoTCJqobo=
X-Received: by 2002:a05:622a:15cc:: with SMTP id d12mr12416182qty.67.1624684640111;
 Fri, 25 Jun 2021 22:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ef5d1b05c57c2262@google.com> <87fsx7akyf.fsf@disp2133>
 <CACT4Y+YM8wONCrOq75-TFwA86Sg5gRHDK81LQH_O_+yWsdTr=g@mail.gmail.com> <87lf6x4vp1.fsf@disp2133>
In-Reply-To: <87lf6x4vp1.fsf@disp2133>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 26 Jun 2021 07:17:09 +0200
Message-ID: <CACT4Y+YdFpx7-f-YwTnhj6Yy_aYGW7qkj+XV-7QT73DB2a=cmQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: out-of-bounds Read in do_exit
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+b80bbdcca4c4dfaa189e@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, ast@kernel.org, christian@brauner.io,
        jnewsome@torproject.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, oleg@redhat.com,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 8:59 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Dmitry Vyukov <dvyukov@google.com> writes:
>
> > On Thu, Jun 24, 2021 at 7:31 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> syzbot <syzbot+b80bbdcca4c4dfaa189e@syzkaller.appspotmail.com> writes:
> >>
> >> > Hello,
> >> >
> >> > syzbot found the following issue on:
> >>
> >> This looks like dueling debug mechanism.  At a quick glance
> >> stack_no_used is deliberately looking for an uninitialized part of the
> >> stack.
> >>
> >> Perhaps the fix is to make KASAN and DEBUG_STACK_USAGE impossible to
> >> select at the same time in Kconfig?
> >
> > +kasan-dev
> >
> > Hi Eric,
> >
> > Thanks for looking into this.
> >
> > I see several strange things about this KASAN report:
> > 1. KASAN is not supposed to leave unused stack memory as "poisoned".
> > Function entry poisons its own frame and function exit unpoisions it.
> > Longjmp-like things can leave unused stack poisoned. We have
> > kasan_unpoison_task_stack_below() for these, so maybe we are missing
> > this annotation somewhere.
> >
> > 2. This stand-alone shadow pattern "07 07 07 07 07 07 07 07" looks fishy.
> > It means there are 7 good bytes, then 1 poisoned byte, then 7 good
> > bytes and so on. I am not sure what can leave such a pattern. Both
> > heap and stack objects have larger redzones in between. I am not sure
> > about globals, but stack should not overlap with globals (and there
> > are no modules on syzbot).
> >
> > So far this happened only once and no reproducer. If nobody sees
> > anything obvious, I would say we just wait for more info.
>
>
> I may be mixing things up but on second glance this entire setup
> feels very familiar.  I think this is the second time I have made
> this request that the two pieces of debugging code play nice.
>
> Perhaps it is a different piece of debugging code and KASAN that
> I am remembering but I think this is the second time this issue has come
> up.

This is the only mention of DEBUG_STACK_USAGE on kasan-dev:
https://groups.google.com/g/kasan-dev/search?q=DEBUG_STACK_USAGE

Searching lore:
https://lore.kernel.org/lkml/?q=KASAN+%22DEBUG_STACK_USAGE%22

I found mention of:
kernel-hacking: move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE

Maybe you remember these 2?

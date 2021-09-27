Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C28419613
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbhI0OS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhI0OSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:18:24 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9407C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:16:46 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id e24so15846824oig.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTD1IG+YmWnt3+MCGA1ZnJmy0L2DQARzYfapPSB4ZVc=;
        b=tUsn/YgJ/eFCFZpyskDmCMeivFaP2fqq4Oq6Dq6hh6xs0nx946+/BgK+IaxupjHqvx
         jda3bZtBe1BqDC4akKu2X2DBeYgFKQRhuoSETOnf+wo6kPmykrP+zZPuhfrKgC0nlchY
         XRkVpzji/EI/EvwCH7YfOfDYJ3SI5fNfEpE57k6N8UohOQnBLGgCUdl994ObEIOtHOzt
         Iro27+J3JH7jK0ymDgf95lX35HlDaUoU2jFsJEfeL7EdwuQ68t1RE+2FIfnn3UxmrNXe
         JpB1q4tBafkXOBK1LMQjHqTRdDAiAq/xFk2yBbJy2IyG3IPVFSVSjJfwuaqsnsvAX1DI
         RM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTD1IG+YmWnt3+MCGA1ZnJmy0L2DQARzYfapPSB4ZVc=;
        b=sGSlkWsOioCoCQe+/czYE39ZbT5oe1E7nU5Y/0HODJnrJ9FtrfVaJ6+zAdWPW26/I8
         lUyNwM4vheAa9Y49V+o2OS+3v4FEERtNh0AxBIsVezgyzBOwiE2u+qvpUj46a5JbIrmv
         5DeSK1/IzJ0OksFFbfyAruydbLtSBL9mhJvKbb0dcG5AYsBKMU3nmK9pbaveMTcnbpiy
         HWd3s5LulFP3Hij+fIm53P/bBMcQ7deSGDWcq5QPyq4zbbaqe9mu6Q+sJQSdyIjeBUOI
         4mGueFJiyKW2kkXVhsrhNEHledwMLf+0XdCkO+3o0ThY73jlDpsR9Q+Bgz+QJBk+ZQRs
         IFVg==
X-Gm-Message-State: AOAM531ywI6SupaZr0kii0gxZVZhuXzahJu4TIBbWuJ95/c7XknpCvgO
        zIA4+rRANd16yITPWTygZxVg3K09M/V0aovmW/0Qwg==
X-Google-Smtp-Source: ABdhPJxDaeudxwkxlPymimuonBIsjqPbk86VRkuseG9eDQWJkkSHfIPR/ydllYEjjMZpuCCt6ESjslLDIx7h0IttkBQ=
X-Received: by 2002:aca:3083:: with SMTP id w125mr110205oiw.109.1632752205257;
 Mon, 27 Sep 2021 07:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d6b66705cb2fffd4@google.com> <CACT4Y+ZByJ71QfYHTByWaeCqZFxYfp8W8oyrK0baNaSJMDzoUw@mail.gmail.com>
 <CANpmjNMq=2zjDYJgGvHcsjnPNOpR=nj-gQ43hk2mJga0ES+wzQ@mail.gmail.com>
 <CACT4Y+Y1c-kRk83M-qiFY40its+bP3=oOJwsbSrip5AB4vBnYA@mail.gmail.com> <YUpr8Vu8xqCDwkE8@google.com>
In-Reply-To: <YUpr8Vu8xqCDwkE8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Sep 2021 16:16:33 +0200
Message-ID: <CACT4Y+YuX3sVQ5eHYzDJOtenHhYQqRsQZWJ9nR0sgq3s64R=DA@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: KFENCE: use-after-free in kvm_fastop_exception
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+d08efd12a2905a344291@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sept 2021 at 01:34, 'Sean Christopherson' via
syzkaller-bugs <syzkaller-bugs@googlegroups.com> wrote:
>
> On Fri, Sep 17, 2021, Dmitry Vyukov wrote:
> > On Fri, 17 Sept 2021 at 13:04, Marco Elver <elver@google.com> wrote:
> > > > So it looks like in both cases the top fault frame is just wrong. But
> > > > I would assume it's extracted by arch-dependent code, so it's
> > > > suspicious that it affects both x86 and arm64...
> > > >
> > > > Any ideas what's happening?
> > >
> > > My suspicion for the x86 case is that kvm_fastop_exception is related
> > > to instruction emulation and the fault occurs in an emulated
> > > instruction?
> >
> > Why would the kernel emulate a plain MOV?
> > 2a:   4c 8b 21                mov    (%rcx),%r12
> >
> > And it would also mean a broken unwind because the emulated
> > instruction is in __d_lookup, so it should be in the stack trace.
>
> kvm_fastop_exception is a red herring.  It's indeed related to emulation, and
> while MOV emulation is common in KVM, that emulation is for KVM guests not for
> the host kernel where this splat occurs (ignoring the fact that the "host" is
> itself a guest).
>
> kvm_fastop_exception is out-of-line fixup, and certainly shouldn't be reachable
> via d_lookup.  It's also two instruction, XOR+RET, neither of which are in the
> code stream.
>
> IIRC, the unwinder gets confused when given an IP that's in out-of-line code,
> e.g. exception fixup like this.  If you really want to find out what code blew
> up, you might be able to objdump -D the kernel and search for unique, matching
> disassembly, e.g. find "jmpq   0xf86d288c" and go from there.

Hi Sean,

Thanks for the info.

I don't want to find out what code blew (it's __d_lookup).
I am interested in getting the unwinder fixed to output truthful and
useful frames.
Is there more info on this "the unwinder gets confused"? Bug filed
somewhere or an email thread? Is it on anybody's radar?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5020419889
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhI0QJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbhI0QJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:09:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BE3C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:07:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r7so12226836pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CBaIVDF4UN9VVYwJROukTIUHRk1VcAmSIyvI/1GuY6U=;
        b=T7xGNAbIwgWoQjmHAfjCyFlxZGmZwVgJp13QAcq9bF1OoppgBW2WkXPGLJksJenBai
         D+5aHtV9bQMmEjbzueuvY4vPf9AE74CBuT3P05dfHp/OCyyMhpnV5CdRPt+he8hrO6mo
         LnsFPrM4csxIeGPyIxIU0mJ9LzFhT1kne6pBl5she3hl6nVOklpcV1dfO4zW2Th7GRN/
         G35PhgJyr3oGGDXkWUgty3HI6mfowgvts5bhUZ0kq+Rxfb+59MpjGhHFODaON7iy0iiM
         JR5ocMzOQwI/6O/Kqxcof7KhSwGZC3LUFOAW0X3wSiL51FHBFdUd7Azy48rMLavEFeux
         ORbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CBaIVDF4UN9VVYwJROukTIUHRk1VcAmSIyvI/1GuY6U=;
        b=2Ha1LiHfROH3xZE2fJxkhUlmKLCKG02qoiEnRMPv8Zigessj3xA7i9xEwFhlpe8PJw
         Pg0b5SEstufYOWDZ4xkRaHtECHxXjf3lIovgdi13AJbqQgD6C3rh1nZAprb8YWFBMi/7
         RT+GESmoKFZnpZWcJWehkCWptQ5vNcaSGp/4XVX76m4WFpX2A4desbo4KksSuYeSOqbq
         cSUwiXM5Lm2APdV5JAjZJ6MW6K7fpWcrbIlg+8DQnyMa3YJUthtuyPH9cKC+yKQMBVCN
         RPNuMQQOtaEexW16mSSvjRVKE3+idIyQ8OB/JK+aGQZWq5kc2j7Kin2fKa6BkMzYfAKi
         f6oQ==
X-Gm-Message-State: AOAM533eyp32ngyXu2hjN8+odFGU35AyeJ3y9/7CEVNPkwHpVo7h+8fE
        c3fwN/VFs/E7Oc/IP+fky3ut+w==
X-Google-Smtp-Source: ABdhPJwDaKS2HT0eEsDrjIENTUe9qQL4tA5WiU/rZM9D+/g6ip8neC4z6hkG15pQ2d/r2fMoMdD1jA==
X-Received: by 2002:a17:90a:ca96:: with SMTP id y22mr9642043pjt.115.1632758876549;
        Mon, 27 Sep 2021 09:07:56 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i2sm16110859pfa.34.2021.09.27.09.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:07:55 -0700 (PDT)
Date:   Mon, 27 Sep 2021 16:07:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+d08efd12a2905a344291@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] upstream test error: KFENCE: use-after-free in
 kvm_fastop_exception
Message-ID: <YVHsV+o7Ez/+arUp@google.com>
References: <000000000000d6b66705cb2fffd4@google.com>
 <CACT4Y+ZByJ71QfYHTByWaeCqZFxYfp8W8oyrK0baNaSJMDzoUw@mail.gmail.com>
 <CANpmjNMq=2zjDYJgGvHcsjnPNOpR=nj-gQ43hk2mJga0ES+wzQ@mail.gmail.com>
 <CACT4Y+Y1c-kRk83M-qiFY40its+bP3=oOJwsbSrip5AB4vBnYA@mail.gmail.com>
 <YUpr8Vu8xqCDwkE8@google.com>
 <CACT4Y+YuX3sVQ5eHYzDJOtenHhYQqRsQZWJ9nR0sgq3s64R=DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YuX3sVQ5eHYzDJOtenHhYQqRsQZWJ9nR0sgq3s64R=DA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Josh and PeterZ

On Mon, Sep 27, 2021, Dmitry Vyukov wrote:
> On Wed, 22 Sept 2021 at 01:34, 'Sean Christopherson' via
> syzkaller-bugs <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Fri, Sep 17, 2021, Dmitry Vyukov wrote:
> > > On Fri, 17 Sept 2021 at 13:04, Marco Elver <elver@google.com> wrote:
> > > > > So it looks like in both cases the top fault frame is just wrong. But
> > > > > I would assume it's extracted by arch-dependent code, so it's
> > > > > suspicious that it affects both x86 and arm64...
> > > > >
> > > > > Any ideas what's happening?
> > > >
> > > > My suspicion for the x86 case is that kvm_fastop_exception is related
> > > > to instruction emulation and the fault occurs in an emulated
> > > > instruction?
> > >
> > > Why would the kernel emulate a plain MOV?
> > > 2a:   4c 8b 21                mov    (%rcx),%r12
> > >
> > > And it would also mean a broken unwind because the emulated
> > > instruction is in __d_lookup, so it should be in the stack trace.
> >
> > kvm_fastop_exception is a red herring.  It's indeed related to emulation, and
> > while MOV emulation is common in KVM, that emulation is for KVM guests not for
> > the host kernel where this splat occurs (ignoring the fact that the "host" is
> > itself a guest).
> >
> > kvm_fastop_exception is out-of-line fixup, and certainly shouldn't be reachable
> > via d_lookup.  It's also two instruction, XOR+RET, neither of which are in the
> > code stream.
> >
> > IIRC, the unwinder gets confused when given an IP that's in out-of-line code,
> > e.g. exception fixup like this.  If you really want to find out what code blew
> > up, you might be able to objdump -D the kernel and search for unique, matching
> > disassembly, e.g. find "jmpq   0xf86d288c" and go from there.
> 
> Hi Sean,
> 
> Thanks for the info.
> 
> I don't want to find out what code blew (it's __d_lookup).
> I am interested in getting the unwinder fixed to output truthful and
> useful frames.

I was asking about the exact location to confirm that the explosion is indeed
from exception fixup, which is the "unwinder scenario get confused" I was thinking
of.  Based on the disassembly from syzbot, that does indeed appear to be the case
here, i.e. this

  2a:   4c 8b 21                mov    (%rcx),%r12

is from exception fixup from somewhere in __d_lookup (can't tell exactly what
it's from, maybe KASAN?).

> Is there more info on this "the unwinder gets confused"? Bug filed
> somewhere or an email thread? Is it on anybody's radar?

I don't know if there's a bug report or if this is on anyone's radar.  The issue
I've encountered in the past, and what I'm pretty sure is being hit here, is that
the ORC unwinder doesn't play nice with out-of-line fixup code, presumably because
there are no tables for the fixup.  I believe kvm_fastop_exception() gets blamed
because it's the first label that's found when searching back through the tables.

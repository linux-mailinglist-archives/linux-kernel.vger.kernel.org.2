Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F68C30AF2E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhBAS0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:26:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46858 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhBASV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:21:27 -0500
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@canonical.com>)
        id 1l6doM-0001eV-IJ
        for linux-kernel@vger.kernel.org; Mon, 01 Feb 2021 18:20:30 +0000
Received: by mail-ed1-f69.google.com with SMTP id g6so571334edy.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UPqXWgUKPGqSrvzsDJ1hLN4vFt5hlyhZiNhXcx6/KiI=;
        b=BnkLCp8TADhkEMkABeKXkX/Xu3UoKx2FRtSoFUYSlIys2l6iBO7JvvxhfzlJ6AB+IM
         voz1z0LxquuEtbcOZ8931/27sjes+gWrg/nWXIWdNzCi1gdS8SO8Z17DivbTp9ES//hm
         y/voFV4VlEVMunkoiSz32dcGTSOD6D1eXaCUKXo0LjjMj5HTGD+f15caW3+k7xhw2VN1
         h2llgTesIiu328XHcA2NhkjmowxZgp0bf2Sf+VZ/TkN3g56C0aqtOVShscUzXMhyu1Ii
         yh3RYMD0m8a1YAQ/x2igMJcRMYDLdP2QQ0KkJwK625i88krvu+lt22fie31cCWDAB41t
         fPpw==
X-Gm-Message-State: AOAM5338xKfSlyBapSmDEz6dib31anCf8sMpbwoTTDXYnyoGwbQu7OlX
        hVD+jiNX3xafoobLy6uz4/FBH98TF5DkkSraxWM+NVdp+Z1xite1fxSe+CjOkdjPEbm/X7azo2+
        leTsQs2s/wSMgpAEIvL/QNmJse0itcpNmVnAVDZp+gg==
X-Received: by 2002:aa7:d045:: with SMTP id n5mr20143337edo.306.1612203630225;
        Mon, 01 Feb 2021 10:20:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/VHsu1uZGrDB+4cT71OTN2hs/MFvOZ2PaJJ/stCN9vTwHOVunhpIC9VzytRJMlREMp6yOQw==
X-Received: by 2002:aa7:d045:: with SMTP id n5mr20143312edo.306.1612203629956;
        Mon, 01 Feb 2021 10:20:29 -0800 (PST)
Received: from gmail.com (ip5f5af0a0.dynamic.kabel-deutschland.de. [95.90.240.160])
        by smtp.gmail.com with ESMTPSA id j18sm8231298ejv.18.2021.02.01.10.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:20:25 -0800 (PST)
Date:   Mon, 1 Feb 2021 19:20:24 +0100
From:   Christian Brauner <christian.brauner@canonical.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jann@thejh.net>
Subject: Re: forkat(int pidfd), execveat(int pidfd), other awful things?
Message-ID: <20210201182024.p5rz47pjksxbxd5a@gmail.com>
References: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 06:47:17PM +0100, Jason A. Donenfeld wrote:
> Hi Andy & others,
> 
> I was reversing some NT stuff recently and marveling over how wild and
> crazy things are over in Windows-land. A few things related to process
> creation caught my interest:
> 
> - It's possible to create a new process with an *arbitrary parent
> process*, which means it'll then inherit various things like handles
> and security attributes and tokens from that new parent process.
> 
> - It's possible to create a new process with the memory space handle
> of a different process. Consider this on Linux, and you have some
> abomination like `forkat(int pidfd)`.
> 
> The big question is "why!?" At first I was just amused by its presence
> in NT. Everything is an object and you can usually freely mix and
> match things, and it's very flexible, which is cool. But this is NT,
> not Linux.
> 
> Jann and I were discussing, though, that maybe some variant of these
> features might be useful to get rid of setuid executables. Imagine
> something like `systemd-sudod`, forked off of PID 1 very early.
> Subsequently all new processes on the system run with
> PR_SET_NO_NEW_PRIVS or similar policies to prevent non-root->root
> transition. Then, if you want to transition, you ask systemd-sudod (or
> polkitd, or whatever else you have in mind) to make you a new process,
> and it then does the various policy checks, and executes a new process
> for you as the parent of the requesting process.
> 
> So how would that work? Well, executing processes with arbitrary
> parents would be part of it, as above. But we'd probably want to more
> carefully control that new process. Which chroot is it in? How do
> cgroups work? And so on. And ultimately this design leads to something
> like ZwCreateProcess, where you have several arguments, each to a
> handle to some part of the new process state, or null to be inherited
> from its parent.
> 
> int execve_parent(int parent_pidfd, int root_dirfd, int cgroup_fd, int
> namespace_fd, const char *pathname, char *const argv[], char *const
> envp[]);
> 
> One could imagine this growing pretty unwieldy. There's also this
> other design aspect of Linux that's worth considering. Namespaces and
> other process-inherited resources are generally hierarchical, with
> children getting the resource from their parent. This makes sense and
> is simple to conceptualize. Everytime we add a new thing_fd as a
> pointer to one of these resources, and allow it to be used outside of
> that hierarchy, it introduces a kind of "escape hatch". That might be
> considered "bad design" by some; it might not be by others. Seen this
> way, NT is one massive escape hatch, with pretty much everything being
> an object with a handle.
> 
> But! Maybe this is nonetheless an interesting design avenue to
> explore. The introduction of pidfd is sort of just the "beginning" of
> that kind of design.
> 
> Is any of this interesting to you as a future of privilege escalation
> and management on Linux?

A bunch of this was discussed in a breakout room during Linux Plumbers
last year and I also had discussions with Lennart about this a little
while ago.

One API I had proposed was to extend pidfd_open() to give you a
pidfd that does not yet refer to any process, i.e. instead of

int pidfd = pidfd_open(1234, 0);

you could do

int pidfd = pidfd_open(-1/-ESRCH, 0);

which would give you an empty process handle without any mentionable
properties.

A simple/dumb design would then be to let clone3() not just return
pidfds but also take pidfds as an argument. You could then hand-off the
pidfd to another process SCM_RIGHTS/pidfd_getfd() and have it create a
process for you with the privileges of the caller, you'd still be the
parent.

Or in addition to pidfd_open() we add new syscalls to configure a
process context pidfd_configure() or sm. This design I initially
proposed before we ended up with what we have now.

So yes, I would love to have at least the concept to create a process
for another process, delegated fork, essentially.

Christian

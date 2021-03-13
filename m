Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE018339E19
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 14:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhCMM75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 07:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhCMM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 07:59:33 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95577C061574;
        Sat, 13 Mar 2021 04:59:33 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id g9so5176066ilc.3;
        Sat, 13 Mar 2021 04:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=i/nFX2vrtJbQB/oaij1mxUdx+zQOpWtdx5QQmezCWhs=;
        b=ty846NYIsUmErNEURC+JYRwBHIBIJYkzryzNqMbBWWh/IycvyDw51NuoH+kPEGieUX
         Q2bmFiSVeQ8xC7Eqy1ZUEnPQntpP/APlRLuO7Mdbv4EKq3EVJxa/HnvvlusP+DFVuJcC
         9pwSoWXdTfHNsHCmNk6H50BdssqJKMQHuxMkefA7LDeIAX1RYL0QJMbdUfUH5FHRHO/u
         KBctSDQdg6Df/yo/WGX9Pd+2TVLSbVQq7Mcq7NyG/PjmimDcP1h7umF2sIUvMLHnJAM9
         DSj+LqB+FnPTT4TfIFIQhreV1x+/JiZrouGmz9NH/xKoy1eIzWCavCMhKDev30DWKz+3
         iJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=i/nFX2vrtJbQB/oaij1mxUdx+zQOpWtdx5QQmezCWhs=;
        b=ENxKzwhUs6jbus1v2zsWeWlz97fE+hCc0Jhn2ftzXBBRXr/hQVjWiijb4ubVNBiAsd
         eINKuw4yjjYNqc6DynufpoNH/q/3lAoHaVgSxbjHMFBWAhk8a0bo9CbmbKDA23j8DE3U
         +/iB60bDUACz/ys9x9fS8JjGtLX3oTyUXSdg21H6Ldguubrs1Oc+nh1JyMLyiHsBjRcF
         +cQ40X7m/D2laCdu0cuPVBBMsCtfWTgjP0HheIB+Yd0zrHaJ86i9IeDmDzZv2A8erb+d
         /xOkAYHW1aCPKtaqq8ZtKyTzYpCqxk95CxvOwAG1sobCPxHx2LdDyz9P41ly0p3wU5PF
         8t8g==
X-Gm-Message-State: AOAM533Z2D91T2UJlHSbMuBNLSUd60QGcQN4xeR2x+ORwrosgX72hlsg
        8NG1K5azBmDy5CMhj45vPSv2DDy5s+sFrd2wJ8U=
X-Google-Smtp-Source: ABdhPJwJTTEacqQIyQcbG43R3S/ajbpo3F4lJjEj8ngTOWwSvLAdI+z/6DCoIZ0mX5AM7bQhsVP/H8UrIKMD9p6d0MM=
X-Received: by 2002:a05:6e02:13a6:: with SMTP id h6mr6451900ilo.10.1615640372918;
 Sat, 13 Mar 2021 04:59:32 -0800 (PST)
MIME-Version: 1.0
References: <20210312113253.305040674@infradead.org> <20210312205914.GG22098@zn.tnic>
 <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
 <20210313084923.GA16144@zn.tnic> <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic> <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic>
In-Reply-To: <20210313124919.GD16144@zn.tnic>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 13 Mar 2021 13:58:56 +0100
Message-ID: <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 1:49 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Mar 13, 2021 at 01:38:22PM +0100, Sedat Dilek wrote:
> > AFAICS you did a 5 times x86-64 defconfig with dropped pagecache and `make -j9`?
>
> The tailored .config for that particular test box.
>
> > Does your distribution offer LLVM/Clang v12.0.0-rc3 (released this
> > week) binaries?
>
> The partition on that box I used is debian testing, so no:
>
> $ apt search llvm-1* 2>/dev/null | grep llvm-1
> libllvm-11-ocaml-dev/testing,testing 1:11.0.1-2 amd64
> llvm-10/now 1:10.0.1-8+b1 amd64 [installed,local]
> llvm-10-dev/now 1:10.0.1-8+b1 amd64 [installed,local]
> llvm-10-runtime/now 1:10.0.1-8+b1 amd64 [installed,local]
> llvm-10-tools/now 1:10.0.1-8+b1 amd64 [installed,local]
> llvm-11/testing,testing,now 1:11.0.1-2 amd64 [installed,automatic]
> llvm-11-dev/testing,testing,now 1:11.0.1-2 amd64 [installed,automatic]
> llvm-11-doc/testing,testing 1:11.0.1-2 all
> llvm-11-examples/testing,testing 1:11.0.1-2 all
> llvm-11-runtime/testing,testing,now 1:11.0.1-2 amd64 [installed,automatic]
> llvm-11-tools/testing,testing,now 1:11.0.1-2 amd64 [installed,automatic]
>

You can add Debian/experimental APT sources.list ...

[ /etc/apt/sources.list.d/debian-experimental.list  ]
deb http://ftp.debian.org/debian experimental main contrib non-free
deb https://deb.debian.org/debian experimental main non-free contrib

[ /etc/apt/preferences.d/99_debian-experimental.pref ]
Package: *
Pin: release o=Debian,a=experimental
Pin-Priority: 99

This gives LLVM/Clang v12 packages an APT prio of 99 - meaning no
auto-upgrade installations will be done.
You have full control by doing it manually.

Renew informations from APT repositories:

root# apt-get update

What clang-12 version is/are available?

root# apt-cache policy clang-12

Simulate an install (note: --no-install-recommends option):

root# apt-get install llvm-12 clang-12 lld-12 llvm-12-tools
--no-install-recommends -t experimental -s

option -s: simulate

Really do an installation of LLVM/Clang v12 stuff:

root# apt-get install llvm-12 clang-12 lld-12 llvm-12-tools
--no-install-recommends -t experimental -y

option -y: yes

If you like to test.

Of course you can use packages from <apt-llvm.org> repositories.
I can give you APT sources.list plus pref files if you desire.

Have more fun.

- Sedat -

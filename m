Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A296738E5A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhEXLqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:46:20 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:43520 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhEXLqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:46:19 -0400
Received: by mail-ua1-f44.google.com with SMTP id f1so9212951uaj.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 04:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inhLKX49iGm1wijybLMB/B2VP4Yr7vVxjNryrInoN78=;
        b=VOkBXky9fxbh5E1GJryV27EQ+FhaHbTM//Dlax3FGCgpdiba4aOB8hpB5sroazMtyg
         SGmVS08Sg3JmpkUlR4SjxuF1GmjkeHQyy54VXeXfqf2EUx8ikF5ZLqbmmEmYtktTob8Q
         pisHeZr+YJE3G/Z5g0YkuAC4YdnZi+gJXofOAGZY6UCLRs/5dWzJ6LdIYDsKqZpCycLT
         oOgx+hsegnsR2Uze1Jd2LUK32G6JABOR8t7KaBY7+gpFP0wLEPybLFIRt0uOsXeWrRei
         AuNCWRqMfkHnLLcYt2JzBgFSKmxVUhIEv1/E4lbt3c2xmGnkIsyCSFZJdL3iRPN9mGQO
         Y7rQ==
X-Gm-Message-State: AOAM533J4EZpPvZE6YVunwjYt6KGP6D4fdUhGE0oDqvG1V2dHDlkxX25
        2x3IEpd0Bz597zDXblyNQ0y/asa59kT+XDf0bMOYPjbnlBM=
X-Google-Smtp-Source: ABdhPJzMuj5ziDH48k3h5fIpN/nxy5zjGlj7xe0HIaQEbmTu9yEdyk8gasCQpHcG8siNQYo/lI71KTFi+F6pbZQkqhw=
X-Received: by 2002:ab0:2242:: with SMTP id z2mr20765675uan.58.1621856689674;
 Mon, 24 May 2021 04:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210521184519.1356639-1-gregkh@linuxfoundation.org>
 <CAMuHMdW42UAWRPWe09=0c=pkNLwwswoQHEbSHyXEjsfF6UZJdw@mail.gmail.com>
 <YKt0v2etlFzpvE9r@kroah.com> <CAMuHMdWL=Jy-PHMU3NTuc2YT=oK7gGGrrj008_k0ATivPsPc8w@mail.gmail.com>
 <YKt9Z82KbBQZIWVl@kroah.com>
In-Reply-To: <YKt9Z82KbBQZIWVl@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 May 2021 13:44:38 +0200
Message-ID: <CAMuHMdXbSyresZNUqq-g4=HNFXqtj2QkPpN1s0LRjmOnNPxn8w@mail.gmail.com>
Subject: Re: [PATCH] debugfs: remove return value of debugfs_create_bool()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, May 24, 2021 at 12:18 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, May 24, 2021 at 11:51:42AM +0200, Geert Uytterhoeven wrote:
> > On Mon, May 24, 2021 at 11:41 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Mon, May 24, 2021 at 11:11:32AM +0200, Geert Uytterhoeven wrote:
> > > > On Fri, May 21, 2021 at 10:28 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > No one checks the return value of debugfs_create_bool(), as it's not
> > > > > needed, so make the return value void, so that no one tries to do so in
> > > >
> > > > Please explain in the patch description why it is not needed.
> > >
> > > Because you just do not need it, like almost all other debugfs calls
> > > now.
> >
> > Why do I just not need it?
>
> Let me flip it around, why do you need it?  There are no in-kernel users
> of the return value anymore so what code requires this pointer now?

There still are a few users of other members in the family, and some
of them are meant to be removed without removing the full parent
directory.  Having all debugfs_create_*() functions behave the same
is a bonus.

> The goal of removing these dentry pointers was that users were somehow
> using the return value to determine code paths (like erroring out of
> files were not created).  Debugfs code working or not working should
> never matter, this is only for debugging features and we had a number of
> cases where if debugfs was acting up, other "real" things would stop
> working.
>
> Yes, there are a few exceptions that some of the perf/trace people point
> out, and they still check the return value of creating individual
> debugfs files for good reasons.  But for any driver or a "normal" kernel
> subsystem, they should not be doing that as it's wasteful and pointless.
>
> debugfs is supposed to be "simple" and almost "fire and forget" as
> possible.  By removing the ability to check return values, it helps
> achieve this as I have seen all sorts of errors when trying to check the
> return values of debugfs calls, mostly where people were thinking they
> were checking for an error, yet they really were not.
>
> So for the past few years, I've been slowly cleaning this all up,
> removing the ability to get using the debugfs api wrong, which is the
> end-goal here.  By allowing a return value to be forced to be checked,
> developers have the ability to get it wrong (and they did.)

"to be forced to be checked" applies to _must_check only.

> > > If you really do need the file dentry, there is still a call to create
> > > it, and you can always query debugfs for the dentry after it is created
> >
> > ... and will have to duplicate debugfs_create_bool() and friends, but
> > with a return value.  This may introduce bugs, and will complicate
> > maintenance, as any change to debugfs_create_bool() means all those
> > copies need to be found and updated, too.
>
> There are no in-kernel users that need to check this return value, so
> what code are we talking about here?

Yeah, you removed the last user in commit 1be4ec2456a7d110 ("scsi:
snic: debugfs: remove local storage of debugfs files") ;-)
As I said, there are a few more for other similar functions.

But if other people are fine with having to call
debugfs_remove(debugfs_lookup(...)), well, let it be like that...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

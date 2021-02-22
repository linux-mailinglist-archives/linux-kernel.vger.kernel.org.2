Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F59322277
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhBVW6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhBVW6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:58:37 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D3C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:57:57 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d8so31856672ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=appB3USc9BYbOHaMaLlCBWgrnFJA97ooreJNgz7Bs+E=;
        b=NCqNpT0Fh4EhH+R6BF38wGXYMzGMo+UXICnd1zIuLwnjVhP3agDg9U0bBLVLtWbhCh
         di98VXZ9z5I5PFVSYrWLmTvH24uCvL7jWxLpC+JkbujBGazWMzzl4FGpxWKm+ZfIpyFe
         GccAnJGvkygmuhZNLEwFV65Sj2a2fZo4qh2SKWQeWpBgjz+EGJVQH/Y+liPFcqUiEndy
         T11iq+EZeoIVXIZQ6Egp5xVJMPGn9XD35fIEwLeG3ESr8MBFV07M/duyP18fbaabsFfq
         SPv38UaRGhO9h7dxtcdrUfxirtyw+jdUizJzvm6RAXckgtpa78iLSv9X/5T1i8mRikJQ
         xP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=appB3USc9BYbOHaMaLlCBWgrnFJA97ooreJNgz7Bs+E=;
        b=Blj/gDF+0Let8FCKgFpXOQkje0Bk/lK2dBfx1jduKcg1gPjCcFT70+ZcIb1ZUVD+39
         6hHeeRB0pSMVxcZd0S3DZ8zuQNeAFv7/TNaZWafAvWUPgJVBv2cfkixj2vBrKXcrnb5D
         IDbb+d0SYdRdrtbvIKcpiXo/ZGvIMydshtHNuGFXJSGgrcmweASYUzDTU5ozhtRkyoj5
         sMhbXoivy5wNuaoYMCMVA2upLk3OQiWXuL17ZHHwX93OFhigy0PbfEoieCnT4Ea0wQOE
         OY5TargGxevaqHzf7S+PmivMKPOhFrFHyiGjaV/HpKz/3J/r+MI/BAnclLSqEhq161VU
         dhUg==
X-Gm-Message-State: AOAM530rjGO5J+9EFSafHeLH0Dylwad9Y8TDTC8QbnOJ6XN8h2PeTH9H
        JBYlw1yFPJbTBP/CmZsox0qnzZZU4EvcY/zk3RFf
X-Google-Smtp-Source: ABdhPJwcKQP0hfOsJylOSmtgZYkORZG40bGafGECNzqdPRMMkAZNAS+HZEFKkU6YD2HR7tbtzsHmq9M0OCnjtOV8xeo=
X-Received: by 2002:a17:906:2bd6:: with SMTP id n22mr4857616ejg.91.1614034675929;
 Mon, 22 Feb 2021 14:57:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRkn65jgVW5fTRWOrDe+dXQD-_-BTN+rZ8Kcq5qxFi45Q@mail.gmail.com>
 <CAHk-=wjs1S_63iF509z6-ZJSXbm5rASYYykMAcOLzjP46eYuRQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjs1S_63iF509z6-ZJSXbm5rASYYykMAcOLzjP46eYuRQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Feb 2021 17:57:44 -0500
Message-ID: <CAHC9VhRSYNcaji0E5PhKap0z3Fdszqa5vZy5R3Jdxzr-GtABbA@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 8:07 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Feb 15, 2021 at 1:57 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > - Add support for labeling anonymous inodes, and extend this new
> > support to userfaultfd.
>
> I've pulled this, but I just have to note how much I hate the function
> names. "secure inode"? There's nothing particularly secure about the
> resulting inode.
>
> It's gone through the security layer init, that doesn't make it
> "secure". ALL normal inodes go through it, are all those inodes thus
> "secure"? No.
>
> Naming matters, and I think these things are actively mis-named
> implying things that they aren't.

I don't disagree that naming is important, I would only add,
non-sarcastically, that naming is hard (as a coworker likes to remind
me on a regular basis).

My personal take on the "secure" function variant is that it provides
some indication that this is tied to a LSM hook.  For better or worse,
all of the LSM hooks start off with "security_" and most (all?) of the
LSM blob void pointers in various structs throughout the kernel are
named "security".  While arguments can be made about the merits of
that depending on how you define "security", the fact remains that
they are named that way.  If you, or anyone else reading this, has
another suggestion for the function names I'm listening ...

-- 
paul moore
www.paul-moore.com

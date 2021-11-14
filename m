Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3C944FBB1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 22:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhKNVDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 16:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbhKNVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 16:03:51 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94754C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 13:00:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b15so62385669edd.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 13:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLydiT80fkzm1nSBPnsz/oh91R9+RWCWhLY9vbO/POc=;
        b=HremuCy+b4/gXnq04jxWJOwd+GtHq4kDaqtxzuqZ6yoo2e6E0mh8//7cnW08QrZiYw
         mXsDxvvWGNseMbnktMAxQt9Bta9YvNDFFKgmTNO7+zwpmhkUwdulkayrnL1G94UWxmjO
         lD8KNcl1KesfISQbLm31YKTDMiveW4G9F7J6atWnA2PPezgNwphGLpTGHNxCNK6WLD4t
         ko+WifWaEqPh3E3LhZEt/SAKwgnfCByI2d5HqsP9KbL0jfaSx9GicFWsP+MCkL417aal
         kXMT720ZoEZ3TuTMu7i/yAmgAuZ51m+Kjthtv1CApwjbaAb4wtFbiVtPWT2qcrDsxdyP
         V8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLydiT80fkzm1nSBPnsz/oh91R9+RWCWhLY9vbO/POc=;
        b=vjJ+N1AMHuQ+9od0NxB8R+s8PAKMtzHmobQN5O+tewz3NAmsqtd0PbV0c88sFPq1QR
         AiAdj1KP+lJpbLM8qJtY9UMXZOpn7f2nDl2mrCiDn2q9+GWIfbLlGARFgQayqDW/D12p
         fL1xAN0ouWZLId6ivP0byPARDB1Z7B56UFul2LO+HAF+X+/W4IoVhDFl83SQ0Me69QQ5
         qbV0rip0OLnSLCkU4eIrM7DsERzI9kcy4BwHtK1dFps91+mge7B3BgyLUGkLeRiDaWrB
         paYur3uW+h174jXt8JLOOzpaC6Ivx+ntXVsUr5abmdx1GuleQwqkQS4doif4Ene0Qlyv
         2M1A==
X-Gm-Message-State: AOAM5338ipnvuXtdGDa2rmxxCYDDjLhmtP3SkkeJjaFyu2om6vHKw2lP
        2mKUj40J7J1Q7wizojwNELGnc5SVoeByE8tQ/lo=
X-Google-Smtp-Source: ABdhPJzc0w601CEdSXYexgtN/EWynGjvsNEqRo7PjVsoHtwd3a61oAD0Q2tHz+1U6Bx6o7qDQ8XPzxzD7Zv0T4bjxN0=
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr42995465ejt.3.1636923655147;
 Sun, 14 Nov 2021 13:00:55 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txVydO1fy8sEwVXRZF0zPfWwLYrk-UnGeKhRCEvrW4B7Q@mail.gmail.com>
 <CAHk-=wiZdONN=1Er5eN1bYurrWqhXF7LxQszpPia8hvYUOiZWQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiZdONN=1Er5eN1bYurrWqhXF7LxQszpPia8hvYUOiZWQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 15 Nov 2021 07:00:42 +1000
Message-ID: <CAPM=9tw=NTZ-1NbGupgg42gOA1aFKZ2C6wt++q5BxaocaUbmFA@mail.gmail.com>
Subject: Re: [git pull] drm fixes + one missed next for 5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 at 06:16, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Nov 11, 2021 at 7:25 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > I missed a drm-misc-next pull for the main pull last week. It wasn't
> > that major and isn't the bulk of this at all. This has a bunch of
> > fixes all over, a lot for amdgpu and i915.
>
> Ugh.
>
> The i915 conflict was trivial, but made me aware of that absolutely
> disgusting "wbinvd_on_all_cpus()" hack.
>
> And that thing is much too ugly to survive. I made my merge resolution
> remove that disgusting thing.
>
> That driver is x86-only anyway, so it all seemed completely bogus in
> the first place.
>
> And if there is some actual non-x86 work in progress for i915, then
> that wbinvd_on_all_cpus() needs to be replaced with something proper
> and architecture-neutral anyway, most definitely involving a name
> change, and almost certainly also involving a range for the cache
> writeback.
>
> Because that "create broken macro on other architectures" thing is
> *NOT* acceptable.
>
> And I sincerely hope to the gods that no cache-incoherent i915 mess
> ever makes it out of the x86 world. Incoherent IO was always a
> historical mistake and should never ever happen again, so we should
> not spread that horrific pattern around.

i915 will no longer be x86-64 only in theory, since Intel now produces
PCIe graphics cards using the same hw designs. These shouldn't AFAIK
require the same incoherent architecture, though PCIe unsnooped
transactions are a thing in the real world.

The thing is the same driver needs to build/work for the integrated
and discrete cards, hence this hack, but I'm sure someone can Intel
can do better.

I'll leave it to Daniel to figure out who/how.

Dave.

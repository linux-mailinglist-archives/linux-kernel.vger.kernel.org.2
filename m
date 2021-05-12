Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03D237B4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhELD6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhELD6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:58:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCE4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 20:56:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t4so32955980ejo.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 20:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zlhKhG4fspgbLiu4c1/LPzDzHnSyAtjFyj5u4dh9SP4=;
        b=SXN4dOAPXIqLhxzVDUinSy7iB+8knc/4ohTd1UBwxqODeQs35tsI9PpQqDt0uP2WU2
         P6oUJsL5PfPQiuxgCJDb7IE3tnV/2ozJtxhjMau3O9+O9aPwKTSD8OEXeKqBcUdI2MhR
         G11oTBwB9bksV1HEAw/AVQFuKEIQl/8Qbp5ITpKU4sECmiBSFaL2iiaO9ElFA3oqNWX6
         rMw69PwMGV8zXXbRRAqXEaERX5vLyfwM9ayF5cfhrtbhvP1++vMclbqSjJFVhXlasDnH
         VzTXRZEfnSm+WCcqy8OLIbwgRkNZEnyotwY7gu1lcxln1q/83HaRN6Bw40wh/VRFSQzH
         mFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zlhKhG4fspgbLiu4c1/LPzDzHnSyAtjFyj5u4dh9SP4=;
        b=J0HStjFZ+LSo+2+/SRkWzt/WDyBsSNXy6YSMFVndpo2ojcLd/rzhapCLlpZsBfyG+u
         vnpN9/FBLuxHQXsSCnSEJE5pUYsw6udYd3WWRyMkv1pjdHPORv93gCJKpPNwwvq72UV+
         ywgg8ezn1eI07cSqtNN35Q9TTWZeUgaRK7ycvwxzlJV5HyMCzzvXNz7W06H5vVVH0h/R
         5NP3CKj0LBsU8sIq5v3iYtbUWgRFehhb1rMg1tnrlKg+CO9wPQxH+UX0We+5EVJLjKlV
         Y4IwiGwILhiRh6F/PJom7RKAHE7dhC4yZEET1242ez47GtIkAffZTFY+6PXhqJoIlNTr
         SrZA==
X-Gm-Message-State: AOAM531dSMUEpbJt5ivEYe/lDL+U7kB07fSPEcRTNCTA3lpzmg8dlvch
        ebkbFsqP79SzDYLSnK4sUDRC8/mryz8zZU1Osh0=
X-Google-Smtp-Source: ABdhPJw2/23+165VMDXvj7TNLDo0omiX2eOVC/D+sgD16wf+j30Ffasg+v5NrPdjA0d6wKkfySYLRsV1isq5yn3h9+4=
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr35306357ejf.25.1620791817166;
 Tue, 11 May 2021 20:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOVCmzGX54u4VLUSLt_yEM4E8MQNLwW4VTkNVurPXbCuQX6d_g@mail.gmail.com>
 <CAHbLzko8rHfE-3k=e+fdW2+S1Cc0his8-=Ch08HuMMmf=RJsDg@mail.gmail.com> <CAOVCmzFiqASFCyoNrxksGzFtqJfR5FA06O-qFD-Jkv0tvsAMog@mail.gmail.com>
In-Reply-To: <CAOVCmzFiqASFCyoNrxksGzFtqJfR5FA06O-qFD-Jkv0tvsAMog@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 11 May 2021 20:56:45 -0700
Message-ID: <CAHbLzko9eh=5qD02jtYq4u4Awqrzc2F=jNWxRw4m0UdCMjjWnA@mail.gmail.com>
Subject: Re: Profiling execution time for __alloc_pages_nodemask
To:     Shivank Garg <shivankgarg98@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, sergey.senozhatsky@gmail.com,
        pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:31 PM Shivank Garg <shivankgarg98@gmail.com> wrote:
>
> >Are you maybe calling ktime_get() too early during boot, where some
> >subsystems are just about to be brought up?
>
> Thanks David, I guess this is the issue.
>
> >Is there any reason that prevents you from using some advanced tools,
> >i.e. perf, bcc/bpftrace, etc? They are much simpler than adding
> >instrumentation in kernel.
>
> Actually, I want to record the arguments for the memory allocator and
> filter out the calls I don't need (which are creating noise).
> For instance, I'm only interested in particular order and flags.

BPF can do so too. You can either attach to kprobe or tracepoint, then
filter out the calls by the function's parameters or tracepoint's
fields.

>
> This is the reason I added my custom tracepoint, which theoretically
> looked easy to implement without adding much overhead.
>
> Thanks,
> Shivank
>
> On Tue, May 11, 2021 at 5:30 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Mon, May 10, 2021 at 7:57 AM Shivank Garg <shivankgarg98@gmail.com> wrote:
> > >
> > > Hi Everyone!
> > >
> > > I want to profile the time taken to execute the __alloc_pages_nodemask
> > > for different linux configurations/parameters.
> > > To measure the execution time, I use the ktime_get() apis. I get the
> > > ktime_get() on the top, and I want to do ktime_sub(ktime_get(),ktime)
> > > and record it in a tracepoint.
> > > However, the patch on implementation prevents the kernel from booting
> > > up. I debugged the bug to find out that the issue recurs on adding
> > > ktime_get() inside the __alloc_pages_nodemask path. So, that the
> > > kernel fails to boot up ( and show the blank screen without any logs )
> > > I'm using the Linux kernel 5.6.13 (5821a5593fa9f28eb6fcc95c35d00454d9bb8624)
> >
> > Is there any reason that prevents you from using some advanced tools,
> > i.e. perf, bcc/bpftrace, etc? They are much simpler than adding
> > instrumentation in kernel.
> >
> > >
> > > Is it an expected behavior? or a BUG? Has anyone else faced the same issue?
> > >
> > > Can you please suggest, what would be a good way to measure execution
> > > time for page allocation (if not ktime_get)
> > >
> > > Stay Safe!
> > > Best Regards,
> > > Shivank Garg
> > > Open-Source Enthusiast and Student, IIT Kanpur
> > >

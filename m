Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD4379F34
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhEKFdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhEKFc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:32:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEF2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 22:31:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c22so21348294edn.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 22:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCZrRM3udZJBNFXFYYKzBZqfQzOH2s+IIGlUraUh5YE=;
        b=gkK9qSTRgN2c9OERNxvdGwa7fWng8sUpLFAl6LfivJoG3qvSNUWIeoWOWyOAnBlwon
         +nBxGW+OltHMXxDrxMYxG2ZT8veHHz71TgmRAMLczL7gfL0vivud496HTvuB1ORuBKuP
         OpnxG8OPfyZLyc5HJ7xJbfd88G/OC+RigjAt5Zb+ml+kviRbrxRALWCKtw4w1m2oY4AL
         hKEUJyi0/qs/tp1DWL4eGMja5Sdd7iA1N4hlg9DXEE6fApLElJUUTTVjZaoktP9yRjHo
         708OM7o7UwXtDd82sJj2PoYTFPwjgaJLllhdqs9mODFbnaQ8yP9gR3D8FxDa763UN2v0
         OyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCZrRM3udZJBNFXFYYKzBZqfQzOH2s+IIGlUraUh5YE=;
        b=draZuXdS6Ya2s7OcjQsvieK2K19y2kTRhZhv7N+DD5Ckavsdfh04/6uKkE/9Ii8unt
         IxhbKCoy2ShLprk5mTbxGYzI2nx67oG9kuDuYLLFI9DNMQ5HSx/lgau6hUohRap48jck
         n0JbO8HepEFhmnhaC3dV41yjvCw+LrFhF4XJj6awK/WhCQfuNmZIdXVuTyffpao5+QlV
         wcK1puMmqOwYRpc7d6+s85klQqiPJmc/7jITWEj+bQLWbd1y95DXt3e8Rg6StRagKcm1
         u/hyv2l+Wmx3nJ7Qxva0e3EP0Bs4AjCCZKCHf13KwlvUbwoZl6QSiXVHnQULa+7UvACQ
         gLKg==
X-Gm-Message-State: AOAM533XEdcCxk9HBP8BXvt9F4OaaGl3LeForJWLmYg1FjWnEv4GjdZj
        ZW+U1cBxKXPVHAMYpJjQgGMN+4uRH1wkO/1WZjEFsdBQlH3DCTGV
X-Google-Smtp-Source: ABdhPJwY+bFI/cwvXwJN8GNLnEmFFhjuly1+pfl6o0dnXuZW9UWpXoknO42mUzqS64jN78DEQmxSqCBrWNM9ILwQT40=
X-Received: by 2002:aa7:d952:: with SMTP id l18mr33295592eds.83.1620711112526;
 Mon, 10 May 2021 22:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOVCmzGX54u4VLUSLt_yEM4E8MQNLwW4VTkNVurPXbCuQX6d_g@mail.gmail.com>
 <CAHbLzko8rHfE-3k=e+fdW2+S1Cc0his8-=Ch08HuMMmf=RJsDg@mail.gmail.com>
In-Reply-To: <CAHbLzko8rHfE-3k=e+fdW2+S1Cc0his8-=Ch08HuMMmf=RJsDg@mail.gmail.com>
From:   Shivank Garg <shivankgarg98@gmail.com>
Date:   Tue, 11 May 2021 11:01:36 +0530
Message-ID: <CAOVCmzFiqASFCyoNrxksGzFtqJfR5FA06O-qFD-Jkv0tvsAMog@mail.gmail.com>
Subject: Re: Profiling execution time for __alloc_pages_nodemask
To:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, sergey.senozhatsky@gmail.com,
        pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Are you maybe calling ktime_get() too early during boot, where some
>subsystems are just about to be brought up?

Thanks David, I guess this is the issue.

>Is there any reason that prevents you from using some advanced tools,
>i.e. perf, bcc/bpftrace, etc? They are much simpler than adding
>instrumentation in kernel.

Actually, I want to record the arguments for the memory allocator and
filter out the calls I don't need (which are creating noise).
For instance, I'm only interested in particular order and flags.

This is the reason I added my custom tracepoint, which theoretically
looked easy to implement without adding much overhead.

Thanks,
Shivank

On Tue, May 11, 2021 at 5:30 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Mon, May 10, 2021 at 7:57 AM Shivank Garg <shivankgarg98@gmail.com> wrote:
> >
> > Hi Everyone!
> >
> > I want to profile the time taken to execute the __alloc_pages_nodemask
> > for different linux configurations/parameters.
> > To measure the execution time, I use the ktime_get() apis. I get the
> > ktime_get() on the top, and I want to do ktime_sub(ktime_get(),ktime)
> > and record it in a tracepoint.
> > However, the patch on implementation prevents the kernel from booting
> > up. I debugged the bug to find out that the issue recurs on adding
> > ktime_get() inside the __alloc_pages_nodemask path. So, that the
> > kernel fails to boot up ( and show the blank screen without any logs )
> > I'm using the Linux kernel 5.6.13 (5821a5593fa9f28eb6fcc95c35d00454d9bb8624)
>
> Is there any reason that prevents you from using some advanced tools,
> i.e. perf, bcc/bpftrace, etc? They are much simpler than adding
> instrumentation in kernel.
>
> >
> > Is it an expected behavior? or a BUG? Has anyone else faced the same issue?
> >
> > Can you please suggest, what would be a good way to measure execution
> > time for page allocation (if not ktime_get)
> >
> > Stay Safe!
> > Best Regards,
> > Shivank Garg
> > Open-Source Enthusiast and Student, IIT Kanpur
> >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A94B37EB9B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381481AbhELTe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbhELRlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:41:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCCDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:40:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v5so16982747edc.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xs+y9eBZ2/f87DSJ1iquJSlmC9eevjB35zefQmd1hRk=;
        b=Utcd2QRxbe79ZIchmVbulc3/bTSxKeki/63PzjOiEhb0lapJGAHR21Z3v+SDY8quYi
         tadQEDFWSlzIBbeu/+TOp3dAVYKTxoxrfTO9DLaL0WNvd7QlHy0LEzQ0CDN4nlMQ2538
         /asIwx2rZYDtz8J2Rfvm4VSZ9CO8DlZqiWZcqrgTfuTVjzyY/PYFoQNCX2v79FnKfL72
         rq6zGJYqI6IF2oAiJ0wrKXpZvDs1sbBnsr7Uk0LR+n71i9yZYJCNl2ffI+nfKguZ0kjv
         J7qHIdx23RohV1r5ZizJHX5VSp2+rAT071LqZGcvwrYb1xmI9NcJid+j/d6JTaFni4i2
         3ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xs+y9eBZ2/f87DSJ1iquJSlmC9eevjB35zefQmd1hRk=;
        b=hVqY+APUmUCy/NKo95HBBPsdIybYWjLFKat76Exd8gocPgtiQ3QEl3rNO/Dyb5gWNG
         bgNxEcdt66dP2NlSt8haiUAZeURT6H6qoSNsTJ1Q1pRaQRO1FegnTzDT9JGJHhdQKvp1
         7qHWI3VbHI9ulatAqGLdA9ERxbmHA+jsAHl7zBjVGxr2DRaEmYagoAl1/iJPRPyy35xV
         QgZBq57iyVR2Gm1Mt1KRLWoXuP/ga4J7BFARnuD2mE4I5Tl45WL40n4E9EiFsKfyBKWn
         ficNsGrYliWEdBdID2W3XD6xvEG0UJk4LcHwTgfe16tdq64i/nilzvQX1+Q0X3DXIhOh
         jDug==
X-Gm-Message-State: AOAM530jqgs7JN7JDq/zEJ3vCX6rNR3cqN+g9U1mAOj/9sGjY8Q3cvyF
        wGKcGRxbybpV8swhz7gDeB7Px/OxmNJMM5AO5ESJAO9FOxGsDA==
X-Google-Smtp-Source: ABdhPJx8E6FGhvyS3xK9AMswqEfR5SPNSY/P+1j9adWZ8+asLCk+dYS/zvLK3tH4enTE2yk3Spv92W+RpAElXBqaQBg=
X-Received: by 2002:a05:6402:17d8:: with SMTP id s24mr44491555edy.155.1620841213370;
 Wed, 12 May 2021 10:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOVCmzGX54u4VLUSLt_yEM4E8MQNLwW4VTkNVurPXbCuQX6d_g@mail.gmail.com>
 <CAHbLzko8rHfE-3k=e+fdW2+S1Cc0his8-=Ch08HuMMmf=RJsDg@mail.gmail.com>
 <CAOVCmzFiqASFCyoNrxksGzFtqJfR5FA06O-qFD-Jkv0tvsAMog@mail.gmail.com> <CAHbLzko9eh=5qD02jtYq4u4Awqrzc2F=jNWxRw4m0UdCMjjWnA@mail.gmail.com>
In-Reply-To: <CAHbLzko9eh=5qD02jtYq4u4Awqrzc2F=jNWxRw4m0UdCMjjWnA@mail.gmail.com>
From:   Shivank Garg <shivankgarg98@gmail.com>
Date:   Wed, 12 May 2021 23:09:57 +0530
Message-ID: <CAOVCmzH2+iHDeyzzSvLcAKXfzcWG5fqTvAPkhqJvdKUU-gY3=A@mail.gmail.com>
Subject: Re: Profiling execution time for __alloc_pages_nodemask
To:     Yang Shi <shy828301@gmail.com>
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

>> Actually, I want to record the arguments for the memory allocator and
>> filter out the calls I don't need (which are creating noise).
>> For instance, I'm only interested in particular order and flags.

>BPF can do so too. You can either attach to kprobe or tracepoint, then
>filter out the calls by the function's parameters or tracepoint's
>fields.

Thanks Yang for the suggestion, I'll try the BPF. Anyway my problem
was solved by the filter in custom tracepoints (for instance,
tracing/events/kmem/filter).

Also, I used trace_*_enabled() to first check if tracepoint is enabled
and take ktime_get() only after that. This solved my initial issue.

Thanks David, Yang and the Linux community for helping me identify my
issue and solve it.

Best Regards,
Shivank

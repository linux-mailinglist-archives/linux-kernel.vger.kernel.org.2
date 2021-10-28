Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9120543DA21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 06:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhJ1EL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 00:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1EL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 00:11:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9C1C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 21:09:01 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y80so11801840ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6yUHQHi+npTtdXXk5DuMN99wacJ4E9CG46ltzl64228=;
        b=LTdKGO67Jtzw5+Mnn0yELwzRX3RGMm4YHRaPSISq3WsblH3jMwIZrhcpbR8CE3AvqX
         vtlCTmihlqAvOTVddnUf33y6YNos+fTc/rxkg2k+Zqe1Ao9rTbFm4AUSGNALP1Oi4Iwl
         FG0aF4WHwTzEevGHd3OAGEvZ6ajzCwD8U5CHo42tD2zOV0v8Dnb+FzpLZorxejensSRK
         Z0MCsf6vXDHbAoUN1lM7g7WsUwlVHU1KV1QetqD9qlWyTePAyOSg5aj1Z4/vLw5KToFG
         oWvZ7PnOLSb82758FfRyf6fG82KPDKWUeZ8Nfw85EpQdesseSq2G0bFbbIm/a6HuqdmY
         9hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yUHQHi+npTtdXXk5DuMN99wacJ4E9CG46ltzl64228=;
        b=bJ0nIz2JzXmbv/U4go5PGZL14OZCyVjeJ4sEPDPFXzbXnrKIZUanGX524Xf/Vks1YL
         BoUdNBXa9qMg0lTZr8EjOFBeFk/fVjfFyxxIVWJ8pxj2fNeo1uuS6WbHC59xECxuPtnt
         i+rgPsAxIbQsFh9u3etYqxkao2Rwa5YoTcFCTGFBUvhVjdy/A+BklbMSeUgetCMGBJF6
         JG9rgGSVbnGjlPZe9nwZ0AU4W+FVoA6MXdVpnvKvAqpb4bBFNflbfRCEjj+wqWYfMoZo
         RtzY/jJjgf3QES2msNkVayhYxFH0/86vswwT/5cZGVAtVKW6P+pKHFiseH2bHx6NHF4/
         ufsw==
X-Gm-Message-State: AOAM533DsXlqL8wuSgdVd9UKloQvjfs9Hx77DvUUOMJLZHt8IL+7/hvU
        7vQf5oA2495oeOry9I8noX+fxtIUVBJCAn41afSTig==
X-Google-Smtp-Source: ABdhPJw+r345VCUEQFGpfG8g3EemP/2PHcshnTveryovvI3QNoAMM2nb8j9v9wlGZ+D6DgP/z6a+aAhMIjHeqxiDtxk=
X-Received: by 2002:a25:d610:: with SMTP id n16mr2080814ybg.208.1635394140512;
 Wed, 27 Oct 2021 21:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-2-pasha.tatashin@soleen.com> <CAMZfGtVS2ZRAsd9HLODoLa1vVp0XCcBOTXjsmpoWwDcdGaADvQ@mail.gmail.com>
 <CA+CK2bA1mj3B8Y47r8KG7oYCNn63WsjUZeyAdOkThjixxqxGPQ@mail.gmail.com>
In-Reply-To: <CA+CK2bA1mj3B8Y47r8KG7oYCNn63WsjUZeyAdOkThjixxqxGPQ@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 28 Oct 2021 12:08:24 +0800
Message-ID: <CAMZfGtVMLUrDZc+_j29jSPTKYmsMRWymxZNwtM2TpKH9wMPfUw@mail.gmail.com>
Subject: Re: [RFC 1/8] mm: add overflow and underflow checks for page->_refcount
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 2:22 AM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > I found some atomic_add/dec are replaced with atomic_add/dec_return,
>
> I am going to replace -return variants with -fetch variants, potentially -fetch
>
> > those helpers with return value imply a full memory barrier around it, but
> > others without return value do not. Do you have any numbers to show
> > the impact? Maybe atomic_add/dec_return_relaxed can help this.
>
> The generic variant uses  arch_cmpxchg() for all atomic variants
> without any extra barriers. Therefore, on platforms that use generic
> implementations there won't be performance differences except for an
> extra branch that checks results when VM_BUG_ON is enabled.
>
> On x86 the difference between the two is the following
>
> atomic_add:
>    lock add %eax,(%rsi)
>
> atomic_fetch_add:
>    lock xadd %eax,(%rsi)
>
> atomic_fetch_add_relaxed:
>    lock xadd %eax,(%rsi)
>
> No differences between relaxed and non relaxed variants. However, we

Right. There is no difference on x86. Maybe there are differences in
other architectures.

> used lock xadd instead of lock add. I am not sure if the performance
> difference is going to be different.
>
> Pasha

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752D630B147
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhBAUE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhBAUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:00:50 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F38C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 12:00:10 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id f14so2044792ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 12:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQZW1SaFjZh0MEmlR6482SykUFNPeKKF6EWw3EBP+ns=;
        b=e3CD2TSS+KFsGyXpJNM0Kv1gIGyh1JkUR8Zx2Z7dLDvc4cYhNziZyNYYIQeLEs5B7C
         lHA7cwxfZ6IiaQbN8XOiFzRjlnwlzlpZIwABdf3zK4Mo1QmZuRX9FgXmU7XQeyp7sWMW
         WXuFFWGooyRJf2qibd1clRGkCKunnpYaAIEWU6RrgyOY49WU1OVn6HZtj8S8S+PwRIR7
         G3yjsbGahAIXRQDe65MrtlOIejn2NvYyYP8TzgOvRd31AxBqbXJdpEGtCuD98Yk8XJxo
         pB7ywaFJYo2o1ZRUyjhrHiliee2Zs9lyvgfmVsBRCeI2wMOjzRzvJHP/rwC6T3qM7qvB
         BdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQZW1SaFjZh0MEmlR6482SykUFNPeKKF6EWw3EBP+ns=;
        b=NvwbQNcC59WDKy0LwavyG32jErQ2G3gBIShg9wffhREBCi5IYI9UBNG9qFgAx04E2l
         rjQPmiB1s0NTLi2jPlAE3lhNmo4s72gch9H2qBEbyTpW+15uQwXEsJRrAd8BB4pUkBbP
         /PycDXGlgyTdA2xWc7W3KggcnayDuF1xcPMlc57SfXJtaA35wKkgmtz22mNJSx+lf6aZ
         4002wVHlfgy95b7VGJntvOdZXUcDmCJNlgZr5x1AaPqhyK2EOkK5Jvw64U/7UbHhRhoj
         G/AEr27zUt9erC4TRS+Nl98jmqWW3/uRbRli2KirTE9zze6rGnSqpHl+cxolEsCtC2fr
         pZhA==
X-Gm-Message-State: AOAM530WXMSH8oiQW+2IGF32/vOLABrMlE1lDYeEPXEJj015Y1RHjvfm
        wZWkwhRCH18KBJwW2VlGJJwlNzhAubrtmyXCOSfWOQ==
X-Google-Smtp-Source: ABdhPJwsjeYkl+h33w7dOEAgBFIgJ7vAcJe9HM7j751I3zTbupPayPX3GEglcn/eoEfe1Ko6r+yvfynIlbnaQqNSSNE=
X-Received: by 2002:a17:906:eddd:: with SMTP id sb29mr10428190ejb.383.1612209608749;
 Mon, 01 Feb 2021 12:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20210127172706.617195-1-pasha.tatashin@soleen.com> <a8a72826-0a27-de9b-bfb7-be8286cd61fe@arm.com>
In-Reply-To: <a8a72826-0a27-de9b-bfb7-be8286cd61fe@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 1 Feb 2021 14:59:32 -0500
Message-ID: <CA+CK2bBSJaL9Hn_LBy78ccaCt7=r9cSaEqUVemRVmKg6cwpLnQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/6] arm64: MMU enabled kexec relocation
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> The problem I see with this is rewriting the relocation code. It needs to work whether the
> machine has enough memory to enable the MMU during kexec, or not.
>
> In off-list mail to Pavel I proposed an alternative implementation here:
> https://gitlab.arm.com/linux-arm/linux-jm/-/tree/kexec+mmu/v0
>
> By using a copy of the linear map, and passing the phys_to_virt offset into
> arm64_relocate_new_kernel() its possible to use the same code when we fail to allocate the
> page tables, and run with the MMU off as it does today.
> I'm convinced someone will crawl out of the woodwork screaming 'regression' if we
> substantially increase the amount of memory needed to kexec at all.
>
> From that discussion: this didn't meet Pavel's timing needs.
> If you depend on having all the src/dst pages lined up in a single line, it sounds like
> you've over-tuned this to depend on the CPU's streaming mode. What causes the CPU to
> start/stop that stuff is very implementation specific (and firmware configurable).
> I don't think we should let this rule out systems that can kexec today, but don't have
> enough extra memory for the page tables.
> Having two copies of the relocation code is obviously a bad idea.

I understand that having an extra set of page tables could potentially
waste memory, especially if VAs are sparse, but in this case we use
page tables exclusively for contiguous VA space (copy [src, src +
size]). Therefore, the extra memory usage is tiny. The ratio for
kernels with  4K page_size is (size of relocated memory) / 512.  A
normal initrd + kernel is usually under 64M, an extra space which
means ~128K for the page table. Even with a huge relocation, where
initrd is ~512M the extra memory usage in the worst case is just ~1M.
I really doubt we will have any problem from users because of such
small overhead in comparison to the total kexec-load size.

>
>
> (as before: ) Instead of trying to make the relocations run quickly, can we reduce them?
> This would benefit other architectures too.

This was exactly my first approach [1] where I tried to pre-reserve
memory similar to how it is done for a crash kernel, but I was asked
to go away [2] as this is an ARM64 specific problem, where current
relocation performance is prohibitively slow. I have tested on x86,
and it does not suffer from this problem, relocation performance is
just as fast as with MMU enabled ARM64.

>
> Can the kexec core code allocate higher order pages, instead of doing everything page at
> at time?

Yes, however, failures during kexec-load due to failure to coalesce
huge pages can add extra hassle to users, and therefore this should be
only an optimization with fallback to base pages.

>
> If you have a crash kernel reservation, can we use that to eliminate the relocations
> completely?
> (I think this suggestion has been lost in translation each time I make it.
> I mean like this:
> https://gitlab.arm.com/linux-arm/linux-jm/-/tree/kexec/kexec_in_crashk/v0
> Runes to test it:
> | sudo ./kexec -p -u
> | sudo cat /proc/iomem | grep Crash
> |  b0200000-f01fffff : Crash kernel
> | sudo ./kexec --mem-min=0xb0200000 --mem-max=0xf01ffffff -l ~/Image --reuse-cmdline
>
> I bet its even faster!)

There is a problem with this approach. While, with kexec_load() call
it is possible to specify physical destinations for each segment, with
kexec_file_load() it is not possible. The secure systems that do IMA
checks during kexec load require kexec_file_load(), and we cannot
ahead of time specify destinations for these segments (at least
without substantially changing common kexec code which is not going to
happen as this arm64 specific problem).

>
>
> I think 'as fast as possible' and 'memory constrained' are mutually exclusive
> requirements. We need to make the page tables optional with a single implementation.

In my opinion having two different types of relocations will only add
extra corner cases, confusion about different performance, and bugs.
It is better to have two types: 1. crash kernel type without
relocation, 2. fast relocation where MMU is enabled.

[1] https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
[2] https://lore.kernel.org/lkml/20190710065953.GA4744@localhost.localdomain/

Thank you,
Pasha

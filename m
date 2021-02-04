Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990D330F63B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbhBDP05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbhBDPYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:24:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1FFC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:23:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q2so1486961eds.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEhxV9P2S1PvM6vEfxJN1WEpwz1WJWS0uG/glB9T2Jg=;
        b=f8TCB65kOI/5YD4eYt2VzD1Wu2rvsxhlN8adiVviJVV4DA3Wl7/uHJ9CE575xk9utB
         e6qh2Xgr7I53+Pacq4xLIECgNw/4wlm0i7bomuGKvWRbuKpt9myaXRmoMDNJmJrEiYC/
         aSqgHfRGTgJ5ZdDcw3kflrqi+7tysmdWl9XC6RqMv9FTm4OdAGl5aMqf4cly/vuLcLgC
         3nS+4V7vHsEWK0jeD1ISELKCGy+JAcZSrTPgupHHL1No+JZkz2nQueGJevCira8IouP2
         KMxixMQIcqAwBkUg8LVD65bZtqvdWLcfPW5ipl9UPvJrc25Ux1fuacSJxpHfjpDD1+5o
         MTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEhxV9P2S1PvM6vEfxJN1WEpwz1WJWS0uG/glB9T2Jg=;
        b=JHLGnOsalif4xrcuFpntbpOR/J8LEaon9II0gIbqitItmHx/S9P4rftDXZxHRYyxIA
         zXzkwDzYRw5bqYn0gDKsyS4cx01jcZE61+tim+5yk4OKuDPs36PCgN0yUI25X5Cpw3jV
         RioqzY4JIUeDJhBF9F2fENN5snuJsAxu8JAh94VVimTUeeO88vaTLBx5Hx1MqAyJDzE4
         4rjnqgFrSPvYXxFtLjzP2uwCpREZa5G9NbeF6nt+LMW7ke70jeiydYoVaYTUTSw1UZ7O
         aI8bZzo4bAw0mY032Pm6ndWubtEtwIDuX6hcLzP0tXN1kMubvpMslG1wc3OOYwC8MAGZ
         Jjdg==
X-Gm-Message-State: AOAM5325yMTPiAA/DRj27ckg5qbiZMwLkQDJNWCVQO6TjYE5v3NBqQbP
        chNodir1WDhnH4YyeQSisBGE3ouv+4P+O6GENrr5Gw==
X-Google-Smtp-Source: ABdhPJyUmQPsLbf5BWKf5fk9Y5JfnVPXqyhY/9QKj8WdKnBuqLGTetkIY8rtIz18JSsEieS+eamybo+g83gzcFyKHi0=
X-Received: by 2002:aa7:cd0a:: with SMTP id b10mr8283776edw.153.1612452219646;
 Thu, 04 Feb 2021 07:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20210127172706.617195-1-pasha.tatashin@soleen.com>
 <a8a72826-0a27-de9b-bfb7-be8286cd61fe@arm.com> <CA+CK2bBSJaL9Hn_LBy78ccaCt7=r9cSaEqUVemRVmKg6cwpLnQ@mail.gmail.com>
 <871rdwocwh.fsf@x220.int.ebiederm.org>
In-Reply-To: <871rdwocwh.fsf@x220.int.ebiederm.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 4 Feb 2021 10:23:03 -0500
Message-ID: <CA+CK2bD9NQ=waaoi4=Ub9o9uKWaAs_ZO8LEwxB2XFhacRhnbOQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/6] arm64: MMU enabled kexec relocation
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     James Morse <james.morse@arm.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
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

> > I understand that having an extra set of page tables could potentially
> > waste memory, especially if VAs are sparse, but in this case we use
> > page tables exclusively for contiguous VA space (copy [src, src +
> > size]). Therefore, the extra memory usage is tiny. The ratio for
> > kernels with  4K page_size is (size of relocated memory) / 512.  A
> > normal initrd + kernel is usually under 64M, an extra space which
> > means ~128K for the page table. Even with a huge relocation, where
> > initrd is ~512M the extra memory usage in the worst case is just ~1M.
> > I really doubt we will have any problem from users because of such
> > small overhead in comparison to the total kexec-load size.

Hi Eric,

>
> Foolish question.

Thank you for your e-mail, you gave some interesting insights.

>
> Does arm64 have something like 2M pages that it can use for the
> linear map?

Yes, with 4K pages arm64 as well has 2M pages, but arm64 also has a
choice of 16K and 64K and second level pages are bigger there.

> On x86_64 we always generate page tables, because they are necessary to
> be in 64bit mode.  As I recall on x86_64 we always use 2M pages which
> means for each 4K of page tables we map 1GiB of memory.   Which is very
> tiny.
>
> If you do as well as x86_64 for arm64 I suspect that will be good enough
> for people to not claim regression.
>
> Would a variation on the x86_64 implementation that allocates page
> tables work for arm64?
...
>
> As long as the page table provided is a linear mapping of physical
> memory (aka it looks like paging is disabled).  The the code that
> relocates memory should be pretty much the same.
>
> My experience with other architectures suggests only a couple of
> instructions need to be different to deal with a MMU being enabled.

I think what you are proposing is similar to what James proposed. Yes,
for a linear map relocation should be pretty much the same as we do
relocation as with MMU disabled.

Linear map still uses memory, because page tables must be outside of
destination addresses of segments of the next kernel. Therefore, we
must allocate a page table for the linear map. It might be a little
smaller, but in reality the difference is small with 4K pages, and
insignificant with 64K pages. The benefit of my approach is that the
assembly copy loop is simpler, and allows hardware prefetching to
work.

The regular relocation loop works like this:

for (entry = head; !(entry & IND_DONE); entry = *ptr++) {
        addr = __va(entry & PAGE_MASK);

        switch (entry & IND_FLAGS) {
        case IND_DESTINATION:
                dest = addr;
                break;
        case IND_INDIRECTION:
                ptr = addr;
                break;
        case IND_SOURCE:
                copy_page(dest, addr);
                dest += PAGE_SIZE;
        }
}

The entry for the next relocation page has to be always fetched, and
therefore prefetching cannot help with the actual loop.

In comparison, the loop that I am proposing is like this:

for (addr = head; addr < end; addr += PAGE_SIZE, dst += PAGE_SIZE)
        copy_page(dest, addr);

Here is assembly code for my loop:

1: copy_page x1, x2, x3, x4, x5, x6, x7, x8, x9, x10
    sub x11, x11, #PAGE_SIZE
    cbnz x11, 1b

That said, if James and you agree that linear map is the way to go
forward, I am OK with that as well, as it is still much better than
having no caching at all.

Thank you,
Pasha

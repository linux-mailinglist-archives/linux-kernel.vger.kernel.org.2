Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED9E4155C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 05:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbhIWDJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 23:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbhIWDJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:09:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CABC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 20:08:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id dj4so18096162edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 20:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wg0SO8Jh5J0YtYhTMPuXq9iTZK0y4Tf/EQSdxnLWV6M=;
        b=agaNwmejKv2RaiO2sHI4XtD5iYj8+bycsl45DOQzbBaglm4ipkIi2QPOzqU2kWk2mm
         PPFDafbkQ8L+/4k2gALrZbxckEmceL9xd3rIzqFWAM6kjymOTe8kSIlG/TWQy7GZqOHZ
         I9VZyLiinPeK4Svx4Z2+z8YlGivEaULY+Ttq8jQabjFsUAud67KrCh813gck4GcCfWGo
         D0kjpmQQ9D8eUfAHWMg2kR91BzZMe9mZbOZaPpdMC0rdZ8rDt0bTC7gMoARdAbLDh5ss
         y7hqG3LF0QRjX7vTYb2T5cCUo0BkdWVfuynwmGHisMEmiAYXuu3W0GIkt6+HKMGJVqx/
         reOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wg0SO8Jh5J0YtYhTMPuXq9iTZK0y4Tf/EQSdxnLWV6M=;
        b=3Ld/VsnO2uVX41iGOUjdkdLihxHsGqSVGiB/ZD1SFBW56CNcBu4ky0VgjK6TimCEEp
         sZtHNHh5kY6SjgO3IiEpvqpVgoASzAYcytAOn/RYcANOP09TW5bh+PJsBOk/maVhCQ1C
         fb2Ve81SSoNoz2h72vNb8iy8s3dpwfd9JNMkQdKADOcrth80cy62VvR4Kq3LgAwXN044
         tHPQiXpx6tv9fNfShAeRxEZJwAq2rpmVSuw3U1pEPJgRXrYxkoeDgE/i1zStBzNcKu0t
         xmw1meKcGX0G/wYyA992Uy1/UqWSY/QoSvePRLJiDG7idXtb8Ac9KSyTjpNyKcHBGVnx
         lOAg==
X-Gm-Message-State: AOAM531lEVcEOHJ4XbMCtUsIaLzdHchlJTpTNi+Zp6MFyG8tLDeDqnXo
        vuprD4e5fniiCtBEhpp8Z4XkjSg0K0V/4Z5BK8+CGtv6
X-Google-Smtp-Source: ABdhPJzu3mm/ITq06L7qrX4Em+cFaEhnqUYjo7bf3jJIhMdlebmUff5pYc0jURAsRAd9mzEkVIR8K4uuVXSRzHEYAQ4=
X-Received: by 2002:a05:6402:16c8:: with SMTP id r8mr2939958edx.101.1632366483922;
 Wed, 22 Sep 2021 20:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210817202146.3218-1-shy828301@gmail.com> <CAHbLzkpkDXyEZ2izMwpkwLg9fN7qsQ+soR+iu6sd8RfOSqhS-A@mail.gmail.com>
 <20210831233839.afaenhn32nx6m2fq@box.shutemov.name> <CAHbLzkrXOM0Ow3YbZnj9RyvTJ8fwaUCzAizOMR5MP=TkxeLywg@mail.gmail.com>
 <07fd6599-88cc-e353-26f0-5de3eeea5b9f@suse.cz> <CAHbLzkoHghYQaqridYuWY=YUm4AB7sQDbCjbmGgr5iXx=nsETg@mail.gmail.com>
 <e5da8162-8360-a380-dfbb-d6b9899d508f@google.com>
In-Reply-To: <e5da8162-8360-a380-dfbb-d6b9899d508f@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 22 Sep 2021 20:07:51 -0700
Message-ID: <CAHbLzkoE5CCqTp1VtbRex+piDEAATM2YD0n5Py1VGD__PDZfFA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: khugepaged: don't carry huge page to the next
 loop for !CONFIG_NUMA
To:     Hugh Dickins <hughd@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 4:49 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Wed, 1 Sep 2021, Yang Shi wrote:
> > On Wed, Sep 1, 2021 at 3:26 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > On 9/1/21 05:46, Yang Shi wrote:
> > > > On Tue, Aug 31, 2021 at 4:38 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > >> On Mon, Aug 30, 2021 at 11:49:43AM -0700, Yang Shi wrote:
> > > >> > Gently ping...
> > > >> >
> > > >> > Does this patch make sense? BTW, I have a couple of other khugepaged
> > > >> > related patches in my queue. I plan to send them with this patch
> > > >> > together. It would be great to hear some feedback before resending
> > > >> > this one.
> > > >>
> > > >> I don't really care for !NUMA optimization. I believe that most of setups
> > > >> that benefit from THP has NUMA enabled compile time.
> > > >
> > > > Agreed.
> > > >
> > > >>
> > > >> But if you wanna to go this path, make an effort to cleanup other
> > > >> artifacts for the !NUMA optimization: the ifdef has to be gone and all
> > > >> callers of these helpers has to be revisited. There's more opportunities to
> > > >> cleanup. Like it is very odd that khugepaged_prealloc_page() frees the
> > > >> page.
> > > >
> > > > Yes, they are gone in this patch. The only remaining for !NUMA is
> > > > khugepaged_find_target_node() which just returns 0.
> > >
> > > As Kirill pointed out, there's also khugepaged_prealloc_page() where the
> > > only remaining variant does actually no preallocation, just freeing of an
> > > unused page and some kind of "sleep after first alloc fail, break after
> > > second alloc fail" logic.
> > > This could now be moved to khugepaged_do_scan() loop itself and maybe it
> > > will be easier to follow.
> >
> > Aha, I see. Misunderstood him. I'm supposed that you mean move into
> > khugepaged_scan_mm_slot().
>
> It may not be possible, but I'd always imagined that a cleanup of this
> kind would get rid of all those "struct page **hpage" artifacts.

It seems we need to find another way to do "sleep for the first alloc
failure, break loop for the second alloc failure" or just remove the
heuristic.

I will take a closer look once I find some time.

>
> Hugh

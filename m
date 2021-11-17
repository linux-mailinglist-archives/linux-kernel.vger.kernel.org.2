Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B8F454B53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbhKQQup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhKQQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:50:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2201BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:47:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y13so13768364edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScuePVig2+6JEGtMxOXcRDUBeyhJaT5Z7Na+LqxWaRI=;
        b=OuPAkQjhwu1zOCBjeWzGpGZPYHqv1O5iU93TRNAUDap1urYSr4crwZ85VM/LJ45Lq9
         RTd5nQ/dt0pvO6Q6ECsB1sVB1p2zfFSCMramPV2SHAVV7jZVSP2Bj5H+0t7D4HI7ir1P
         RA/OHuxebKX94zZLVe6OAKGRtLcxbqxqkK4yrBnJ1W2OWwN+o3SWasHe4uQspSxq5tyO
         xgvcqhB55OC1h5WEqEoYVeDlP/CHBzUtjmnZ1jaMjdslEhoD9VP2I+i8NyGFHOKw/jdy
         n0QJdCqjMEoKoWHkY9qY3uNcFY6omoPIItWhQEWdlK3V2rFUPkCBoSoD67vofLnFwgDF
         tbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScuePVig2+6JEGtMxOXcRDUBeyhJaT5Z7Na+LqxWaRI=;
        b=dvB7/Iyw8CPlDFohyKlmW+KSlZSyWovvascfcxBZ3qOZ7WKLR1PqZZt39eZ0cKzbNI
         9LzVxM6CIY/k/vwA6BZomodeRcVHb+xvTg6GRALA8koR0gA2zjDMbW9DZLOIvfUDgqQM
         mhuue2dWl6SVk28K7eDNwW17XfFUOZAyFre6fwQaiJbbi8WBHx25UpfbDAhlBOIrHFEn
         hLaBTIWJBhPKh8xM48QpBFwcgSseJT29ySXwIkHGnX8+06w4Dhe0rnjjKUkqJ4HyBVY4
         6WClsoqTJ99lqygsgJxYIw4jdHXQP3BpSbuVTtIfCUe87bm/WNTrrg4vZdqICWSUGZDx
         GJhg==
X-Gm-Message-State: AOAM530QqKhrAzVFShTFrhYnH7sRa/ct/IJ4H1aCkOQV/FBBeAEfoGlY
        KXyhiPv1E9H8rvwWa4Oe3/mDuoGEvvUpxrKtnQ6sDXrU0S4=
X-Google-Smtp-Source: ABdhPJyAGNTWz9a3U4XU4978MbGu9P5P8hAtsQiHg+kzEeQtvN6JAJ7Sc1+xsI1+tr2jObUZ6jHciI3iHnf6pYUC2aA=
X-Received: by 2002:a50:c212:: with SMTP id n18mr6606edf.211.1637167664600;
 Wed, 17 Nov 2021 08:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20211116220038.116484-1-pasha.tatashin@soleen.com>
 <20211116220038.116484-3-pasha.tatashin@soleen.com> <878rxngq6g.fsf@meer.lwn.net>
In-Reply-To: <878rxngq6g.fsf@meer.lwn.net>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 17 Nov 2021 11:47:08 -0500
Message-ID: <CA+CK2bCwHeodpyfHqSzqQWFTrJEYyYFeythYoMAD2eYw7BfNKg@mail.gmail.com>
Subject: Re: [RFC 2/3] mm: page table check
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  Documentation/vm/page_table_check.rst |  53 ++++++
>
> Thanks for documenting this feature!  When you add a new RST file,
> though, you need to add it to the index.rst file as well so that it is
> included in the docs build.

I will add the index.rst changes.

>
> >  MAINTAINERS                           |   9 +
> >  arch/Kconfig                          |   3 +
> >  include/linux/page_table_check.h      | 147 ++++++++++++++
> >  mm/Kconfig.debug                      |  24 +++
> >  mm/Makefile                           |   1 +
> >  mm/page_alloc.c                       |   4 +
> >  mm/page_ext.c                         |   4 +
> >  mm/page_table_check.c                 | 264 ++++++++++++++++++++++++++
> >  9 files changed, 509 insertions(+)
> >  create mode 100644 Documentation/vm/page_table_check.rst
> >  create mode 100644 include/linux/page_table_check.h
> >  create mode 100644 mm/page_table_check.c
> >
> > diff --git a/Documentation/vm/page_table_check.rst b/Documentation/vm/page_table_check.rst
> > new file mode 100644
> > index 000000000000..41435a45869f
> > --- /dev/null
> > +++ b/Documentation/vm/page_table_check.rst
> > @@ -0,0 +1,53 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +.. _page_table_check:
>
> Do you need this label for anything?  As-is it's just added visual
> clutter and could come out.

Sure, I will remove it

>
> > +================
> > +Page Table Check
> > +================
> > +
> > +Page table check allows to hardern the kernel by ensuring that some types of
> > +memory corruptions are prevented.
> > +
> > +Page table check performs extra verifications at the time when new pages become
> > +accessible from userspace by getting their page table entries (PTEs PMDs etc.)
> > +added into the table.
> > +
> > +In case of detected corruption, the kernel is crashed. There is a small
> > +performance and memory overhead associated with page table check. Thereofre, it
> > +is disabled by default but can be optionally enabled on systems where extra
> > +hardening outweighs the costs. Also, because page table check is synchronous, it
> > +can help with debugging double map memory corruption issues, by crashing kernel
> > +at the time wrong mapping occurs instead of later which is often the case with
> > +memory corruptions bugs.
> > +
> > +==============================
> > +Double mapping detection logic
> > +==============================
>
> I'd use subsection markup (single "==========" line underneath) for the
> subsections.

I will change to subsection.

Thanks,
Pasha

On Wed, Nov 17, 2021 at 3:08 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > Check user page table entries at the time they are added and removed.
> >
> > Allows to synchronously catch memory corruption issues related to
> > double mapping.
> >
> > When a pte for an anonymous page is added into page table, we verify
> > that this pte does not already point to a file backed page, and vice
> > versa if this is a file backed page that is being added we verify that
> > this page does not have an anonymous mapping
> >
> > We also enforce that read-only sharing for anonymous pages is allowed
> > (i.e. cow after fork). All other sharing must be for file pages.
> >
> > Page table check allows to protect and debug cases where "struct page"
> > metadata became corrupted for some reason. For example, when refcnt or
> > mapcount become invalid.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  Documentation/vm/page_table_check.rst |  53 ++++++
>
> Thanks for documenting this feature!  When you add a new RST file,
> though, you need to add it to the index.rst file as well so that it is
> included in the docs build.
>
> >  MAINTAINERS                           |   9 +
> >  arch/Kconfig                          |   3 +
> >  include/linux/page_table_check.h      | 147 ++++++++++++++
> >  mm/Kconfig.debug                      |  24 +++
> >  mm/Makefile                           |   1 +
> >  mm/page_alloc.c                       |   4 +
> >  mm/page_ext.c                         |   4 +
> >  mm/page_table_check.c                 | 264 ++++++++++++++++++++++++++
> >  9 files changed, 509 insertions(+)
> >  create mode 100644 Documentation/vm/page_table_check.rst
> >  create mode 100644 include/linux/page_table_check.h
> >  create mode 100644 mm/page_table_check.c
> >
> > diff --git a/Documentation/vm/page_table_check.rst b/Documentation/vm/page_table_check.rst
> > new file mode 100644
> > index 000000000000..41435a45869f
> > --- /dev/null
> > +++ b/Documentation/vm/page_table_check.rst
> > @@ -0,0 +1,53 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +.. _page_table_check:
>
> Do you need this label for anything?  As-is it's just added visual
> clutter and could come out.
>
> > +================
> > +Page Table Check
> > +================
> > +
> > +Page table check allows to hardern the kernel by ensuring that some types of
> > +memory corruptions are prevented.
> > +
> > +Page table check performs extra verifications at the time when new pages become
> > +accessible from userspace by getting their page table entries (PTEs PMDs etc.)
> > +added into the table.
> > +
> > +In case of detected corruption, the kernel is crashed. There is a small
> > +performance and memory overhead associated with page table check. Thereofre, it
> > +is disabled by default but can be optionally enabled on systems where extra
> > +hardening outweighs the costs. Also, because page table check is synchronous, it
> > +can help with debugging double map memory corruption issues, by crashing kernel
> > +at the time wrong mapping occurs instead of later which is often the case with
> > +memory corruptions bugs.
> > +
> > +==============================
> > +Double mapping detection logic
> > +==============================
>
> I'd use subsection markup (single "==========" line underneath) for the
> subsections.
>
> > ++-------------------+-------------------+-------------------+------------------+
> > +| Current Mapping   | New mapping       | Permissions       | Rule             |
> > ++===================+===================+===================+==================+
> > +| Anonymous         | Anonymous         | Read              | Allow            |
> > ++-------------------+-------------------+-------------------+------------------+
> > +| Anonymous         | Anonymous         | Read / Write      | Prohibit         |
> > ++-------------------+-------------------+-------------------+------------------+
> > +| Anonymous         | Named             | Any               | Prohibit         |
> > ++-------------------+-------------------+-------------------+------------------+
> > +| Named             | Anonymous         | Any               | Prohibit         |
> > ++-------------------+-------------------+-------------------+------------------+
> > +| Named             | Named             | Any               | Allow            |
> > ++-------------------+-------------------+-------------------+------------------+
> > +
> > +=========================
> > +Enabling Page Table Check
> > +=========================
> > +
> > +Build kernel with:
> > +
> > +- PAGE_TABLE_CHECK=y
> > +Note, it can only be enabled on platforms where ARCH_SUPPORTS_PAGE_TABLE_CHECK
> > +is available.
> > +- Boot with 'page_table_check=on' kernel parameter.
> > +
> > +Optionally, build kernel with PAGE_TABLE_CHECK_ENFORCED in order to have page
> > +table support without extra kernel parameter.
>
> Thanks,
>
> jon

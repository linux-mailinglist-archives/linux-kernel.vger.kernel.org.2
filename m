Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF7367E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhDVKAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbhDVKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:00:15 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BC7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:59:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q136so24718750qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSjG3n4vs4c5Vfn7M5IAgCBt0t2W+qOflahbb5eE8zU=;
        b=BSbT79pHH5saOlwJQs8PcApvsXCBcSFUS8hUTzbrCjJKhfYrobxoLBzvsel8JTSFwo
         IHL3N5mTlMHPAFD6RJT410GQYvPL+d7tghGdRS87O2e+owFP/fPww4kAURg9jDJP9rs0
         yjjFo0JkBjSqFUoFeYNjHCzG0fP2wSfJPvCJeNAnOyzoU3iivLYnKwHiZuoe6Ccs6mkK
         RN9AiwsCi90um/8h1eQ1xIxHKcwBHnTGa4wV9AS1lkRW6aunDYf9qf/4qHfJSa3KkkTd
         XSY3i7dHQFiXXSKxZcTyJaIhw0egVOdcSZgXbOISQoZZvtRhEL9hPC5I+KGg86evo4pT
         dF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSjG3n4vs4c5Vfn7M5IAgCBt0t2W+qOflahbb5eE8zU=;
        b=Gdm1IPgUbYhdzWGfbS+1OqaC/pbTwE4Swp+9rxfQJl6NZJHkc/QsijhKVo1y+e7PQU
         DMwhMepT1GDfHs6y64ggf2AZ7+sikrbI3T4emr8Pvh9YODUBhLHZghMzX6Wgj89J9n3P
         CHOYsqIVSIIpxZUOTA6pUfIasNY1zjgQ1bE3X/1yzbnj25qbZ6MR8/2JLZGyUKG27f7W
         0NSYHQWL2a0/aD3YDOBM4rKcVnp4NxTC7uSTku/IAcKULmlzKHIOu9oKDRPV/2lPLWzW
         dbxvfLvbbsV3f6eXIVdQ+dc8+NrzQfC3iDXCKhZ7ytOGICD7RUPS/va07+Wt8wlrfq/O
         TUFA==
X-Gm-Message-State: AOAM531WW9NeUMFO44hpa83eWfE8xuj2Juj/jfcxihAatFl84/xYzBxR
        8fk3rl7LlUpNrk1hjF8L7W9AmOC3CwwRHSV7PbFaqQ==
X-Google-Smtp-Source: ABdhPJwKw5ZqBstbPTQR1HKVO0LSLOlBgCJllsiTMHdnws7C1zRQTCtWAot1IgsiARXgE8GCohmUWwnCTnEDOuSdkKo=
X-Received: by 2002:a05:620a:89d:: with SMTP id b29mr2864406qka.231.1619085579765;
 Thu, 22 Apr 2021 02:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa@epcas5p2.samsung.com>
 <1619079317-1131-1-git-send-email-maninder1.s@samsung.com> <CACT4Y+azDLjbNH0A8_G-yG4qg964f-sGiBNvfatYuTk5aBu9aw@mail.gmail.com>
In-Reply-To: <CACT4Y+azDLjbNH0A8_G-yG4qg964f-sGiBNvfatYuTk5aBu9aw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 22 Apr 2021 11:59:28 +0200
Message-ID: <CACT4Y+ZT47jPfHH-hgtqLre5wC-vy-yLN6Re3A-Oe2CQ+yAOvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/kasan: avoid duplicate KASAN issues from reporting
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:58 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Apr 22, 2021 at 11:17 AM Maninder Singh <maninder1.s@samsung.com> wrote:
> >
> > when KASAN multishot is ON and some buggy code hits same code path
> > of KASAN issue repetetively, it can flood logs on console.
> >
> > Check for allocaton, free and backtrace path at time of KASAN error,
> > if these are same then it is duplicate error and avoid these prints
> > from KASAN.

Can this be tested with the kunit kasan tests? If yes, please add a
test for this new code.


> > Co-developed-by: Vaneet Narang <v.narang@samsung.com>
> > Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> > ---
> >  mm/kasan/kasan.h  |  6 +++++
> >  mm/kasan/report.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 73 insertions(+)
> >
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 78cf99247139..d14ccce246ba 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -102,6 +102,12 @@ struct kasan_access_info {
> >         unsigned long ip;
> >  };
> >
> > +struct kasan_record {
> > +       depot_stack_handle_t    bt_handle;
> > +       depot_stack_handle_t    alloc_handle;
> > +       depot_stack_handle_t    free_handle;
> > +};
>
> Hi Maninder,
>
> There is no need to declare this in the header, it can be declared
> more locally in report.h.
>
> > +
> >  /* The layout of struct dictated by compiler */
> >  struct kasan_source_location {
> >         const char *filename;
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 87b271206163..4576de76991b 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -39,6 +39,10 @@ static unsigned long kasan_flags;
> >  #define KASAN_BIT_REPORTED     0
> >  #define KASAN_BIT_MULTI_SHOT   1
> >
> > +#define MAX_RECORDS            (200)
>
> s/MAX_RECORDS/KASAN_MAX_RECORDS/
>
> > +static struct kasan_record kasan_records[MAX_RECORDS];
>
> Since all fields in kasan_record are stack handles, the code will be
> simpler and more uniform, if we store just an array of handles w/o
> distinguishing between alloc/free/access.
>
> > +static int stored_kasan_records;
> > +
> >  bool kasan_save_enable_multi_shot(void)
> >  {
> >         return test_and_set_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
> > @@ -360,6 +364,65 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
> >         end_report(&flags, (unsigned long)object);
> >  }
> >
> > +/*
> > + * @save_report()
> > + *
> > + * returns false if same record is already saved.
>
> s/same/the same/
>
> > + * returns true if its new record and saved in database of KASAN.
>
> s/its/it's/
> s/database/the database/
>
> > + */
> > +static bool save_report(void *addr, struct kasan_access_info *info, u8 tag, unsigned long *flags)
> > +{
> > +       struct kasan_record record = {0};
> > +       depot_stack_handle_t bt_handle;
> > +       int i = 0;
> > +       const char *bug_type;
> > +       struct kasan_alloc_meta *alloc_meta;
> > +       struct kasan_track *free_track;
> > +       struct page *page;
> > +       bool ret = true;
> > +
> > +       kasan_disable_current();
> > +       spin_lock_irqsave(&report_lock, *flags);
>
> Reusing the caller flags looks strange, do we need it?
> But also the very next function start_report() also does the same
> dance: kasan_disable_current/spin_lock_irqsave. It feels reasonable to
> lock once, check for dups and return early if it's a dup.
>
> > +       bug_type = kasan_get_bug_type(info);
> > +       page = kasan_addr_to_page(addr);
> > +       bt_handle = kasan_save_stack(GFP_KERNEL);
>
> ASsign directly to record.bt_handle.
>
> > +       if (page && PageSlab(page)) {
> > +               struct kmem_cache *cache = page->slab_cache;
> > +               void *object = nearest_obj(cache, page, addr);
>
> Since you already declare new var in this block, move
> alloc_meta/free_track here as well.
>
> > +
> > +               alloc_meta = kasan_get_alloc_meta(cache, object);
> > +               free_track = kasan_get_free_track(cache, object, tag);
> > +               record.alloc_handle = alloc_meta->alloc_track.stack;
> > +               if (free_track)
> > +                       record.free_handle = free_track->stack;
> > +       }
> > +
> > +       record.bt_handle = bt_handle;
> > +
> > +       for (i = 0; i < stored_kasan_records; i++) {
> > +               if (record.bt_handle != kasan_records[i].bt_handle)
> > +                       continue;
> > +               if (record.alloc_handle != kasan_records[i].alloc_handle)
> > +                       continue;
> > +               if (!strncmp("use-after-free", bug_type, 15) &&
>
> Comparing strings is unreliable and will break in future. Compare
> handle with 0 instead, you already assume that 0 handle is "no
> handle".
>
> > +                       (record.free_handle != kasan_records[i].free_handle))
> > +                       continue;
> > +
> > +               ret = false;
> > +               goto done;
> > +       }
> > +
> > +       memcpy(&kasan_records[stored_kasan_records], &record, sizeof(struct kasan_record));
> > +       stored_kasan_records++;
>
> I think you just introduced an out-of-bounds write into KASAN, check
> for MAX_RECORDS ;)
>
>
> > +
> > +done:
> > +       spin_unlock_irqrestore(&report_lock, *flags);
> > +       kasan_enable_current();
> > +       return ret;
> > +}
> > +
> >  static void __kasan_report(unsigned long addr, size_t size, bool is_write,
> >                                 unsigned long ip)
> >  {
> > @@ -388,6 +451,10 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
> >         info.is_write = is_write;
> >         info.ip = ip;
> >
> > +       if (addr_has_metadata(untagged_addr) &&
>
> Why addr_has_metadata check?
> The kernel will probably crash later anyway, but from point of view of
> this code, I don't see reasons to not dedup wild accesses.
>
> > +               !save_report(untagged_addr, &info, get_tag(tagged_addr), &flags))
> > +               return;
> > +
> >         start_report(&flags);
> >
> >         print_error_description(&info);
> > --
> > 2.17.1
> >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA61F367E34
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbhDVJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbhDVJ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:59:09 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1F7C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:58:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z25so10620206qtn.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVnJbmEkfxXnJEPDJlf6F38sWKPScLpz9CDnrIopbyM=;
        b=TYedG1fJacOD+Bb2QwT7pOSedLhckqpyaM0TQ7zNMtmFymonWhNGx6n+SCybHM7wQl
         vzx52vqKLK2h2i8TmhMnXI++DcjCn1EAiUxqh9sg1tH/d3AlIfExRhooaIjGLQBAnjnC
         rvoWcAkXVIyMev4qGuGtMx7TPcNrWFp+eM9oSuZxLs8AiXK3a44jiCgz6BoZ4WaxJ3T0
         TTFULShEdpyq7JmNnZHkA+XUvZ4KpularJ70h7K9j+jFEXywTLkrQ+EzalCs5xrXM7Cf
         NX1wuP05h8WWOFsFbC0ezeu8OfwoGi/IQnL5GGHJWZQsA4I7qjQmR+XSD12pyKINfFnd
         aGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVnJbmEkfxXnJEPDJlf6F38sWKPScLpz9CDnrIopbyM=;
        b=W+Q9uRMOoLRI065lCeEQDJMohC+L3gNqfYcmIXLq7g6Juigv7r8OZCQ0ojm2SAeuWS
         QZOY9LwtWTAiRF5/rm6wNZ6VFYBfY6NdIMwL48VJVuu/UPr1E4tc37oELD0slo4pc7x7
         7gCdL4NPPRJHo7hy7CYLPPLfE9iTXNgd+qHpmypcY0J/vrf+EFBvIZQYUhq2CbJ/aRFU
         EKB29hy21uTiviRGo4Ph5UU6Sn9aUAXJ304Xk1daIPRj80DDxTD5AA0R/49khjgjN4/o
         TP+82OCVjV15szDXPTvLbYqNbNqOSZcloCjhtsU5XwOcGgiDbaS0OByg4wALd57s6tof
         LKpw==
X-Gm-Message-State: AOAM531I1GvLrYdH1VTwjJMqaC/rne6eMvsVcEcCmQeVS0eaSBjc960i
        z2JfJ1KSbp7HKkY15fGe1PKciGkgreg84n1v84oOUw==
X-Google-Smtp-Source: ABdhPJyJ8oT1MqeUdOl5WYqQqJBPncgbwFNVWPDlaBH7Gtho0a7YHGMvC3uCjojGUnpUotMf6LpoilEeGPbiM39X5EM=
X-Received: by 2002:ac8:5c92:: with SMTP id r18mr2284877qta.66.1619085513632;
 Thu, 22 Apr 2021 02:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa@epcas5p2.samsung.com>
 <1619079317-1131-1-git-send-email-maninder1.s@samsung.com>
In-Reply-To: <1619079317-1131-1-git-send-email-maninder1.s@samsung.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 22 Apr 2021 11:58:22 +0200
Message-ID: <CACT4Y+azDLjbNH0A8_G-yG4qg964f-sGiBNvfatYuTk5aBu9aw@mail.gmail.com>
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

On Thu, Apr 22, 2021 at 11:17 AM Maninder Singh <maninder1.s@samsung.com> wrote:
>
> when KASAN multishot is ON and some buggy code hits same code path
> of KASAN issue repetetively, it can flood logs on console.
>
> Check for allocaton, free and backtrace path at time of KASAN error,
> if these are same then it is duplicate error and avoid these prints
> from KASAN.
>
> Co-developed-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  mm/kasan/kasan.h  |  6 +++++
>  mm/kasan/report.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 78cf99247139..d14ccce246ba 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -102,6 +102,12 @@ struct kasan_access_info {
>         unsigned long ip;
>  };
>
> +struct kasan_record {
> +       depot_stack_handle_t    bt_handle;
> +       depot_stack_handle_t    alloc_handle;
> +       depot_stack_handle_t    free_handle;
> +};

Hi Maninder,

There is no need to declare this in the header, it can be declared
more locally in report.h.

> +
>  /* The layout of struct dictated by compiler */
>  struct kasan_source_location {
>         const char *filename;
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 87b271206163..4576de76991b 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -39,6 +39,10 @@ static unsigned long kasan_flags;
>  #define KASAN_BIT_REPORTED     0
>  #define KASAN_BIT_MULTI_SHOT   1
>
> +#define MAX_RECORDS            (200)

s/MAX_RECORDS/KASAN_MAX_RECORDS/

> +static struct kasan_record kasan_records[MAX_RECORDS];

Since all fields in kasan_record are stack handles, the code will be
simpler and more uniform, if we store just an array of handles w/o
distinguishing between alloc/free/access.

> +static int stored_kasan_records;
> +
>  bool kasan_save_enable_multi_shot(void)
>  {
>         return test_and_set_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
> @@ -360,6 +364,65 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>         end_report(&flags, (unsigned long)object);
>  }
>
> +/*
> + * @save_report()
> + *
> + * returns false if same record is already saved.

s/same/the same/

> + * returns true if its new record and saved in database of KASAN.

s/its/it's/
s/database/the database/

> + */
> +static bool save_report(void *addr, struct kasan_access_info *info, u8 tag, unsigned long *flags)
> +{
> +       struct kasan_record record = {0};
> +       depot_stack_handle_t bt_handle;
> +       int i = 0;
> +       const char *bug_type;
> +       struct kasan_alloc_meta *alloc_meta;
> +       struct kasan_track *free_track;
> +       struct page *page;
> +       bool ret = true;
> +
> +       kasan_disable_current();
> +       spin_lock_irqsave(&report_lock, *flags);

Reusing the caller flags looks strange, do we need it?
But also the very next function start_report() also does the same
dance: kasan_disable_current/spin_lock_irqsave. It feels reasonable to
lock once, check for dups and return early if it's a dup.

> +       bug_type = kasan_get_bug_type(info);
> +       page = kasan_addr_to_page(addr);
> +       bt_handle = kasan_save_stack(GFP_KERNEL);

ASsign directly to record.bt_handle.

> +       if (page && PageSlab(page)) {
> +               struct kmem_cache *cache = page->slab_cache;
> +               void *object = nearest_obj(cache, page, addr);

Since you already declare new var in this block, move
alloc_meta/free_track here as well.

> +
> +               alloc_meta = kasan_get_alloc_meta(cache, object);
> +               free_track = kasan_get_free_track(cache, object, tag);
> +               record.alloc_handle = alloc_meta->alloc_track.stack;
> +               if (free_track)
> +                       record.free_handle = free_track->stack;
> +       }
> +
> +       record.bt_handle = bt_handle;
> +
> +       for (i = 0; i < stored_kasan_records; i++) {
> +               if (record.bt_handle != kasan_records[i].bt_handle)
> +                       continue;
> +               if (record.alloc_handle != kasan_records[i].alloc_handle)
> +                       continue;
> +               if (!strncmp("use-after-free", bug_type, 15) &&

Comparing strings is unreliable and will break in future. Compare
handle with 0 instead, you already assume that 0 handle is "no
handle".

> +                       (record.free_handle != kasan_records[i].free_handle))
> +                       continue;
> +
> +               ret = false;
> +               goto done;
> +       }
> +
> +       memcpy(&kasan_records[stored_kasan_records], &record, sizeof(struct kasan_record));
> +       stored_kasan_records++;

I think you just introduced an out-of-bounds write into KASAN, check
for MAX_RECORDS ;)


> +
> +done:
> +       spin_unlock_irqrestore(&report_lock, *flags);
> +       kasan_enable_current();
> +       return ret;
> +}
> +
>  static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>                                 unsigned long ip)
>  {
> @@ -388,6 +451,10 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>         info.is_write = is_write;
>         info.ip = ip;
>
> +       if (addr_has_metadata(untagged_addr) &&

Why addr_has_metadata check?
The kernel will probably crash later anyway, but from point of view of
this code, I don't see reasons to not dedup wild accesses.

> +               !save_report(untagged_addr, &info, get_tag(tagged_addr), &flags))
> +               return;
> +
>         start_report(&flags);
>
>         print_error_description(&info);
> --
> 2.17.1
>

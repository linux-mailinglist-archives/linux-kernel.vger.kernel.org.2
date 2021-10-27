Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E070843C44D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbhJ0Htt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhJ0Htq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:49:46 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EFEC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:47:21 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i65so4161261ybb.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loo6J+IxIj4clOI8hbAYwr44QCVgT2WqP23IkmlyE90=;
        b=ejNHgkTEI3rvzEqVdyGTwC4ZsTd3PDCtXvqQq6h7xYm339qXrcU/LTl4td5IJ9K80l
         PDNmBPPXvQvVaBiiZy7PN77C7Czz+NStfGWc39W0PiK9prM9AT9f9ivIUH3nZFIriI5F
         DqBL6YR/3Pd9WTECoGr0FNUp0mAdSqAJ7x9IvKOjAF4Eei+IrsiX3gCMIpSS8lnvQcfO
         tPV9rmIQvzqweHp9j7FRlN2Aj2U94P3ECNMGnwpExpWsaG1pcGzR7r6cwjmGGRlxZ+mv
         ldbrKEaIAHjOHVr8Oia34oebIlHlXXUlIpNgUsWRdXVA3jtrqvR+tD1bkjSJLRjLJwUp
         2Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loo6J+IxIj4clOI8hbAYwr44QCVgT2WqP23IkmlyE90=;
        b=sAYfNwmOyurNXPl+mwJf2m3X2d9bDr2TaQaYx0qTLwzLiEitoYQ+4da5Vi+TAqOqb4
         cK48f44wnRIrG33kNO5P13FQX4ETdz2TDmz7h7DnVetocEK45guGJeKhituTWIrZCLp7
         RWq1gtczsZQaFXRUfO2mwe0GEo4oFY59hNChn19AUAyu0ja4Q3NsBz/3OqDnIMickl6v
         xhzexaZit1KEAO2zT8hBy/UJQAfTq7x8rZydkE9X+MmZFPRvjHlu7xh0t/eCDULlUUKb
         esBiFRBiTqio60qeS4WORHQGwJUYrpxWV9ZZ4OXqJbuhbOEKgXjY+HPkhhzFOGqT3PJb
         WXIA==
X-Gm-Message-State: AOAM531iesJYA1GYhXKkZDSr20stAZw6Hi0kaRIJMfeMsSEYwyJWoihB
        okOJpcBgixXQOD+RuJsAr4tuMdyWWVMYlgP/9qhR2PaDxX0/mg==
X-Google-Smtp-Source: ABdhPJz+XebE2bOjEj4+R9On6uOHRAEk9nRXfXlxTPyeWvga0rJ1rMsvtN+tWifQabRIRggo5SvYAy4Nno4c280mUp4=
X-Received: by 2002:a25:3b50:: with SMTP id i77mr1035222yba.404.1635320840664;
 Wed, 27 Oct 2021 00:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com> <20211026173822.502506-2-pasha.tatashin@soleen.com>
In-Reply-To: <20211026173822.502506-2-pasha.tatashin@soleen.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 27 Oct 2021 15:46:42 +0800
Message-ID: <CAMZfGtVS2ZRAsd9HLODoLa1vVp0XCcBOTXjsmpoWwDcdGaADvQ@mail.gmail.com>
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
        Vlastimil Babka <vbabka@suse.cz>, geert@linux-m68k.org,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 1:38 AM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> The problems with page->_refcount are hard to debug, because usually
> when they are detected, the damage has occurred a long time ago. Yet,
> the problems with invalid page refcount may be catastrophic and lead to
> memory corruptions.
>
> Reduce the scope of when the _refcount problems manifest themselves by
> adding checks for underflows and overflows into functions that modify
> _refcount.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

I found some atomic_add/dec are replaced with atomic_add/dec_return,
those helpers with return value imply a full memory barrier around it, but
others without return value do not. Do you have any numbers to show
the impact? Maybe atomic_add/dec_return_relaxed can help this.

Thanks.

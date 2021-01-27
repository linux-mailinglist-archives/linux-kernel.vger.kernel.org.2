Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C48305068
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbhA0EGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhA0DE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:04:59 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB813C061356
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 19:04:00 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id z22so427869ioh.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 19:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axTIKsBwCZ+GiXRsONJYMKcV1k64sfNs+QF8LQway7I=;
        b=SQO2pjLRhLokWeJHP9LJQGT+ZE2MfSwMR7DxeQvUPhWA1RlnzLDtcHchVOq+VLPuxY
         Mbe85F9UU/NLSi6kyisqYSZvvgK8wZljI55UP1YWqF8DfWk/vu00sYI7Jrj0x3W+zsaO
         AimZdBTXchXe8KS8UQS/yycFSN3KX10XncxHeRPQk2Z0WEoGhMo03DpK8eOZ8sr+ArC7
         TiS28tvZ0fWG56rjG/BKpTBvkjvTl19z0Q0Z7k15LjHzJiHo24KonZYqEAd/NncjjZ/K
         aMi84RdwAG0v2CCcA50W9szVylmRtzDPXxmlqp1hi9w8dkUISO7RV0nAwp2j4Jon7IUN
         SdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axTIKsBwCZ+GiXRsONJYMKcV1k64sfNs+QF8LQway7I=;
        b=H3xTB2OhwPvxPo9N3HeZj6vsKn0wyLLEAB/DUQJyg2094q4ix9riQN9onCytbfvsoj
         ObFDrHOLrfkgHoxtXKcEyqtm8gGhDLouwSIL6UnIgIDV7gYdTrWzhftAmq4brQhjcDjs
         uw1dHrh9C5dC+XyR9toTT25HOEMQEQv+cpZXfAh1ktKmXLNZ0PGUslvUipsYRugkf5C4
         rHrboFFz2/Wv5Mtsg8xZh7BvuavDQ28+M+rnQHZoGDJ3lW0hU5O3NwWpSUUCc4T6Iqa7
         IrWO2TuMB0ZdVR3NsttROgjArNL/YSA9e9T0EBwNMMIsh2ryjMV/3c8Blylp2nEmflhe
         SEPA==
X-Gm-Message-State: AOAM532dM9/dbfbJ/W9vLA+RUnHGXRUHL9ij+TkZcjnTU65fGrA0iRJI
        WVjEKoWY2nc6WpLp/mAqGF5oZDLwLqR+irRxY5U=
X-Google-Smtp-Source: ABdhPJwhV15h3wABHLVrnWAkb1Jj2bJnhzGJyJOA21E4vxXrNij5RTS29F/k7XdbVodRKTPSq2hEuke+zrEOkFSmwBI=
X-Received: by 2002:a02:a997:: with SMTP id q23mr7346724jam.67.1611716640325;
 Tue, 26 Jan 2021 19:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20210126171141.122639-1-paul.gortmaker@windriver.com> <20210126171141.122639-3-paul.gortmaker@windriver.com>
In-Reply-To: <20210126171141.122639-3-paul.gortmaker@windriver.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 26 Jan 2021 19:03:49 -0800
Message-ID: <CAAH8bW9kE03eYdAeEQPnogBHeBfGTbyj5teDEfn2wxFZME5x-Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] lib: test_bitmap: add more start-end:offset/len tests
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lizefan@huawei.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, josh@joshtriplett.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, fweisbec@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 9:12 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> There are inputs to bitmap_parselist() that would probably never
> be entered manually by a person, but might result from some kind of
> automated input generator.  Things like ranges of length 1, or group
> lengths longer than nbits, overlaps, or offsets of zero.
>
> Adding these tests serve two purposes:
>
> 1) document what might seem odd but nonetheless valid input.
>
> 2) don't regress from what we currently accept as valid.
>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  lib/test_bitmap.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 3d2cd3b1de84..807d1e8dd59c 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -35,6 +35,8 @@ static const unsigned long exp1[] __initconst = {
>         BITMAP_FROM_U64(0x3333333311111111ULL),
>         BITMAP_FROM_U64(0xffffffff77777777ULL),
>         BITMAP_FROM_U64(0),
> +       BITMAP_FROM_U64(0x00008000),
> +       BITMAP_FROM_U64(0x80000000),
>  };
>
>  static const unsigned long exp2[] __initconst = {
> @@ -335,6 +337,26 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
>         {0, " ,  ,,  , ,   ",           &exp1[12 * step], 8, 0},
>         {0, " ,  ,,  , ,   \n",         &exp1[12 * step], 8, 0},
>
> +       {0, "0-0",                      &exp1[0], 32, 0},
> +       {0, "1-1",                      &exp1[1 * step], 32, 0},
> +       {0, "15-15",                    &exp1[13 * step], 32, 0},
> +       {0, "31-31",                    &exp1[14 * step], 32, 0},
> +
> +       {0, "0-0:0/1",                  &exp1[12 * step], 32, 0},
> +       {0, "0-0:1/1",                  &exp1[0], 32, 0},
> +       {0, "0-0:1/31",                 &exp1[0], 32, 0},
> +       {0, "0-0:31/31",                &exp1[0], 32, 0},
> +       {0, "1-1:1/1",                  &exp1[1 * step], 32, 0},
> +       {0, "0-15:16/31",               &exp1[2 * step], 32, 0},
> +       {0, "15-15:1/2",                &exp1[13 * step], 32, 0},
> +       {0, "15-15:31/31",              &exp1[13 * step], 32, 0},
> +       {0, "15-31:1/31",               &exp1[13 * step], 32, 0},
> +       {0, "16-31:16/31",              &exp1[3 * step], 32, 0},
> +       {0, "31-31:31/31",              &exp1[14 * step], 32, 0},
> +
> +       {0, "0-31:1/3,1-31:1/3,2-31:1/3",       &exp1[8 * step], 32, 0},
> +       {0, "1-10:8/12,8-31:24/29,0-31:0/3",    &exp1[9 * step], 32, 0},
> +
>         {-EINVAL, "-1", NULL, 8, 0},
>         {-EINVAL, "-0", NULL, 8, 0},
>         {-EINVAL, "10-1", NULL, 8, 0},  /* (start > end) ; also ERANGE */
> --
> 2.17.1

Acked-by: Yury Norov <yury.norov@gmail.com>

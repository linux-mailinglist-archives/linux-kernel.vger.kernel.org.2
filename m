Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA78F35345C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 16:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhDCOpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhDCOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 10:45:29 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B9C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 07:45:25 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so7420347oto.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fd57dXyQV6AT1R00nKnfUO2FzSbFjinw6VgrMLgEL4U=;
        b=uX/VfAjFux5IF302lX518bHTStFi96or0bU6mH6tb/4P7FlLsv7YSQhUp6x+R8k0em
         ubIxuVl6x55LIVHZeOe9w9YStTWAdJw7kAQl7R5+7pxI9O0h+qM5+HDQEQFEvcm6leGZ
         GflGKyAqauMcIJY9ATi3Kyw9Tkqbl9WdYWLNKJXvcve8Bfywu74Zuta1ybgbaJtulC+s
         2CR4bGtLHX1c3qe4BLws95WSx0n+FTQP2ZfGocczdClmNJK+l6CpYqIpF11a44j4fkg6
         0FdOGjTsW8atFNhHDiKy2nsJYAlYoZjJtCTMuBF8cQYMTGEeqIHEKtE7VXuAPUgvY6qi
         CaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fd57dXyQV6AT1R00nKnfUO2FzSbFjinw6VgrMLgEL4U=;
        b=kTWtZiDl5huru3/j4OuU/vyP0derZdvDT1boZ2nJF6irvHnVSbxXhTGilNlMYypYXC
         ViLjPiUDoMIn3Mnw41YW5rs9e2F7QJmhMowO5T/9wS6BTiqPPAfTUNlxOecRpyUzdRWG
         KKgcl6Y9tqo7+EfbMijhk76pN5zpj6jDoRAhspMNgq4vWiT6h1r30c8WRY7Lalv/56Hc
         u2mXqGGvhJmm7B8cFsG5LcZBSvcE5T6x7yLmLSgDaLqA1ej2hMNnzc/pEdfeoM4qltDG
         nVTGWZtjeEd6oJzVAeaakBk9iF2xdh6dNCBEJDeqc1o79Z5UnCXmVujIoB93VKq2XTQb
         xRbA==
X-Gm-Message-State: AOAM5337ynsd2yJMFey9u0JmcAKb4MvGOgmxs0D1ORJEAMF29wSNU14m
        ZFgfAAHjPzB+Z2RNGzmr1iT4Q3pCAJ89tsPUJjDGGw==
X-Google-Smtp-Source: ABdhPJx2Dj8ZBn5LJr20YtASOMkaB5/FF5uBlxh3qrOWZxY/85TFkpoGkjMQO2tRs8zHEyKBHTjSfMNxle27WK7Yv2Q=
X-Received: by 2002:a9d:5508:: with SMTP id l8mr15738536oth.233.1617461124762;
 Sat, 03 Apr 2021 07:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210403051325.683071-1-pcc@google.com> <CA+fCnZc+-csYZ+4ao1Y4gmjhej9Rtt9WRzHhEvCee3ePHoydRg@mail.gmail.com>
In-Reply-To: <CA+fCnZc+-csYZ+4ao1Y4gmjhej9Rtt9WRzHhEvCee3ePHoydRg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 3 Apr 2021 16:45:13 +0200
Message-ID: <CANpmjNP+p6QyOJnMmtrG-d4bSrhRZoGVGfvp=-WNHL8kpXHUUg@mail.gmail.com>
Subject: Re: [PATCH] kfence: unpoison pool region before use
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2021 at 16:05, Andrey Konovalov <andreyknvl@gmail.com> wrote:
...
> Which kasan_byte_accessible() call fails?
>
> KASAN checks shouldn't be performed for KFENCE objects. We have a
> number of is_kfence_address() checks in KASAN runtime, but maybe we're
> missing some. Perhaps, we should even move those checks into the
> high-level wrappers in include/linux/kasan.h.

Moving them into include/linux/kasan.h seems unnecessary and an easy
way to introduce unnecessary overhead. AFAIK, there should be no
difference between having them in the high-level wrappers and the
inner runtime functions. I think until we understand what is actually
going on and could thoroughly justify, I'd be opposed to larger
changes. The small patch here is innocent enough, but it'd still be
good to understand. (FWIW, I believe the issue was encountered with
SW_TAGS on a downstream kernel.)

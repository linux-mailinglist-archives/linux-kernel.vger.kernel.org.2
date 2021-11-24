Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E2A45CBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351039AbhKXSKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350347AbhKXSJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:09:45 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27909C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:06:35 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so1212807ooe.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMUMI0m488pbWUAXr6OzZzxKEpJRpDah7A59AGDrcqc=;
        b=tZ1DG4V4BbHUZ10IG4qSJ0EpZVSL1YGVa5GTc2TF1sxYM/H8tHDCaMQpRBAYaFMUr2
         NMlYl6TFNcRQiorldPEFv/x0WAOjGuejKpgzbXm0ToGi+MghfqhYc8t9zucpNGrbJ595
         FpeVAFCe2llrdVVsxEvYE2vCdiO2gR5j2mhuiEtJ55gnQ4GBfAZGPnhf4K+O3mgSyLK2
         lm8t1GAXu1ZQJ0L64xCtiEys8Ea2xKFTDPGMjwdDTsNph+YobTgkgcC4ZyiXT5Ef/yVW
         h6L66C51/Mq5Fyy1ShiaKkCWsL3LWNT6aUr56CgJaqRftPUeoo0lefMSp4TXdp+Gw33M
         LV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMUMI0m488pbWUAXr6OzZzxKEpJRpDah7A59AGDrcqc=;
        b=KLexEbwrXjbgX9mxY/yHah3leNNV7n4NFPU7yWU4GRcjRsQVxKlx9hH+g/M55l6Be/
         s5jtxr+MApr2jdMd0f33O+AXmNRAwouyuE7THwPacVqSV0WIastca14cH9MFUiDPC5lm
         axEggM8y1lxHr50PS897dZMj2kDDRyetKgQKo8JgapkMHDplHYskxd6cTntDqywbei1V
         4Jmk2VIBTvqiIrP/ZZVoke0Np+41Uney7/QOOnEP8EE8OJ6JvNJEn7F/mTzKMpHQOIqO
         gPXFC9KKB2OiVrcscOXJra9QmFqwP8/zt5KaSnmvBcNb+/Q4gaHWUT4y/tqUZf1cxl6i
         Qy2A==
X-Gm-Message-State: AOAM532r2bxMR/YO7m98+S5IXijGnGzMHczE/TCWv2v+Gm8CLek1TGfV
        epqnANRgPABovPh5ULYrMJTAvdAhJtJc5zBucJFA1w==
X-Google-Smtp-Source: ABdhPJxztcRYy5Q8/09XRwcDPshbomSGAC6oC6solbJnyGdhyd/PPvH2KSyesT9D9sIFFDcipEPlYDmdt5c4KsA3QBs=
X-Received: by 2002:a4a:4f04:: with SMTP id c4mr10227828oob.62.1637777194256;
 Wed, 24 Nov 2021 10:06:34 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2111241839590.16505@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2111241839590.16505@cbobk.fhfr.pm>
From:   Marco Elver <elver@google.com>
Date:   Wed, 24 Nov 2021 19:06:22 +0100
Message-ID: <CANpmjNOHN7SWu-pKGr9EBb3=in2AWiGmqNb6sYwhebGtRk+1uQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: distinguish kasan report from generic BUG()
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jslaby@suse.cz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 18:41, Jiri Kosina <jikos@kernel.org> wrote:
>
> From: Jiri Kosina <jkosina@suse.cz>
>
> The typical KASAN report always begins with
>
>         BUG: KASAN: ....
>
> in kernel log. That 'BUG:' prefix creates a false impression that it's an
> actual BUG() codepath being executed, and as such things like
> 'panic_on_oops' etc. would work on it as expected; but that's obviously
> not the case.
>
> Switch the order of prefixes to make this distinction clear and avoid
> confusion.
>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

I'm afraid writing "KASAN: BUG: " doesn't really tell me this is a
non-BUG() vs. "BUG: KASAN". Using this ordering ambiguity to try and
resolve human confusion just adds more confusion.

The bigger problem is a whole bunch of testing tools rely on the
existing order, which has been like this for years -- changing it now
just adds unnecessary churn. For example syzkaller, which looks for
"BUG: <tool>: report".

Changing the order would have to teach all kinds of testing tools to
look for different strings. The same format is also used by other
dynamic analysis tools, such as KCSAN, and KFENCE, for the simple
reason that it's an established format and testing tools don't need to
be taught new tricks.

Granted, there is a subtle inconsistency wrt. panic_on_oops, in that
the debugging tools do use panic_on_warn instead, since their
reporting behaviour is more like a WARN. But I'd also not want to
prefix them with "WARNING" either, since all reports are serious bugs
and shouldn't be ignored. KASAN has more fine-grained control on when
to panic, see Documentation/dev-tools/kasan.rst.

If the problem is potentially confusing people, I think the better
solution is to simply document all kernel error reports and their
panic-behaviour (and flags affecting panic-behaviour) in a central
place in Documentation/.

Thanks,
-- Marco

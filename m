Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5817132448A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 20:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhBXTTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 14:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbhBXTTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 14:19:17 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE38C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:18:37 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id w36so4758794lfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsetPJB5m47FCg13KC6GjSTLKBsPDI7MuzXhPKMTnS4=;
        b=g0wCVRLuZhRAZSx2tZaeQKkHmjHJt6HcVeX1wF81XK3ID/P21CzwT5FyHF6bzyJiaK
         7Wbpg65iES9Lwj24IG8yT/fkKOgtfPxfvdKC+qXihnsfhzxP5qlnVz0sgNHOO9KXWCV6
         eIoO/wnpUtMRNAs14sprZgujgxrvqBNk1ASSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsetPJB5m47FCg13KC6GjSTLKBsPDI7MuzXhPKMTnS4=;
        b=tr+ieX7K9ikVuAzad0r/4Lvec/TuNvshWpoR1cw4mZYJ5jfmenVoZYHPIZmQevESYF
         A4jhIrrlTUday2OWiJv6P34NKdGdAcIZuEbm4kEhjwuVcoHlO3p8rXLUCpKCnewc0y9P
         WbgPcx1I60ncRKWks142pBJXDXtALsrOFRKeJhqPrFUHjc0GIEZnHFBK+eJcnccrYhkh
         h5B+NYOrOk1Nse1Arv+eTF9WKl3Gs2heBn/G8QXtIgDzFYTIQxoi9vMGE3kpZsP7NS9N
         DCgtMbCmlArhLL7s7LWehNdDg8OPjGzqXr8OiqBvgQK1pC9sqiQWU0EtcO0fUC0fNKLO
         yLTQ==
X-Gm-Message-State: AOAM531pIo72+ilbsqcGDCxUhVEncwnZPOvu3L0yuPN3FoqlRhKhcBgR
        FabCDIEzuyiJSQLwvU4Gw99mrR/C7No/Gg==
X-Google-Smtp-Source: ABdhPJzsOMkMiPJ9tAdHJGXEJnFgMIfuP/B5SKNYKQ8g885aahve0eUbtiXJdhWZbd5Uqo8rW0viJQ==
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr21033408lfe.313.1614194315379;
        Wed, 24 Feb 2021 11:18:35 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id h28sm650452lfg.234.2021.02.24.11.18.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 11:18:35 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id f1so4783121lfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:18:34 -0800 (PST)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr20000602lfu.253.1614193859813;
 Wed, 24 Feb 2021 11:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20210224051845.GB6114@xsang-OptiPlex-9020> <m1czwpl83q.fsf@fess.ebiederm.org>
 <20210224183828.j6uut6sholeo2fzh@example.org>
In-Reply-To: <20210224183828.j6uut6sholeo2fzh@example.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Feb 2021 11:10:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3wVpx97e=n2D98W+PSDWUkQrX3O+c7n7MGRbn_k9JMg@mail.gmail.com>
Message-ID: <CAHk-=wh3wVpx97e=n2D98W+PSDWUkQrX3O+c7n7MGRbn_k9JMg@mail.gmail.com>
Subject: Re: d28296d248: stress-ng.sigsegv.ops_per_sec -82.7% regression
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com,
        io-uring <io-uring@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 10:38 AM Alexey Gladkov
<gladkov.alexey@gmail.com> wrote:
>
> One of the reasons for this is that I rolled back the patch that changed
> the ucounts.count type to atomic_t. Now get_ucounts() is forced to use a
> spin_lock to increase the reference count.

Yeah, that definitely should be an atomic type, since the extended use
of ucounts clearly puts way too much pressure on that ucount lock.

I remember complaining about one version of that patch, but my
complaint wasabout it changing semantics of the saturation logic (and
I think it was also wrong because it still kept the spinlock for
get_ucounts(), so it didn't even take advantage of the atomic
refcount).

Side note: I don't think a refcount_t" is necessarily the right thing
to do, since the ucount reference counter does its own saturation
logic, and the refcount_t version is imho not great.

So it probably just needs to use an atomic_t, and do the saturation
thing manually.

Side note: look at try_get_page(). That one actually does refcounting
with overflow protection better than refcount_t, in my opinion. But I
am obviously biased, since I wrote it ;)

See commits

    88b1a17dfc3e mm: add 'try_get_page()' helper function
    f958d7b528b1 mm: make page ref count overflow check tighter and
more explicit

with that "page->_recount" being just a regular atomic_t.

            Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84303453775
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhKPQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbhKPQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:32:20 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8422C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 08:29:22 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v7so59325364ybq.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jo2z/sk4w5ET+TMNOU4Bv9tAqb0FTWbn//GMT837wWo=;
        b=Bj3MQbYKuY2HSsvTHleRkzdz0dS4u/QQIFIQVLy6ihpEnMue9pCmiUT3ro8/eJQHui
         uJYhXtGbAv55wIXPjWI9Dx/BKBAq3GHdtRIgBD3+smRb+wUDMLZJ1P9Thz2j+cPTOFlh
         FWPlVw5XIFz1/w9V5JXJFshQsFFTfUq7/HoA3xZqUfmgZo+sEytywvzlOyQDoAB6jE+I
         MLkxypGX8akOQxBMGvP7ZkMyuuldubtDbbwPASHgLgi0B3yrjwcMQpvGW2JQhRoj89UA
         uR1JzkQhGJOOI5RYp+dthWzzbkZ2esiMcZgrTg/pS8atsHEt71SpMxHAgxIm4KK+XuG3
         WrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jo2z/sk4w5ET+TMNOU4Bv9tAqb0FTWbn//GMT837wWo=;
        b=S1Nz3wOXML+HhLnkZlzMiM2BT5EIjDUybwMcPpr9rL7bpP7iJDcn7hwSLg5rT4v5vg
         8e2ANmqSQLg7zzUf62ei/nOgS3RmMWC1M1t2b8R5qLB3Mm6VQuw4KLGBys5ZXDKIJ3ZU
         6X78eXrKsNb8HShW0KXBYn5gMQ+bt/u05K/CbQUir5/qPKXc6T4mkNhtpUgotYgS4zBv
         MXm7KVhjY8rjwM+5gV07K9an94t3WqNqUsrPmX5XvMekE6hT8pWpLLhVWRLHYXaXJU1H
         Zb/et+M6g2fQqTXC5kw0XYxuoadaQ8zKJF2L+O74D3oApjhIap2zPLLSV7VXNij3Bc+q
         a6pw==
X-Gm-Message-State: AOAM531KLVYico2XyVFNDjICzU8Veh+focvKsAbWhN/AY/omqxe9oXp1
        /pPs6WMhMuBrA67P4f9rJ05AP2dWKiT+Ep1TfnktHQ==
X-Google-Smtp-Source: ABdhPJyWGi9v6oZRY6+Aur7ihxhAeaLhwnzKpU43nXHE9UtzmOl9DYKed1QSbT413RMotAwHS4PAVJeWYYSOX5AUNN0=
X-Received: by 2002:a25:2f58:: with SMTP id v85mr9626618ybv.487.1637080161720;
 Tue, 16 Nov 2021 08:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20211019215511.3771969-1-surenb@google.com> <20211019215511.3771969-2-surenb@google.com>
 <89664270-4B9F-45E0-AC0B-8A185ED1F531@google.com> <CAJuCfpE-fR+M_funJ4Kd+gMK9q0QHyOUD7YK0ES6En4y7E1tjg@mail.gmail.com>
 <CAJuCfpHfnG8b4_RkkGhu+HveF-K_7o9UVGdToVuUCf-qD05Q4Q@mail.gmail.com>
 <CAJuCfpEJuVyRfjEE-NTsVkdCZyd6P09gHu7c+tbZcipk+73rLA@mail.gmail.com> <YZN/BMImQqrK4MWm@dhcp22.suse.cz>
In-Reply-To: <YZN/BMImQqrK4MWm@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 16 Nov 2021 08:29:10 -0800
Message-ID: <CAJuCfpH6Cg=CDut_9vd3BcX6U_X0WR2tFkqKePLU7aPxFO0UDw@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] mm: add a field to store names for private
 anonymous memory
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, Alexey Alexandrov <aalexand@google.com>,
        ccross@google.com, sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com, pavel@ucw.cz,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 1:51 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 15-11-21 10:59:20, Suren Baghdasaryan wrote:
> [...]
> > Hi Andrew,
> > I haven't seen any feedback on my patchset for some time now. I think
> > I addressed all the questions and comments (please correct me if I
> > missed anything).
>
> I believe the strings vs. ids have been mostly hand waved away. The
> biggest argument for the former was convenience for developers to have
> something human readable. There was no actual proposal about the naming
> convention so we are relying on some unwritten rules or knowledge of the
> code to be debugged to make human readable string human understandable
> ones. I believe this has never been properly resolved except for - this
> has been used in Android and working just fine. I am not convinced TBH.
>
> So in the end we are adding a user interface that brings a runtime and
> resource overhead that will be hard to change in the future. Reference
> counting handles a part of that and that is nice but ids simply do not
> have any of that.

I explained the way this interface is used and why ids would not work
for us in https://lore.kernel.org/all/CAJuCfpESeM_Xd8dhCj_okNggtDUXx3Nn9FpL_f9qsKXKZzCKpA@mail.gmail.com.
I explored all the proposed alternatives, all of which would be
prohibitive for our needs due to performance costs compared to this
solution. I wish I could come up with something simpler but a simpler
solution simply does not meet our needs.

It's true that this approach does not formalize how VMAs are named but
I don't see why kernel should impose a naming convention. I can see
some systems defining more formal conventions but I believe it should
be up to the userspace to do that.

>
> > Can it be accepted as is or is there something I should address
> > further?
>
> Is the above reason to nack it? No, I do not think so. I just do not
> feel like I want to ack it either. Concerns have been expressed and I
> have to say that I would like a minimalistic approach much more. Also
> extending ids into string is always possible. The other way around is
> not possible.

Unfortunately, extending ids into strings comes with the cost we can't
afford in Android. Therefore I don't see a point for me to upstream
such a solution which I can't use.
Thanks,
Suren.

>
> --
> Michal Hocko
> SUSE Labs

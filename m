Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4196E405BF3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbhIIRY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbhIIRYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:24:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B6C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 10:23:15 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s3so4126373ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6IJpdyTV9RM1+HAVghvZCBeKL8NDMdT8/thsJ+vYl0=;
        b=d/Cm/SAUhDwf7DCQEkoVrmFkB/9CL0b8pA5PmPS8EU77HXDdzgEOXRUTwEK6IETgXK
         d7dwkAqlP05KbPlW3NS8FI7pi0/wpcu8lpfbqGzYvk5d/J1P80i0uY894FNCjnJ99IT7
         Z/LeSXzV7P3I2yGkUEJbF3lmaMHtRIQBM+ljk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6IJpdyTV9RM1+HAVghvZCBeKL8NDMdT8/thsJ+vYl0=;
        b=tvFGORIJb0PM1nhcAWZ9kjVy2TufsPAsr+mKoAOMYupM0wr9ULFMk8OhgVDLtuzWou
         PfWaGEHrkBGfmLZemU4dWnPF7X7FPAITQ8r/Be9cFJvKCasn68dVdbGQoqB2YXgeSNYP
         XEJehCyY27M94eA9gOGK1MmCWUkL0JXR5VcQH9QtTZ/KvJlgvrI0HxyLCazG27ahojsv
         wrIkZ8K8LPIvTVZzTIjNsgIMtvk4k3w8q+tgjvWnXL7UwInsV9YF6/ZfUvtqKVv5dxcc
         oVtteJfLEULS10J2QpR19SQ1iffJl9s77/HrcrTqM+sFQJx5Csu/Q1iX2yyfLPl6GQIO
         LN3Q==
X-Gm-Message-State: AOAM530mDcgmJ84T5o2bCYqpeMLCiGGuXTj3BnshSCyQIkwTuwaMNGSe
        LAFfKzdBbxAMtQ3Mv0eGuV7xJq4kpnVcSc/M+U0=
X-Google-Smtp-Source: ABdhPJzb9amopsqcNZhs3nFWn4WRfh1Bs0c0o5AKRAlibBUt3+mMLLZKQW43t0WnKk/EoPqKiDGofA==
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr781886ljp.199.1631208193395;
        Thu, 09 Sep 2021 10:23:13 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id z7sm266591ljh.59.2021.09.09.10.23.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 10:23:12 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id g14so4152444ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 10:23:12 -0700 (PDT)
X-Received: by 2002:a2e:a363:: with SMTP id i3mr806608ljn.56.1631208192152;
 Thu, 09 Sep 2021 10:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-17-agruenba@redhat.com>
 <YTnwZU8Q0eqBccmM@infradead.org>
In-Reply-To: <YTnwZU8Q0eqBccmM@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 10:22:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgF7TPaumMU6HjBjawjFWjvEg=116=gtnzsxAcfdP4wAw@mail.gmail.com>
Message-ID: <CAHk-=wgF7TPaumMU6HjBjawjFWjvEg=116=gtnzsxAcfdP4wAw@mail.gmail.com>
Subject: Re: [PATCH v7 16/19] iomap: Add done_before argument to iomap_dio_rw
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 4:31 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> What about just passing done_before as an argument to
> iomap_dio_complete? gfs2 would have to switch to __iomap_dio_rw +
> iomap_dio_complete instead of iomap_dio_rw for that, and it obviously
> won't work for async completions, but you force sync in this case
> anyway, right?

I think you misunderstand.

Or maybe I do.

It very much doesn't force sync in this case. It did the *first* part
of it synchronously, but then it wants to continue with that async
part for the rest, and very much do that async completion.

And that's why it wants to add that "I already did X much of the
work", exactly so that the async completion can report the full end
result.

But maybe now it's me who is misunderstanding.

          Linus

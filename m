Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790D43571D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhDGQJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbhDGQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:08:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C0AC0613DD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:07:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 12so29243191lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+GZihE1qWi22Nq3Hnh+PiXEp0mKLQ2A+oFFp9yIals=;
        b=J99hjckmBosLPM9Ed+eK2wWObnFsiBDrZ0ii/IRGS7ALFw6ItbZ+BG7zbtuYs/4LnK
         wNs84LO7gQTNKl4wDVOdHkZp+yR4/UEsTJpB38wAD4VDL1fltxcsnkSToDxC23/kkkMO
         cxUD93e3l2f0ypdrY08/2frZV3aQ/27xDphVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+GZihE1qWi22Nq3Hnh+PiXEp0mKLQ2A+oFFp9yIals=;
        b=b3jh47LKqtucbYscKo2lxtg8Qzz9UYDAuGiQ9a0TyjNCQ6TaEWenWOvRQePLWiUEmb
         zSPo154wy8uYLOOKm56QnMfy6ZWn6GM7Wd4+2IqJwJ7bFcJVk1GEzQTTYh0NG75HYamj
         SO9lGNNY28BautdI/8TepfkWEjQVwJMhEJiQ0HMINXEqnXProv9WjMEQOikjzUYflMYy
         E03fYugiwe58lEiQSY0eIpYT4D0fONCgihMf+IFMOEWwGsoS5gkStHyCzFs31ROOYRiF
         jgF3yuYL98FZfzVc74rCVJSFx068MXGVLTNurh65mnibm9EAbzNQlxpXlFtK5FeJ89tP
         zEyQ==
X-Gm-Message-State: AOAM530JKYdorzK4EGB1I2XiZ2sVaOy9OE0szACQ2R+Rk8AlVQI0H3PE
        MECTsSc7m+wLneMqADK9g9bYoWgYhaksxKu+
X-Google-Smtp-Source: ABdhPJwytc66IVPqDAqGDY2+awXZqrjdqOgLjVPZdlQBkkEaikpSCLVjkZpsRgI4eBdDDg8CAJ5CFQ==
X-Received: by 2002:a05:6512:207:: with SMTP id a7mr2916038lfo.393.1617811655005;
        Wed, 07 Apr 2021 09:07:35 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 7sm2601262lfq.170.2021.04.07.09.07.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 09:07:34 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id f16so21377192ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:07:34 -0700 (PDT)
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr2540948ljj.465.1617811653798;
 Wed, 07 Apr 2021 09:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210401181741.168763-1-surenb@google.com> <CAHk-=wg8MDMLi8x+u-dee-ai0KiAavm6+JceV00gRXQRFG=Cgw@mail.gmail.com>
 <c7d580fe-e467-4f08-a11d-6b8ceaf41e8f@suse.cz>
In-Reply-To: <c7d580fe-e467-4f08-a11d-6b8ceaf41e8f@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Apr 2021 09:07:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQCrpxGL4o5piCSqJF0jahUUYW=9R=oGATiiPnkaGY0g@mail.gmail.com>
Message-ID: <CAHk-=wiQCrpxGL4o5piCSqJF0jahUUYW=9R=oGATiiPnkaGY0g@mail.gmail.com>
Subject: Re: [PATCH 0/5] 4.14 backports of fixes for "CoW after fork() issue"
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, Shaohua Li <shli@fb.com>,
        Nadav Amit <namit@vmware.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 6:22 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> 1) Ignore the issue (outside of Android at least). The security model of zygote
> is unusual. Where else a parent of fork() doesn't trust the child, which is the
> same binary?

Agreed. I think this is basically an android-only issue (with
_possibly_ some impact on crazy "pin-and-fork" loads), and doesn't
necessarily merit a backport at all.

If Android people insist on using very old kernels, knowing that they
do things that are questionable with those old kernels, at some point
it's just _their_ problem.

                 Linus

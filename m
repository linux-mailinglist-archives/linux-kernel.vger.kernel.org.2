Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43A73A344E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFJTxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:53:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:51:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k40so5036844lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7gUGOzETMzYFAG4seIz29zubSDkdiXjPsIc9hK01xE=;
        b=aBsNBHP0NpRBvB46PeLY9+arShvd1498r3GSD0O2n4SRYflDcL42dQNQtcGknUePat
         3nywBCNe6xd+GcU1Vx9TJ6128jk5YFNdIWWwxAVHawjXXU8e4kV4pi9X+M42A+gU72FM
         jdWC7EmtUd4URMrXwAJ1eo4czRMFqiB5EI9nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7gUGOzETMzYFAG4seIz29zubSDkdiXjPsIc9hK01xE=;
        b=Rb0xMa7FnNGN2NaV9PUn7fw2HB2kTKxAjhEe9uHBnHRQVPZmksOz6Uyzxb+5aI0EOe
         oA3JCP/sWurVGwH6qdPDch1Pc2+EcCmaQd3wiCqBL2D3CBTgkFUw+i2tqheop4AYAI6R
         PSzZpavyKpjVDEShs9xx/aLbAA4p6xTsq3NC7KbE9Lbe+05OHwmIUDvgBjwrR8jqVzLz
         tldxT1w5Dz75ZwbAqXXs7C0UnNdNSk+Z/dSNmPYcS/wPGE6XbhVevntaSQV7TZsdDGk/
         PuLbTo0FwodjqU2hupme+b5y4bOFhDmPTmAkJElyGfPsM3fiERGT5SfXf5jyYr8I1no1
         WuGA==
X-Gm-Message-State: AOAM530XOTJq8XsTd7qlGUNeugZ3JpGFEOCZ0GSUwuPE6YG4VRBps8lp
        iaLvcZ/v+MkuOm1mxRAW9wmxDXTfpsf1zRN9pSE=
X-Google-Smtp-Source: ABdhPJwsGOPMMxnBS6aZQoAKrykh7QPlf753rY0fXWyNH2mW+7dYF1G7jT8dsB+A97gEc6Rv3qnjvg==
X-Received: by 2002:a05:6512:6cc:: with SMTP id u12mr299464lff.32.1623354667259;
        Thu, 10 Jun 2021 12:51:07 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y8sm383945lfj.192.2021.06.10.12.51.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 12:51:06 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id f30so5064497lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:51:04 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr266721lfa.421.1623354664442;
 Thu, 10 Jun 2021 12:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
 <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com>
 <87h7i694ij.fsf_-_@disp2133> <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
 <198e912402486f66214146d4eabad8cb3f010a8e.camel@trillion01.com>
 <87eeda7nqe.fsf@disp2133> <b8434a8987672ab16f9fb755c1fc4d51e0f4004a.camel@trillion01.com>
 <87pmwt6biw.fsf@disp2133> <87czst5yxh.fsf_-_@disp2133> <CAHk-=wiax83WoS0p5nWvPhU_O+hcjXwv6q3DXV8Ejb62BfynhQ@mail.gmail.com>
 <87y2bh4jg5.fsf@disp2133>
In-Reply-To: <87y2bh4jg5.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jun 2021 12:50:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPiEaXjUp6PTcLZFjT8RrYX+ExtD-RY3NjFWDN7mKLbw@mail.gmail.com>
Message-ID: <CAHk-=wjPiEaXjUp6PTcLZFjT8RrYX+ExtD-RY3NjFWDN7mKLbw@mail.gmail.com>
Subject: Re: [CFT}[PATCH] coredump: Limit what can interrupt coredumps
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Olivier Langlois <olivier@trillion01.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov>" <asml.silence@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:18 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> I just didn't want those two lines hiding any other issues we might
> have in the coredumps.
>
> That is probably better development thinking than minimal fix thinking.

Well, I think we should first do the minimal targeted fix (the part in
fs/coredump.c).

Then we should look at whether we could do cleanups as a result of that fix.

And I suspect the cleanups might bigger than the two-liner removal.
The whole SIGNAL_GROUP_COREDUMP flag was introduced for this issue,

See commit 403bad72b67d ("coredump: only SIGKILL should interrupt the
coredumping task") which introduced this all.

Now, we have since grown other users of SIGNAL_GROUP_COREDUMP - OOM
hanmdling and the clear_child_tid thing in mm_release(). So maybe we
should keep SIGNAL_GROUP_COREDUMP around.

So maybe only those two lines end up being the ones to remove, but I'd
really like to think of it as a separate thing from the fix itself.

                Linus

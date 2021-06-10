Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4BA3A355F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFJVGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFJVGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:06:20 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFFFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 14:04:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id n17so6808405ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvL3lGwbeiN7MBxmsi5XUSzTl5bywBkq1SiXoFH9p/Y=;
        b=h5msG03u/H4hnhe+y6dZRvJGZM7Z1bjF9rSXqXZFXISpshwR35XOKKkNfFcU03dOQZ
         UOuf4TEMF1JPT/M4VVo37xPOjNyCt/8oZXgGCHZDs4SCE2xITO/oY8+2Ss+oKPbfETpd
         Q1u/byu5sVQ5jFQU3+ukI40pjUCqgaobqASIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvL3lGwbeiN7MBxmsi5XUSzTl5bywBkq1SiXoFH9p/Y=;
        b=tkGZhqfBmZnUoKiH3e/6guWtqF1eUp0MyjZrLZCZlgtiLd63KNYGrRowrRak3QHM5V
         BMzVPZUaG95tbvfz3He8dAtuTH+mrXfm/e8hS0fwdfrv7KkGlZUo7kK9nZ61FQvj1IB7
         91sILCS3SocsnLNkQ7mpmXPheLVSd+wh4ScwfkY12csrfkZjIEuanenxwIGHHtafHtZS
         4XNIfP+yuLci9nv7HG6oJuPcS5YnxZacfoQx4LOarO/odMfWlvKWLzICN2JqgrCERQs5
         cQdrEg48Ox/s6Bu+wf5JU3MhOxCI1BD5+1+XUvsLrYpL2Xt2Ob5WQCEXkRfWjCcHqDcB
         +F5Q==
X-Gm-Message-State: AOAM533Z0AFi1pqSTKs6rouOiJ8Qz+u9M9pj1ziIHafgF9cl9VWmN5OL
        T9LDXuM4izlmDv4aZAWCP/HeSQOtq+tK7+vhQg8=
X-Google-Smtp-Source: ABdhPJxWzd1corZuC3G018lswKcq/qTWZ8pLEwQgOYy1Ui4ibo90b//IKbebbWNmW7TUwfaVc5fF8w==
X-Received: by 2002:a2e:9a96:: with SMTP id p22mr363606lji.389.1623359061430;
        Thu, 10 Jun 2021 14:04:21 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id f19sm466553ljn.88.2021.06.10.14.04.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 14:04:20 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id i10so5333737lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 14:04:20 -0700 (PDT)
X-Received: by 2002:a05:6512:3d13:: with SMTP id d19mr433821lfv.41.1623359060330;
 Thu, 10 Jun 2021 14:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
 <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com>
 <87h7i694ij.fsf_-_@disp2133> <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
 <198e912402486f66214146d4eabad8cb3f010a8e.camel@trillion01.com>
 <87eeda7nqe.fsf@disp2133> <b8434a8987672ab16f9fb755c1fc4d51e0f4004a.camel@trillion01.com>
 <87pmwt6biw.fsf@disp2133> <87czst5yxh.fsf_-_@disp2133> <CAHk-=wiax83WoS0p5nWvPhU_O+hcjXwv6q3DXV8Ejb62BfynhQ@mail.gmail.com>
 <87y2bh4jg5.fsf@disp2133> <CAHk-=wjPiEaXjUp6PTcLZFjT8RrYX+ExtD-RY3NjFWDN7mKLbw@mail.gmail.com>
 <87sg1p4h0g.fsf_-_@disp2133>
In-Reply-To: <87sg1p4h0g.fsf_-_@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jun 2021 14:04:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5_=m4DyZ=8==bfL2UCnWU=UDjQu-XCq_b92oDJh1i-Q@mail.gmail.com>
Message-ID: <CAHk-=wj5_=m4DyZ=8==bfL2UCnWU=UDjQu-XCq_b92oDJh1i-Q@mail.gmail.com>
Subject: Re: [PATCH] coredump: Limit what can interrupt coredumps
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

On Thu, Jun 10, 2021 at 1:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Make the coredump code more robust by explicitly testing for all of
> the wakeup conditions the coredump code supports.  This prevents
> new wakeup conditions from breaking the coredump code, as well
> as fixing the current issue.

Thanks, applied.

And lots of thanks to Olivier who kept debugging the odd coredump
behavior he saw.

            Linus

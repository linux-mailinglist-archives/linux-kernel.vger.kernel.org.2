Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440FE349C65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 23:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhCYWi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 18:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhCYWh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:37:59 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AC7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 15:37:59 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z25so5209039lja.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 15:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5e4oQJs7D+v1Fp3qOgnpvnuKs8stkr9RsHaAFeuS1Fc=;
        b=ZFU9nYcCw1i1YZLwUD9j6hzdpJn7J4V1dZU6rfkkC0CTqlwogXdIkiC/7xKG04aIBY
         PA92xy40DUv5AHeYhyJTT93+bTuuKfpRfF5xBzIpvKm63s6OjulKUT/Cp/9KZOQC72Hw
         QdfoxCxgbz5pWPRCuETEw+RkR53XEtwLJFTq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5e4oQJs7D+v1Fp3qOgnpvnuKs8stkr9RsHaAFeuS1Fc=;
        b=O1vszWHFgb+AcRh6gf6tJpFct6DWURZnO8NgnxdpQsYPWf+EdmxFzA9YKh4R/6fup2
         0BOgx09vgeUKqkbrU4Azl2vj+quSUXjQQl/p6iD59ifGj1+Q/xRCSQziWncUGteBpIbW
         efExMs8mTll52PDuLGRVBs9kuQrz5qAZbpVWH637PCo36pefwv/G6he23mxAvdTQV7U7
         svEdR/ZLzhQsbQV6yeFg/FO+yRHJh4aJ/rmZcW71krVvDNDCDvB89JDkqs4QGYUJKsbH
         AQMbi9Ss6lzZJoQX9Zc26Z956z3hG+1B7DYY/MFtjEVAiFq5SOwehiKFaTQNSxi2SE95
         efCQ==
X-Gm-Message-State: AOAM530Sj1v6CezTcAP7Q5GGY88fstR9rv7+mNZQ0+U4iChdLJ3oAD2C
        DKdZLWoSwZhK8XzAxaCc1pmnsVtTVl0wig==
X-Google-Smtp-Source: ABdhPJwVmiIO0JolhcTVflOQUEmvhEb46FwsFQtab6eEp90p3XwQIet0dEf8UlZ7C7cUDEBGid0QeQ==
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr7126679ljn.30.1616711877684;
        Thu, 25 Mar 2021 15:37:57 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id z28sm955379ljn.117.2021.03.25.15.37.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 15:37:56 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id g8so4820723lfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 15:37:56 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba9:: with SMTP id g41mr5979179lfv.421.1616711875760;
 Thu, 25 Mar 2021 15:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210325164343.807498-1-axboe@kernel.dk> <m1ft0j3u5k.fsf@fess.ebiederm.org>
 <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
 <CAHk-=wg1XpX=iAv=1HCUReMbEgeN5UogZ4_tbi+ehaHZG6d==g@mail.gmail.com>
 <CAHk-=wgUcVeaKhtBgJO3TfE69miJq-krtL8r_Wf_=LBTJw6WSg@mail.gmail.com>
 <ad21da2b-01ea-e77c-70b2-0401059e322b@kernel.dk> <f9bc0bac-2ad9-827e-7360-099e1e310df5@kernel.dk>
In-Reply-To: <f9bc0bac-2ad9-827e-7360-099e1e310df5@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Mar 2021 15:37:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmHRvoYdsA2ZL4aEOYvNx-5c7typsUbFcqq+GmOMcoDQ@mail.gmail.com>
Message-ID: <CAHk-=wgmHRvoYdsA2ZL4aEOYvNx-5c7typsUbFcqq+GmOMcoDQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 2:44 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> In the spirit of "let's just try it", I ran with the below patch. With
> that, I can gdb attach just fine to a test case that creates an io_uring
> and a regular thread with pthread_create(). The regular thread uses
> the ring, so you end up with two iou-mgr threads. Attach:
>
> [root@archlinux ~]# gdb -p 360
> [snip gdb noise]
> Attaching to process 360
> [New LWP 361]
> [New LWP 362]
> [New LWP 363]
[..]

Looks fairly sane to me.

I think this ends up being the right approach - just the final part
(famous last words) of "io_uring threads act like normal threads".

Doing it for VM and FS got rid of all the special cases there, and now
doing it for signal handling gets rid of all these ptrace etc issues.

And the fact that a noticeable part of the patch was removing the
PF_IO_WORKER tests again looks like a very good sign to me.

In fact, I think you could now remove all the freezer hacks too -
because get_signal() will now do the proper try_to_freeze(), so all
those freezer things are stale as well.

Yeah, it's still going to be different in that there's no real user
space return, and so it will never look _entirely_ like a normal
thread, but on the whole I really like how this does seem to get rid
of another batch of special cases.

               Linus

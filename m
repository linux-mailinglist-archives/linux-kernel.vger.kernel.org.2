Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C709F349AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhCYUNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 16:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhCYUNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:13:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C78C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 13:13:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a198so4353223lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSCZD0WysGru/kVbyNvevo1VRTVBoKkOp1lzPAHeWdQ=;
        b=GemDuBlk7PzUL2Fb3Mi1u+hLLL1HEDKYeh2Hbjs1BW61m4FQbvXD22/IGQ38dao6HV
         y9nQhMQjlF47CrpXbP9GKzIRwhDsvNCl/DEmzolXE3cUG1JXPp/jR8UzT/LgJ0KaFCpR
         rf/4UWJ4RL0zAyhp4Qc+xCgBMm7YF057ScHws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSCZD0WysGru/kVbyNvevo1VRTVBoKkOp1lzPAHeWdQ=;
        b=kiZ53RSOIptx/WQRX68jyhlqBQDAvdAKZJ1810cVzgA8xYV+pig9rhPYv1tKloP46u
         aR3CKRoeQ2h76YSQCDlYe5Fx5qe1CocbQGT3oBz1S8Zo+Dq7gzJtM0CLeorC5NsVlTA7
         l/7zNnVZKjGbpUNUxK2LXjjkf0XvXmItXWhzCyXQLj3zP7NtloWeBj2OXBAPcuFbwcl6
         9vBE/yd2hWBRD8rGJnTnXiO1jp3fsjC3ox1XabgFfwwd72E6jY8GFUjA8TOB4CuHFo21
         pagkc9SyQD5+7/16JgVpKnCBx4BfvED3Y+Ue7kaI9AIRW3lBjS04swZz0aNBknQDQuKm
         GIXg==
X-Gm-Message-State: AOAM532os74pjSE24oFZTPLh8tekb6qLQNoaVTe+Id8QsHRbCD16g8vu
        +a4AsXxr0TatOBLYP6SonjITTpvkCsef8Q==
X-Google-Smtp-Source: ABdhPJwnyPYyMnI8Nu0RN6ZoGsSRdT8J+u60oGOEpeRTkzv0aVvv7UpxdoVU7ncNFl48/HUztWSctw==
X-Received: by 2002:a05:6512:3327:: with SMTP id l7mr6081061lfe.639.1616703179434;
        Thu, 25 Mar 2021 13:12:59 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id p5sm883663ljj.26.2021.03.25.13.12.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 13:12:58 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id a1so4795936ljp.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 13:12:58 -0700 (PDT)
X-Received: by 2002:a2e:864d:: with SMTP id i13mr6644465ljj.48.1616703178433;
 Thu, 25 Mar 2021 13:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210325164343.807498-1-axboe@kernel.dk> <m1ft0j3u5k.fsf@fess.ebiederm.org>
 <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com> <CAHk-=wg1XpX=iAv=1HCUReMbEgeN5UogZ4_tbi+ehaHZG6d==g@mail.gmail.com>
In-Reply-To: <CAHk-=wg1XpX=iAv=1HCUReMbEgeN5UogZ4_tbi+ehaHZG6d==g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Mar 2021 13:12:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUcVeaKhtBgJO3TfE69miJq-krtL8r_Wf_=LBTJw6WSg@mail.gmail.com>
Message-ID: <CAHk-=wgUcVeaKhtBgJO3TfE69miJq-krtL8r_Wf_=LBTJw6WSg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 12:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Mar 25, 2021 at 12:38 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I don't know what the gdb logic is, but maybe there's some other
> > option that makes gdb not react to them?
>
> .. maybe we could have a different name for them under the task/
> subdirectory, for example (not  just the pid)? Although that probably
> messes up 'ps' too..

Actually, maybe the right model is to simply make all the io threads
take signals, and get rid of all the special cases.

Sure, the signals will never be delivered to user space, but if we

 - just made the thread loop do "get_signal()" when there are pending signals

 - allowed ptrace_attach on them

they'd look pretty much like regular threads that just never do the
user-space part of signal handling.

The whole "signals are very special for IO threads" thing has caused
so many problems, that maybe the solution is simply to _not_ make them
special?

           Linus

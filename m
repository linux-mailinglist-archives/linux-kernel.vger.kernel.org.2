Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77FD442277
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhKAVTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKAVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:19:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223F0C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 14:16:43 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c28so38739993lfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8vfSiLQfcV8LSE/0VZN9nVymiWfQcf3HwDo3/s+A28=;
        b=Nq1P/t/kTMIhHA/oVJQEreCbMYA1lLPseP1YwRnBgkI+rwLrkUnvCwRE5vK8d+UrWb
         MYWBvzpASJ6sYAnkGmmhJG91PeyumZXs75AUf9oA3+gvZyaIwKzA9V7La+eusnHHoKYm
         ymfuDesBPwWtB570ovAO0NARSsUWyH+QCYLtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8vfSiLQfcV8LSE/0VZN9nVymiWfQcf3HwDo3/s+A28=;
        b=S20wzXaDTM4jXqDqpFuKAfyvaFcix/qsxcMkYjV8d9OOy2bX9SZotPFxHJTM9MXuPC
         4F7Cm864L0A6dh2fuhO39ipO0oKA/QrqCzO5RCrUDpuASZDolbpiFkPqPylckiHaOWwh
         GTo7o8dEpmXVdJIk52cpy2DheH6DLL4SsGKkTt2GO4qGdgnNd/HWvlX8KR/Yx1TIQj5+
         kmSVa/9ItiakfQR0WPyaDHi0eVa1DFg0FeE9kEUjvliP5RPt6cbzIrXG1biROuZ194Oo
         JdGit4H5AuVFQDl1tj0uKnlJF3h2LicmssqVdT7CBtRq+om2pH87PbOR8zovC9DSS2fV
         CHEg==
X-Gm-Message-State: AOAM532C33eampPTnOwiIZ8xLVkjyerndMvNCJW6NDymn1nfKJ9EjmOx
        HmTkfkG4ZEYDO4PfLE9+KBwhjO0/nYYOgKiw
X-Google-Smtp-Source: ABdhPJzQFfl8ZXrMmLKsBoe0FWt2edwYdkE0Q+9WHPpvtiFejunzQPahTD5mUsmhv79eSJew3qyOKQ==
X-Received: by 2002:a05:6512:230b:: with SMTP id o11mr32595092lfu.490.1635801401230;
        Mon, 01 Nov 2021 14:16:41 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id f4sm1508525lfr.43.2021.11.01.14.16.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 14:16:40 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id f3so30648871lfu.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:16:40 -0700 (PDT)
X-Received: by 2002:a19:ad0c:: with SMTP id t12mr29903941lfc.173.1635801399851;
 Mon, 01 Nov 2021 14:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <YX/AmFgkQ0AEqDaG@zn.tnic>
In-Reply-To: <YX/AmFgkQ0AEqDaG@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 14:16:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNyR-cAxicOD6nkRQNw-q+uzFvB3hpA-s=7asEKom=og@mail.gmail.com>
Message-ID: <CAHk-=wiNyR-cAxicOD6nkRQNw-q+uzFvB3hpA-s=7asEKom=og@mail.gmail.com>
Subject: Re: [GIT PULL (not really)] x86/core for v5.16
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 3:25 AM Borislav Petkov <bp@suse.de> wrote:
>
> so this is not really a pull request but more of a question on the
> process. I have merged the x86/cc branch into this branch I'm sending to
> you - x86/core - and when I generate the diffstat with git request-pull,
> it adds the changes of the merged branch x86/cc too, of course.
>
> I can doctor the diffstat and the merge message by doing
>
>  git diff --stat ^x86/cc x86_core_for_v5.16_rc1
>
> see below, so that the merged branch's changes are not there.
>
> But I'm not sure if this is the right thing to do. Especially if you do
> not merge x86/cc first - then the below diffstat becomes wrong.

So other developers do this kind of thing fairly regularly, because
they have some "core branch" that does the basic core development
(say, a driver subsystem), and then they have other branches (eg the
lowlevel drivers themselves etc) that depended on the core work but
are sent as individual pull requests to keep the conceptual separation
alive, and make it easier to review.

The way to do it tends to be:

 (a) make it clear that some pull request depends on a previous one,
so that I'm aware of it, and don't do them out of order and get
confused

 (b) when you have a series of pull requests that aren't independent,
create the series of pulls yourself in a temporary tree, and generate
the pull request from that series, with the previous merge always as
the "base".

The reason for (a) is obvious, and the reason for (b) is that then
each pull request automatically gets the right shortlog and diffstat.

Of course, if this is the only time you expect to haev this kind of
dependency, you don't need to have much of a process in place, and a
hacky manual one-time thing like the above works fine too.

And in general, the more independent the pull request can be, the
better. But having two or more branches that have some serial
dependency certainly isn't unheard of or wrong either.  It happens.

             Linus

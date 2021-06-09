Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1A03A1E59
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 22:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFIUyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 16:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFIUyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:54:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B11C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 13:52:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j2so12562767lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 13:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XArs7dfKd1jb8KVECknZ5tHK7pCuauc7kNtOU0BuGyQ=;
        b=d2c1kWEJ0AgEydECoXutpmofFDQXFyVtEZ9eA5D5JURcxb31tlEXBtljToI9e7Yp4S
         nnIcfeTgiuCVJKge24fWKsfVzi+rcZe0APlOb5EAnE+y2tUwASVAyuMnEM1BsjngaF8O
         6ZbYHAR2LSXCzqR6zx26XbzDZ2HReHBMouhrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XArs7dfKd1jb8KVECknZ5tHK7pCuauc7kNtOU0BuGyQ=;
        b=qmKbGEldLgle+uViy1PDPX8pRHOmrc8hiUEluqxI+4QMs0KzOurVBWMPTdoovZ+r8T
         SZvXZY9CVon8JaN9R0vFYwPZTbhQBTBJTDV/H4BRNxhIEvLYm4+YiFWRRugfMrbcGq9c
         /TVNJdmsR9i80Q2ZQEnDRNDe6dRk8Q91zEuAVHpQ+5Xamic6qIljYYsmdY1RDi4rb+cl
         lUsntle3zKywb2W1Uhlz5b2jNPLWIffh5F1fX6w/rJhg1hFGO5hmI0zp83ruHKY7FWma
         buESUmS5qbawbA7tMuJMlXKwp/7D2RD/450N897Gyrh8vDTGyXLDPyWYVzIiMVpLJOpH
         j/yw==
X-Gm-Message-State: AOAM533BvZwJwAlYgedu/LuMDhUIgWyvsJybqzK3fO6cZvWDgNtvtASm
        ugHTzs6oezhkTbi8ILwnSTpfY0Xy5R+mNMij2WM=
X-Google-Smtp-Source: ABdhPJwkuhEefK+X2bKKyCcGkJyn6WbSMIqHwWaSvp2Irx5a/2mJ+tUnERAXw9JLCxDdQQBKUXrhlg==
X-Received: by 2002:a19:4f1a:: with SMTP id d26mr820535lfb.265.1623271945153;
        Wed, 09 Jun 2021 13:52:25 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id t3sm90744lfl.78.2021.06.09.13.52.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 13:52:24 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id f30so40202597lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 13:52:24 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr826068lfl.253.1623271944108;
 Wed, 09 Jun 2021 13:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
 <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com>
 <87h7i694ij.fsf_-_@disp2133> <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
 <8735tq9332.fsf@disp2133>
In-Reply-To: <8735tq9332.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jun 2021 13:52:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXROFSDa6gHei4fNmdU=VppqnBThdCraNpuirriSyKQA@mail.gmail.com>
Message-ID: <CAHk-=wgXROFSDa6gHei4fNmdU=VppqnBThdCraNpuirriSyKQA@mail.gmail.com>
Subject: Re: [RFC] coredump: Do not interrupt dump for TIF_NOTIFY_SIGNAL
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Olivier Langlois <olivier@trillion01.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov>" <asml.silence@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 1:48 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> It looks like it would need to be:
>
> static bool dump_interrupted(void)
> {
>         return fatal_signal_pending() || freezing();
> }
>
> As the original implementation of dump_interrupted 528f827ee0bb
> ("coredump: introduce dump_interrupted()") is deliberately allowing the
> freezer to terminate the core dumps to allow for reliable system
> suspend.

Ack. That would seem to be the right conversion to do.

Now, I'm not sure if system suspend really should abort a core dump,
but it's clearly what we have done in the past.

Maybe we'd like to remove that "|| freezing()" at some point, but
that's a separate discussion, I think. At least having it in that form
makes it all very explicit, instead of the current very subtle exact
interaction with the TIF_NOTIFY_SIGNAL bit (that has other meanings).

Hmm?

             Linus

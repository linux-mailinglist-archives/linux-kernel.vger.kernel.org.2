Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B683A16E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbhFIOTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:19:15 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:44895 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbhFIOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:19:14 -0400
Received: by mail-il1-f173.google.com with SMTP id i17so26281016ilj.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eN8+eR8AJAlCzAe6aRKwBFZ94zTbqJRc3z44p4oPAck=;
        b=nKL1lZcdAIrnIUr94pyY8xPmYLDscVVSqjC8tPRaNT/Jdo0cIsYXYxdqeAm73Um5z+
         t1ksbwzZSDhNpd6vcguU9iWR6GAiRnzG/Df/hUwX1tWDG9n11vCbCLcvL4sSWqXl6yhc
         rbrY5TSxSTR7564S3VpN9AYicF17NrPXBkv20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eN8+eR8AJAlCzAe6aRKwBFZ94zTbqJRc3z44p4oPAck=;
        b=C4orpUZTVvbsntC0qoSOgzb46AYq5r8DOy6CIynM2ZTKI0ZWNqORFbKcRJtsXKrmrk
         o+nVFFp4YEBQeXCXcj6O+sZUIZiK38TfJa6hug20kOlI42ecLcGSDy8/SqYkh7V2jpjs
         q3MVXTT1K4Rpr2JZ4NOsiXgBzgLCJTuR4OwkG/eKAhXSELFX3aL+CKT6tHDifCt2bIhv
         OkbyC9+GN+5joXV8kGRtmzL+190rGnBpQGkPXgxDPwTUljBLbKXIfh8JR0SjyDDuqlY+
         yPl7ONI1+w7kNkHht30MkJyXgY9fiy7gazc1DHeaOAInWrXZ+2CMOMhQ83XNgvHnJNFm
         RGJA==
X-Gm-Message-State: AOAM532JpHvjoMQQrkzZ4mowOPC4OixvL10+4SZ/wpqansAtftAidiZs
        5Enxzp2OXafzEdVAgmS1xcteogHtaE8IlQ==
X-Google-Smtp-Source: ABdhPJyDr39epCmafstZlND6tTJVUEzJ3UMLpGhCLyvo0oi+X/JREzoFM/CLxFU0Ub69kHX6ERACoA==
X-Received: by 2002:a02:9109:: with SMTP id a9mr188745jag.93.1623248167951;
        Wed, 09 Jun 2021 07:16:07 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id u18sm97637ilb.51.2021.06.09.07.16.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:16:07 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id x18so26300765ila.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:16:07 -0700 (PDT)
X-Received: by 2002:a05:6638:27a:: with SMTP id x26mr204405jaq.144.1623248166593;
 Wed, 09 Jun 2021 07:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210604092638.985694-1-ribalda@chromium.org> <YLn0D+1R2QHZYRVV@hirez.programming.kicks-ass.net>
 <CANiDSCu4Brz7FZX5oa57kNLG9h_1EASX=bdQij4+apg0ZwW8QA@mail.gmail.com> <YL9UZzjqz8gHLbfo@hirez.programming.kicks-ass.net>
In-Reply-To: <YL9UZzjqz8gHLbfo@hirez.programming.kicks-ass.net>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 9 Jun 2021 16:15:55 +0200
X-Gmail-Original-Message-ID: <CANiDSCtYr3R79XPnFvMfLZYj=sTWGq+neHqrdNwXDN6JB25aMA@mail.gmail.com>
Message-ID: <CANiDSCtYr3R79XPnFvMfLZYj=sTWGq+neHqrdNwXDN6JB25aMA@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Do not set a variable unless it will be used
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

On Tue, 8 Jun 2021 at 13:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 04, 2021 at 09:24:23PM +0200, Ricardo Ribalda wrote:
> > Hi Peter
> >
> > On Fri, 4 Jun 2021 at 11:36, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Jun 04, 2021 at 11:26:38AM +0200, Ricardo Ribalda wrote:
> > > > clang-13 triggers the following warning:
> > > >
> > > > bench/inject-buildid.c:351:6: error: variable 'len' set but not used [-Werror,-Wunused-but-set-variable]
>                                                                          clue here: ^^^^^^^^^^^^^
>
> > > >         u64 len = 0;
> > > >
> > > > This patch sets the value to len only if it will be used afterwards.
> > >
> > > My vote would be to kill that warning, what absolute shite.
> >
> > My knowledge of llvm codebase is close to NULL, so it is much easier
> > for me to "fix" the code.
>
> That's what -Wno-unused-but-set-variable is for, which is trivial to add
> to the Makefile.

Yes, that is quite easy to add, the problem is that we might hide real
bugs.  I completely agree that this one is borderline :)



-- 
Ricardo Ribalda

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6100A3141D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhBHVc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:32:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39050 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhBHUmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:42:24 -0500
Date:   Mon, 8 Feb 2021 21:41:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612816897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OmWz7jyyHWml4Y3HXei+RUiHBzoBJ5krv5L/FhG9ZyQ=;
        b=H5sixMXVfeD7mibLRrgDnY0ul2glG+uZoi9QG3xKocYT0tEXursSFaLHJyVAgE57DGpjpB
        fvAPwA8v4nRtIgi4aQU3Jo+67phXV7tJf5lzzzsgMt8CCIoZVhJ8FbaM0zr0vGNymeV/0P
        FM0DKXdQH1+L/3OSF8OIMreC1I4gAWmLnySIEzyny2+rSFtlF5kl/Vf8H/UcT8fG8SeoCO
        QwzagsHKxOHbEE3WQq3zSJotwFvYdsTWJFMbAMiz6IGiwrcGcXNuGzH0NsTPtf4RtSEAwo
        Lz5kOUWHqt6UEvuDTK8DWlDCAFTqSmc0i6s00J8OeLj+IviX4jCFa2aP986arg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612816897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OmWz7jyyHWml4Y3HXei+RUiHBzoBJ5krv5L/FhG9ZyQ=;
        b=WBw4eo2Lk7mPpPgddvTeBPmcjB96L5QC3YuZHQpaeAKyLBMbrKJLd7adpjF0ZNNtRp+8zn
        Pc/6RRhHoDEmxKCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] auxdisplay: Remove in_interrupt() usage.
Message-ID: <20210208204136.sv4omzms3nadse6e@linutronix.de>
References: <20210208175824.381484-1-bigeasy@linutronix.de>
 <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
 <20210208190735.ibq44r5pc4cwzt7j@linutronix.de>
 <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-08 21:14:54 [+0100], Miguel Ojeda wrote:
> On Mon, Feb 8, 2021 at 8:07 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > Yes.
> 
> In what way?

It hurts to keep in_interrupt() because it is desired to have it removed
from drivers. The problem is that pattern is often copied and people
sometimes get it wrong. For instance, the code here invoked schedule()
based on in_interrupt(). It did not check whether or not the interrupts
are disabled which is also important. It may work now, it can break in
future if an unrelated change is made. An example is commit
   c2d0f1a65ab9f ("scsi: libsas: Introduce a _gfp() variant of event notifiers")
   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git/commit/?id=c2d0f1a65ab9f

in_interrupt() is often used in old code that was written before
might_sleep() and lockdep was introduced.

> > No. If you know the context, pass it along like this is done for
> > kmalloc() for instance.
> 
> What do you mean?

What I meant was GFP_KERNEL for context which can sleep vs GFP_ATOMIC for
context which must not sleep. The commit above also eliminates the
in_interrupt() usage within the driver (in multiple steps).

> Cheers,
> Miguel

Sebastian

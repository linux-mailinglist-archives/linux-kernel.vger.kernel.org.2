Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB041FE81
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 00:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhJBWlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 18:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhJBWlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 18:41:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56585C061714
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 15:40:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i4so54506281lfv.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 15:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3o+HPeR9EbtnHX+94EjHfOu3iAnHimt25CzZpAQ8GlI=;
        b=RWopi1jMhILOrbSqr6Msa20jU1DWxrGZDgqc4NOxHUPWffQ37cz0/w2irICGXyMEQm
         QdpwobZwbOTfjpxdvm0n3An3AXr156XOHOAaHpQQSj3F/IwsaSOBFBrVKBcAfsBoLYFr
         WVeUgklWzIzMy34MWSNcJJmfgreYiXHvQ8SpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3o+HPeR9EbtnHX+94EjHfOu3iAnHimt25CzZpAQ8GlI=;
        b=TIXstwTS3PP6yYfLczZES7Hv7uu05aJGNTXhCwuAz5shxCiiNl/IwAJA/6+e4m28R3
         5kDoSU+wFizqfUL+RtLTVj8QF1dXWJYQezuJUzivBHmg+T9duocvuGBOjUQTuUhVTlG4
         MML5OFo01GOsGI+EnmKzMgCFtsFe81lRZ/djnyGsz3fN+HIpxSB4pQgEg8SAcsJ9C0g8
         onU3i5tt8JVR58CvPp9h3jz4LfP4SUcGLpxATgdZJtbhMZxqXY71v1Wr9kq6eJlLFRqJ
         yZ+4BAUnf0jNNXezJtt+uqy/7GZz1ou6U5KUsyJFO3YD8Y8f3OnezNnqD+GB8iQXF5Gf
         jtRQ==
X-Gm-Message-State: AOAM531C9jAFJEbt4PkAUS9oE+RtTwW+oBUSJEwPDVszKShelLs7DbiO
        Lj2r3kQLymMB/BeQy3tdVuvubcR+0IfGhuB9mfA=
X-Google-Smtp-Source: ABdhPJyoDc1E4Gcci08LHX+1g/e1qISDxmTfO8zvFvSixgtxV8nu3adxs5pj8QhuUDzkkiTq/zmJTA==
X-Received: by 2002:ac2:597b:: with SMTP id h27mr5910584lfp.541.1633214402361;
        Sat, 02 Oct 2021 15:40:02 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id o13sm298432lfl.111.2021.10.02.15.40.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 15:40:01 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id b20so54322075lfv.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 15:40:01 -0700 (PDT)
X-Received: by 2002:ac2:51a6:: with SMTP id f6mr6005698lfk.150.1633214401510;
 Sat, 02 Oct 2021 15:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <7E585A79-A705-4CB9-9E4C-0E73DCE237E2@goodmis.org>
In-Reply-To: <7E585A79-A705-4CB9-9E4C-0E73DCE237E2@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Oct 2021 15:39:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpkoC4wDPDUtVs22aZ=5v2bzAUPTGZTxnK19qB6euRug@mail.gmail.com>
Message-ID: <CAHk-=whpkoC4wDPDUtVs22aZ=5v2bzAUPTGZTxnK19qB6euRug@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing: Define "fake" struct trace_pid_list
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 2, 2021 at 1:04 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> [ Note, this is on top of my tree in ftrace/core, but wanted to ask if
>   this is the proper "fix".

Ugh, please no. This is going to be very confusing, and it's going to
mess with anything that does things based on type (eg traditionally
module signatures etc).

I'd rather you just expose the proper type, if that is what it takes.

> Some compilers give this error:

Only some? Which ones? And what did you do to make it appear? Sounds
like whatever change wasn't worth it.

The advantage of some "opaque type" does _not_ override the
disadvantage of then having to make up these kinds of horrific
workarounds that actively lie to the compiler.

We have tons of structures (and occasionally single structure members)
that we don't want people to access directly, and instead use a
wrapper function. That doesn't mean that they can't be exposed as a
type.

> The reason is that rcu_dereference_sched() has a check that uses
> typeof(*p) of the pointer passed to it.

Sadly, we do that for a reason - we do a

     typeof(*p) *__local_p;

to drop the address space specifiers from (or add them to) the pointer.

That said, I wonder how many of them are actually needed. At least
some of them are purely for sparse

So at least some could probably just use

     typeof(p) __local_p;

instead, which would avoid the problem with a pointer to an incomplete
type (and keep it as a pointer to an incomplete type).

So one option might be to work on the RCU accessor macros instead.

               Linus

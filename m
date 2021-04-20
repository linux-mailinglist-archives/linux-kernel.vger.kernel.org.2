Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8638B365B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhDTOlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhDTOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:40:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62C9C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:40:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w23so42847509ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDWQCx2ZEYEZtk8z9074r5Idvp5NdDJI3fzKNITaGfU=;
        b=jzoF00kY1Vgahjz/TfGq1cVrvyuUV1nxAd7/YCD5nnlFsdPMgwdDtbSczU6/eEr3es
         FRyyzqTN0O52sjEzgrPl9xzt33ZpQugABpEq5o6zI5Oky2ednpQ8QvGq2uhPkfbQDski
         A65/+GeTR8z3mO+jFgV3Nr/s3N1ze0KhA7h3d4kiI2LJFNE2/QBmFq+rV5qWYbI2ZOxa
         fP6ma4bBKg3y8qTgtr4Dpm1PNbG9/u4FcpncYL/86t/ynoKbpfPYC49s8CmU5KkaeVZp
         +jKsj87jiiDQoRnjv/6AQ+afWFAkYDjK59/zRPt2IOIcShUE3ZlmRqrYDCinBvKHczNg
         rpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDWQCx2ZEYEZtk8z9074r5Idvp5NdDJI3fzKNITaGfU=;
        b=fD7TnwD27wDPvvFyK1QGMku4VHGUb23oZJb3lo8GY4Ji+8YfcE56EfTyHhmlnia2uP
         3kFAT4Tlexf1JQcU2LWb9Su/8reZ+G5qkGgXPN0FkgzIpP1HGAryttGZRCvi/WwveRox
         ZWxbhvLI2jvxve0XX0YjAn0wKlTo1HrP7gqcnnHqnvupk9c4kGfmKsWOlfNLEDC0+F2Z
         QSEiMdROmDCWnW4ImP9YrPji6NP74VjgSp8HdnJ92ENroepndSkg42YmSuSctASv6Qwr
         jupcfEbplJaPat0blz10K4CwX0Lr0kbSKMk71vzqtz97XQHWbdkfPV525DXco/dbOU7E
         lwpA==
X-Gm-Message-State: AOAM531pphKd+pa+jHJ60ycOT56yY9p3UJUWM1rewdUeXJ+6eH39GX4n
        6fSkVL3GqF3ks4bO1yMZyrH24eV/WtQQ9GHibIQwiA==
X-Google-Smtp-Source: ABdhPJwvQeOER6Ge1OQ1HxeS2VdoudW6xuPXPcMfX+yfnqgel8Ee0RyfbzZd+nvpOOgqXt5rAEXDaMlqbilsNxbkNhs=
X-Received: by 2002:a17:906:1c8f:: with SMTP id g15mr27599057ejh.20.1618929619246;
 Tue, 20 Apr 2021 07:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210419184455.2987243-1-lrizzo@google.com> <20210419191712.GB26214@worktop.programming.kicks-ass.net>
 <CAMOZA0JxwQFfA=acfr255xcR85ztv-URwaQQFHR6RrLk-cPbvg@mail.gmail.com>
 <YH6bV9W4lgIl4Fry@hirez.programming.kicks-ass.net> <CAMOZA0J4q2XSmhxB_uc-Q2mOA=K_FcvZqy3G+8ME=QMicOF=Lg@mail.gmail.com>
 <YH7XlxfvrdM1+oCe@hirez.programming.kicks-ass.net>
In-Reply-To: <YH7XlxfvrdM1+oCe@hirez.programming.kicks-ass.net>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Tue, 20 Apr 2021 16:40:07 +0200
Message-ID: <CAMOZA0LxPLW2juGq2kZgrTT31L+rTq2LaAD17omGC++VHDOX2w@mail.gmail.com>
Subject: Re: [PATCH] smp: add a best_effort version of smp_call_function_many()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, axboe@kernel.dk,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 3:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Apr 20, 2021 at 12:41:08PM +0200, Luigi Rizzo wrote:
> > On Tue, Apr 20, 2021 at 11:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
...
> > My case too requires that the request is eventually handled, but with
> > this non-blocking IPI the caller has a better option than blocking:
> > it can either retry the multicast IPI at a later time if conditions allow,
> > or it can post a dedicated CSD (with the advantage that being my
> > requests idempotent, if the CSD is locked there is no need to retry
> > because it means the handler has not started yet).
> >
> > In fact, if we had the option to use dedicated CSDs for multicast IPI,
> > we wouldn't even need to retry because we'd know that the posted CSD
> > is for our call back and not someone else's.
>
> What are you doing that CSD contention is such a problem?

Basically what I said in a previous email: send a targeted interrupt to a
subset of the CPUs (large enough that the multicast IPI makes sense) so
they can start doing some work that has been posted for them.
Not too different from RFS, in a way.

The sender doesn't need (or want, obviously) to block, but occasional
O(100+us) stalls were clearly visible, and trivial to reproduce in tests
(e.g. when the process on the target CPU runs getrusage() and has
a very large number of threads, even if idle ones).

Even the _cond() version is not a sufficient to avoid the stall:
I could in principle use the callback to skip CPUs for which I
have a request posted and not processed yet, but if the csd
is in use by another pending IPI I have no alternative but spin.

cheers
luigi

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E43144C12C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhKJM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231232AbhKJM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636547054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QDBntIPO0wEoyBMfZ3tKBmUSJOmiLOto35nSfxuOJEs=;
        b=GYBHO6qpJ0YrPDlPW29uoRWCQz9pObGi2wszkqpV+BZ3SHNwOZ1TWufbf/3f7i5C+KCQ1c
        k0y8i/ySattqTqcXolADS0eMTiap36hkHOuLVi4Is3ElEPeywgh1TwlCLtyqhlf9ju9AzI
        8TgPybafqdsb5AEnb3KsaHZlKuBZZi8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-mFT1rpCmMKCnH7mSi_c5bA-1; Wed, 10 Nov 2021 07:24:13 -0500
X-MC-Unique: mFT1rpCmMKCnH7mSi_c5bA-1
Received: by mail-ed1-f71.google.com with SMTP id g3-20020a056402424300b003e2981e1edbso2206369edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDBntIPO0wEoyBMfZ3tKBmUSJOmiLOto35nSfxuOJEs=;
        b=m1hduVQapLqlCYOAZ+H7cWhi9eKabt1ibC8TipDYwUxTduZvtHF9VfVtNnrBtpmYyr
         lzZFHVWhyCC/HZLjzM0ThgWAoj1/F0F7Mo9+cNAqwY3hbwk/ck3Lox9Cqh4DjrlAQeHj
         AwLnFST9sdG4Zg8bEMroibShpLu7LEkX//IeUKi7KsfyS7bFGemyc0EM7khYdbYMR9In
         jxjCncN5sgvoykrYkIXpL1quYoa0QYdvm5cNxFjdCCDEKWq5Q/kAQOjkNvM4FZg8/jUJ
         /EXqGTLOLl756+3uvsgms2mbi6MPskfps+J+6iSwBeCKIIDVtXhs0u5nKJ8Y32KcT5a9
         1e6Q==
X-Gm-Message-State: AOAM532MuhGe2JpPj29HS/gAyM2JV215HTLQFDSGwMq3iklxUTQD+7Fi
        IPJI08TegobZpUvCYNMkAF80yMRoY8xOnCLT/vunRwqL1Bzo3s69pfsWtlWYKLuckVyibfc24uA
        TNTK2GphWzm9EjSMz7FkGPsQj0LSzluM4nG3/j6Vr
X-Received: by 2002:a05:6402:44c:: with SMTP id p12mr7151102edw.234.1636547052009;
        Wed, 10 Nov 2021 04:24:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvQZi7oZ2z9bC/JYOu9H4TrVq1eS5IwH5H6fTg9dND+AsPWxxwXyOJG9Z7kIckaODRizhj4jbDyTXNStSHfaU=
X-Received: by 2002:a05:6402:44c:: with SMTP id p12mr7151063edw.234.1636547051834;
 Wed, 10 Nov 2021 04:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20211109174602.407644-1-wander@redhat.com> <20211109203715.GW641268@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20211109203715.GW641268@paulmck-ThinkPad-P17-Gen-1>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 10 Nov 2021 09:24:00 -0300
Message-ID: <CAAq0SUms6+ZMhk4WV0bJY-zCwSBS5xHOSLMgywDEUmb_pSB1nA@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Avoid soft lockup during cpu stall
To:     paulmck@kernel.org
Cc:     wander@redhat.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:TORTURE-TEST MODULES" <linux-kernel@vger.kernel.org>,
        "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 5:47 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Nov 09, 2021 at 02:46:02PM -0300, wander@redhat.com wrote:
> > From: Wander Lairson Costa <wander@redhat.com>
> >
> > If we use the module stall_cpu option, we may get a soft lockup warning
> > if we also don't pass the stall_cpu_block option.
> >
> > We introduce the stall_no_softlockup option to avoid a soft lockup on
> > cpu stall even if we don't use the stall_cpu_block option.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>
> This looks plausible to me, though it would be good to hear others'
> thoughts.  In the meantime, could you please forward-port this to
> the "dev" branch of the -rcu tree?
>
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html
>
>                                                         Thanx, Paul
>

Thank you for the feedback. I just sent a v2 against that applies to
the aforementioned branch.

Cheers,
Wander

[snip]


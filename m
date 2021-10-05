Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9A942324A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhJEUsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhJEUsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:48:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F4FC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:46:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u18so1065386lfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSPoOTkRr5tV7uZ2oQ4/a2w9VK4Qjz1YAPZdC+7bcrw=;
        b=atKPmliQ9LuYJrilGpsViHfk6LQV6BmknanYEfaKC5+DRlC/Sf/bbZjgm5eOG2gsrs
         fmv7trPUK3bUcYnjK+F3dvGkJznH7EtdSCCwNZlfE6Q1ZLEG8bowAjHuLUwTsaJgDL3U
         E3zlV7ocEBIN+OWdpawxUEevr7fS0Jaaj9cW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSPoOTkRr5tV7uZ2oQ4/a2w9VK4Qjz1YAPZdC+7bcrw=;
        b=3AV2bd71outU/fSKZDSAR0cVfS1bXZCTPuwZCCETRRW+F9YHOvBP3Q79QbF+CnxL1m
         TR6PVeeOrzYRQGVz+Vew4YdHm3Ga2673bN2IZVnjTk9zbnZQmDzZRDnEkfKRdH4bUP45
         htjoujq/XoyTLrxPasbvXfQrrlzzAyPPFcprRXJYYW8z2B/H8KVeyQR5W3HWdDPER2XU
         lbfht9JYKXN6JCUtHJt3z2sGKdrgzc4z1fkMKQBQohsUkJi36vupo/Qrnu5Cplm5aC3j
         /I6ryBmxBWCSRj+fKDfYWV7UhvnyTIRP3M1SlVcYvk3gCwoAC7lc+IUovNx0VqeicG0G
         9i8w==
X-Gm-Message-State: AOAM532ZDbb0G0i8jFKu2SBErXLXeex8NTh7ekLkfS3WwI7QJ0axtfmi
        h6vVrJ8Ff3AhTWWDteSYfO5RDLmtvWa+qm9F1Nk=
X-Google-Smtp-Source: ABdhPJwVVe7jFAGM6ahVb97ZcXZk32teTerbbY0PA4QGhOL+PpinJsuBTN/7TTr12Hij+NZkt4tOFA==
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr5310364lfb.189.1633466770142;
        Tue, 05 Oct 2021 13:46:10 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id f7sm2058042lfc.217.2021.10.05.13.46.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 13:46:10 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id n8so1178379lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:46:09 -0700 (PDT)
X-Received: by 2002:a05:651c:a09:: with SMTP id k9mr25182695ljq.191.1633466769318;
 Tue, 05 Oct 2021 13:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211005094728.203ecef2@gandalf.local.home> <ef5b1654-1f75-da82-cab8-248319efbe3f@rasmusvillemoes.dk>
 <639278914.2878.1633457192964.JavaMail.zimbra@efficios.com>
 <826o327o-3r46-3oop-r430-8qr0ssp537o3@vanv.qr> <20211005144002.34008ea0@gandalf.local.home>
 <srqsppq-p657-43qq-np31-pq5pp03271r6@vanv.qr> <20211005154029.46f9c596@gandalf.local.home>
 <20211005163754.66552fb3@gandalf.local.home>
In-Reply-To: <20211005163754.66552fb3@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Oct 2021 13:45:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+P=YeuY=tpY72nDMQgxGTzEMqjfq5P536G=qYEkQr1w@mail.gmail.com>
Message-ID: <CAHk-=wj+P=YeuY=tpY72nDMQgxGTzEMqjfq5P536G=qYEkQr1w@mail.gmail.com>
Subject: Re: [RFC][PATCH] rcu: Use typeof(p) instead of typeof(*p) *
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jan Engelhardt <jengelh@inai.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, rcu <rcu@vger.kernel.org>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam <coreteam@netfilter.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 1:38 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Really, thinking about abstraction, I don't believe there's anything wrong
> with returning a pointer of one type, and then typecasting it to a pointer
> of another type. Is there? As long as whoever uses the returned type does
> nothing with it.

Just stop doing this.,

Dammit, just include the header file that defines the type in the
places that you use the thing.

Because, yes, there is a LOT wrong with just randomly casting pointers
that you think have the "wrong type". You're basically taking it on
yourself to lie to the compiler, and intentionally breaking the type
system, because you have some completely bogus reason to hide a type.

We don't hide types in the kernel for no good reason.

You are literally talking about making things worse, for a reason that
hasn't even been explained, and isn't valid in the first place.
Nothing else in the kernel has had a problem just declaring the damn
type,.

If there was some clean and simple solution to the compiler warning
problem, that would be one thing. But when you think you need to
change core RCU macros, or lie to the compiler about the type system,
at that point it's not some clean and simple fix any more. At that
point you're literally making things worse than just exposing the
type.

           Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F175C4230ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhJETs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 15:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbhJETsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:48:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2CEC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 12:47:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y23so807345lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugWGt9Pg5upI+OifuSoHCXw7NKwxQ1vrKgVTrc521LA=;
        b=T7PyJHg80nfkPUQJ7wSKYwTRhSmMLdv+QAUUhPStrfcNo/FY2KObTGqH8VI91mm2de
         in0tGoxNF7Pfx7awFKAakx9kDhOZoB9oYhggSaw/Q0JWtGGgV/+n3HELHjYLUkWJV3N/
         5K95Wh43Bw4IeM9lQCzUeqH0Sb/e/rUuWf6Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugWGt9Pg5upI+OifuSoHCXw7NKwxQ1vrKgVTrc521LA=;
        b=PMCYXZ/6mlJskP69GFrHZXjjsP45xpAyW8t+4LL58lD/ASlaCHZEVOVyNrsdRKs849
         bDj6zEcL3YDCszz35g4dEObzyKY7gHzIeIp9Sw1QnUEMkhIy3Cy805EOsYXgpjZ1xgZL
         HSdBxcNr9re8r+XwIfB+YI57MojZRjIKzlB1Olb5m8MB4yEqcYvRXsJhyQDkFDLxJHx2
         2yvOBz52uif1JXQqDikvsqIFJmo6iPNSOas69dIsmxxH3naKInRhC8EsIgkv21GDxTzw
         jOp9WanMDAUhKutvUgs9lxNga7IQ5PBUJQjxLAi9lOWsZgukfBbaOSXSQCti0r4I3neU
         O/Aw==
X-Gm-Message-State: AOAM5334FK9p1GzvASMdjhMQgaQFFee1KZL2oDVYeYLOtrBs6jO0Ojkp
        8QzDzgQb8CV9D62nmfPspAL27TGgfA0gIAK6H3s=
X-Google-Smtp-Source: ABdhPJwfff5/5+Wgk9flUjXpBRczjkgw1fiGUNauAe8avCwgnqP/gG9p8FuGA3LRWO99YaM5eAjOmw==
X-Received: by 2002:a05:6512:33cb:: with SMTP id d11mr5062862lfg.566.1633463222142;
        Tue, 05 Oct 2021 12:47:02 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id o21sm2053336lfu.81.2021.10.05.12.47.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 12:47:01 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id y23so806957lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 12:47:00 -0700 (PDT)
X-Received: by 2002:a05:6512:12c4:: with SMTP id p4mr5337511lfg.280.1633463219864;
 Tue, 05 Oct 2021 12:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211005094728.203ecef2@gandalf.local.home> <ef5b1654-1f75-da82-cab8-248319efbe3f@rasmusvillemoes.dk>
 <639278914.2878.1633457192964.JavaMail.zimbra@efficios.com>
 <826o327o-3r46-3oop-r430-8qr0ssp537o3@vanv.qr> <20211005144002.34008ea0@gandalf.local.home>
 <srqsppq-p657-43qq-np31-pq5pp03271r6@vanv.qr> <20211005154029.46f9c596@gandalf.local.home>
In-Reply-To: <20211005154029.46f9c596@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Oct 2021 12:46:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiL+wyCOTedh48Oz0cNOKJq2GNwtxg6423hf-1FuGrv_A@mail.gmail.com>
Message-ID: <CAHk-=wiL+wyCOTedh48Oz0cNOKJq2GNwtxg6423hf-1FuGrv_A@mail.gmail.com>
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

On Tue, Oct 5, 2021 at 12:40 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I may try it, because exposing the structure I want to hide, is pulling out
> a lot of other crap with it :-p

One option is just "don't do rcu_access of a pointer that you're not
supposed to touch in a file that isn't supposed to touch it".

IOW, why are you doing that

     pid_list = rcu_dereference_sched(tr->function_pids);

in a place that isn't supposed to look at the pid_list in the first place?

Yeah, yeah, I see how you just pass it to trace_ignore_this_task() as
an argument, but maybe the real fix is to just pass that trace_array
pointer instead?

IOW, if you want to keep that structure private, maybe you really just
shouldn't have non-private users of it randomly doing RCU lookups of
it?

                  Linus

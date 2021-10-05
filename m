Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7502D422DBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhJEQUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhJEQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:20:32 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C4C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:18:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n8so31881614lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pR87ZxffODNYHX3y8wIUUlOXsoFep7W3KkITUWQQdA=;
        b=TpNQeD0xD3/3W2Huts2s1yHnNDHO08/TvqGsxKknqz53fnCGeGEUqEVbfpYl1NdwF4
         xJpyZzE3P+DphdGWSaAERkfy6zE0yQxVQJzxFtwf2PG26X4bXpACjDTFkKxp99R+RSkM
         OtWyX3w8eTxmkzyy/0NhGAMfrer3tnjCwq++I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pR87ZxffODNYHX3y8wIUUlOXsoFep7W3KkITUWQQdA=;
        b=N4JlTA6OHrcIBe4oiNFiaDMJPtVyoFQ+XzDWcnTadVv302hETJAPCI34iFBzao94/0
         Y37yzKFjaGdCbKyjagTsnYDsI+9LofQnZyK+wXHRbmO7Qoqw6fXj2x/lWlnTRQB2rt95
         uZgaAwIAkTMjyWXCMhFuRAqfC/vYnhIRQFEShusk9Uq6wNgIdvf+hLDGEosOn3dIJzSh
         K8Y1BXmBEAswbNu2Lq4DbkQ1xHtRcerraMzetfGI+6SA1TsHeCTmETXnIaoBaI+sx18o
         r66BfP9Tv1kKFxsDcUdpSZBRAP3UMaWhHb4VuBumgt4ROqPA6lxYYxOuTYLRHQQO64Iy
         hGTQ==
X-Gm-Message-State: AOAM531W0dHWQayOMdCzC9d583JUTnvvZ9/3bQ1Ai1gYRQvJM2f/L7WY
        qcEjzb/wF/3vvUJ7PVAg5OlL3+Orr8F4GAwi
X-Google-Smtp-Source: ABdhPJxkyHdGDG9WkwpR7Z2WoNOtA865ayrkyXigpeaErgJQrtotfYMxrWor+FdFmqS3DS+nOHVXFw==
X-Received: by 2002:a19:5e0d:: with SMTP id s13mr4216023lfb.174.1633450713029;
        Tue, 05 Oct 2021 09:18:33 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t20sm648125lft.240.2021.10.05.09.18.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 09:18:32 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id n8so31879535lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:18:30 -0700 (PDT)
X-Received: by 2002:a05:6512:b8e:: with SMTP id b14mr4429467lfv.655.1633450701008;
 Tue, 05 Oct 2021 09:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211005094728.203ecef2@gandalf.local.home>
In-Reply-To: <20211005094728.203ecef2@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Oct 2021 09:18:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0AJAv9o2sW7ReCFRaD+TatSiLMYjK=FzG9-X=q5ZWwA@mail.gmail.com>
Message-ID: <CAHk-=wj0AJAv9o2sW7ReCFRaD+TatSiLMYjK=FzG9-X=q5ZWwA@mail.gmail.com>
Subject: Re: [RFC][PATCH] rcu: Use typeof(p) instead of typeof(*p) *
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, rcu <rcu@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 6:47 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Also had to update a lot of the function pointer initialization in the
> networking code, as a function address must be passed as an argument in
> RCU_INIT_POINTER() and not just the function name, otherwise the following
> error occurs:

Ugh.

I think this is a sign of why we did it the way we did with that odd
"typeof(*p)*" thing in the first place.

The thing is, in any normal C, the function name should just stand in
for the pointer to the function, so having to add a '&' to get the
function pointer is somehow odd..

So I think you should just expose your type to anybody who uses a pointer to it.

               Linus

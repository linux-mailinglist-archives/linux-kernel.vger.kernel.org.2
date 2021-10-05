Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF5A422E4E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhJEQta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbhJEQt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:49:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15126C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:47:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id n8so32180640lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLZ4fUPrQrbt7FIi8eh6e+j83DwiHUC8faRiqF4uPzs=;
        b=Sx/egy7EF/hE71/yLc5iCclMS1KXr0PsI3iiyddcxXDm2B0Fxf8mgNzYhQ2YN7zBBO
         /4+9Kcm3Z11rJyATI53bYBVYHhIMcqzuKTHZLXoJBScRA6Yo3U68Qhd6c/SYBgRtmj6W
         xEbTJ6zX5RaesGntJeEEsVug181hbwk/vJhRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLZ4fUPrQrbt7FIi8eh6e+j83DwiHUC8faRiqF4uPzs=;
        b=XOzcK9f/rJNdcB1GBKPnxp7Z7yzbju93/DvL/9D/HHv7d0Je52IrV348YXgtLp9298
         KyA0hwb+ekQJq9mGoMejtxokfh3oVMmTYSnbNa+e0CpQm4saSh8E1mmf4s8BGipKx8x0
         FnJUZTxhENnM5wLBhY0JgmU+2meLIe50f90JhVOdexUP2bkDjfsqTyrgNC8TZG6lZNFH
         BxRKHsLp4tqOt9/E820h2mHaHGd1FbduO07sSzdP2GNSUd0xVGVmzrajVs6eLU4wNadM
         GglBaumXMj2t/+ct2ANv34mpTJQLHpsJm39vA6XnjemqjMlsSTZxU/aOKQZk+Gfm1dyE
         a93w==
X-Gm-Message-State: AOAM531shohmoBpnxovtkZdByccO4jpF0b2QnyXFKkq9NGskvf+a68jT
        hekkROmb8qBsHLAYj1omNL7KVnZBNjxAMPfx
X-Google-Smtp-Source: ABdhPJxR1PGzpWo9Ys9/zJUNT0jJwuJrIr8uTGOBitgruFmA2nTVsrLoIlEjz/6nGxoqSE2u8YuM4w==
X-Received: by 2002:a05:6512:400c:: with SMTP id br12mr4551864lfb.23.1633452450254;
        Tue, 05 Oct 2021 09:47:30 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id w11sm170924lfq.133.2021.10.05.09.47.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 09:47:28 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id r19so6051856lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:47:26 -0700 (PDT)
X-Received: by 2002:a05:6512:12c4:: with SMTP id p4mr4519659lfg.280.1633452446149;
 Tue, 05 Oct 2021 09:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211005094728.203ecef2@gandalf.local.home> <CAHk-=wj0AJAv9o2sW7ReCFRaD+TatSiLMYjK=FzG9-X=q5ZWwA@mail.gmail.com>
 <20211005123729.6adf304b@gandalf.local.home>
In-Reply-To: <20211005123729.6adf304b@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Oct 2021 09:47:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8duLUhR4duN2fNWRF73oGufZNMyvyF5Twp9FnqXmq+g@mail.gmail.com>
Message-ID: <CAHk-=wg8duLUhR4duN2fNWRF73oGufZNMyvyF5Twp9FnqXmq+g@mail.gmail.com>
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

On Tue, Oct 5, 2021 at 9:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Oh well, it was a fun exercise. Too bad we failed due to inconsistencies in
> compilers :-(

I'm admittedly surprised that something like this would be a
"different compiler versions" issue. But "typeof()" isn't exactly
standard C, so the fact that some version of gcc did something
slightly different is annoying but I guess not _that_ surprising.

Oh well indeed,

           Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE437081A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 19:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhEARMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 13:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhEARME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 13:12:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CB9C06138B
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 10:11:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d15so1851038ljo.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4MiGambOH4Q41KUPDr0utbfXa2gDpNvnZNfFaeSWGI=;
        b=OcQ/r1/syjv1XULz5t4nXGvygGmxbigE6rMcT7tyo7mea/qVET26A82gNFVc49DGOr
         wXH+ksm///CLTcAfiAPFZ4ZQhDg/6VeINM52p83MWFH9rn+hrY+f8busw+3oa9Mei3mp
         9ZgD6h5qO5bMzZKithNwl8cwo0vQX6zbrqZ7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4MiGambOH4Q41KUPDr0utbfXa2gDpNvnZNfFaeSWGI=;
        b=affkne93eHGf6kVofPA9NDZ5eUlnpRG0GlOI2MQpdn56k2cMAJMUdvCpBWsRsYgdey
         KshhcjQBGsPnKmaK52cMv11HKiMVNgA7Ln+6sOpIQgJNUvdtV01suPDslDWSLhANQarb
         M9uOhPue34s1a65lTdBoukP5zHPgWVyixsbEVetnN+98ouSPZMjXAVpq+qJyv068Azq/
         ikyrw5UrjZjJzdHseIzuEub0eaOa7q4MolyYyXXiAO85ynGrOokxBno/vKYBVYovlZ49
         qG8RAe1HDj04d5ONqltKdHI7YonRrVsTST4vD9Gq8mnlim/7Y48td3GVOAy5csB5fjKp
         ztsw==
X-Gm-Message-State: AOAM533C05m5IknNQ8e+L4rP58JpXOFw++S1Un03gKMiIfz1p52Wn+E8
        8nMF0vR81dMKl31Ug3bmHvdfwjYrxnY8e1g/
X-Google-Smtp-Source: ABdhPJxWAazuXMNhKFckytfeFcjyjRy/LNSAMqHq7Onu/rMjKjhlEjI8MkDIZyxjf/YWaQn8L4d3XQ==
X-Received: by 2002:a05:651c:102b:: with SMTP id w11mr7272348ljm.449.1619889071340;
        Sat, 01 May 2021 10:11:11 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v16sm572874lfd.110.2021.05.01.10.11.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 May 2021 10:11:10 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id z13so1861864lft.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 10:11:10 -0700 (PDT)
X-Received: by 2002:a05:6512:3763:: with SMTP id z3mr7025614lft.487.1619889069713;
 Sat, 01 May 2021 10:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210428230528.189146-1-pbonzini@redhat.com>
In-Reply-To: <20210428230528.189146-1-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 May 2021 10:10:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMc55HFTxEiJi=3iUcFm7fBeYHUvUmP1ZFYxbbs8nfXA@mail.gmail.com>
Message-ID: <CAHk-=wjMc55HFTxEiJi=3iUcFm7fBeYHUvUmP1ZFYxbbs8nfXA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM, AMD PSP and ARM CoreSight changes for 5.13 merge window
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, got around to this now, one comment:

On Wed, Apr 28, 2021 at 4:05 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> - the coresight/next-ETE-TRBE branch from the KVM ARM tree hasn't yet
> reached you, so I am CCing the maintainer.  Since he sent the patches
> as a pull request to Marc Zyngier (the KVM ARM maintainer) at
> https://lore.kernel.org/kvmarm/20210406224437.330939-1-mathieu.poirier@linaro.org/T/#u,
> I actually suspect that from his point of view he's done.

So the problem with this is not the code, it's the merge (and
admittedly the pull request in that case).

The totality of the merge message for the coresight pull is this:

    Merge remote-tracking branch 'coresight/next-ETE-TRBE' into
kvmarm-master/next

    Signed-off-by: Marc Zyngier <maz@kernel.org>

Can you spot the problem?

And  honestly, it's not just that merge. *Most* of the merges in this
tree have absolutely garbage commit messages. This is particularly
true of Marc's merges, but there's one from you too, with the merge
message being:

    Merge branch 'kvm-sev-cgroup' into HEAD

Guys, merges need explanations. A one-liner "I merged this" is not ok.
The reason I ask for pull requests to have explanations is exactly so
that I can write reasonable merge messages.

Pull requests need to have explanations of what they pull - not just
because it needs to go into the merge message, but because the
maintainer needs to keep track of what's happening.

And even when you merge your own topic branch, you should explain
*what* you are merging and why.

Yes, it can be some simple extra line for trivial stuff ("Fix ARM
memory slot handling"), but even when it's that simple, that extra
line should be in addition to the "this is where I merged things from"
like

    Merge branch 'kvm-arm64/memslot-fixes' into kvmarm-master/next

so sometimes you only need one extra short line as a human-readable
"this is what's going on".

But then when you have something like that commit 53648ed3f085

    Merge remote-tracking branch 'coresight/next-ETE-TRBE' into
kvmarm-master/next

that actually brings in a lot of new code, that "merge from where"
really doesn't cut it.

Put another way - just look at

    gitk 53648ed3f085^..53648ed3f085^2

and tell me that that merge message is enough for what got merged.

Because it damn well isn't.

Merges are *important*. Even if nothing goes wrong, that's where
history can get messy, and the message really tells outsides what's
going on in the big picture.

And heaven forbid that a bisect points to a merge as an issue - it's
rare, but it happens - then you really want the merge to talk about
what is going on, and what it brings in.

So please people: fix your useless merge messages.

            Linus

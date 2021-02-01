Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED2E30AE9B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhBAR7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhBAR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:59:05 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E39AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 09:58:25 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 16so18360454ioz.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bv8ZgkdpbtWRz3CeKeqPHjo/hOCKsBVIEdmTNlxLJSM=;
        b=klKDnUELxUZeEjyVuPIjtkORiqDrPDKxzUfGKgFJ8y8IYEVq7fDn+tN4RCOOYQJDIi
         yvj4eVFn2BjhA5at4JWsUXeIa3B2lzIkzfeZwKMcS+4XELsCUhy/0gugDnbAeu+0K8xR
         UWS10sPUqt7GwwHrkhURpyvJcuU2giHTUmrvopCEgnHfx1KiMqbB9CUxqlERhf2IX5aL
         jl5TosryvAyFvAosWd0Wyvhd0vEy4u1cqL5KbIy1RyeXlXUiAei/U9tmhXNypbbM4GuR
         d/NPY0RPjtGKTMpiZwDTl5EY+i8TQGVorYk686FAkIaX6iM2zDcodSx5pFSFHAG8wBB+
         G/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bv8ZgkdpbtWRz3CeKeqPHjo/hOCKsBVIEdmTNlxLJSM=;
        b=rjsYcynVHjd6okNz9+MV6x6LDaQ0Q/fAeMBJttedHHLi0sobTAcbKdq2+ZcNZ2Fb32
         mUNSQ6bMiF3u1DQUG6LTQStXwkhS35B9I8ksDwhRtpWfKrDS7xsyn5s6ZVjDOITMJtpZ
         jraKimRqAv7xzvns3VLSWDD/w0LOI/h8jC4kPBIa+mfcGmcZa1A//LEIeptJYLn2F1qE
         tF8o2cTYbTPGa7hD17iu2TnYhZ/JRpIahDw65dPu9+oDj5eR28vGAfrJXI1C3FcROW4+
         h0xdvHiC/N1p15Fa7eKdJErKrPub/4Ot2KINOvhZOjj43eGaA67oaq4Ajzo7RgaurqYc
         tsmA==
X-Gm-Message-State: AOAM532OS8/7/EryT3r7cSGfn9RRIMP8fshubbT/C8tLxa8hc0UazBo4
        zrGpmekbmZGF5F07KFP6/a5zpfjLfDBxYnwl2813VQ==
X-Google-Smtp-Source: ABdhPJworOiTAhpDnz2geF6mGwnmzvskFQFo+HEu27UpDCq/rJieGNrWIG4qKLQUHm18Mj12jU/n1y9UKsQq4odITi4=
X-Received: by 2002:a02:e87:: with SMTP id 129mr15622009jae.34.1612202304740;
 Mon, 01 Feb 2021 09:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20210201160420.2826895-1-elver@google.com> <CALMXkpYaEEv6u1oY3cFSznWsGCeiFRxRJRDS0j+gZxAc8VESZg@mail.gmail.com>
 <CANpmjNNbK=99yjoWFOmPGHM8BH7U44v9qAyo6ZbC+Vap58iPPQ@mail.gmail.com>
In-Reply-To: <CANpmjNNbK=99yjoWFOmPGHM8BH7U44v9qAyo6ZbC+Vap58iPPQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 1 Feb 2021 18:58:12 +0100
Message-ID: <CANn89iJbAQU7U61RD2pyZfcXah0P5huqK3W92OEP513pqGT_wA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: fix up truesize of cloned skb in skb_prepare_for_shift()
To:     Marco Elver <elver@google.com>
Cc:     Christoph Paasch <christoph.paasch@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        linmiaohe <linmiaohe@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        Dongseok Yi <dseok.yi@samsung.com>,
        Yadu Kishore <kyk.segfault@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        netdev <netdev@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        syzbot <syzbot+7b99aafdcc2eedea6178@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 6:34 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, 1 Feb 2021 at 17:50, Christoph Paasch

> > just a few days ago we found out that this also fixes a syzkaller
> > issue on MPTCP (https://github.com/multipath-tcp/mptcp_net-next/issues/136).
> > I confirmed that this patch fixes the issue for us as well:
> >
> > Tested-by: Christoph Paasch <christoph.paasch@gmail.com>
>
> That's interesting, because according to your config you did not have
> KFENCE enabled. Although it's hard to say what exactly caused the
> truesize mismatch in your case, because it clearly can't be KFENCE
> that caused ksize(kmalloc(S))!=ksize(kmalloc(S)) for you.

Indeed, this seems strange. This might be a different issue.

Maybe S != S ;)

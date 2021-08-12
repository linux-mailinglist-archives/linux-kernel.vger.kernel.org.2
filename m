Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6623E9F33
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhHLHIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbhHLHIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:08:02 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2C6C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:07:38 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id k11so9760008ybf.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNbadYpEdJVuH8IgME6HLnqMP9VEAKKImPC7HomiMdE=;
        b=EZh5Vi7dnJV+CsZFIWmVlgH8ElUJ+2gtNAZh5NOT7HwuyPBTzLSN1M5eX/k0PSey87
         E3sObwmwcGZaXoaW1c8/RW7SUPRYJbu6iL6EwjeP0wTiE24/siJnc7Lhj5CF/KeZVCtP
         fBaG66NmQ6h6FTRheBv+pz1Tu0n1reibJy9QdvO4uOxnrwxf2AO/MMafwAJNWVT/ocxX
         2Tiz3AWP8qeJ8JlFry8IvgiW1h2wTtZl4Bp3qULM2EbcWtU7EHOfVtnPuoeaVNe988l6
         4LXMPCrCBPTynZFuDZf6q03wNx+20itUZrEcihJ9TQNSkaq/GIDEyeeoy0+90D3egGDn
         6Nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNbadYpEdJVuH8IgME6HLnqMP9VEAKKImPC7HomiMdE=;
        b=cTVhDme49NbLy7f+WJnOXNGtuJJZicgqNY4LtgbAxa63wPIvqr46B3WOPu66Q84S6/
         7S6s8HqLi2yDiW1ES1fHRIq/6c0xL1bYyX2eQHTxjb2mXEf3niiumaKwIOVqB1V+V/ig
         9xDfngBV6q3Lz+Y3q+yoxAdPunyE+8W5aAyc3h72+ArMXl7YJQHyuOTtaxZ4P7c5gP8w
         ynrpqxdmuz3Rtr5bTwNa4W5yST8S16qfPRckbikjL+SD0qoIAg+CtE1c8RCL0OB94HTA
         aTizeJhzFnAjkZIJycpGoVs9oJ4FHkHv7IUPTVTgH0bGNZKTCxoZtER4SS1w9NuDfbU/
         XC2w==
X-Gm-Message-State: AOAM533avwchFpDCUM5/9SmMIBmOJTiiU98KtD3dMVVaV0qDkWvX4HF2
        HhpjZBX7bC+F0y2YFWtgwI+dI8sg7I9/cTPnxN/7ug==
X-Google-Smtp-Source: ABdhPJz4R9WwiWRLBaxIdLeSpTQe1Orbq+PuyORfqX/1JHJwCICUFP6LIBDpoLgZ9L+Z5WysNNJSVOWKhNAHK6H7dZo=
X-Received: by 2002:a25:ea51:: with SMTP id o17mr2748444ybe.253.1628752056761;
 Thu, 12 Aug 2021 00:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210811235959.1099333-1-phind.uet@gmail.com>
In-Reply-To: <20210811235959.1099333-1-phind.uet@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 12 Aug 2021 09:07:25 +0200
Message-ID: <CANn89iLQj4Xm-6Bcygtkd5QqDzmJBDALznL8mEJrF1Fh_W32iQ@mail.gmail.com>
Subject: Re: [PATCH] net: drop skbs in napi->rx_list when removing the napi context.
To:     Nguyen Dinh Phi <phind.uet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        kpsingh@kernel.org, Antoine Tenart <atenart@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Wei Wang <weiwan@google.com>, Taehee Yoo <ap420073@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        memxor@gmail.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+989efe781c74de1ddb54@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 2:00 AM Nguyen Dinh Phi <phind.uet@gmail.com> wrote:
>
> The napi->rx_list is used to hold the GRO_NORMAL skbs before passing
> them to the stack, these skbs only passed to stack at the flush time or
> when the list's weight matches the predefined condition. In case the
> rx_list contains pending skbs when we remove the napi context, we need
> to clean out this list, otherwise, a memory leak will happen.
>
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Reported-by: syzbot+989efe781c74de1ddb54@syzkaller.appspotmail.com

Thank you for working on this.

Please add a Fixes: tag, otherwise you are asking maintainers and
stable teams to find the original bug,
while you are in a much better position, since you spent time on
fixing the issue.

Also I object to this fix.

If packets have been stored temporarily in GRO, they should be
released at some point,
normally at the end of a napi poll.

By released, I mean that these packets should reach the upper stack,
instead of being dropped without
any notification.

It seems a call to gro_normal_list() is missing somewhere.

Can you find where ?

Thanks !

> ---
>  net/core/dev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b51e41d0a7fe..319fffc62ce6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -7038,6 +7038,13 @@ void __netif_napi_del(struct napi_struct *napi)
>         list_del_rcu(&napi->dev_list);
>         napi_free_frags(napi);
>
> +       if (napi->rx_count) {
> +               struct sk_buff *skb, *n;
> +
> +               list_for_each_entry_safe(skb, n, &napi->rx_list, list)
> +                       kfree_skb(skb);
> +       }
> +
>         flush_gro_hash(napi);
>         napi->gro_bitmask = 0;
>
> --
> 2.25.1
>

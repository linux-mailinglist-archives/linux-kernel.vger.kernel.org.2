Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6865941F845
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 01:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhJAXjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 19:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhJAXji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 19:39:38 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656E0C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 16:37:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v195so23320334ybb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 16:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tt7Hdb+hPYhUJtzg78OyXPTH1G9+C5jzb56pV825FZQ=;
        b=eLyjdUaPWiUSeVQ5w0qP3Shd6csqCSF3Dinc5Ah7hTICHORWETU35atAI7Uyok6vsn
         Ibk6m1JOMkW9PJ1Wpzb13yAlEAWmXUZdEZR3nIjA4rCmpU4z9tPTNc8cfGc1CZnekDoz
         QFtBpirtyfbNNqtu8Oj1hTnvGHaraB+5Qvtzn1RAnEQyTV9dc4gxBLXPGljeHhPiDBtA
         EyMOkuZZUZjySRoB5EwEWyn6hEaYbap/EvuoW0LwLn91c2p5yarYkhBTujBJbnGozngC
         S1ZWemAxLh86AxFx4//kAsKbc0utO0dSWdhzACNjUiMt8ZhcbQ67YUFjbatUlhZRQJ72
         DxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tt7Hdb+hPYhUJtzg78OyXPTH1G9+C5jzb56pV825FZQ=;
        b=u5awhed5JvakNRBz3kATzCbFaSmprVkfUpY29IWZr/TlhQXHWLOoTEO05GYyBB7gLM
         u7nAQy3oHm49hALE1GKQtytcOz6IVAQ5eO+T1lg9Hn6Os1480y9r70BSbqh0Ee12oQ2j
         auGd/alMZXieSANo7Py/N1da21M2mFPKm0300fkNiyMJ3XMutqwx475EEK+TInPJGrKH
         uJiudRqnaw2bEa24/Ven7hYF+skFVomA/TzzDHGdNqcR+B3xnYrTEu4AfUDW56J2KVH1
         lyuIumU81YUFp0sYPff4D1B+ozKFS0i6ChisBjBuT2/xrkqTPB78t59pjahRHnSL83gD
         piMg==
X-Gm-Message-State: AOAM531m2JzB6DnnmHIDBxNVpyjCAFCGgLIQ8Ot1BM1Qv2mB9bA+Zt94
        +DnOpphuZy5QReO6HMlI6qhLWnX0bMkLp3wVTmUO1g==
X-Google-Smtp-Source: ABdhPJxamboFE4NPYJAmRT2znIQBkJMM7K5bSExj1BqiL3sMcVxvBS7HLXN98nT5tx6KAkbsfSTk992vy/WOeej18+o=
X-Received: by 2002:a25:7415:: with SMTP id p21mr682439ybc.78.1633131472098;
 Fri, 01 Oct 2021 16:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211001215630.810592-1-eric.dumazet@gmail.com> <20211001154949.98956c092734590e781ce672@linux-foundation.org>
In-Reply-To: <20211001154949.98956c092734590e781ce672@linux-foundation.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 1 Oct 2021 16:37:40 -0700
Message-ID: <CANn89i+diZ9cmMo+y3KhBK3xiWbzAsC_RF86=hN4KJ1Kxg1SwA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING
 | MPOL_LOCAL in mbind()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        syzbot <syzkaller@googlegroups.com>,
        "Huang, Ying" <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 3:49 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri,  1 Oct 2021 14:56:30 -0700 Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> > From: Eric Dumazet <edumazet@google.com>
> >
> > syzbot reported access to unitialized memory in mbind() [1]
>
> I'm lazy.  What memory is being accessed-unintialized?

I think you can clearly see that with this debug patch (courtesy of
Alexander Potapenko) :
(Then issue various mbind( ...MPOL_F_NUMA_BALANCING | MPOL_LOCAL ...)
in a loop... )


diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1592b081c58e..95a4d71efe99 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -291,6 +291,7 @@ static struct mempolicy *mpol_new(unsigned short
mode, unsigned short flags,
        } else if (nodes_empty(*nodes))
                return ERR_PTR(-EINVAL);
        policy = kmem_cache_alloc(policy_cache, GFP_KERNEL);
+       memset(policy, 0xAA, sizeof(struct mempolicy));
        if (!policy)
                return ERR_PTR(-ENOMEM);
        atomic_set(&policy->refcnt, 1);
@@ -2256,9 +2257,12 @@ bool __mpol_equal(struct mempolicy *a, struct
mempolicy *b)
                return false;
        if (a->flags != b->flags)
                return false;
-       if (mpol_store_user_nodemask(a))
+       if (mpol_store_user_nodemask(a)) {
+               pr_err("struct mempolicy *a: %px, nodemask: %px\n", a,
*(void**)&(a->w.user_nodemask));
+               pr_err("struct mempolicy *b: %px, nodemask: %px\n", b,
*(void**)&(b->w.user_nodemask));
                if (!nodes_equal(a->w.user_nodemask, b->w.user_nodemask))
                        return false;
+       }

        switch (a->mode) {
        case MPOL_BIND:


>
> > Issue came with commit bda420b98505 ("numa balancing: migrate on
> > fault among multiple bound nodes")
>
> No cc:stable?  What's the worst-case user-visible impact here?

I added the more precise tag  :  Fixes: bda420b98505 ("numa balancing:
migrate on fault among multiple bound nodes")
I only put Fixes: tag, so that stable teams can use their automation just fine.

worst-case impact, I am not sure if any application ever used this
undocumented combinations of flags ?
Also, it is generally advised that accessing garbage values has
undocumented behavior.
A host could for example crash (it certainly does with KMSAN)

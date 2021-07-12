Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8AC3C59E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385092AbhGLJJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382110AbhGLJAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:00:31 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502EC0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:52:20 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id s6so14376523qkc.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gr5RwC6zTNVzz2t2qLDZNHNhS8++ncXvIVfc8T4BQKw=;
        b=swJ87Q9gFWn9AJRRt20yb/p5k7hDgEvS+K57GUEsjNrmAOODI7HIMfs4fq2Pf6TJhI
         O+LzphEojHWKcorplpOsLraa2aE3o2HYM+XOIj8KL14q1drqptieUl7luAMIeyz1xm0d
         tCw1hKR4CnRObeatq95PM5ZX2Bgdg5npo6qe6nRtPk9zS+j+Nh9oyOzi/NOIzKzKI9vj
         sY2eN6Tq6YwSqZtgz7b4tfJPzDizkeZNV4R4oYTKT1hcOulATG3luTNyKcNSdItJ88px
         gns5L0HyrA+i7jiP3HTcMe6RO7F2mp4E5sKfCe/24zJHEw9xFTvkNfB9MiTRlRmms+uT
         MpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gr5RwC6zTNVzz2t2qLDZNHNhS8++ncXvIVfc8T4BQKw=;
        b=OKsxFUsTtK2qgmSSwSi4cHaM89XJQREWrs9Jc8V/r8phyXWFeNinV0O9HAHaVb4aBd
         8Fky2+b5/Fq/HJ17gFbuCayZ8bEOK65YSL+mrACcQcDnDXMqobLJuhTxFL5sskTCqPQX
         nVTD1wbYSvJz95TzWS7B5+Cc/n3j/p54Zbw6Jy7VJRCLbdI9Oo7UStVeyPCmRxlRcnzT
         Ph1DvsuHCF15YwPQLh99Y3LuOdY1kdWxrxofuYfoY1iNIZu24LdSJWpcx4wkQieIu1X+
         d+3Nz79Hx3fJ/zaD6P6uKiq3Bbt90IW+0QTnl9gAmI9h2Ry3WrPAfE6AHNN6ALv6qaYs
         a6bQ==
X-Gm-Message-State: AOAM533BNLAMOzgE3FxrzPB6UaJCyXqaHb5zitmbHL9nA6EqG962x1TY
        ARLQyWqRBrwa6SakCgvqEcs=
X-Google-Smtp-Source: ABdhPJygvub6WI37v9jRgCUpw6u7jXnRPZMWCkUZMCNvzeBJZC214rp3izSEjbBa+HJuVcXwoexdVg==
X-Received: by 2002:a05:620a:142d:: with SMTP id k13mr33216765qkj.48.1626079940164;
        Mon, 12 Jul 2021 01:52:20 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p9sm5363507qtw.88.2021.07.12.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 01:52:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 39D3927C005B;
        Mon, 12 Jul 2021 04:52:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Jul 2021 04:52:19 -0400
X-ME-Sender: <xms:wgLsYON4MLwV3Udmlf_-WinBByALy566zzBwKkuKfqzF0JajJ5l7-g>
    <xme:wgLsYM-GeUAND0RJuFTr1f00OJNzcMHAUsw3Uqe0j_5_qOB5Lbf_Krl2HMHtdPwpc
    GrCutekwwY5bZ4HDA>
X-ME-Received: <xmr:wgLsYFS4EGNOsoiNrVwhMbcPYewk0HU5SVsEb1o8qZqgbtxNaQH7-v5fe_UglA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegudffjeelvddtgfejleekffeufeekkeehgeelkeetveeiieetteefheetvefh
    feenucffohhmrghinheplhifnhdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:wgLsYOtfDT5otZCqRqG4QxTW_GyJ92lFb7BuflPpZppHNWnI37gGeQ>
    <xmx:wgLsYGe9xuKMH_vpApjTC49FMDrcI7feeXDYW1PQ9BvJTSAef_GFfg>
    <xmx:wgLsYC3Lo4osWqf0-EsU0GeKc_GNzWqZluy_pp-1675aVM_cabCCaA>
    <xmx:wwLsYOTcibvn9DgM3t8DH2yys9K3tSCe7r3Gc78rw61ZJm5ojyER5Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jul 2021 04:52:17 -0400 (EDT)
Date:   Mon, 12 Jul 2021 16:50:44 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Xiongwei Song <sxwjean@gmail.com>
Cc:     Waiman Long <llong@redhat.com>, Xiongwei Song <sxwjean@me.com>,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/3] locking/lockdep: Fix false warning of
 check_wait_context()
Message-ID: <YOwCZEdRdS8MPFvY@boqun-archlinux>
References: <20210711141430.896595-1-sxwjean@me.com>
 <07878d21-fa4d-fbf5-a292-b71c48847a5e@redhat.com>
 <CAEVVKH_95TMa8RRChzG0ZzMdzx3gp7wWmbPnbUst3+mi8wFnBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEVVKH_95TMa8RRChzG0ZzMdzx3gp7wWmbPnbUst3+mi8wFnBg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 04:18:36PM +0800, Xiongwei Song wrote:
> On Mon, Jul 12, 2021 at 12:43 AM Waiman Long <llong@redhat.com> wrote:
> >
> > On 7/11/21 10:14 AM, Xiongwei Song wrote:
> > > From: Xiongwei Song <sxwjean@gmail.com>
> > >
> > > We now always get a "Invalid wait context" warning with
> > > CONFIG_PROVE_RAW_LOCK_NESTING=y, see the full warning below:
> > >
> > >       [    0.705900] =============================
> > >       [    0.706002] [ BUG: Invalid wait context ]
> > >       [    0.706180] 5.13.0+ #4 Not tainted
> > >       [    0.706349] -----------------------------
> >
> > I believe the purpose of CONFIG_PROVE_RAW_LOCK_NESTING is experimental
> > and it is turned off by default. Turning it on can cause problem as
> > shown in your lockdep splat. Limiting it to just PREEMPT_RT will defeat
> > its purpose to find potential spinlock nesting problem in non-PREEMPT_RT
> > kernel.
> As far as I know, a spinlock can nest another spinlock. In
> non-PREEMPT_RT kernel
> spin_lock and raw_spin_lock are same , so here acquiring a spin_lock in hardirq
> context is acceptable, the warning is not needed. My knowledge on this
> is not enough,
> Will dig into this.
> 

You may find this useful: https://lwn.net/Articles/146861/ ;-)

The thing is that most of the irq handlers will run in process contexts
in PREEMPT_RT kernel (threaded irq), while the rest continues to run in
hardirq contexts. spinlock_t is allowed int threaded irqs but not in
hardirq contexts for PREEMPT_RT, because spinlock_t will become
sleeplable locks.

Regards,
Boqun

> > The point is to fix the issue found,
> Agree. I thought there was a spinlock usage issue, but by checking
> deactivate_slab context,
> looks like the spinlock usage is well. Maybe I'm missing something?
> 
> > not hiding it from appearing.
> I'm not trying to hiding it, according to the code context, the fix is
> reasonable from my point of
> view. Let me check again.
> 
> Thank  you for the comments.
> 
> Regards,
> Xiongwei
> >
> > Cheers,
> > Longman
> >

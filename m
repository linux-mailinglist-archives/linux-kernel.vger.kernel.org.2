Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3563F43F9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 05:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhHWDg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 23:36:27 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43204
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230401AbhHWDg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 23:36:26 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Aug 2021 23:36:26 EDT
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1FA9440769
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629689212;
        bh=Cypx4Nn+r/dXMbYAm6m3pweXCOI+f20/ritVZIXiH5w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Jsci6frtugZ8MkyqcZOGV2KXbAVklW190pLFWDj9yyu/UCV0rMUhK1LsSEcob1UvT
         oQDsnCnGrkH/zr9xZLYMeNRoU70hDsMxkkGokF0WrG4UNLp3N7eqVD2UkbPtHFv8Sj
         y0KIemxtI0pgLXGcfr7x499Urmn6zh9pRh/H2wE/hsvikJVaE0z3PwEsWy5SjZWr/u
         +dWttxXFs/9m5cR+QtHo96yuTU4v6nofSjkpCMUbjZMziozunkHzrGBwZrb2JBGEFF
         bnCwL/PriUGoR0Z/O6XgiqiQDLKKBpZkidEQ0b6POQDk8GRD9TeJRQ+uAPm5zP3cAi
         7Ma/ivBTF/sNA==
Received: by mail-ed1-f72.google.com with SMTP id k13-20020aa7c04d000000b003bf04c03fc4so8075792edo.22
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 20:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cypx4Nn+r/dXMbYAm6m3pweXCOI+f20/ritVZIXiH5w=;
        b=JeNdkh+Y5KvMaaRCORFtDN8K12rr3mFg78HkuGuiy17+kuEzfNQkXOBBP7toMGhHbn
         nJkBPYHsokkTtSYOsDTh+HVKp9v+fvOw++aV+aqHYq/5/Tx5b4aGdeTyegmvB+/MzfZ3
         WJ4bDsNL0p55lca0XsK5+oFUNf9Qce917UvxbxoqWGeNaBaRE8nmyn7b273xeUR3KsEd
         sylkMQ/zzTPUoDJkchLq0E0ocZSyz2T2ggnY3JoEc6Ik0HB3mhFkXNpk/ZtbGJ6VyQec
         K6GPcsTuzdTYsVFQmy395aMM3N9sPOf3QCaE+W9X0CDRYRWolSsmzLC3DNWp545rywdO
         euvQ==
X-Gm-Message-State: AOAM532W22gxc9Y75hx96tZO83yenqMsztrwXN9nmwXUKu72FaQC0b0z
        OUdCwrNAayHX1bb1JT+HF90DLFG8O8PeNIQJaOmqGT+Ww9Z7eMzrBCSYyUGlPF16m5wffzGzyZ4
        9scYIRwV0ScSUWlXZaXfUtqFnR7Nzw2hdG27j+Uu9vCRycf3WncZsliyldA==
X-Received: by 2002:a50:ec0e:: with SMTP id g14mr33889318edr.157.1629689211633;
        Sun, 22 Aug 2021 20:26:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4NaD5EZD9YyEnnx2kyjQZGtgZgz1h2jLXjJib7TrkVr6SsYEOZKkJx63kjgOlyjTzaPjSSrkTRMU5zwF+7Eo=
X-Received: by 2002:a50:ec0e:: with SMTP id g14mr33889314edr.157.1629689211456;
 Sun, 22 Aug 2021 20:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210809032809.1224002-1-acelan.kao@canonical.com>
 <YRDCcDZGVkCdNF34@unreal> <CAFv23Qn=c_EZNPxu90s0n-HB6_vQCqaUG34YAq7-T6Np+10ZUA@mail.gmail.com>
 <YRIl0WKm+n8EZjlk@unreal>
In-Reply-To: <YRIl0WKm+n8EZjlk@unreal>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Mon, 23 Aug 2021 11:26:40 +0800
Message-ID: <CAFv23Q=Ue3kupfvMm2AnGP9iHXkpjpsCzzD36Ohd=SAGC=rzNg@mail.gmail.com>
Subject: Re: [RESEND][PATCH] net: called rtnl_unlock() before runpm resumes devices
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Antoine Tenart <atenart@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Wei Wang <weiwan@google.com>, Taehee Yoo <ap420073@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Romanovsky <leon@kernel.org> =E6=96=BC 2021=E5=B9=B48=E6=9C=8810=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Aug 10, 2021 at 09:57:57AM +0800, AceLan Kao wrote:
> > Leon Romanovsky <leon@kernel.org> =E6=96=BC 2021=E5=B9=B48=E6=9C=889=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:51=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Aug 09, 2021 at 11:28:09AM +0800, AceLan Kao wrote:
> > > > From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> > > >
> > > > The rtnl_lock() has been called in rtnetlink_rcv_msg(), and then in
> > > > __dev_open() it calls pm_runtime_resume() to resume devices, and in
> > > > some devices' resume function(igb_resum,igc_resume) they calls rtnl=
_lock()
> > > > again. That leads to a recursive lock.
> > > >
> > > > It should leave the devices' resume function to decide if they need=
 to
> > > > call rtnl_lock()/rtnl_unlock(),
> > >
> > > Why? It doesn't sound right that drivers internally decide if to take=
 or
> > > release some external to them lock without seeing full picture.
> > From what I observed, this is the only calling path that acquired
> > rtnl_lock() before calling drivers' resume function.
> > So, it encounters recursive lock while driver is going to cal rtnl_lock=
() again.
>
> I clearly see the problem, but don't agree with a solution.
>
> >
> > >
> > > Most of the time, device driver authors do it wrong. I afraid that ig=
s
> > > is one of such drivers that did it wrong.
> > The issues could be if we remove rtnl_lock in device drivers, then in
> > other calling path, it won't be protected by the rtnl lock,
> > and maybe we shouldn't call pm_runtime_resume() here(within rtnl
> > lock), for device drivers don't know if they are protected by the rtnl
> > lock while their resume() got called.
>
> This is exactly the problem, every driver guesses if rtnl_lock is needed
> or not in specific path. It is wrong by design. You should ensure that
> all paths that are triggered through rtnl should hold rtnl_lock.
Hi Jesse, Tony,

As you are the Intel Ethernet drivers' maintainers, do you have any
idea about this?
We can reproduce this issue on the machine with PCI Ethernet card
using igb or igc driver.

>
> You dropped rtnl_lock() without any protection, it is 100% bug.
>
> Thanks
>
> >
> > >
> > > Thanks
> > >
> > > > so call rtnl_unlock() before calling pm_runtime_resume() and then c=
all
> > > > rtnl_lock() after it in __dev_open().
> > > >
> > > > [  967.723577] INFO: task ip:6024 blocked for more than 120 seconds=
.
> > > > [  967.723588]       Not tainted 5.12.0-rc3+ #1
> > > > [  967.723592] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
> > > > [  967.723594] task:ip              state:D stack:    0 pid: 6024 p=
pid:  5957 flags:0x00004000
> > > > [  967.723603] Call Trace:
> > > > [  967.723610]  __schedule+0x2de/0x890
> > > > [  967.723623]  schedule+0x4f/0xc0
> > > > [  967.723629]  schedule_preempt_disabled+0xe/0x10
> > > > [  967.723636]  __mutex_lock.isra.0+0x190/0x510
> > > > [  967.723644]  __mutex_lock_slowpath+0x13/0x20
> > > > [  967.723651]  mutex_lock+0x32/0x40
> > > > [  967.723657]  rtnl_lock+0x15/0x20
> > > > [  967.723665]  igb_resume+0xee/0x1d0 [igb]
> > > > [  967.723687]  ? pci_pm_default_resume+0x30/0x30
> > > > [  967.723696]  igb_runtime_resume+0xe/0x10 [igb]
> > > > [  967.723713]  pci_pm_runtime_resume+0x74/0x90
> > > > [  967.723718]  __rpm_callback+0x53/0x1c0
> > > > [  967.723725]  rpm_callback+0x57/0x80
> > > > [  967.723730]  ? pci_pm_default_resume+0x30/0x30
> > > > [  967.723735]  rpm_resume+0x547/0x760
> > > > [  967.723740]  __pm_runtime_resume+0x52/0x80
> > > > [  967.723745]  __dev_open+0x56/0x160
> > > > [  967.723753]  ? _raw_spin_unlock_bh+0x1e/0x20
> > > > [  967.723758]  __dev_change_flags+0x188/0x1e0
> > > > [  967.723766]  dev_change_flags+0x26/0x60
> > > > [  967.723773]  do_setlink+0x723/0x10b0
> > > > [  967.723782]  ? __nla_validate_parse+0x5b/0xb80
> > > > [  967.723792]  __rtnl_newlink+0x594/0xa00
> > > > [  967.723800]  ? nla_put_ifalias+0x38/0xa0
> > > > [  967.723807]  ? __nla_reserve+0x41/0x50
> > > > [  967.723813]  ? __nla_reserve+0x41/0x50
> > > > [  967.723818]  ? __kmalloc_node_track_caller+0x49b/0x4d0
> > > > [  967.723824]  ? pskb_expand_head+0x75/0x310
> > > > [  967.723830]  ? nla_reserve+0x28/0x30
> > > > [  967.723835]  ? skb_free_head+0x25/0x30
> > > > [  967.723843]  ? security_sock_rcv_skb+0x2f/0x50
> > > > [  967.723850]  ? netlink_deliver_tap+0x3d/0x210
> > > > [  967.723859]  ? sk_filter_trim_cap+0xc1/0x230
> > > > [  967.723863]  ? skb_queue_tail+0x43/0x50
> > > > [  967.723870]  ? sock_def_readable+0x4b/0x80
> > > > [  967.723876]  ? __netlink_sendskb+0x42/0x50
> > > > [  967.723888]  ? security_capable+0x3d/0x60
> > > > [  967.723894]  ? __cond_resched+0x19/0x30
> > > > [  967.723900]  ? kmem_cache_alloc_trace+0x390/0x440
> > > > [  967.723906]  rtnl_newlink+0x49/0x70
> > > > [  967.723913]  rtnetlink_rcv_msg+0x13c/0x370
> > > > [  967.723920]  ? _copy_to_iter+0xa0/0x460
> > > > [  967.723927]  ? rtnl_calcit.isra.0+0x130/0x130
> > > > [  967.723934]  netlink_rcv_skb+0x55/0x100
> > > > [  967.723939]  rtnetlink_rcv+0x15/0x20
> > > > [  967.723944]  netlink_unicast+0x1a8/0x250
> > > > [  967.723949]  netlink_sendmsg+0x233/0x460
> > > > [  967.723954]  sock_sendmsg+0x65/0x70
> > > > [  967.723958]  ____sys_sendmsg+0x218/0x290
> > > > [  967.723961]  ? copy_msghdr_from_user+0x5c/0x90
> > > > [  967.723966]  ? lru_cache_add_inactive_or_unevictable+0x27/0xb0
> > > > [  967.723974]  ___sys_sendmsg+0x81/0xc0
> > > > [  967.723980]  ? __mod_memcg_lruvec_state+0x22/0xe0
> > > > [  967.723987]  ? kmem_cache_free+0x244/0x420
> > > > [  967.723991]  ? dentry_free+0x37/0x70
> > > > [  967.723996]  ? mntput_no_expire+0x4c/0x260
> > > > [  967.724001]  ? __cond_resched+0x19/0x30
> > > > [  967.724007]  ? security_file_free+0x54/0x60
> > > > [  967.724013]  ? call_rcu+0xa4/0x250
> > > > [  967.724021]  __sys_sendmsg+0x62/0xb0
> > > > [  967.724026]  ? exit_to_user_mode_prepare+0x3d/0x1a0
> > > > [  967.724032]  __x64_sys_sendmsg+0x1f/0x30
> > > > [  967.724037]  do_syscall_64+0x38/0x90
> > > > [  967.724044]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > >
> > > > Fixes: bd869245a3dc ("net: core: try to runtime-resume detached dev=
ice in __dev_open")
> > > > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > > > ---
> > > >  net/core/dev.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index 8f1a47ad6781..dd43a29419fd 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -1585,8 +1585,11 @@ static int __dev_open(struct net_device *dev=
, struct netlink_ext_ack *extack)
> > > >
> > > >       if (!netif_device_present(dev)) {
> > > >               /* may be detached because parent is runtime-suspende=
d */
> > > > -             if (dev->dev.parent)
> > > > +             if (dev->dev.parent) {
> > > > +                     rtnl_unlock();
> > > >                       pm_runtime_resume(dev->dev.parent);
> > > > +                     rtnl_lock();
> > > > +             }
> > > >               if (!netif_device_present(dev))
> > > >                       return -ENODEV;
> > > >       }
> > > > --
> > > > 2.25.1
> > > >

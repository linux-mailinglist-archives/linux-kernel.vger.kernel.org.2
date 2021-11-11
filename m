Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5644D6F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhKKNC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:02:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232918AbhKKNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636635577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mYNth8yGw4v927g+Vg3jQS/EjAzZzl56c0iIAAHcboA=;
        b=eXDLeTeMqni1bDwiXc/desfd8V4U6WLWrRkhmn0QJ4LrCTgldTn+l6VVgrQ7ZzGZ6lJFjW
        ruqV39YH2N4eLkwgTbLW++SuobXBYot2oX45qgECpk5KXRvvwwjE2+u+vVJ6ZXq+p7rp8m
        c8JDC4eNGkfpXM2v+gayk1IgXj1Pqgo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-0MwPjN7nO7Stp0sieKFxhQ-1; Thu, 11 Nov 2021 07:59:35 -0500
X-MC-Unique: 0MwPjN7nO7Stp0sieKFxhQ-1
Received: by mail-yb1-f197.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so9065089ybe.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 04:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYNth8yGw4v927g+Vg3jQS/EjAzZzl56c0iIAAHcboA=;
        b=YTZ5DOjVEPFIrOPNF2R52Dq2lDyVkSpVVBNZu3lAy9vrwhFZ9fXCAGmW3Ce74njZtb
         so15tcdxqVzgohuDYurM5Hty9/Ipb4/KEpUzKVDK8zD/3NwNEkUs1Q8xKuo0auScTMgN
         SLeEZQhJzGXKCgHBDTiEkWyQpIW69GtX8BHs5LcpUqqZVEdnQglrBwtjclzXHweraAlg
         o7TV3J+sQOWjIWeBnR6vN5q2nCApejqblGhPPr9emp+gJFVG7xrRYDLJAX0XjTTc6A4i
         tpqMHleXD8RUH+PhXcYMGRiJO85vqWOgLmuE06Yn3qAagEbNMy2/rwLVmSSMtDbZ5q6c
         mFnQ==
X-Gm-Message-State: AOAM532fyo9wJPRUxm6eXp3Z1tIJRdrujO1+h1HoPkngTT8POrs7O13/
        Ii3XaElht9/S2mLQYNy62zEvAq82ws5Im4wYes7bx1qy13z94uiu3iLiIaLA8vvzv9z8lMLNwfO
        LtHdQQSpCoaictudxMz5sxRy3Vs+7zLM+Fdp/dRZk
X-Received: by 2002:a25:8205:: with SMTP id q5mr8471173ybk.256.1636635575357;
        Thu, 11 Nov 2021 04:59:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIi/1Svow6TT4OfOYjhTxQ7Cq1Y11nySt5jkdv4wavlrbMpPNIHMsXQc5bQLOFe91kCQ+8oGm16aGVLrXvy24=
X-Received: by 2002:a25:8205:: with SMTP id q5mr8471141ybk.256.1636635575185;
 Thu, 11 Nov 2021 04:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20211104195949.135374-1-omosnace@redhat.com> <20211109062140.2ed84f96@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAHC9VhTVNOUHJp+NbqV5AgtwR6+3V6am0SKGKF0CegsPqjQ8pw@mail.gmail.com>
In-Reply-To: <CAHC9VhTVNOUHJp+NbqV5AgtwR6+3V6am0SKGKF0CegsPqjQ8pw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 11 Nov 2021 13:59:23 +0100
Message-ID: <CAFqZXNuct_T-SkvoRg2n7+ye0--OkMJ_gS31V-t3Cm+Yy7FhxQ@mail.gmail.com>
Subject: Re: [PATCH net] selinux: fix SCTP client peeloff socket labeling
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 4:00 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Nov 9, 2021 at 9:21 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > On Thu,  4 Nov 2021 20:59:49 +0100 Ondrej Mosnacek wrote:
> > > As agreed with Xin Long, I'm posting this fix up instead of him. I am
> > > now fairly convinced that this is the right way to deal with the
> > > immediate problem of client peeloff socket labeling. I'll work on
> > > addressing the side problem regarding selinux_socket_post_create()
> > > being called on the peeloff sockets separately.
> >
> > IIUC Paul would like to see this part to come up in the same series.
>
> Just to reaffirm the IIUC part - yes, your understanding is correct.

The more I'm reading these threads, the more I'm getting confused...
Do you insist on resending the whole original series with
modifications? Or actual revert patches + the new patches? Or is it
enough to revert/resend only the patches that need changes? Do you
also insist on the selinux_socket_post_create() thing to be fixed in
the same series? Note that the original patches are still in the
net.git tree and it doesn't seem like Dave will want to rebase them
away, so it seems explicit reverting is the only way to "respin" the
series...

Regardless of the answers, this thing has rabbithole'd too much and
I'm already past my free cycles to dedicate to this, so I think it
will take me (and Xin) some time to prepare the corrected and
re-documented patches. Moreover, I think I realized how to to deal
with the peer_secid-vs.-multiple-assocs-on-one-socket problem that Xin
mentions in patch 4/4, fixing which can't really be split out into a
separate patch and will need some test coverage, so I don't think I
can rush this up at this point... In the short term, I'd suggest
either reverting patches 3/4 and 4/4 (which are the only ones that
would need re-doing; the first two are good changes on their own) or
leaving everything as is (it's not functionally worse than what we had
before...) and waiting for the proper fixes.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B138D4390A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhJYH6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhJYH6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635148550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HaP6doBxD9Jv1Cm2ztaSXVICaEyRQuexJoV+q8tgM3o=;
        b=RJFirYdi9Iiy0peCLi1yuNmTkUFEe3AWgEBSpnfpvD2mjW8SJBzARKAtFCYiZz7BaGEicJ
        N9P5QGiJYyg2KhhNDtVTJak434gAcVpJhtKQgyiM/r5fQywfjk/yOmd4i7b+/yuIfg2bdf
        8jifkyvkqGvkjngje2pc/njdI4g2a14=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-b-rEmMgEMGGmnzr76_3hhg-1; Mon, 25 Oct 2021 03:55:47 -0400
X-MC-Unique: b-rEmMgEMGGmnzr76_3hhg-1
Received: by mail-yb1-f199.google.com with SMTP id s4-20020a252c04000000b005be94057849so16034443ybs.21
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 00:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaP6doBxD9Jv1Cm2ztaSXVICaEyRQuexJoV+q8tgM3o=;
        b=c+z0CDmUrkRZ461380G1lpbCAYGeaODWBh3lk4VEjDc50wt+3HrzWKTRa8cQ1zk2PW
         Dkh/tGCdYgpGeIGaKPy8CyB1PW3cdcjTehEJB+z4fjDPh2k94lo7i39Sifdca9xxcDYa
         LMAwVZ3WG9O9UG3WtObxrH7+jwWMqbahoS6uwiVRXTMz78qw4ugNDEkmi7h8E7XUMdjc
         L8YPk4b3QiEh7w9sdPdmqo7yR80SKnwyHEykwCRCw5hpRmJb0q7oq5j6hT9qGA8zP65w
         jCE87O8uxVo02xlrl4bbYNSlwhRCPjtw2VrYt12Gi8iwZN+OwsydAtKYNvfBsRSbOjUT
         fRAg==
X-Gm-Message-State: AOAM532KStq4+cKYHEpTBN5C6lNuvuKcNktQUgRWvxNIRIz7ZDtDhCKQ
        zRkyNcAMYe6ek4AOEAe7tsLZjBW9iLq0kJBle460zqqXlBycg/TLoYA6xA4emdK5l5PrhtipW9B
        hcjFEMBevDFC1hiBMBec5YXtHI9UHG+szbjD7Mz4q
X-Received: by 2002:a25:3b16:: with SMTP id i22mr16104536yba.467.1635148547339;
        Mon, 25 Oct 2021 00:55:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQw0oj27SWyE9xLBVuhd8Wl9gLIz3ENrF6wNdaHq8P1pN33qBVs/7UZHdeiuqKxnM8N6EFqfHGvFU6FiORm38=
X-Received: by 2002:a25:3b16:: with SMTP id i22mr16104517yba.467.1635148547139;
 Mon, 25 Oct 2021 00:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211021153846.745289-1-omosnace@redhat.com> <YXGNZTJPxL9Q/GHt@t14s.localdomain>
 <CADvbK_eHsAjih9bAiH3d2cwkaizuYnn6gL85V6LdpWUrenMAxg@mail.gmail.com>
In-Reply-To: <CADvbK_eHsAjih9bAiH3d2cwkaizuYnn6gL85V6LdpWUrenMAxg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Oct 2021 09:55:36 +0200
Message-ID: <CAFqZXNuPwbwTD4KqQfc1+RtLswR3a=j4aFMYPf7rnxkkZMLvMA@mail.gmail.com>
Subject: Re: [PATCH] sctp: initialize endpoint LSM labels also on the client side
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 8:33 AM Xin Long <lucien.xin@gmail.com> wrote:
> On Thu, Oct 21, 2021 at 11:55 PM Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> >
> > On Thu, Oct 21, 2021 at 05:38:46PM +0200, Ondrej Mosnacek wrote:
> > > The secid* fields in struct sctp_endpoint are used to initialize the
> > > labels of a peeloff socket created from the given association. Currently
> > > they are initialized properly when a new association is created on the
> > > server side (upon receiving an INIT packet), but not on the client side.
> >
> > +Cc Xin
> Thanks Marcelo,
>
> security_sctp_assoc_request() is not supposed to call on the client side,
> as we can see on TCP. The client side's labels should be set to the
> connection by selinux_inet_conn_request(). But we can't do it based
> on the current hooks.
>
> The root problem is that the current hooks incorrectly treat sctp_endpoint
> in SCTP as request_sock in TCP, while it should've been sctp_association.
> We need a bigger change on the current security sctp code.
>
> I will post the patch series in hand, please take a look.

Thanks, your patches indeed seem to do the right thing and they also
do pass selinux-testsuite with the added client peeloff tests (as also
confirmed by Richard already). I have just a few minor comments, which
I'll send as replies to the individual patches.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


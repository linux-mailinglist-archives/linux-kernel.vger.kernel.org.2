Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF24D4090C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbhIMNzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242516AbhIMNwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631541061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBjIIvcb5dunWtRsVviIpL9DBOBpPMCvEHR7NyeCpew=;
        b=R0ZsdT0X/e6yWi8hCQWcVjAFz8l2CrvK3wqJ78Tb71MEtKPNYNW0OAMVEMcMH3fgG83O2j
        0knf+w5c5WdnZQHMcc1QZlQRIimVR9PEAshGtaPm6WVqDr5L/YfoI17EMBbKFiOwb7fNDw
        eOKhxJJqrQgrg7iKv3SINShLIRQ52Qw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-SQnitZwrMSCZ5aSgZsu2IA-1; Mon, 13 Sep 2021 09:50:42 -0400
X-MC-Unique: SQnitZwrMSCZ5aSgZsu2IA-1
Received: by mail-yb1-f199.google.com with SMTP id v66-20020a25abc8000000b0059ef57c3386so13044845ybi.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aBjIIvcb5dunWtRsVviIpL9DBOBpPMCvEHR7NyeCpew=;
        b=DsnW4cvtA6xpIgt4s0DkHMO05+dSqRhM6TTgI3OsHhnsVgLCyXRvhSB6V7Usrbkbfr
         LvMx59peZQERA66c+7ypvxBfKNC7AhP4n5HFXDPfLo1ZJWusRRlbKqYdqrE5zZ4jPP4p
         f2MYTwXrw44ZmmzZx9os5CF2sElZgVNoHgBLd/m+x3HdEdrI+Wp0SauLhL2wdEw4LlXe
         tsmn+D81u3a3y+mRuh7n+W0v8wHjrYMp/g8Ek0hrGyAREzl7eozs1GIgUWxWwKFUBNuv
         AefIZpsJ07r/pb57xoeBwQyVYPYiyYuV2ToVzvSGxTLX030Agb37A466P+tUNQUd+yWb
         whzw==
X-Gm-Message-State: AOAM5331XhlxsyOMrh7UCZN+vNJlEBs1MiM2536q0ftGZQgVg3yxvw05
        Azeamo8NyZy1E/b4hGbJOPb/9qZxhSKg6fsoZXZGDEOjjMc/8GqQVO8Dp5c9BOnfuKd+zBrVl0I
        n2y3BR4SYVhcwhN+0XtuwAfStWZuOMeKQXUpaPjxy
X-Received: by 2002:a25:6913:: with SMTP id e19mr15482530ybc.25.1631541032785;
        Mon, 13 Sep 2021 06:50:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaynW83umBqEPokVSSibnO6NtuWoQhuE0RyA2lBp5gkMZ2HjvBKRYnpKQf1MqN054h1RGdfDAUtNC2myJBoIU=
X-Received: by 2002:a25:6913:: with SMTP id e19mr15482493ybc.25.1631541032487;
 Mon, 13 Sep 2021 06:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210912122234.GA22469@asgard.redhat.com> <CAFqZXNtmN9827MQ0aX7ZcUia5amXuZWppb-9-ySxVP0QBy=O8Q@mail.gmail.com>
 <20210913102316.GA30886@asgard.redhat.com>
In-Reply-To: <20210913102316.GA30886@asgard.redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 13 Sep 2021 15:50:21 +0200
Message-ID: <CAFqZXNsp84kFLDfJfdu5fboB8vMm85FU7BDDjpiqeiJ2WSjWAg@mail.gmail.com>
Subject: Re: [PATCH v2] include/uapi/linux/xfrm.h: Fix XFRM_MSG_MAPPING ABI breakage
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Antony Antony <antony.antony@secunet.com>,
        Christian Langrock <christian.langrock@secunet.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        network dev <netdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@strace.io>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 12:23 PM Eugene Syromiatnikov <esyr@redhat.com> wro=
te:
> On Mon, Sep 13, 2021 at 09:16:39AM +0200, Ondrej Mosnacek wrote:
> > Perhaps it would be a good idea to put a comment here to make it less
> > likely that this repeats in the future. Something like:
> >
> > /* IMPORTANT: Only insert new entries right above this line, otherwise
> > you break ABI! */
>
> Well, this statement is true for (almost) every UAPI-exposed enum, and
> netlink is vast and relies on enums heavily.  I think it is already
> mentioned somewhere in the documentation, and in the end it falls on the
> shoulders of the maintainers=E2=80=94to pay additional attention to UAPI =
changes.

Ok, fair enough.

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34474296BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhJKSXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231756AbhJKSXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633976465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ohyIViGl1QdCfoc0LpU/AMXi6YFfnwDVF+4zmqvqVyg=;
        b=T0vfigrLyLJLfIi65TSqS/GvUJxNIktuo+xjT5PdjHmTg3hDs6Dk4HqRB2p2SxC/94L2x0
        tQKVk5bC06wm5ZoBqHEfSM8vc7SK5xUm96uPzDge0HohsyU1e5lrTftnAJYIJ064uXcncJ
        vEX2OoNU+WufrkYjPnqCcFUAf0SVX78=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-0T7ZFfT2OkiRnGYkF5Bqlg-1; Mon, 11 Oct 2021 14:21:04 -0400
X-MC-Unique: 0T7ZFfT2OkiRnGYkF5Bqlg-1
Received: by mail-yb1-f198.google.com with SMTP id y16-20020a2586d0000000b005b752db8f97so24064810ybm.18
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohyIViGl1QdCfoc0LpU/AMXi6YFfnwDVF+4zmqvqVyg=;
        b=SftZGTqPtQCf9aH9yjkMvkK3PlmlkxUxNW01h0aeqbC7pHmIw7I9RAbeooX4nt10Gp
         4/vmScY4D+KQBhQESrteoDoNDa7TNdjsEoB9cFFY/Wy0JUCMxCZjXQIqgFU+YCMPi00q
         AQ3vLF7KHh0JlEymlUtV4sVlrccpcjaXA9PRSHbWa8In6FOIDizppO8z8JNWeIaz+dmF
         XE/3cAnYviIPSo3g01ByjUGFOCclcGtpqdBlrOLy7jwtB62ujFm/iPDVNH73eoQHt7x0
         q72OxDXUfI2ZAPmY7OqHk8dJE1H6BM+YRItkz2F6Y7Vds0VcTih8JMBSmsCQYS7PghtD
         ijbw==
X-Gm-Message-State: AOAM531MO25wH1JRPy+P7tge5ofgFGa9dbIzj+Y2XTiDLcX3XRiFZ5lR
        lEPdh9+NNEVTw3VSMFP7zqduhTa4bbxpPDIQ5aPpfVewMWywBHvi3b4bNR+1AthoSZ84VkXrC04
        QNUIPAUeX02j/+CNlzk8A94nuRMea2fPQIOKox/B1
X-Received: by 2002:a25:2e01:: with SMTP id u1mr15371699ybu.363.1633976464003;
        Mon, 11 Oct 2021 11:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMqltzBWSwS35cooO86q7dmgQ4fXEyQmCNC8yxgopUWT43s9eRMelqFxm40Ko0isnyBLw3opotjhPpJyi6x+M=
X-Received: by 2002:a25:2e01:: with SMTP id u1mr15371670ybu.363.1633976463738;
 Mon, 11 Oct 2021 11:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211011142416.26798-1-fw@strlen.de> <CAHC9VhRBYMMSucVbqUkcWTtyeuJ7SSuzDED=Cg=svWiaByo3Qw@mail.gmail.com>
In-Reply-To: <CAHC9VhRBYMMSucVbqUkcWTtyeuJ7SSuzDED=Cg=svWiaByo3Qw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 11 Oct 2021 20:20:51 +0200
Message-ID: <CAFqZXNvHitBVyDga2CO2WAdxFwhY44xXoLkvmvVsPNGwqSe5zw@mail.gmail.com>
Subject: Re: [PATCH v2 selinux] selinux: remove unneeded ipv6 hook wrappers
To:     Paul Moore <paul@paul-moore.com>
Cc:     Florian Westphal <fw@strlen.de>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 7:10 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Oct 11, 2021 at 10:25 AM Florian Westphal <fw@strlen.de> wrote:
> >
> > Netfilter places the protocol number the hook function is getting called
> > from in state->pf, so we can use that instead of an extra wrapper.
> >
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> >  v2: add back '#endif /* CONFIG_NETFILTER */' erronously axed in v1.
> >  Applies to 'next' branch of
> >  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/
> >
> >  security/selinux/hooks.c | 52 ++++++++++------------------------------
> >  1 file changed, 12 insertions(+), 40 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index e7ebd45ca345..831b857d5dd7 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -7470,38 +7442,38 @@ DEFINE_LSM(selinux) = {
> >
> >  static const struct nf_hook_ops selinux_nf_ops[] = {
> >         {
> > -               .hook =         selinux_ipv4_postroute,
> > +               .hook =         selinux_hook_postroute,
> >                 .pf =           NFPROTO_IPV4,
> >                 .hooknum =      NF_INET_POST_ROUTING,
> >                 .priority =     NF_IP_PRI_SELINUX_LAST,
> >         },
>
> Thanks for the patch Florian, although the name "selinux_hook_*" seems
> a bit ambiguous to me, after all we have a little more than 200
> "hooks" in the SELinux LSM implementation.  Would you be okay with
> calling the netfilter hook functions "selinux_nf_*" or something
> similar?  If you don't have time I can do the rename during the merge
> assuming we can all agree on a name.

Since selinux_ip_forward() and selinux_ip_postroute() are used only in
the hook functions, how about changing their signature and using them
as hooks directly? That would solve the naming and also remove a few
extra lines of boilerplate.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


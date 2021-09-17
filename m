Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C9C41006E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhIQUzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232556AbhIQUzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631912029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8EWbBFRzqn+CDnvlJz5qcZT7fMT6Nw9+JVYnR+B85b8=;
        b=Qtazm53bD1rj62mLjNEyE5Uio6JW0c160v7EqbmBq2tXeIw3roLe9em7IJcogj3oVyvFGZ
        dt6RwsAbJ1yoqY7jLDZN86m2yL3HUoWA2DX13PZklTKsWPT/BnBlh6ku4XGukRAH4Qp+fH
        r7LXEn8QpByY3YRPjXE98NPeu1FVwaQ=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-f6HfXWWtNpq_T1nFnPJ_ew-1; Fri, 17 Sep 2021 16:53:48 -0400
X-MC-Unique: f6HfXWWtNpq_T1nFnPJ_ew-1
Received: by mail-il1-f199.google.com with SMTP id f13-20020a056e02168d00b002244a6aa233so23734046ila.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8EWbBFRzqn+CDnvlJz5qcZT7fMT6Nw9+JVYnR+B85b8=;
        b=xa1bDHht3rQFYrx0oM27sDScvTGtd9lo+enSBZuvlGk1IdKKdWU09dsgBOHi5Be+xg
         4t2EcmHz9hYmstL5vIt8JnhwGROU/GjAtWQnsKJrJypoOQ+fP8S8ptR0lVXC/RTCampR
         Yn0O/2aS/vyQ85ePhMbSF2UujdOweQtXo44V7J6v+l1m3kYwX3NENV+myM3eYdWc0hSS
         02EK2ikVbBGK4QqOQLxBTV58ZkUhg4zRLsJvQ9/ko80QVKkc6jAc1UIIvZZQ2UlRYFgk
         ae1CzgCUSFSvOCh80HzdSECsYGVIliGalcAzLMHNSaffoKgPA5aLeH2JmDJp2FgWIPC8
         AnSQ==
X-Gm-Message-State: AOAM532pq9Vqxvyqgw2QS3lJJiTewoi5OqVEGzHrHSqMdISVvhcdkTCx
        MDOsel7z5syTdl4bLweVyCJ+midKm98FHs6i8pep55I4CKiQTgKPMhTVUv634HD9qqwdAlrqqFJ
        +gnl+2VJ6IQqGDcp/FsHn5ErD
X-Received: by 2002:a02:6043:: with SMTP id d3mr9052584jaf.127.1631912027040;
        Fri, 17 Sep 2021 13:53:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9q5X+AjYh1s/BEQkwddLJb9bdzZfTEh23K5SUpGpNdb4d0D6r/xx3i+FMB15F9hn+KggqPw==
X-Received: by 2002:a02:6043:: with SMTP id d3mr9052574jaf.127.1631912026714;
        Fri, 17 Sep 2021 13:53:46 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id b1sm4165003ilf.43.2021.09.17.13.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 13:53:46 -0700 (PDT)
Date:   Fri, 17 Sep 2021 15:53:41 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>, Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] Documentation: dyndbg: Improve cli param examples
Message-ID: <20210917205341.5bayndskygan6qrd@halaneylaptop>
References: <20210913222440.731329-1-ahalaney@redhat.com>
 <20210913222440.731329-4-ahalaney@redhat.com>
 <ff05cae4-8fa7-d1b6-795e-3bd85316774d@akamai.com>
 <CAJfuBxzrJwr17-RWZzhw90pKXZ1hL5kepuzvt1Di=JyekMJf4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxzrJwr17-RWZzhw90pKXZ1hL5kepuzvt1Di=JyekMJf4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 02:30:09PM -0600, jim.cromie@gmail.com wrote:
> On Fri, Sep 17, 2021 at 1:50 PM Jason Baron <jbaron@akamai.com> wrote:
> >
> >
> >
> > On 9/13/21 6:24 PM, Andrew Halaney wrote:
> > > Jim pointed out that using $module.dyndbg= is always a more flexible
> > > choice for using dynamic debug on the command line. The $module.dyndbg
> > > style is checked at boot and handles if $module is a builtin. If it is
> > > actually a loadable module, it is handled again later when the module is
> > > loaded.
> > >
> > > If you just use dyndbg="module $module +p" dynamic debug is only enabled
> > > when $module is a builtin.
> > >
> > > It was recommended to illustrate wildcard usage as well.
> > >
> > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > Suggested-by: Jim Cromie <jim.cromie@gmail.com>
> > > ---
> > >   Documentation/admin-guide/dynamic-debug-howto.rst | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> > > index d0911e7cc271..4bfb23ed64ec 100644
> > > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> > > @@ -357,7 +357,10 @@ Examples
> > >     Kernel command line: ...
> > >       // see whats going on in dyndbg=value processing
> > >       dynamic_debug.verbose=1
> > > -    // enable pr_debugs in 2 builtins, #cmt is stripped
> > > -    dyndbg="module params +p #cmt ; module sys +p"
> > > +    // Enable pr_debugs in the params builtin
> > > +    params.dyndbg="+p"
> >
> > If we are going out of our way to change this to indicate that it works
> > for builtin and modules, it seems like the comment above should reflect
> > that? IE, something like this?
> >
> > '// Enable pr_debugs in the params module or if params is builtin.
> >
> 
> I dont think params can be a loadable module, so its not a great
> example of this.
> it should be one that "everyone" knows is usually loaded.
> 
> conversely, bare dyndbg example should have only builtin modules,
> then the contrast between 2 forms is most evident.
> 

Thank you both for the feedback, good points.

Does something like:

    // Enable pr_debugs in the btrfs module (can be builtin or loadable)
    btrfs.dyndbg="+p"
    // enable pr_debugs in all files under init/
    // and the function parse_one, #cmt is stripped
    dyndbg="file init/* +p #cmt ; func parse_one +p"

Work for you both? I think that makes the advantages of $module.dyndbg=
more clear and makes the usage of dyndbg= stick to strictly builtins.
If so I'll respin this patch in v3 of the series.

Thanks,
Andrew

> 
> > The first two patches look fine to me, so if you agree maybe just
> > re-spin this one?
> >
> > Thanks,
> >
> > -Jason
> >
> > > +    // enable pr_debugs in all files under init/
> > > +    // and the function pc87360_init_device, #cmt is stripped
> > > +    dyndbg="file init/* +p #cmt ; func pc87360_init_device +p"
> > >       // enable pr_debugs in 2 functions in a module loaded later
> > >       pc87360.dyndbg="func pc87360_init_device +p; func pc87360_find +p"
> >
> 


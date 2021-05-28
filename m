Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00383394641
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbhE1RQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhE1RQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:16:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB0CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:14:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so2910809pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jdSDHqrpODkjWfBbbyG6vrMb009iDQOh1kwEFeMeXVQ=;
        b=JqDww1mmvzIwNQsCG0aunTaF8NLcrJ0Ibo9IfukAcFtkxDz1RT+h5IH3I6n61mpYfV
         SBce2TSfwOSlKsp8BgY0uPzalxWGBM9cXO2qx7/jvVFNOMnmjjKy6gRG0j0CS+CQCQCK
         gDT+Y/5uMTCjknH3QY1BFZiEHumHYubymuQ2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jdSDHqrpODkjWfBbbyG6vrMb009iDQOh1kwEFeMeXVQ=;
        b=r0Op3exMW8wyBIf4ib1/gGurFyWStuJ5KQ8fNmn1glJwV/vhWA+PrIgQtEyTPMQTKl
         EMkAdSOzNLwV6ZTRcERXOVu7UBid1xtiSyNrEvSbvN3aBqIIkcCCyChyFMolhYv4FsIq
         Tad3zY3vp7hbBJ2zWu/H4Z3kn2d57trvidBaikgt0CPY7JDZ8NO3uhwxEPcuWo0dGK7o
         X68ZY01rIIB7XVqEvpwF31bpja8pPwq1n8fwGWo3mY4nAE52HsiIZIzi34pNwy98HGe4
         ynvB1rpMRzV+7NVc9E8xdMyokGC7CKPgNQn3lhPKwWO2vBJ4MN8mhJEwh0ec3/NGjq4I
         MUVA==
X-Gm-Message-State: AOAM5319AOi0zSqM1fKb07pfOm4D7QG98mTfs6DeT9hJkzjribb8UAvy
        v6uN95FV7+e9lOpszCdy1z4Qyw==
X-Google-Smtp-Source: ABdhPJw0tPyzD2F7Jyx6FGKRdozODrroXNe9pqxuACKJUfpUIY0AqTbpb540nh3W0zU0XJllHER3Kg==
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr5530405pjs.61.1622222072618;
        Fri, 28 May 2021 10:14:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p15sm4816757pjb.8.2021.05.28.10.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 10:14:32 -0700 (PDT)
Date:   Fri, 28 May 2021 10:14:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rodrigo Campos <rodrigo@kinvolk.io>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>, Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v2 2/4] seccomp: Refactor notification handler to prepare
 for new semantics
Message-ID: <202105281014.EECE3D3048@keescook>
References: <20210517193908.3113-1-sargun@sargun.me>
 <20210517193908.3113-3-sargun@sargun.me>
 <CACaBj2YUiowSKzvh02OjpQNqQViA8N0eyRMimkK=90NagRF40w@mail.gmail.com>
 <202105271137.C491991621@keescook>
 <CACaBj2aaDkJwDM8ugR5LxWEOho3nZuHjYLLsth3XYjf39tpaQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACaBj2aaDkJwDM8ugR5LxWEOho3nZuHjYLLsth3XYjf39tpaQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 05:27:39PM +0200, Rodrigo Campos wrote:
> On Thu, May 27, 2021 at 8:42 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, May 27, 2021 at 01:51:13PM +0200, Rodrigo Campos wrote:
> > >
> > > Kees, as I mentioned in the linked thread, this issue is present in
> > > 5.9+ kernels. Should we add the cc to stable for this patch? Or should
> > > we cc to stable the one linked, that just fixes the issue without
> > > semantic changes to userspace?
> >
> > It sounds like the problem is with Go, using addfd, on 5.9-5.13 kernels,
> > yes?
> 
> Yes.
> 
> > Would the semantic change be a problem there? (i.e. it sounds like
> > the semantic change was fine for the 5.14+ kernels, so I'm assuming it's
> > fine for earlier ones too.)
> 
> No, I don't think it will cause any problem.
> 
> > > Just to be clear, the other patch that fixes the problem without
> > > userspace visible changes is this:
> > > https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/
> >
> > I'd prefer to use the now-in-next fix if we can. Is it possible to build
> > a test case that triggers the race so we can have some certainty that
> > any fix in -stable covers it appropriately?
> 
> I've verified that Sargun's patch also solves the problem in mainline.
> I have now also verified that it applies cleany and fixes the issue
> for linux-stable/5.10.y and linux-stable/5.12.y too (without the patch
> I see the problem, with the patch I don't see it).  5.11 is already
> EOL, so I didn't try it (probably will work as well).

Oh, btw, may I add a Tested-by: from you for this fix?

Thanks!

-Kees

-- 
Kees Cook

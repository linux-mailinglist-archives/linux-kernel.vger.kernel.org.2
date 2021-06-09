Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D673A1E26
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 22:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhFIUeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 16:34:46 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:33561 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFIUep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:34:45 -0400
Received: by mail-qk1-f173.google.com with SMTP id k4so25132010qkd.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4tou8Ij0MR64Lz7wvtzPtmf/akDmg+C8gLyT+EbWhtY=;
        b=l+WAIxTSX0+7AYWb4Zsg5/UW3epyBa2JngfMmH0BO49mEDNpyjh33mYiwtMkRHBRiw
         YdvYAcIGIyCuJ22jFnhjm87zBEui4oDOaT/MnaQaXqfxDSvz655+8bUJm2UzugvUUmJs
         R9fTjM9fUlHY/QJFZaEnM2gAqGukpqbHAHUgo7qMZabYr9tqOQg0bUBlRKxYlf9uIOcF
         ZXhdnylcHfz5zUNB38jfPl5MZ9sYaP8rr0bg/CWu3ufkqHG9r7R8Gh90vZ347oxwICng
         7ckPHHOTIvlkZB5uCqYQ2UMMmD0lYzSyfppjJ7ZtIr4QO+GtyOZTyc9iG7r7zL87W+fV
         Xelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4tou8Ij0MR64Lz7wvtzPtmf/akDmg+C8gLyT+EbWhtY=;
        b=cUR7tJvMx5ggnTYkzxMrexI7fkcfhJaAERK4PUxX8Tula2uieo3gFlypKtZAGmXBCE
         phFgrziI5HofaXgiYKgOaXmlVpyG/baFr46NhEdXpyq9cBif6zW8LofjFXmGvx8X3JpM
         HD8kfpKHOHSIUZiBTgUO6DGEuAKFWSc4IGMdSYoLjx6QCFLNbXG0uKNmktFzXdpFG2LU
         JLgULr5Lh1IYkmQVM/CQkjUYr28ZwrF++5IaKDPg1aA9kxZUKt33+w301jg3Jaz1In1A
         T8SOdReJD45w5pJ1OjJKNTTf8lHyHF1T5Uq1MsY92yHoEk7VWruzypzbewyw+41TDTOb
         dzKw==
X-Gm-Message-State: AOAM532Ca1MByxyrx4UbaaIFnxx6SJ3iSsASBIgi+/IbSBRNHoW3BS4v
        RpRy5AkGLlI2pCN7LJivtwMLVA==
X-Google-Smtp-Source: ABdhPJxUlgcTmZr9HuiF5jr294kcz/LFgjRp/R6q/V5HHkkvWATBaunm70lpEJrVBM/OdCEj9/twcQ==
X-Received: by 2002:a37:848:: with SMTP id 69mr1444328qki.411.1623270699692;
        Wed, 09 Jun 2021 13:31:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2165])
        by smtp.gmail.com with ESMTPSA id e3sm789600qts.34.2021.06.09.13.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 13:31:38 -0700 (PDT)
Date:   Wed, 9 Jun 2021 16:31:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Chris Down <chris@chrisdown.name>, legion@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
Message-ID: <YMElKcrVIhJg4GTT@cmpxchg.org>
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
 <YLi+JoBwfLtqVGiP@chrisdown.name>
 <b8c86081-503c-3671-2ea3-dd3a0950ce25@metux.net>
 <87k0n2am0n.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0n2am0n.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 02:14:16PM -0500, Eric W. Biederman wrote:
> "Enrico Weigelt, metux IT consult" <lkml@metux.net> writes:
> 
> > On 03.06.21 13:33, Chris Down wrote:
> >
> > Hi folks,
> >
> >
> >> Putting stuff in /proc to get around the problem of "some other metric I need
> >> might not be exported to a container" is not a very compelling argument. If
> >> they want it, then export it to the container...
> >>
> >> Ultimately, if they're going to have to add support for a new
> >> /proc/self/meminfo file anyway, these use cases should just do it properly
> >> through the already supported APIs.
> >
> > It's even a bit more complex ...
> >
> > /proc/meminfo always tells what the *machine* has available, not what a
> > process can eat up. That has been this way even long before cgroups.
> > (eg. ulimits).
> >
> > Even if you want a container look more like a VM - /proc/meminfo showing
> > what the container (instead of the machine) has available - just looking
> > at the calling task's cgroup is also wrong. Because there're cgroups
> > outside containers (that really shouldn't be affected) and there're even
> > other cgroups inside the container (that further restrict below the
> > container's limits).
> >
> > BTW: applications trying to autotune themselves by looking at
> > /proc/meminfo are broken-by-design anyways. This never has been a valid
> > metric on how much memory invididual processes can or should eat.
> 
> Which brings us to the problem.
> 
> Using /proc/meminfo is not valid unless your application can know it has
> the machine to itself.  Something that is becoming increasing less
> common.
> 
> Unless something has changed in the last couple of years, reading values
> out of the cgroup filesystem is both difficult (v1 and v2 have some
> gratuitous differences) and is actively discouraged.
> 
> So what should applications do?
> 
> Alex has found applications that are trying to do something with
> meminfo, and the fields that those applications care about.  I don't see
> anyone making the case that specifically what the applications are
> trying to do is buggy.
> 
> Alex's suggest is to have a /proc/self/meminfo that has the information
> that applications want, which would be something that would be easy
> to switch applications to.  The patch to userspace at that point is
> as simple as 3 lines of code.  I can imagine people take that patch into
> their userspace programs.

But is it actually what applications want?

Not all the information at the system level translates well to the
container level. Things like available memory require a hierarchical
assessment rather than just a look at the local level, since there
could be limits higher up the tree.

Not all items in meminfo have a container equivalent, either.

The familiar format is likely a liability rather than an asset.

> The simple fact that people are using /proc/meminfo when it doesn't make
> sense for anything except system monitoring tools is a pretty solid bug
> report on the existing linux apis.

I agree that we likely need a better interface for applications to
query the memory state of their container. But I don't think we should
try to emulate a format that is a poor fit for this.

We should also not speculate what users intended to do with the
meminfo data right now. There is a surprising amount of misconception
around what these values actually mean. I'd rather have users show up
on the mailing list directly and outline the broader usecase.

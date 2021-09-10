Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AAA407256
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhIJUOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhIJUOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:14:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974B1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:13:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so2226082pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iePa+QJwyypIcxS3XgZtAGnALz0TqV4Q+j6tPAq5kjc=;
        b=IsHb274uPH9FPLgOtvnWx7raGr0U3XdM/HtccgychtOnJvhTAta6jhijpXFohaIsQW
         bZoWz/q4e0kzF75ln08/dBHmi8xsIkXqp6BWQJq0MhM9s5K07fWEdQ2Tpe09rK7FumiM
         YzHzB3Wl3E4BacbtocMVpqC70kN/f262nczy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iePa+QJwyypIcxS3XgZtAGnALz0TqV4Q+j6tPAq5kjc=;
        b=t+7lupiL88EUbBB0cTU0H+XptBajWxaCtK6fBAwnVhi3Dq33YMQ/1yLUcdg6pGjVCJ
         ZSibk66wKbr2ypkcRjzODarl2UWLAanwmBwq9+0ksLoZ8W75pz47JAsFtwIEA4znIKMI
         RrnQOeLsXG4HUFpG0fCHyQ7XJ/rUFAc6s6z8JuQP1tphuXn9bxB6xZdaL99/jkn6ntKZ
         PqZvVgpVIQ3UkC5SVphZNguu27Uhz2dhppmOVPFoXgrsakeATvBhgyRYrZGFtEsTvv3e
         nt1Dsk6FM/p7PpcUnfg68S7d3H6TMq0YjSJExDtaT92jflktFUnu0cxfbgSy72xHP83E
         XqCQ==
X-Gm-Message-State: AOAM530b2lcFWxeakZCewAONoWpQWdDH/uXCUjExUyCh+VusoEKdRUl0
        oMoazgXS2+LaKRq6vmQQIJKBeLF2rGipDw==
X-Google-Smtp-Source: ABdhPJzIXuCxHsDcf3kB/8sJIGUFvSUANIwT7WrHR5D8g478XSdun3ts3kErWKLttx0O/HnwKe3dtQ==
X-Received: by 2002:a17:90b:4a8e:: with SMTP id lp14mr11619185pjb.79.1631304810547;
        Fri, 10 Sep 2021 13:13:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s5sm6614726pgp.81.2021.09.10.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:13:30 -0700 (PDT)
Date:   Fri, 10 Sep 2021 13:13:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org
Subject: Re: incoming
Message-ID: <202109101312.C145D4F@keescook>
References: <20210909200948.090d4e213ca34b5ad1325a7e@linux-foundation.org>
 <202109101009.13A90EBB6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109101009.13A90EBB6@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:11:53AM -0700, Kees Cook wrote:
> On Thu, Sep 09, 2021 at 08:09:48PM -0700, Andrew Morton wrote:
> > 
> > More post linux-next material.
> > 
> > 9 patches, based on f154c806676ad7153c6e161f30c53a44855329d6.
> > 
> > Subsystems affected by this patch series:
> > 
> >   mm/slab-generic
> >   rapidio
> >   mm/debug
> > 
> > Subsystem: mm/slab-generic
> > 
> >     "Matthew Wilcox (Oracle)" <willy@infradead.org>:
> >       mm: move kvmalloc-related functions to slab.h
> > 
> > Subsystem: rapidio
> > 
> >     Kees Cook <keescook@chromium.org>:
> >       rapidio: avoid bogus __alloc_size warning
> > 
> > Subsystem: mm/debug
> > 
> >     Kees Cook <keescook@chromium.org>:
> >     Patch series "Add __alloc_size() for better bounds checking", v2:
> >       Compiler Attributes: add __alloc_size() for better bounds checking
> >       checkpatch: add __alloc_size() to known $Attribute
> >       slab: clean up function declarations
> >       slab: add __alloc_size attributes for better bounds checking
> >       mm/page_alloc: add __alloc_size attributes for better bounds checking
> >       percpu: add __alloc_size attributes for better bounds checking
> >       mm/vmalloc: add __alloc_size attributes for better bounds checking
> 
> Hi,
> 
> FYI, in overnight build testing I found yet another corner case in
> GCC's handling of the __alloc_size attribute. It's the gift that keeps
> on giving. The fix is here:
> 
> https://lore.kernel.org/lkml/20210910165851.3296624-1-keescook@chromium.org/

I'm so glad it's Friday. Here's the v2 fix... *sigh*

https://lore.kernel.org/lkml/20210910201132.3809437-1-keescook@chromium.org/

-Kees

> 
> > 
> >  Makefile                                 |   15 +++
> >  drivers/of/kexec.c                       |    1 
> >  drivers/rapidio/devices/rio_mport_cdev.c |    9 +-
> >  include/linux/compiler_attributes.h      |    6 +
> >  include/linux/gfp.h                      |    2 
> >  include/linux/mm.h                       |   34 --------
> >  include/linux/percpu.h                   |    3 
> >  include/linux/slab.h                     |  122 ++++++++++++++++++++++---------
> >  include/linux/vmalloc.h                  |   11 ++
> >  scripts/checkpatch.pl                    |    3 
> >  10 files changed, 132 insertions(+), 74 deletions(-)
> > 
> 
> -- 
> Kees Cook

-- 
Kees Cook

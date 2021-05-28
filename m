Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0B39460F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 18:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbhE1QwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbhE1QwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 12:52:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74978C061760
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 09:50:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso2886138pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bf/qW3piWCuBBeLZ+p4pokx2iGuE3UcRHm7BvkTCNSc=;
        b=g+Y+IAxG0cB1wATcml49hmgG5JMzliGRY7NR1ATb6fl2roE3wT1z6tSIAd7myl8+Hc
         T0UIVvOmFc6nKXl5zyyVLm6MzbLhhNPBADN5JeWU/LNd6sA7q1Gokgtjg7j+dtmFJg6b
         j8Dm5mDF396YU4G0m4gwEVELa8pWBomUZTjF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bf/qW3piWCuBBeLZ+p4pokx2iGuE3UcRHm7BvkTCNSc=;
        b=ITd3GZVOhboc3MjNqCjsIYYFor79imHwhs55WDW2oWzgkbmcLizoOhlC9fg58OApRT
         Jzxv4IUkfjAK5JS2xOcQ26i6n+kkSJFQW/0t9dsLoZv4n3bZjMvv7lc18/paIMQXNV/t
         K/5ILGAWTyBq4CtvaijnL/CLZjrHav9phk5dWy/FoQ+6zyASKq+NZUfMuF3c5Rsw+agx
         Pu1NhRwtAfkGDMyj2rKQRxhalM5PiCgM4VojfzZw2GZmLxlQZERBW81cuthCIMWFyHdO
         uAVWGDahcoETXrfyNiZiT3DpS4qsVFWa3pyW/bkj7uryZIJQe1sKueSp6iP6KVLkKTiE
         HTFQ==
X-Gm-Message-State: AOAM532aqS5ba9GyWfRhZSCTSIeAK473Pvs/EDxI2WQJ/pbqlTUbfbCQ
        1dp85lWDVJCZ5ooSILM73w1xEg==
X-Google-Smtp-Source: ABdhPJwBG9lRb7x6OUHwPfbld8YZaCMUZ7MT9zFSclWeTljnDURj7UmLVNDXrMQZsqKhuPw7Zu5qmw==
X-Received: by 2002:a17:903:2290:b029:f3:9129:8397 with SMTP id b16-20020a1709032290b02900f391298397mr8875442plh.13.1622220634969;
        Fri, 28 May 2021 09:50:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 25sm4640452pfh.39.2021.05.28.09.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:50:34 -0700 (PDT)
Date:   Fri, 28 May 2021 09:50:33 -0700
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
Message-ID: <202105280949.00DE5B3018@keescook>
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

Great! Thanks for doing that testing.

> The test case that I have is quite a complicated one, though. I'm
> using the PR we opened to runc to add support for seccomp notify[1]
> and a seccomp agent slightly modified from the example in the PR with
> some cgo to use addfd, and need to run it for several thousand
> iterations, as the kernel needs to be interrupted in a specific line
> and some kernel locks to be acquired in a specific order for this to
> trigger. If you think it is important, I can try to cleanup the code
> and share it, but the issue is basically what I explained here:
> https://lore.kernel.org/lkml/20210413160151.3301-2-rodrigo@kinvolk.io/

Okay; yeah, sounds like that'll be hard to port sanely. :)

> Can we cc this patch to stable, then? :)

Yup, sounds good to me. I will adjust the tags.

Thanks!

-Kees

> Best,
> Rodrigo
> 
> [1]: https://github.com/opencontainers/runc/pull/2682

-- 
Kees Cook

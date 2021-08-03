Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCC3DE6E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 08:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhHCGyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 02:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbhHCGyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 02:54:44 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8892CC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 23:54:30 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so4984511ooc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 23:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4oJ/jweDfhBNzYtl7cCA85MSZCoSaUkH+H3AHvOTrdo=;
        b=Q7T8lrKRMiZFhbrH9Kuj8YjWlp/32J2eatqWjLvhxKq44gIXSIzEQvxjiIZjc3yow+
         zEYXSXoLaPPcRGipX/YZKT0Zxh7KLEhgBgFIG1jQCxNqrLPpzdPHEo47vsOHoj5xzz8W
         dpHISSOI6dWGOyKASL3fgvTNxRG+WQkmLDlv90px5w9kxPskULngQ3jV/T9espPH3S3f
         pA+Ua687K1nU9mEDWLzhz/cGz70XczyR0ZGS+m+ckoxI/M6yZBon84Yw4hXQIq4Q4UZL
         FnmMDdvwJbj/EnOqU+ymrGUJz2bMk+igczHoaCX3jWuSWTgV6ZulI/cZCpS4E8jcE3nS
         lotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4oJ/jweDfhBNzYtl7cCA85MSZCoSaUkH+H3AHvOTrdo=;
        b=mlt/7gXsjtVh8Urg0uDSsM+vgt5rGI9Bf0QzA/wzomhyQL7eekXdYVuN3row3CHdSi
         aNcpcRxwx+5qi6YAm3v0UMwu/KKuGZNHbBLgoyxhFy2cjN9ykonokjNmR11WXdy1V4Tr
         G8SGDGWxvhQAlRjzfmPUMBWIgo9NzzLUREvBMOGJtSdhmgXOajZP4xysAg4T7LCka9Rd
         ggMLPPThXK0S6n6V9mxgWY1w50Ly+1vxShBHENaiOWOydbA7KInNxHuRztl/mX5NNtxH
         xpgopI6d54KsRxCVlB8+CKD0LeIKzZzMStR7SeJecMyAfsLQfremAskXngVaPFCeaFTL
         Mc9A==
X-Gm-Message-State: AOAM531iAS3URRbXryR8mMlZG19LS1a36lpJ9yuKywD/XFBU9tsO7CbX
        VwMFbZDcOqx7YOyOYf512iPGYjcTU1Rt76UtjY8=
X-Google-Smtp-Source: ABdhPJw/KFzh4RBceTHLwY8pNWrudKwrxWElPQzZu7APABTp0flCbC3wsOnBm6xHXk3rYBJL9ROwC5q00Dp2Iiuka+4=
X-Received: by 2002:a4a:5dc6:: with SMTP id w189mr13495446ooa.1.1627973669935;
 Mon, 02 Aug 2021 23:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAM43=SNDAcS952MZpsiD2Z-WU9Bd0EPv=7Z86i7FGdvDtsSXdQ@mail.gmail.com>
 <20210802112904.110028a4@ws>
In-Reply-To: <20210802112904.110028a4@ws>
From:   Mikael Pettersson <mikpelinux@gmail.com>
Date:   Tue, 3 Aug 2021 08:54:18 +0200
Message-ID: <CAM43=SP2TUUfo2bUiu+5fvKvT1gn0e4vofoX3zDP1pV_qnv+BA@mail.gmail.com>
Subject: Re: [BISECTED] 5.14.0-rc4 broke drm/ttm when !CONFIG_DEBUG_FS
To:     Duncan <j.duncan@cox.net>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Jason Ekstrand <jason@jlekstrand.net>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 8:29 PM Duncan <j.duncan@cox.net> wrote:
>
> [Not subscribed so please CC me.  Manual quoting after using lore's
> in-reply-to functionality.  First time doing that so hope I got it
> right.]
>
> Mikael Pettersson <mikpelinux@gmail.com> wrote...
> > Booting 5.14.0-rc4 on my box with Radeon graphics breaks with
> >
> > [drm:radeon_ttm_init [radeon]] *ERROR* failed initializing buffer
> > object driver(-19).
> > radeon 0000:01:00.0: Fatal error during GPU init
>
> Seeing this here too.  amdgpu on polaris-11, on an old amd-fx6100
> system.
>
> > after which the screen goes black for the rest of kernel boot
> > and early user-space init.
>
> *NOT* seeing that.  However, I have boot messages turned on by default
> and I see them as usual, only it stays in vga-console mode instead of
> switching to framebuffer after early-boot. I'm guessing MP has a
> high-res boot-splash which doesn't work in vga mode, thus the
> black-screen until the login shows up.

Yes, I have the Fedora boot splash enabled.

> > Once the console login shows up the screen is in some legacy low-res
> > mode and Xorg can't be started.
> >
> > A git bisect between v5.14-rc3 (good) and v5.14-rc4 (bad) identified
> >
> > # first bad commit: [69de4421bb4c103ef42a32bafc596e23918c106f]
> > drm/ttm: Initialize debugfs from ttm_global_init()
> >
> > Reverting that from 5.14.0-rc4 gives me a working kernel again.
> >
> > Note that I have
> > # CONFIG_DEBUG_FS is not set
>
> That all matches here, including the unset CONFIG_DEBUG_FS and
> confirming the revert on 5.14.0-rc4 works.

Thanks for the confirmation.

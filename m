Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D82B348958
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCYGtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhCYGsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:48:45 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76017C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 23:48:44 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c3so810493qkc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 23:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T5CjvFYDEtZ3kZrOVFQv//2YoZQXvV6dPPPaR37s0/M=;
        b=u42vQyq9npwV6wo2mn8Gb/P1O4BKWJjfNNG5ECMFoYSDSFss54BNtiHnMhfRKhUqzx
         VMQCcv1pQTcH8MdxkNVnqDbVq4Z0DO+M7qeBayVDyGX5HK9ZmMOoZ7nycbQxHf79vHe2
         +9pax28kyxhcroqAnfSj991jH1gDW3lfFsbaUVCeoNqFgfWfGxCxfm6dNfeko+wTgFqK
         6ilRMOP5Mfxv7VRmSYnoA0BiqAiEZz5PcHw7MnG5SK5op6YdIneMsomUX+zeElFgHuNS
         6HA92jwaWhlLcgJ7NKQUlyi8XTPkn9vKtRr0pOZozf1btzfuN9pPRza+fSwitlcwvoWU
         bQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5CjvFYDEtZ3kZrOVFQv//2YoZQXvV6dPPPaR37s0/M=;
        b=hj92w2xr//QWz/vLFYtlftsjsDux9f8XPaf3+nTQ6t1K+EF30cRGfEu2VwqynO6gU1
         +3OHOku1GcLIWO9Im9gFJjFpctdiC0vTJwmd1de1cm17HiTvKyVkEqtCVmGqRr42PgQe
         deZ+uwpW2HzkENPjxobVNQiy7UOSlz/xQ36u0HJUyN4NMfBTKEYHUbufGXyt17z6IFiU
         9vkf83CLMcsbBNjNThw8pZKJ9DALy76P/r5svq7heg1THplFbyJGR8kcMx4t1UNP4tQQ
         +cuf3g/ogbzul/cINMHYbaS8jKRPgUOW6SuToy4iMPjONBCbhPIKerZ2BNV9nEn4zzux
         elvQ==
X-Gm-Message-State: AOAM530kfMnYbU1Cds08ZPg7yXiYYJe6/7HyUB1rV2BB8qBCyKr+Pjns
        lJuVlXZ4KpJxLHRlU6e/5zLpfTaMAIe38D3dE6l00w==
X-Google-Smtp-Source: ABdhPJzvuHIQMu8gosf36fWYs8QS4hqDSnRtedbl/Y969KzsphbiRmzb3t2DsUCOrDtiq1damp2ZtQBFoes/LA2xwVA=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr6771758qko.424.1616654923419;
 Wed, 24 Mar 2021 23:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210320132840.1315853-1-dvyukov@google.com> <20210324220008.nqwwwfugyfngbn3x@smtp.gmail.com>
In-Reply-To: <20210324220008.nqwwwfugyfngbn3x@smtp.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 25 Mar 2021 07:48:32 +0100
Message-ID: <CACT4Y+bDcd+hdgkQyEvPRM1eSWSoud4EDhq4tLKS8wxFjr1F6w@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: fix misuse of WARN_ON
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        syzbot+4fc21a003c8332eb0bdd@syzkaller.appspotmail.com,
        DRI <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 11:00 PM Melissa Wen <melissa.srw@gmail.com> wrote:
>
> On 03/20, Dmitry Vyukov wrote:
> > vkms_vblank_simulate() uses WARN_ON for timing-dependent condition
> > (timer overrun). This is a mis-use of WARN_ON, WARN_ON must be used
> > to denote kernel bugs. Use pr_warn() instead.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Reported-by: syzbot+4fc21a003c8332eb0bdd@syzkaller.appspotmail.com
> > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > Cc: Melissa Wen <melissa.srw@gmail.com>
> > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Change-Id: I7f01c288092bc7e472ec63af198f93ce3d8c49f7
> > ---
> >  drivers/gpu/drm/vkms/vkms_crtc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > index 0443b7deeaef6..758d8a98d96b3 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > @@ -18,7 +18,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> >
> >       ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
> >                                         output->period_ns);
> > -     WARN_ON(ret_overrun != 1);
> > +     if (ret_overrun != 1)
> > +             pr_warn("%s: vblank timer overrun\n", __func__);
>
> Hi Dmitry,
>
> Thanks for your patch.
>
> Looks good to me.
> The Change-Id tag just seems a little noisy to me, but can be
> fixed while applying.

Yes, please drop Change-Id when applying if possible. Sorry for that.
Thanks for the review, Melissa.

> Acked-by: Melissa Wen <melissa.srw@gmail.com>
>
> >
> >       spin_lock(&output->lock);
> >       ret = drm_crtc_handle_vblank(crtc);
> >
> > base-commit: e94c55b8e0a0bbe9a026250cf31e2fa45957d776
> > --
> > 2.31.0.291.g576ba9dcdaf-goog
> >

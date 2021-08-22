Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2D3F4277
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhHVX7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 19:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbhHVX7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 19:59:24 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D7C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 16:58:43 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id o2so15008835pgr.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 16:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1QEzz8l10ItQyTj7R7UnaMBv4HzmAT0MuoYeWEko34=;
        b=NVgAk9sX2H5XPJKqTjIeK3u/mKQNJ/yfRoAM5NCYBWJiRVOfDw6XtN25QrqN6viyO3
         8a595bmdo0+4GEMKjEDdHmSuJbz1csuEpQUPITluIbx+NSsnUmUI/O8fhaxuoPqzyo/P
         DdftZOOdz/8y8hLXmvCnUiRDjL+T1opKYISCulL//sfmO05EaAsJFDbMu+/ipAX2/sGP
         6/QxAHNWqLQwTUbmVaqqgIjPdiR65Nao/4XPxg0tOIfUxP8/RTVsAVTdGexpCEkeG5K9
         c0FJvtXbMr1Usc+H5eHU3HgFhHbXZk3IVRN3fOL42m4PTH8/J6vfbTvZCdBseHJTQ9NK
         N/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1QEzz8l10ItQyTj7R7UnaMBv4HzmAT0MuoYeWEko34=;
        b=eNcTB6EsUpQhu5xrsc8pvFbikfg1pIuLvhOlieswhsNl2csdw94loVpH+/jNsbyu6x
         /CxNMZfx7JKYJiSc0u7GuHt/eEpZPF/HO5csbb6WR8WJr0SiaEsgXhPMdANka/73Xx7M
         isTv42FbIqF9YR0NqWW3ErdO6icOGO3MRI86/wek2L70ICLewi4cJPdpfQDD1GfC01Bc
         nPIiTHiKjrA0CxlIjliIOlZyEUu2+evEmhvgVpIS2cTdLjt3/GI7IiKhTsCY5yReqaSX
         HXoBL5tWKWvdwhlSfQsOEK8M3s0TobD3lkTwAW90qEXs9Kv0qGn2idrSPP+oX0WG1+zF
         RSoA==
X-Gm-Message-State: AOAM532JeOZa5Y3/Qyyt8q8mVNgDD4dbdzUOQJABQfFUZXd5Ym1Ly8oo
        r4DR9kuMU9mK3nVILLoKmGUUmby6/tsyBVDcowo6wQ==
X-Google-Smtp-Source: ABdhPJwEoaX3sH59fomXWEOKyrjNhGQnlPM9ZNdL791GaE5sj8mEhORNycvvLERmMeeJCaW6msqclGYBlqJOaG4KoBw=
X-Received: by 2002:a63:aa43:: with SMTP id x3mr29693865pgo.208.1629676722589;
 Sun, 22 Aug 2021 16:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <YSFgrLUfXzgcT6k4@user> <1821445.fzUCeO1EU3@localhost.localdomain>
 <CAA=Fs0mu4m04_Be4-f=W+=_hhGn5oJ2q=KOmZdRrMyGhMgqc-Q@mail.gmail.com> <18734228.Nv2I6EOGHm@localhost.localdomain>
In-Reply-To: <18734228.Nv2I6EOGHm@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 00:58:31 +0100
Message-ID: <CAA=Fs0kZvkSmf9vH_Z1rUbDMYYd5SWbQQXhGpMxDbfvWQs338A@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: core: remove condition with no effect
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        saurav.girepunje@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2021 at 17:24, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
>
> Dear Philip,
>
> I didn't mean to be harsh with you, I apologize if this is the message
> I conveyed. Really!

Dear Fabio,

No apology necessary :-)

>
>
> Now it is clearer to me what acking means. I've given only a handful of
> acks because I thought I should also check if they applied and if they
> build. It takes time. Now I understand it is not required. Thanks.
>

Yeah I try to ack as many as I can now, but couldn't possibly do as
many as I do if I had to build test them all, especially with my own
code to write and a family/full time non-kernel dev role. It is
certainly desirable for the majority, but if the code looks
good/correct and is a simple patch then in my mind an Acked-by is fine
to give in any case. That said, I will no doubt make mistakes on that.

>
> Please, don't ever think I'm not more than sure that you give a lot
> of your _unpaid_ time to the kernel and I thank you very much
> I know what it means, because I too have other commitments :-)

Thank you, and I appreciate your involvement so keep up the good work :-)

Regards,
Phil

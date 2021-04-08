Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466AC357DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhDHIEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhDHIEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:04:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5400FC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 01:03:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n138so2487124lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 01:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISfQB/dgrT5oTpjTvqCHzpI7aicxEygBEF/QqXzmpEs=;
        b=t0Y4Hf13+QHG2sjEsgOwGIvUpHNtbP1UOtGcHT3Or0kvT9B/quXEIvVPDKIcgThT+a
         jJryonsnpVMX+7jhdyZYO2ORpUQ+wZDcD3vO7Hj15Y9fdGrdE304/rDUQ72cd8ec41t8
         OfezHpsyrR4Rhgd+HM3WMsup15RxQKlGgIIeQ7eCHj56OO/L1+G9E3eQZdg5+gx7E+yO
         Eb+0MI3ClRZI8RYPqeuG84DUEQnqPvi+kNkSY7ev7IWwW9jzzqT7a+bpA5UdMDzJvFWj
         5111fRyODxb4Ar5hDZiCYOf0viHWTQMrgRUGCzGZLkW2wQCkACnhHMG1xBPPT2scBgLh
         QPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISfQB/dgrT5oTpjTvqCHzpI7aicxEygBEF/QqXzmpEs=;
        b=lKSY9adlAqNTSIxU1KbXTNWfiurIuqZt2YZHJtGzA3q6t0LdO2cVjbTrH2R6XI5zey
         bf1SWlmpE4qKisANBs5Zk6TGXORTcBuQl47GrN8ouWfyatrq5Ok3QLlvvoErvosRAYPc
         IxTouFEoCkQ0WtaQUPw59nCmvrxEAEP4wN31xB1cC3YKbHvvd3+s4tF8/Yw1ODuwEzP5
         6ZIMFT+wPfR4fgjlduOp1h08V0wVJcacDSuHrekEV8dmXKGkAgBeu3koQjWRZuf2E+3b
         8fDHfaAEHije+2o0kK/9rrR5P2cvBZbkcn09JMm6qIsY1aqqVg8TU/lWS9/hbtd4zLJt
         xehQ==
X-Gm-Message-State: AOAM533LwIpmoVLYV1uGjr6l78SHbsc6udp2OCqB9/9yDoS1sY48xBJk
        dXqr0YghVgaCM0OG+9Y0v0xnVwyuYSS/1O/6/o3wuQ==
X-Google-Smtp-Source: ABdhPJx1SgqoW7cJBKhGp4xh3iz9T5hM1LcKl8KIsGCeeekjm6qBadMbWxM4m0ikYiAJZETSNX1NUa6HmlNqsDziKSA=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr5537845lfe.29.1617869037744;
 Thu, 08 Apr 2021 01:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210225083306.25792-1-julianbraha@gmail.com> <CACRpkda2Jbm3DmOhxFyyxDZRrUk01TtPbD+OOG=U7o2mnxEB8A@mail.gmail.com>
 <12736456.GqETC5XQ6s@ubuntu-mate-laptop>
In-Reply-To: <12736456.GqETC5XQ6s@ubuntu-mate-laptop>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Apr 2021 10:03:46 +0200
Message-ID: <CACRpkdbSYzeoA5Ojraq-kmJr0V=kM1uoNBzFAduTB-a9UtJqRw@mail.gmail.com>
Subject: Re: [PATCH v1] drivers: pinctrl: qcom: fix Kconfig dependency on GPIOLIB
To:     Julian Braha <julianbraha@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 6:41 PM Julian Braha <julianbraha@gmail.com> wrote:
>
> On Tuesday, March 2, 2021 9:46:04 AM EDT you wrote:
> > On Thu, Feb 25, 2021 at 9:33 AM Julian Braha <julianbraha@gmail.com> wrote:
> >
> > > When PINCTRL_MSM is enabled, and GPIOLIB is disabled,
> > > Kbuild gives the following warning:
> > >
> > > WARNING: unmet direct dependencies detected for GPIOLIB_IRQCHIP
> > >   Depends on [n]: GPIOLIB [=n]
> > >   Selected by [y]:
> > >   - PINCTRL_MSM [=y] && PINCTRL [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
> > >
> > > This is because PINCTRL_MSM selects GPIOLIB_IRQCHIP,
> > > without selecting or depending on GPIOLIB, despite
> > > GPIOLIB_IRQCHIP depending on GPIOLIB. Having PINCTRL_MSM
> > > select GPIOLIB will cause a recursive dependency error.
> > >
> > > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> >
> > Does it work to just:
> >
> > select GPIOLIB
> >
> > instead?
> >
> > The driver needs the library so...
> >
> > Yours,
> > Linus Walleij
> >
>
> Hi Linus,
>
> Looks like I confused this patch with another one when
> I responded last time. This config option cannot select
> GPIOLIB, because it will cause a recursive dependency
> error.
>
> Any other ideas?

No we can apply the patch as-is but let Bjorn have  a look at it first,
I noticed he is not on the To: line of the original patch.

You may need to resend with Bjorn Andersson in the recipients.

Yours,
Linus Walleij

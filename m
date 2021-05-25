Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DEB3904A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhEYPKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhEYPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:10:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB90C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:09:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o8so38654594ljp.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXhstycvJ/ZxY8r6rEvIPljRylC1sPEk0zKGubyDqnc=;
        b=BkHE3p4fPN34oOAaNSE02dOwEecfhj/NQtDloDqQc+xn+yc/uj4k7T1GAhnkoP7XK5
         PAirC+CqUOlNV4agBX4g9/Ge6HdzmhIku6IGO1lZlAQ4HoUyPFHWGpKqSpYR4oCZ17/x
         OL4NFaTV9ufHRrTmyXNPQy0SobLF2Ah9Y/tHmZgKuKoywMAr/qH4eq4OhSBPU+fW+iew
         lDytQ6AVAFVeL5MfFadlSqcfKptxdCKCSmg60GJGHFKBdWVJjN6us/ZAJ3izcjLvMERO
         yT9gaICJf2Nc/0SKF4R1mlJwpRq4RbvU1REAIzGEeLOMIo34QkHzOBHiHCvo0l+vpuOR
         E/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXhstycvJ/ZxY8r6rEvIPljRylC1sPEk0zKGubyDqnc=;
        b=sOLuBCAzn66U6dCqzziVD6MNMCjEVe6sNYUyLxwmk7aw7TWnFJZlMfM/W8xZRT1jFW
         jHfcKAMGJ3vleoq54Haws/ZdNpDkcZXjhbQ4+qH8jnoZV+N+HydEV8tN/5YfC11V+y+q
         9Ky768MmjSSseIsd7G/FasfplugHVeTlmpm9jLJAnDedJvS9Hbp0YrJNkqpr1/xHw6/7
         ZH09JHabl20qxlUhe/1CjJ1kl0FrWXbZpqGoEs/hu68OpTh+kxz8DTRhaJMJJmK8+qxR
         OZoVmRlr7Llo5n6nesHEc6JucM0TbUEyDdlzIFZNfVxtuEe5iBi+KNHArFX/qPaEW/eI
         eNsw==
X-Gm-Message-State: AOAM531PfWOQolEFkl7J/7lgGeHLGWyQOL471yEZ6UIbFg7QPYUoCt8/
        c/YbKWITM5/5WqrKIkSihuZIU7ulxj8gR/jojkQafAho3FM=
X-Google-Smtp-Source: ABdhPJxLgO3lpcEhQzJRZHtjBBS37mdWQMb5YUpDCqSSE+VsKji9pL95xpoUjuJXjYq+UoY6D/AWgxbpMKAO5jVryg0=
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr21231147ljg.368.1621955356716;
 Tue, 25 May 2021 08:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210512210316.1982416-1-luzmaximilian@gmail.com>
 <CACRpkdZpm4w6Ym2p9xTsYpkU7CR531aLUUxXj54tssoqd6c9=Q@mail.gmail.com> <YKYnYCaoUDwjS1gL@smile.fi.intel.com>
In-Reply-To: <YKYnYCaoUDwjS1gL@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 May 2021 17:09:05 +0200
Message-ID: <CACRpkdYHxKbAwFTD=g_xWxq2wnRFC2V7NBrODVn-QDVUREfyhA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl/amd: Add device HID for new AMD GPIO controller
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Sachi King <nakato@nakato.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:09 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, May 20, 2021 at 01:50:50AM +0200, Linus Walleij wrote:
> > On Wed, May 12, 2021 at 11:03 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> >
> > > Add device HID AMDI0031 to the AMD GPIO controller driver match table.
> > > This controller can be found on Microsoft Surface Laptop 4 devices and
> > > seems similar enough that we can just copy the existing AMDI0030 entry.
> > >
> > > Cc: <stable@vger.kernel.org> # 5.10+
> >
> > Why? It's hardly a regression?
>
> IIRC the stable policy allows to backport new IDs.

You're right.

> > > Tested-by: Sachi King <nakato@nakato.io>
> > > Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> >
> > I've applied the patch for next without the stable tag for now.
>
> It can be pulled to stable afterwards anyway :-)

Nah I'll tag it back on. But it goes upstream with the rest of
patches for v5.14 in the merge window because it is not
urgent.

Yours,
Linus Walleij

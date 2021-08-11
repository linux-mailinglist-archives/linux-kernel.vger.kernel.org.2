Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD543E910D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbhHKMaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhHKMaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:30:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A9FC0617BD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:25:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h9so4241423ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEH3nbdjRk3iKKEKjuiI8MahBqLUdJ0ANeHswehlAC4=;
        b=fryX8NC6y6XlhC7j8uc53VpWuPhaK1RvrhW4QxLCjceOa1J59cngm58Q5breUEAZbO
         OdlWLshstDrjt6UOfytqzUzuH9ayTdiWPqaDLgUlsUlCyZld1UlCCVRE0nBVaW4paNh6
         1a3FNJ14ZhQ8hNw03miW5hJUrtt3hETfd0HLclQFNJOttkWqXJ3IQJ2dZonNKhWThxNV
         s25hAQibOskooQ2GsZBsZ7KyVni2733OGYGblU+c4qNb68oeRVGM9Zmcpn+boaMC4754
         13X17tG6W+wmrmnj86w4abOEdedO5ZYDks6sohT3FniDvvsgkv/WrYVhuuAwaLgJG3Rb
         a1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEH3nbdjRk3iKKEKjuiI8MahBqLUdJ0ANeHswehlAC4=;
        b=Bal2k3XBRi4iJeJZ3gsue+G5w93aQbSDrSafrcYIPduNUPooikme6lgIr6krpq9N7w
         od+djai/wfA/ypbN2LNZpd4LsQdRJ+pLZLZuaXKSsghs8Rz7ijMYXTg4cty5ze447WeL
         4hYaeUhsaxz45Xt795sbsWQOSg9RuZ1ItQtk3iy0Ymu2LrLW5Nha5dX2X70anJTYq+SW
         rZeehg5GzAizU8KUcW3TCIUhkzI2zUo5fIPp0k20DZPhySrxuBhFDGt0+OUTiWg3XshW
         7bJUON7V9svfcj9gbhIdP9sjL172r7os7iRi7DBy88Bi8O98LJsaX/CTUKJV3k+pVY8s
         OEvQ==
X-Gm-Message-State: AOAM533YJjITEBZQgSHiC+aty27B0VkUKkBcHPy0tRSgVYIaU0hg5CPO
        0dWaZOPvMpcmgkSiyMoMSZEak213Rx54nMuhyLyHpQ==
X-Google-Smtp-Source: ABdhPJz/gGHq1zq1jYiqFyFHQT7Hh0KkvI1s2Ai88t2QU+nt6YVYNQmSr60cJpcwWEILkaeEmBjD5VELf9BFPZPEGi4=
X-Received: by 2002:a2e:9a4b:: with SMTP id k11mr12624317ljj.368.1628684730077;
 Wed, 11 Aug 2021 05:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628590591.git.viresh.kumar@linaro.org> <afc7b34cee856f1ed1a65034f4a9fe705dd04d6a.1628590591.git.viresh.kumar@linaro.org>
In-Reply-To: <afc7b34cee856f1ed1a65034f4a9fe705dd04d6a.1628590591.git.viresh.kumar@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 14:25:18 +0200
Message-ID: <CACRpkdajnPsD01ztx5xdVnR=cEK78KY+D169HXeDKuaOMS9qfQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] gpio: Add virtio-gpio driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        stratos-dev@op-lists.linaro.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 12:25 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> This patch adds a new driver for Virtio based GPIO devices.
>
> This allows a guest VM running Linux to access GPIO lines provided by
> the host. It supports all basic operations, except interrupts for the
> GPIO lines.
>
> Based on the initial work posted by:
> "Enrico Weigelt, metux IT consult" <lkml@metux.net>.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I see there is a dependency that needs to be fixed but
the driver looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

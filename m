Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421BB40B556
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhINQyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhINQyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:54:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4098A61175
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631638373;
        bh=5EAvlbhbq0llbBvQjlmqanU1k/OmKujqCYaW1xdICc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NxWci+lLFroCVxuTO0p+EIuaBd24OTW5hJVINSIx9f0Jomwho+oT6dlGWxndYV0mQ
         dVVPF7pjKWWDD6NCKJnmCnIxI1ow76DdlgWJP02dzEWBlGfuVwjAVKhnu4JWylMG+H
         jP0FaFKXJsyWOhg9UyoYa81uaOJpXC81Gbs8764ZC3QBK1sDvjYzFxx43Ca0xi/dHH
         L2lpPTwPBhw82inwr+udP0XhUR0hrDI/60JrzH0vPLddoQx7GvzNLY0nU0UBLXNy2s
         zq++3h5q12BXXyiKWzhdcPal90hOO3XbA+45xjoDwcj90Oo1JHl4jCV7tnzuR+yQSL
         C07nOU3PEd98w==
Received: by mail-ej1-f49.google.com with SMTP id qq21so24547236ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:52:53 -0700 (PDT)
X-Gm-Message-State: AOAM533xgjyggJL3Wa6KEyXB8ysFU9h+wII5UcCYa9wmj5WxeAuvj8/l
        DY4s7AyiBg3VkceaT1ndfC8U/2kBtSuX3p98sg==
X-Google-Smtp-Source: ABdhPJzlcmTyyKGeLqhCnAJGaPA8O2Oney8+0epWQscPZ1td58g17eux2tseCgGfkEry5Gs0nVA8EUjOCc2B1p/Lvq8=
X-Received: by 2002:a17:906:fc09:: with SMTP id ov9mr19911160ejb.128.1631638371795;
 Tue, 14 Sep 2021 09:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
 <20210914043928.4066136-6-saravanak@google.com> <YUC7c9BNuHPOEg4g@lunn.ch>
 <CAGETcx-B+yE8X2rn4GdzAikVO-swXb9a5-CxOG_HSuiQoHQZcw@mail.gmail.com> <YUDRSIR2g6Pt1umn@lunn.ch>
In-Reply-To: <YUDRSIR2g6Pt1umn@lunn.ch>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Sep 2021 11:52:38 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+D2nyzrvWE7vdbQFB680+cmx=FfFMqHL0s=tkTSduz2Q@mail.gmail.com>
Message-ID: <CAL_Jsq+D2nyzrvWE7vdbQFB680+cmx=FfFMqHL0s=tkTSduz2Q@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] driver core: Add fw_devlink.debug command line
 boolean parameter
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:44 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I did think of this, but the problem is that dynamic debug logs can
> > get compiled out (when DYNAMIC_DEBUG isn't set). I think debugging of
> > fw_devlink needs to be possible without having to recompile the
> > kernel. So in a sense similar to how initcall_debug works today.
>
> My off the shelf Debian kernel has it enabled. Maybe you can check
> other mainline distributions and see if it is enabled by default.

Right, I would expect users that can't rebuild their kernel easily
would have it enabled.

> You are also on a slippery path. You argue this is needed all the time
> and add a custom knob. Somebody else adds a new feature which they
> also argue always needs bug, and add there own custom knob. We soon
> have lots of custom knobs, each doing it slightly differently, in
> different places. Chaos. So you need a really good argument why your
> code really is special.
>
> I would suggest you start with dynamic debug, and collect some
> statistics of how often you need to ask people to recompile their
> kernel.

I agree.

What would be nice is documenting what needs to be set for devlink.
What I used was just 'dyndbg="file drivers/base/core.c +p"'

Rob

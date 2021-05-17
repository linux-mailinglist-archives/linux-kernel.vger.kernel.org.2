Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65482386D58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhEQW6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhEQW6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:58:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096D0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:57:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v13so3990290ple.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6onhnC7x1T1SJbKsTWGvvMOggtzE2dsg7emuHSDAOKI=;
        b=TsDx9hQPgJblA+EiIU2r2jtsDd8T6kxBsz8nr41hSHKTGD4QBfKQ6Rc4vqgOXhHfAQ
         uu/8+FUXbnE3cTyQKUpwlpTTnIxkVi6hqu025cmd5G0zjPSK/CGFwcQcZrxyVQsOlZxM
         IFCqn+TpO6XA/YyA2KWEvQHgeouVI6Mh7jf9wS+7FiZ5khxgxh2guGFniUsdWYHzzGjP
         EZVU95vhsFwqSQsO1tYQ/+Xk+JJgYiLIDn/P1WKFTgCYIPtaF2KuTvZRFec3EYP6Qxrp
         gQ1LMdBkf9pfYYr2WoJB46mPBFHrS/ymNYsnDm45I7f2MYLUeycFpC5/w9T/Of0Xrtnu
         ndPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6onhnC7x1T1SJbKsTWGvvMOggtzE2dsg7emuHSDAOKI=;
        b=G1nuxwmCP27jo991pGeGPBLKcRGpl4lOuNflT3D44wONPrOuDyuD9u8o03KGGCSBGb
         xdtzyImYXF6yGm8hzoO/kbxyGKqJRTtlIietZCa+bviDOc0H3cfVXiEKd2w+P3Jdd0T3
         TgYc5LfPfu116+gdukF6zpEZt5WbPAipXktTp2828y8PjhSgGWqvUeqQfWRxNetpLVbI
         r1IYdhlNpYBfC2gXbG7a3xWUoIN0l0Jk/5yhPJVNEYw0bCymtZDsMkx1R0VjkI/ty1Dl
         0LyGgROkeEo+5FfNuGCnK+YC7U4UXkFzuIWX02wRhfIvRMAQIAICmbasq/9KTN1DFy9I
         NT4A==
X-Gm-Message-State: AOAM530One+Lvym8cUHjAMfY5AqRB9bgviuorNna2HzLDAubtZo+Kh4w
        xaqwG+89rTWG3vyObbcCfliXXg==
X-Google-Smtp-Source: ABdhPJw3tP45bSqKwVdGo/U+SU8KxdHtPliGOYoyYwPfNmuu6RFQbhte2iwYzrfUlchdH5ZaRW4y4g==
X-Received: by 2002:a17:902:a40e:b029:e9:7253:8198 with SMTP id p14-20020a170902a40eb02900e972538198mr924491plq.82.1621292236416;
        Mon, 17 May 2021 15:57:16 -0700 (PDT)
Received: from x1 ([2601:1c0:4701:ae70:aa60:5ddf:388a:f8f7])
        by smtp.gmail.com with ESMTPSA id x90sm343184pjj.55.2021.05.17.15.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 15:57:15 -0700 (PDT)
Date:   Mon, 17 May 2021 15:57:13 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dario Binacchi <dariobin@libero.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 1/2] pinctrl: core: configure pinmux from pins debug file
Message-ID: <20210517225713.GB2936462@x1>
References: <20210516135531.2203-1-dariobin@libero.it>
 <20210516135531.2203-2-dariobin@libero.it>
 <CAHp75Vd8875hRNk1JK6gkmfxjqxBSu4cRNE1zJt9TyEW7TvsMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd8875hRNk1JK6gkmfxjqxBSu4cRNE1zJt9TyEW7TvsMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 11:02:00PM +0300, Andy Shevchenko wrote:
> On Sun, May 16, 2021 at 7:43 PM Dario Binacchi <dariobin@libero.it> wrote:
> >
> > The MPUs of some architectures (e.g AM335x) must be in privileged
> > operating mode to write on the pinmux
> 
> pinmux is not pin configuration. You need to rethink the approach.
> 
> > registers. In such cases, where
> > writes will not work from user space, now it can be done from the pins
> > debug file if the platform driver exports the pin_dbg_set() helper among
> > the registered operations.
> 
> Drew, is it similar to what you are trying to achieve?

Yes, I would say this similar to what I was trying to accomplish: being
able to change contents of conf_<module>_<pin> register [table 9-60]
from userspace.

However, I was specifically looking to change bits 2:0 which is mux
mode. My motivation was to allow BeagleBone users to easily switch
between pin functions on the expansion headers during runtime to make
rapid prototyping with a breadboard easier (such as changing header pin
from GPIO to SPI mode). Most of the header pins have 7 different modes.

Ultimately, the solution I settled on with feedback from this list was
to create pinmux-select debugfs file that can activate desired fucntion:
6199f6becc86 ("pinctrl: pinmux: Add pinmux-select debugfs file")

Bits 6:3 are related to what this subsystem would refer to as pin conf
such as slew, input enable and bias. Thus it might make sense to expose
something like a select-pinconf file to activate pin conf settings from
userspace. This would require using 'pinconf-single' compatible.

I fixed pinctrl-single bug regarding pinconf last year so it should be
possible to use 'pinconf-single' compatible for the am33xx_pinmux node:
f46fe79ff1b6 ("pinctrl-single: fix pcs_parse_pinconf() return value")

Thanks,
Drew

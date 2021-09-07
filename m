Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92058402F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346208AbhIGUWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhIGUWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:22:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A07C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:21:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id p15so555970ljn.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLPM3CmAMxCZympRP7kvfM9bqd+LVpjvPnRaMAwi04k=;
        b=Pt3HaPqsQd/xVFlPx5FDQsGrdVQ+8S0LeNXHzsGEpQmH7rKovEryR630JuJZZLuxDd
         hD5CoPHyHb3CaUOjQbJqpLFLeuJep69F6kModAS8eCqcsbcrTFnFlCgd0jyPPb20Ws0H
         JOCVKDlW9Dcl0+1nXXE0QaBu3zRadKzUuF1YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLPM3CmAMxCZympRP7kvfM9bqd+LVpjvPnRaMAwi04k=;
        b=YBdVP6+iT7jOC62m/gWPAweHaS3PKYDQiBR6aP8SuqFcwpVegCVoATSobEf6xfnAii
         9CYiaZnzlOJgi3YTXebcpeYZnalXhfX+PqgnDYR1deVOMem9qF6OeszBV9UAUfhGM2FZ
         9dk/C0KHwEfJ7B3vNn+5/tcsw4FgbGnZemoK9LYr1CKOv06gJCoY7KN48JFXwvbqvCd1
         4Lf5NcMPTphWo2meKM59cw6b8Ugm1FpWQGpgmDWx0a23X2fwcbPs4nwDjalbK6At74vq
         XZfEwOpS6qOJTD4E3mY+hW62uf6CVDHDPV8mS1DvFYEsxnI5bvJATZyLxpQCqL1QEvQv
         r/jw==
X-Gm-Message-State: AOAM533sgIP4D1vxZmfGpzkqNovZQMO6FmxdihF/8Y4hjyFy5f+zwfTh
        2dVBzf/JkY4//VbaU7VDZ4qy/j9hHsY061pJQwY=
X-Google-Smtp-Source: ABdhPJz0CzhfdAkbHMUn6kYM1FDfE1sUajsyO0FmTT00RfiGNxiZP8mHFBEu6MfGe8euYlQvbmm2sQ==
X-Received: by 2002:a05:651c:90b:: with SMTP id e11mr57252ljq.172.1631046081053;
        Tue, 07 Sep 2021 13:21:21 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id o14sm1172693lfb.280.2021.09.07.13.21.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 13:21:20 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id f2so574345ljn.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:21:20 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr38605ljg.31.1631046080210;
 Tue, 07 Sep 2021 13:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210907083613.31268-1-brgl@bgdev.pl> <163104566243.21240.4845140527007156447.pr-tracker-bot@kernel.org>
In-Reply-To: <163104566243.21240.4845140527007156447.pr-tracker-bot@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 13:21:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg97FcRFyY=xSLfOmZ5XntCsp9bAj6VZXSbU8YXVzyOfA@mail.gmail.com>
Message-ID: <CAHk-=wg97FcRFyY=xSLfOmZ5XntCsp9bAj6VZXSbU8YXVzyOfA@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: updates for v5.15
To:     pr-tracker-bot@kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 1:14 PM <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Tue,  7 Sep 2021 10:36:13 +0200:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v5.15
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/5e6a5845dd651b00754a62edec2f0a439182024d

Yup, this is the real pr-tracker-bot response for Bartosz' pull
request, not the over-eager slightly random one.

Looks like there was possibly some parsing problem with the email having that

      Merge branch 'ib-rockchip' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
into gpio/for-next

in the shortlog. Or something like that?

         Linus

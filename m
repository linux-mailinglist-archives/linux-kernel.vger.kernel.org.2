Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0657402F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345488AbhIGUWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhIGUV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:21:57 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C99C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:20:50 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x5so453653qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DnMGstwpP4WxQT6+Xyzo4pEeCxQ24RpGikfTYrXfzQY=;
        b=hCtdRHnIFcZtDM7EdvwAYS1Q0ZAd5cGBSkM0WWt6Il9QameMZskLIlCRGYbHbhbJs3
         vVY8ZCz18LRIqM27n7hBsyyzWtJOk45wHLrOZ1jJq4U+GMHg4JAfIYLN6icUYTk6bIWL
         bZz6mFS0aCjQhULTCFQB9iox5YUgyQKKpJLHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DnMGstwpP4WxQT6+Xyzo4pEeCxQ24RpGikfTYrXfzQY=;
        b=GwHWL6b8efIEfbVFXioh+ckloh3eIQE5YYdPAFNurRgjdSQrDtcGNEhqpi5q6m1CHv
         eIFf30XblEPMCCtDlp+StfQ+hszlmPeyesz+TvEjRrnyL8NmK5raHS4RCgTl8loSmaiM
         E1CI1Ra/Brkqxn/D6aKd9sI4Qq+8fKF+pxF/79Du2MhnQwV4cDT80nmXczWcSmd1Ml5q
         y+LnrNjj4hYZiyg93z7N9iu903kjBrwe53spegcSJs6z8N8krZ6nLLI/5AwKz2oCTRzf
         o1b1iZGxJg5fr4wdwtoAsTfHzZpFdukfAh0GYUtcQk0Voi0rODzqxTU1BO1B9I9fhsfH
         rYWQ==
X-Gm-Message-State: AOAM532GHbae+LCmOutMaCurYDb7ZykVv5UgbIOf57KL6eaVSQzx2Kur
        eCiZ6rnFMQ8FE6dmaMInrL1e2A==
X-Google-Smtp-Source: ABdhPJwqQxtuAO2y1425kZ1AHL7kW1fwfw05VJtaerHvkwGDyeYpWi8mZjPvow68sf5bREBa7UzKig==
X-Received: by 2002:ac8:4892:: with SMTP id i18mr247140qtq.13.1631046049650;
        Tue, 07 Sep 2021 13:20:49 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id h18sm94965qke.6.2021.09.07.13.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 13:20:49 -0700 (PDT)
Date:   Tue, 7 Sep 2021 16:20:47 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     pr-tracker-bot@kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] gpio: updates for v5.15
Message-ID: <20210907202047.2tm4q5euaxlb7cjz@meerkat.local>
References: <20210907083613.31268-1-brgl@bgdev.pl>
 <CAHk-=wgQBgkut6zXTbZN45AtJmSceXwDw6Y60ZmwrPkOL__A8g@mail.gmail.com>
 <163104361220.4526.774832613459764535.pr-tracker-bot@kernel.org>
 <CAHk-=wgAi8jHOFuk8iqXsL4Aekst996HGeN18aKQhXd-qu2dcQ@mail.gmail.com>
 <20210907195647.jutizso7o2r4mddj@meerkat.local>
 <CAHk-=wiFkW3XGD+Ejv_mxTaPxh+tpRTCP+zufrWnNEiMm9PPEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiFkW3XGD+Ejv_mxTaPxh+tpRTCP+zufrWnNEiMm9PPEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 01:01:37PM -0700, Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 12:56 PM Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:
> >
> > Failure is always an option. Let me poke at the logs and see what happened
> > here.
> 
> I was spooked by how it actually sent the email just after I had done
> the merge, but before I had pushed it out.

Uh... I'm borrowing some ideas from some large processor manufacturers and
implementing what I refer to as "speculative" pre-processing of pull requests.
If you've previously merged similar-looking requests in the past, then I'm
just extrapolating the average delay times and sending predictive
notifications.

The real reason this happened is just bot stupidity, actually. In your
response to the pull request in question [1], you had the following lines:

>     Merge branch 'ib-rockchip' of
>     git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
>     into gpio/for-next

[1] https://lore.kernel.org/all/CAHk-=wgQBgkut6zXTbZN45AtJmSceXwDw6Y60ZmwrPkOL__A8g@mail.gmail.com/

This was enough for the bot to think that this was a whole new pull request,
which it catalogued as pointing at commit 8096acd7442e613fad0354fc8dfdb2003cceea0b
(where linusw/linux-pinctrl master is). Then, since that commit already exists
in your tree, it sent out the notification.

I'm not sure what the right course of action here is. On the one hand,
recognizing your response as a pull request was clearly wrong. On the other
hand, a lot of valid pull requests are actually very similar to that (just
someone sending a "please pull" and a URL in the body -- often as a response
to a previous message, so we can't even reasonably weed out subjects with
"Re:").

So, we can either live with an occasional fail like this or I can try to
figure out how to narrow down the rules for what is and isn't a valid pull
request. One option is to check if the object is already in your tree and
over a few days old -- which would indicate that it's obviously not a pull
request to which we should be paying any attention.

-K

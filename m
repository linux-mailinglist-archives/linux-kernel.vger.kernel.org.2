Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6643D402FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346468AbhIGU2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbhIGU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:28:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12363C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:27:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q21so551811ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNnWr7VvFbJVbHak9kzp8+A6N60RsRSsS3eaMhvDg9w=;
        b=dHhZoSbrc9jWRGG2vEoUeiijoLGiPxW++foOws+QuVh2LrLYuJ+tCVwuNxIipJVZiL
         oR7MAdYImKp2LiksWPkITfXqUtoLqq9zDDbaTXUMBNnZUPgMzpq25BkouYXu/XVZq0lB
         CPX5srk4/vlW/QWGQ0ICoBHq8bPy7YQhkNDmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNnWr7VvFbJVbHak9kzp8+A6N60RsRSsS3eaMhvDg9w=;
        b=ija/C7Rs6PIgtKCSIaItxagSoHWhzp9K3GfFtN3jenmMLNgckZ9PEArjQL47R1uQn4
         U6beG6HMM6b/kugudiAunphuf7GaiseK2C16pwgjEOMwdhmUjlPNC1T07Sk6eT/drJ9p
         +kX+npX7i7fAEc66eDVW4cB9aOsbDfxI5HdHXs9+R+pa1d9VHH6+63RdnhCx5WgeqWHR
         bAFf/T2UZL455fULhNCP++fVKqxhMKRSYCUE2VY3iW50vvxQ3Jq3mYv/IOd5hYQhFB1c
         XPxQX6aGMf8sZtX0JBg8ErUHOrKr9++gDylBlYBIPIIcuBHrVQ9gYYFqrpk/TbJMzQa3
         52ig==
X-Gm-Message-State: AOAM531moiVxx2EB0wOqdcSkVky+VRix3KvQRVZFCWnh4NoTGJQKiqBb
        hRg7Zx6AYSjgKAJi7U8HKCZKhe4KLU9/NGEJU5M=
X-Google-Smtp-Source: ABdhPJx8nhK3hDCEQKqGRpP2fyZJNYECWsLxwi/QB452/UnoJzTArVHyVde/l7/pJIl0T64YuQHDNg==
X-Received: by 2002:a2e:8650:: with SMTP id i16mr63844ljj.354.1631046422154;
        Tue, 07 Sep 2021 13:27:02 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id x24sm1094756lfc.246.2021.09.07.13.27.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 13:27:01 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id k13so247473lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:27:01 -0700 (PDT)
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr158455lfg.402.1631046421443;
 Tue, 07 Sep 2021 13:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210907083613.31268-1-brgl@bgdev.pl> <CAHk-=wgQBgkut6zXTbZN45AtJmSceXwDw6Y60ZmwrPkOL__A8g@mail.gmail.com>
 <163104361220.4526.774832613459764535.pr-tracker-bot@kernel.org>
 <CAHk-=wgAi8jHOFuk8iqXsL4Aekst996HGeN18aKQhXd-qu2dcQ@mail.gmail.com>
 <20210907195647.jutizso7o2r4mddj@meerkat.local> <CAHk-=wiFkW3XGD+Ejv_mxTaPxh+tpRTCP+zufrWnNEiMm9PPEQ@mail.gmail.com>
 <20210907202047.2tm4q5euaxlb7cjz@meerkat.local>
In-Reply-To: <20210907202047.2tm4q5euaxlb7cjz@meerkat.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 13:26:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEPq1QkCMQvL449rdEbJmhkpUo0Uv5OkisYeYKv7LcsA@mail.gmail.com>
Message-ID: <CAHk-=wiEPq1QkCMQvL449rdEbJmhkpUo0Uv5OkisYeYKv7LcsA@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: updates for v5.15
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     pr-tracker-bot@kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 1:20 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> So, we can either live with an occasional fail like this or I can try to
> figure out how to narrow down the rules for what is and isn't a valid pull
> request.

I guess the occasional false positives are fine - if this was the
first time I noticed something like that in the almost three years (?)
we've had pr-tracker-bot, and you figured out what happened quickly,
it clearly isn't a huge problem in practice.

           Linus

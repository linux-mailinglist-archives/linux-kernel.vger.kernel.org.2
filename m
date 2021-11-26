Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F204445E3F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 02:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbhKZBYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 20:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbhKZBWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 20:22:08 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F0CC06175D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 17:17:30 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id n66so15767782oia.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Od+ySjjFhxRYMYxmCjjF/atFp38NKQiXX3R9mG25u1U=;
        b=rlaNmopmdxpmRhI68bh9xfiePxM4NRw3sd2puoAGv1UUCg+x//QQ8mlRn0P0A97ELO
         iLW82dW1jC90Tmmc52xSGvLME0s+tzAMwyt03JEhV7UREahtYafqdEiJ4/1djK+3ZePH
         uWMa3sc+6hBmilVZjLOzJBl8VXh3yB36nwdq6nJPS0RHVqtWaX7KnYKmm/MhM8MYlFt/
         U3u0Ve9k5/XkJQiAgklfCrkW9Dytey2eth/ItjPVL02L2oGvdxrDkxcoL1o2fp07MGIs
         zBCfY3HNb7PiZEDIxSMSgU3zIKzQ8L6DcDq08NrKa7sakmt8i+vmUk7hqGhKQKu5vQCN
         tXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Od+ySjjFhxRYMYxmCjjF/atFp38NKQiXX3R9mG25u1U=;
        b=26zlu94szwSJ93aSlvjBH31AsU3T6xjZ/r7bcoIPZ1ZRoql+hWPTeaLm8fjgOLo2vw
         O80d9F0HRwZ9bKj/MfOQsV4TPydyXUrum/l2FdwuauKoVe3WrwV6SLtseIwGGSwE7yNi
         NHmsjg+vc7FaKwcjhfIlgRbi4h9ZRQ4rp1ZDtwc8Iz9qJN4vs6E6/+5GIIO/My5DpoBS
         rv+gtAx9QoNBQbrz3Z5739I3ow/wUKYvDGDsnKqe07eEqytvZLVYvpyKlZAAYnoeAGhv
         mmv0l2cF30gO1jjWlWGqUc/NbRi/fCzSm51PGVdEthQ2kw8g3k6SSn5MkHxjP7alVxVD
         bnvA==
X-Gm-Message-State: AOAM531P5MJMElAa/ein+f224nhwFhC+TqumbAtkuYYSfJY9m2aDSjMn
        LGtclgDV9J/YUH8YatsM0h2LunAoHcfafW00BeRWDg==
X-Google-Smtp-Source: ABdhPJxN8xXtCL8trbzcImBq6BHkAMLjbBKtbeSeg2aMmb/JvoO7mh5sEnm3HadQxxajk60V9jJ8teZFmcZSZZ7yEEU=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr19809406oih.162.1637889449635;
 Thu, 25 Nov 2021 17:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20211108214148.9724-1-shreeya.patel@collabora.com>
 <YYp8JzxfLK2u0fU4@arch-x1c3> <87tugdxkj6.fsf@collabora.com> <d7d8bd97-3c12-bf04-a0ad-e0f391158d01@collabora.com>
In-Reply-To: <d7d8bd97-3c12-bf04-a0ad-e0f391158d01@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Nov 2021 02:17:17 +0100
Message-ID: <CACRpkdbPKW10YrzCPKPiJpPTAPPBSiV9CUiJgvasozOfjNbUKg@mail.gmail.com>
Subject: Re: [PATCH] gpio: Initialize gc->irq.domain before setting gc->to_irq
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        andy.shevchenko@gmail.com, sebastian.reichel@collabora.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:56 AM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
> On 16/11/21 1:23 am, Gabriel Krisman Bertazi wrote:
> > Emil Velikov <emil.velikov@collabora.com> writes:

> >> Hi Shreeya, all,
> >>
> >> On 2021/11/09, Shreeya Patel wrote:
> >>> There is a race in registering of gc->irq.domain when
> >>> probing the I2C driver.
> >>> This sometimes leads to a Kernel NULL pointer dereference
> >>> in gpiochip_to_irq function which uses the domain variable.
> >>>
> >>> To avoid this issue, set gc->to_irq after domain is
> >>> initialized. This will make sure whenever gpiochip_to_irq
> >>> is called, it has domain already initialized.
> >>>
> >> What is stopping the next developer to moving the assignment to the
> >> incorrect place? Aka should we add an inline comment about this?
> > I agree with Emil.  The patch seems like a workaround that doesn't
> > really solve the underlying issue.  I'm not familiar with this code, but
> > it seems that gc is missing a lock during this initialization, to prevent
> > it from exposing a partially initialized gc->irq.
>
> I do not see any locking mechanism used for protecting the use of gc
> members before they are
> initialized. We faced a very similar problem with gc->to_irq as well
> where we had to return EPROBE_DEFER until it was initialized and ready
> to be used.
>
> Linus, do you have any suggestion on what would be the correct way to
> fix this issue of race in registration of gc members?

Not really, we just haven't faced the issue until now because it is only
now that people have actually added all these devlinks and deferred
probing and what not that actually starts to stress the system and
now that results in it being less stable, right?

How do other subsystems do it?

Yours,
Linus Walleij

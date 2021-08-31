Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537413FC883
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbhHaNne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbhHaNnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:43:31 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C1EC061575;
        Tue, 31 Aug 2021 06:42:35 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b7so24847104iob.4;
        Tue, 31 Aug 2021 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/T4oXxIZKVXcXuK4xo4FO0eUgZsswaNawbX1ar73vJY=;
        b=YTCuGPHaE/M2F5PZEGC2L/zzZfxy8dVhvnvzZYwmm3xf/Gi20rmsGYkpJDmB90B4GE
         4bpFmfkAv2xpClmwba0vZOETrmpy+Jt5aPHvLEa/EWIUVsU9vARzdaHo17c1Ky/3nOcn
         4UDb4aTJxLkkDsl5GD9o45Z5T8qdupa/rudoBBguEqQV85qCZ4xY6tCkW7/WrK9RhuCH
         +qItJnHKxj1EuTt/5U3we6rWvlpyPDRPMnWvTC9c8m6QsgQQHeVlv4sUkwXrlh0SX/IN
         prZ47i+a4W74xrFP8hdS3ftnYHW5mGCm2ca2ZWiDldixcHFDj2u0u1qHlWzMNo2Lw8xJ
         IAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/T4oXxIZKVXcXuK4xo4FO0eUgZsswaNawbX1ar73vJY=;
        b=KXQjDSTP0qQdxiy0XAbUe61kUcma1a86qRU9uqEoirtFwN0nCcCAsXCOZKOXt1nlZp
         SRHTnai+MIXhPWE5a5KdgKFGvLlrsAERydZcxGmZ8FIOxRQ4DhXXXmS0ATEZpPrN/SA3
         Ijvq/RNC+17PAel36pdvaCom2VRtWae9RSgO/iqpmBw8Mkb38nKJSN+ozBjgucJuEYhm
         B0dYo7ia1lQQSdkl5TOOjdTkHmLt43OpVi0LxgaeeP5IY9y8xY9t2VFyzEOGrsYLLEQq
         Cyu2aiXRo82ig5qyadMeIkC8TS/BS9KZ9AaZDbULBJoPKeYLqdlrYHFtgv762fN8tgwA
         T78Q==
X-Gm-Message-State: AOAM5320JST4x3J1kbrkXCokYVUN6FvlJV+n54zOB20TnxZ3ntba+uL6
        K3R3k0K2Q+4m5StU4AGJ0SCcawxg8Mv7SQv6zA0=
X-Google-Smtp-Source: ABdhPJw4lII5+mP2IjiI7gw8j7KxgaPU/kBhn676pl7jR3vSimgmTPlFzm6EAay+u/ZodVqWYPpPEyk5+ENo17HBD/0=
X-Received: by 2002:a05:6602:2597:: with SMTP id p23mr22902651ioo.195.1630417355164;
 Tue, 31 Aug 2021 06:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <0c5910979f39225d5d8fe68c9ab1c147c68ddee1.1629314734.git.christophe.jaillet@wanadoo.fr>
 <f8a4a6897deb0c8cb2e576580790303550f15fcd.1629314734.git.christophe.jaillet@wanadoo.fr>
 <c56617ff-5d74-9b07-4bcc-25f3dd2aca64@gmail.com>
In-Reply-To: <c56617ff-5d74-9b07-4bcc-25f3dd2aca64@gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Tue, 31 Aug 2021 09:42:37 -0400
Message-ID: <CAOGqxeXrkv2-7CX34QMQgmtkOwQo2fmmDYbKxJ3hUNAB3gXkEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: bdc: Fix a resource leak in the error handling
 path of 'bdc_probe()'
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 4:03 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 8/18/2021 9:32 PM, Christophe JAILLET wrote:
> > If an error occurs after a successful 'clk_prepare_enable()' call, it must
> > be undone by a corresponding 'clk_disable_unprepare()' call.
> > This call is already present in the remove function.
> >
> > Add this call in the error handling path and reorder the code so that the
> > 'clk_prepare_enable()' call happens later in the function.
> > The goal is to have as much managed resources functions as possible
> > before the 'clk_prepare_enable()' call in order to keep the error handling
> > path simple.
> >
> > While at it, remove the now unneeded 'clk' variable.
> >
> > Fixes: c87dca047849 ("usb: bdc: Add clock enable for new chips with a separate BDC clock")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>
> > ---
> > Review with care.
> > I don't like shuffling code like that because of possible side effect.
> > Moving the code related to this clk looks fine to me, but who knows...
>
> There are no register accesses until bdc_phy_init() gets called, so this
> looks fine to me. Al knows this code better than I do though, so it
> would be better to wait for his Acked-by tag.

This is safe.
Acked-by: Al Cooper <alcooperx@gmail.com>

> --
> Florian

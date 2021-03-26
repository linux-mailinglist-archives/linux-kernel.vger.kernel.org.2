Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD434A5C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhCZKp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCZKpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:45:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE2EC0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:45:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m12so6962351lfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IK4/sJNKpiXcAkZPkWde1UY0aLQTEEelKUznm20o8Vo=;
        b=CJyacTlwtLXGbCs5AoYG0JIafM42Hz1J1CXyseLv1SRT+wY5/h0dnDuwnUZ06+OO5P
         UMrVbLtH/LGKm4kylBJfqkDHuzu35nFH7+7oL63TmM6kE2amaSMs8Xm8v+7wl83SSuga
         5k46KN0hPWEgJH5R0IPffVF+EbdzcfKeGsSex+CMEQiPyxipLyD98BogEF8y0vGOTqy1
         3bowHgeLnqLHM1s7elKdEEiuG8NjpZSoFy6iXFTY97mlyz1xcIhSKgE+2j8cHECHtZuA
         7A1tyE2j3XTtMJZIW/747ZEIG9obesEuUIujyB31FLAcuU1kZ4y6tnXFXSuwWbbY/U4C
         yJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IK4/sJNKpiXcAkZPkWde1UY0aLQTEEelKUznm20o8Vo=;
        b=j5+E6ILCxWM8PyMhIkt2hADqxuJwy3qd0G3TxsJoPOV+50YVZ8fkenAzAJO3Af1eZw
         bmDdTHHWeQj7iGQ0AU5oNagdUjlWu9S1+DOb5QaPIAGUqJB7OsE+z99s46GcymqROV3L
         YlueSo3lNfg/5+Gs+S678XRctqsLpQM3P8RiyWkfS459z3s93Oy+Lqtmu0btwd8o6FZi
         rNpgsc45Y1SH7Oc9FyNEBNiWDLF8TJTFicUKkrz3ykS6yItKcl/AqRiKwH9vvK2IxWws
         L0b4N4SO7//S5AgbpwD6QrrTXo5ylgkMbd1w9tqJndKkaXmeaKdi/knraMy7OWBGVCTL
         qAgQ==
X-Gm-Message-State: AOAM533tGjeFyVK5rqB7QJ7qVImg85eOyPCHtS6wxss1Bw8gaCXfOv9I
        YqLLteuEUqgeFd7Kj1ZqdVAsV8aiZS37NbaAodewkA==
X-Google-Smtp-Source: ABdhPJxT1rj22fVGJqVzGXNuT9Wc6xVCgWO8b1atXNowepxcEYEwKbab92Vj3dYjxrucjH3qTZ0gJX+42SONzCvB7R0=
X-Received: by 2002:a19:6b13:: with SMTP id d19mr7522600lfa.291.1616755538184;
 Fri, 26 Mar 2021 03:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Mar 2021 11:45:27 +0100
Message-ID: <CACRpkdaHMKueLr9Q5CAXQXN5A5FwZScfroE-DYfK+NaGXaqN1A@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Driver of Intel(R) Gaussian & Neural Accelerator
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Olof Johansson <olof@lixom.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 7:39 PM Maciej Kwapulinski
<maciej.kwapulinski@linux.intel.com> wrote:

> This submission is a kernel driver to support Intel(R) Gaussian & Neural
> Accelerator (Intel(R) GNA). Intel(R) GNA is a PCI-based neural co-processor
> available on multiple Intel platforms.

I clearly remember Olof Johansson talking about the potential need
of creating a kernel subsystem for inference engines, so I believe he
wants to be in on this discussion.

There is already misc/habanalabs, and I personally feel this is already
going in the same direction as did pin control before we standardized
it (somewhat), with vendors claiming they are all necessarily different.

So are they necessarily different? New frontiers in the Wild West
every vendor shooting from the hip without any attempts at
standardizing this thing?

Habanalabs was first at this and they made it in, has there been
any attempt to see if the two drivers could actually share code or
have anything in common? Could they share interfaces to userspace?
That kind of thing.

In the end what kernel users want is to be able to write a
userspace making use of any kind of inference/statistics engine
without having to worry about the underlying hardware, this is
what abstractions are for.

> The driver works with Intel(R) libraries in user space. The Intel(R) driver
> exposes a few IOCTL interfaces for use by libraries in user space. The
> libraries are open sourced and are available at:
> https://github.com/intel/gna

This is nice.

Have you made any attempts to cooperate with anyone else in the
world on this, or is this Intel's personal playground?

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1C0331728
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhCHTXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhCHTXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:23:02 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2833FC061760
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 11:23:02 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hs11so22653451ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 11:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5hm6aHK8+K1Uogp8/qJt3hNGrKpWyW0WQaeRio5Q8A=;
        b=TDedw5QVb9bgoxauwP+/OGfYJGObXA0ByQkjCJSSQrS2iCpc1a8qr0/xxLjEWCJ5dj
         3QQP7JKMsHMkFex5umK1Usd8muY6HMrHv4z4Sx5Uvt7hvuj9dGlrVh+q4Jefpx0MT46+
         7QvtnA1P5iSn+pmgxNr03XoFdiTS87LdwGaPguXPHiWwJlmBxXH1x87XWAwJUFBiQ45M
         ypv1dAz3f2CQ7mTbChiMm5iQJR+5MNfS8PYfZZk5sH/ciwaF79Y8AuGhobVIIKXAJ0q8
         wabCkxNVQ8X3xuVAl/JgPny5GorlIVmPhEOy38rPd2Z0RaEYyvwyoKRim615b2ygZS0S
         Qpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5hm6aHK8+K1Uogp8/qJt3hNGrKpWyW0WQaeRio5Q8A=;
        b=fbJeDR9Z/WxQzSkRcHg1wlFo+aMvhX6sxDUgU4nQkoEHZ4m804rOkGIfr0U2b9yZId
         Wwq4rrirTwzy3+x7EebgI3VjqL/LCxhusT2mY0NjbV3ta0NuTSLPzqHMpo36TuJeCg0N
         Y7Za4ca8USDE8OdvxR55DY0q2vBCRuUzQ9EQL/J5H9fZHz2W2IZAaekOr379MOPW3chd
         yojViU7P6TPjYEQOCShznRp7Fm+ljwzzHbLHmctjEAY4gboD3Rkp1b3spyvlGHGUhlQS
         H9MGSU+8P7Gdtfl/0o8+C9Q6LiE5RkfhUAoYcHoXIzmWTltI6k3iTpS8DUmcOEkQH+I9
         Q2DQ==
X-Gm-Message-State: AOAM533/5N7KP9Yo9mD7FcsR576U59BaJ+9LgDm4sX/T8lLKxieJZej2
        GmuC7oHASg5dexyVhNubGvSDp64fKp5+TTvzoKoXyg==
X-Google-Smtp-Source: ABdhPJypPPr/xuf9LRgK9t/szYCa+1qZSOmBNIq3CvaYF8+xtRCD8J3V2cw8H+R8RASkwpKC8ecMCSCP8b3t3qhyRi4=
X-Received: by 2002:a17:906:bb06:: with SMTP id jz6mr16303394ejb.429.1615231380809;
 Mon, 08 Mar 2021 11:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0gR=gN2ROo9JSOGHokw5imscMBwDERni8X83p0eWt634w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gR=gN2ROo9JSOGHokw5imscMBwDERni8X83p0eWt634w@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 8 Mar 2021 20:22:49 +0100
Message-ID: <CAMpxmJUQ3r0YCeQvPq=SW57w-5BLtoTO1_bv=2uw6CX_1-EXcQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] gpiolib: switch to fwnode in the core
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 7:22 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Mar 4, 2021 at 9:13 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > GPIO library uses of_node and fwnode in the core in non-unified way.
> > The series cleans this up and improves IRQ domain creation for non-OF cases
> > where currently the names of the domain are 'unknown'.
> >
> > This has been tested on Intel Galileo Gen 2.
> >
> > In v3:
> > - fix subtle bug in gpiod_count
> > - make irq_domain_add_simple() static inline (Marc)
> >
> > In v2:
> > - added a new patch due to functionality in irq_comain_add_simple() (Linus)
> > - tagged patches 2-4 (Linus)
> > - Cc'ed to Rafael
> >
> > Andy Shevchenko (5):
> >   irqdomain: Introduce irq_domain_create_simple() API
> >   gpiolib: Unify the checks on fwnode type
> >   gpiolib: Move of_node operations to gpiolib-of and correct fwnode use
> >   gpiolib: Introduce acpi_gpio_dev_init() and call it from core
> >   gpiolib: Reuse device's fwnode to create IRQ domain
>
> [1-4/5] applied as 5.13 material and I have a minor comment regarding
> the last patch (will send separately).
>
> Thanks!

Hi Rafael!

AFAICT this should go through the GPIO tree as usual. Any reason for
you to pick these patches this time?

Bartosz

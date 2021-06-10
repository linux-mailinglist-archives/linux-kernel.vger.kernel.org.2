Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38873A350C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFJUs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJUs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:48:27 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A14AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 13:46:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r16so6720677ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3feXPo8hgD2FD68i8SPgVY8I4kuiJLBZN2g8qdSekM=;
        b=yY+WLokJziltoHJ9f3XgfvwE/LSudYOXHFaEMxWzIlSAyHQ4l4493Euz5Bx9wQPb7a
         jpyTB8qdbkY1dJd4TqfOgK+VuvohCE29cXAbv6BGujgKABmWag8PeU0649zqKmpPK+d3
         L3YeQfMXlzWmcQPkHTiWmDTr2Ly+swbU10hGAGB5DlKfZSPjiUa/medL+veah9aYlzKz
         HWakmG2quynID1DJ+/m3r5Vq1EEnUjoQA2Ht+5jxdI5W6AowYsdQm9TP/2CtP0evZfaU
         1pJBZ9tM9E79EbjLcTa47JCMa41g7dXjg6ykRGszpx/NJB5cC9Ep31xpV808Li2sJr9h
         U89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3feXPo8hgD2FD68i8SPgVY8I4kuiJLBZN2g8qdSekM=;
        b=slw18+cTSqcO+3KvrL2e4SVcDOVIyiCFn1tr3vVIhF65v1Nj4O0oXtwk7HYYx6bfCp
         WR/ZtUZPl7No2rlu6VELToSArc7EZdzRPvxedr0PasS2QLMT1DyQCxiq6//5NOUmnBBj
         0PotiARO7DkZRT/M8wFmkY5AGnsHXNNdbLUwFQ0QlA0hIan5Dt3TNDW6VGCQq9skV5QE
         8wG3uogsvBOBT1Ajn0QqX9+3nxv3BtDTSx/DsoqDee0XdxS2ZbVN73RsUXxuREkBvwzV
         pwjPTAv/eaZ5g4tKG0tO6nRkUOEVWMxY+Fm+6PQf6TxYnjKpgEScfseCoRv650zPs/4M
         Q0FA==
X-Gm-Message-State: AOAM533GE5xdeCs9NsX0zbT9DIH83H2XYX3yyLUjHVtPHssZOnIf6CzT
        fkDZpxwlB87l+SGK8CkaO2C60UBta9kR6DNUUwUxPQ==
X-Google-Smtp-Source: ABdhPJxNKGpZ/jjSlWl2zoMMOz8tNxjDSR41dSYXKzHTgV7+ERxWWp9zJMl7Q6uw/IGcGvfEK0j0qWyEO2QHKxTxfVQ=
X-Received: by 2002:a05:651c:1411:: with SMTP id u17mr327855lje.438.1623357976125;
 Thu, 10 Jun 2021 13:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org> <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
In-Reply-To: <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Jun 2021 22:46:04 +0200
Message-ID: <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh!

thanks for working on this, it's a really interesting driver.

My first question is conceptual:

We previously have Geerts driver for virtualization:
drivers/gpio/gpio-aggregator.c

The idea with the aggregator is that a host script sets up a
unique gpiochip for the virtualized instance using some poking
in sysfs and pass that to the virtual machine.
So this is Linux acting as virtualization host by definition.

I think virtio is more abstract and intended for the usecase
where the hypervisor is not Linux, so this should be mentioned
in the commit, possibly also in Kconfig so users immediately
know what usecases the two different drivers are for.

Possibly both could be used: aggregator to pick out the GPIOs
you want into a synthetic GPIO chip, and the actual talk
between the hypervisor/host and the guest using virtio, even
with linux-on-linux.

Yet another usecase would be to jit this with remoteproc/rpmsg
and let a specific signal processor or real-time executive on
another CPU with a few GPIOs around present these to
Linux using this mechanism. Well that would certainly interest
Bjorn and other rpmsg stakeholders, so they should have
a look so that this provides what they need they day they
need it. (CCed Bjorn and also Google who may want this for
their Android emulators.)

On Thu, Jun 10, 2021 at 2:16 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> +static const char **parse_gpio_names(struct virtio_device *vdev,
> +                              struct virtio_gpio_config *config)

I really like this end-to-end plug-and-play that even provides
the names over virtio.

I think my patch to the gpiolib to make it mandatory for names to
be unique per-chip made it in, but please make that part of the spec
so that we don't get the problem with non-unique names here.

I suppose the spec can be augmented later to also accept config
settings like open drain pull up/down etc but no need to specify
more than the basic for now.

But to be able to add more in the future, the client needs some
kind of query mechanism or version number so the driver can
adapt and not announce something the underlying virtio device
cannot do. Do we have this? A bitmask for features, a version
number that increase monotonically for new features to be
presented or similar?

Because otherwise we have to bump this:
+#define VIRTIO_ID_GPIO                 41 /* virtio GPIO */

every time we add something new (and we will).

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA633A17DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhFIOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:51:54 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43883 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhFIOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:51:52 -0400
Received: by mail-ot1-f41.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso24126992otu.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTh8R/SkvzXRGPhrTpf9c7cGy1PDb0Bu2dMrsT+Lr58=;
        b=FPzO9ihEhaNG25m8QGxh9tnKYkMoGw9gihqtV1WIQIcLGQYskRIRCSf1teruEnhZHD
         VVIL3nL8S/B17XEbFTa59hURmeC98BwnGJr5HjtPWGQJNriLx91IWqcWs9zZdC/SQJlX
         c0XCxEZ6VdmlFLOBcoYzPxy/f3XLhxveDIfZmGQXHu5T53WV4j6tOVGL9CeziaNpACTi
         TCsMCJBIOdhsQDuUgtbIvts0Tt/c6DSNm7YMeejEAfUMMOZ2iYzP6ALnQHhDFJS+EHz4
         HFGn1hFJKg6GPQ4kl1Ov2wjOoeYDZJU15c8BeIVy35iqbflPhsp6NQDoRQ2dyKGmYm/6
         4YvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTh8R/SkvzXRGPhrTpf9c7cGy1PDb0Bu2dMrsT+Lr58=;
        b=LB1pfby415KT8p5bVsPQziT8a8hZs9CkiYUZ28KqCodfw9PaT2iRQZUCbLE8c8GGDQ
         SpSGY53+gH+Dfky0X1uyyxlhgoV8ct60lkK5qLmvuqfJtfVt6UJh6JcvR87Wfov3B87w
         bjpT/GaienQYz54WwsynNJgVjpBaV5/CI1TtlBcUxKxsr1ieaysyzP+EeTF35j4QDd0p
         GHfs+Sv6xlaN8papjLq/N4LE0cVF6KG+L3jAU/uB/jfNPItDXBc1Ft8m8HnAJww8N2BE
         ELEp1iX0fMXNOJ23NiHRhwo8LSf3j0HyUfErRpEEbst6xkp18mnIFj1hJJRcr4u0/05c
         4UXQ==
X-Gm-Message-State: AOAM531CY3cwiQFMhdOsAXayNvd2dyPnUuftcdmuc+aYUzKBhqb6waJM
        uqCtb36tfPXyL9R1eWTthHaBOxRFW8lsBU1Ft6Exqw==
X-Google-Smtp-Source: ABdhPJyLL9+tqO5KcCRA4d6MWqmNxcy4/ZqxjjqPSSqTT4wybkdYZwiLqGYwAmkreE9Nh3X1l6SRPT3u/FP8capReSQ=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr8740513oto.17.1623250125090;
 Wed, 09 Jun 2021 07:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210607125653.1388091-1-elver@google.com> <20210609123810.GA37375@C02TD0UTHF1T.local>
In-Reply-To: <20210609123810.GA37375@C02TD0UTHF1T.local>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Jun 2021 16:48:33 +0200
Message-ID: <CANpmjNMvvdaBsN4QFVQ2CW7mB0yW2J0EF9aMd7RFg-K8BMkdgw@mail.gmail.com>
Subject: Re: [PATCH 0/7] kcsan: Introduce CONFIG_KCSAN_PERMISSIVE
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 at 14:38, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Marco,
>
> On Mon, Jun 07, 2021 at 02:56:46PM +0200, Marco Elver wrote:
> > While investigating a number of data races, we've encountered data-racy
> > accesses on flags variables to be very common. The typical pattern is a
> > reader masking all but one bit, and the writer setting/clearing only 1
> > bit (current->flags being a frequently encountered case; mm/sl[au]b.c
> > disables KCSAN for this reason currently).
>
> As a heads up, I just sent out the series I promised for
> thread_info::flags, at:
>
>   https://lore.kernel.org/lkml/20210609122001.18277-1-mark.rutland@arm.com/T/#t
>
> ... which I think is complementary to this (IIUC it should help with the
> multi-bit cases you mention below), and may help to make the checks more
> stringent in future.

Nice, glad to see this.

And yes, this series isn't a permission to let the 'flags' variables
be forgotten, but perhaps not every subsystem wants to go through this
now. So seeing any progress on this front helps and we can also use it
to give concrete suggestions how to approach it (e.g. your accessors).

> FWIW, for this series:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thank you!

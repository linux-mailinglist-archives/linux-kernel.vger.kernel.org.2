Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055AA40B486
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhINQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhINQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:25:08 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE0C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:23:51 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i12so29244623ybq.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkxiKkJZQPWUnpA6UjGhhzm6GH94OQg2pGbIC1WarNM=;
        b=fsdy8CO4MDN9vRVkZ5380u1LLS9x/4EZYu26hzE4qPVmI2wLvUwoUYCXwYz1AKSfM/
         X9Xy2BTu+pqQi2e1mRyi3bWmdKY8CWXHhGEdHWtKYSmS56X1C1zMLlQzsVvk2I6HMY32
         p9g5aQ+5Hrl3J8iZpoLxRbeUg9L92MKvW3twiX64HDp1GnKNcU6CYLHTykKpKOLdeL3o
         r1puXXoiB+HsrQ7K2F90MmbKfP8tnqENjSE0tgC9hDokJq2UmYmzuxX4OpEYqBNuZOX2
         YqoA2MWZB2bweBf3RuD+4feiwqkVp/593zC3SHRyqn7MuR9bXIusDv0Dscr4CISDZ/7E
         GsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkxiKkJZQPWUnpA6UjGhhzm6GH94OQg2pGbIC1WarNM=;
        b=jJSrO2REuHYAcCDu1dVzKbJhUzefgT02z68lA+7NNEyNwUeWY4IiHMAaEoE73rf/Ih
         p+73Sy5NQJlor89O7b460vOG1sqrKUOavJFncocHpEAtyIajnGlt5Vwsw+Andt82u52q
         dKMdrffrqoWXvw/GSGlH2d1jfZYr+4YhcN+pOM2i59evkHPmYacAZCaA+L7O/ectVcmw
         ZejMQ25fgUYevn4B02v/g8R0Mh4ZEkvs7fs9rUWd1ufS9bDMCPpptaIZN/ft/nwnXw1d
         NUCgxFIbLgyqQjxdgH81tmp7wS2k+oRwsISryUw3kHeniYMlapYDsv1sO7xHzzvVlyFX
         0dTg==
X-Gm-Message-State: AOAM532nPfeX/vbyE3RFx+u7NCke5D+WXDOZOvtEUDz+emHj6yX82gXU
        B3g73yqDQIj8mGkdcWYRk4ZJNls/P3t7ihCp+8wYtg==
X-Google-Smtp-Source: ABdhPJzVqZyLqMCvqaWcNI+1LFdBDi2j+7vfC3l/IQLBy/L0I/03cZRg+Udt42V/3GN6t8MxzKPmp4s0/aULUWqB7MU=
X-Received: by 2002:a25:af49:: with SMTP id c9mr19848330ybj.432.1631636630386;
 Tue, 14 Sep 2021 09:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
 <20210914043928.4066136-2-saravanak@google.com> <CAL_Jsq+FXN9cU5h7ZtcR_P6kuF-Hs3Cy-Z8rEug=F_4v0sWggg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+FXN9cU5h7ZtcR_P6kuF-Hs3Cy-Z8rEug=F_4v0sWggg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 14 Sep 2021 09:23:14 -0700
Message-ID: <CAGETcx9rEHG4xj1X6ERtPbL2GjzuNU+9OZPb6zY2hxvHFXnq-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] driver core: fw_devlink: Improve handling of
 cyclic dependencies
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 5:35 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Sep 13, 2021 at 11:39 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > When we have a dependency of the form:
> >
> > Device-A -> Device-C
> >         Device-B
> >
> > Device-C -> Device-B
> >
> > Where,
> > * Indentation denotes "child of" parent in previous line.
> > * X -> Y denotes X is consumer of Y based on firmware (Eg: DT).
> >
> > We have cyclic dependency: device-A -> device-C -> device-B -> device-A
> >
> > fw_devlink current treats device-C -> device-B dependency as an invalid
> > dependency and doesn't enforce it but leaves the rest of the
> > dependencies as is.
> >
> > While the current behavior is necessary, it is not sufficient if the
> > false dependency in this example is actually device-A -> device-C. When
> > this is the case, device-C will correctly probe defer waiting for
> > device-B to be added, but device-A will be incorrectly probe deferred by
> > fw_devlink waiting on device-C to probe successfully. Due to this, none
> > of the devices in the cycle will end up probing.
> >
> > To fix this, we need to go relax all the dependencies in the cycle like
> > we already do in the other instances where fw_devlink detects cycles.
> > A real world example of this was reported[1] and analyzed[2].
> >
> > [1] - https://lore.kernel.org/lkml/0a2c4106-7f48-2bb5-048e-8c001a7c3fda@samsung.com/
> > [2] - https://lore.kernel.org/lkml/CAGETcx8peaew90SWiux=TyvuGgvTQOmO4BFALz7aj0Za5QdNFQ@mail.gmail.com/
> > Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
>
> Am I supposed to apply this? What about the revert and mdio-parent-bus
> support you mentioned? Those are needed too? Please send me a series
> with what I should apply for 5.15, not fixes and new features
> combined.

You don't need to pick up any of this. I just added you for 5/5 and
you've seen how a lot of the debugging goes.

-Saravana

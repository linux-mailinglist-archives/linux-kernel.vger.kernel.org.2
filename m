Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F803FF15B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346236AbhIBQ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbhIBQ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:28:45 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBF6C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:27:47 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id f15so4977339ybg.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJLIiedISCJRyHw16WvJSkD85mHHNgMIgGyWz+lopEc=;
        b=fM+/JeCwdbssBXpOkjmEZ3eIo9++9cKPpbcRN1wKaKgQ4I9DDDeOALD7CaTBisOPz9
         C1FFKVwWxUb5uKAKlOHcOXhksa4rhh6l8dQ/UWlwEAmfJ9c2ym4Zzfcbxzq4/fo3wVOL
         W01nxuHRtWPZKJqHXIk6mfSpWKoXky/+m2foBQ7x8FSyVwc4LUUd9pIPc2m+DEdTVuad
         DfOTGBR6yJH8YE5iEj4/khKub/UXSmvkh7BHCEdbKIVRNgDJmG8qOHcG6Nr9UWyS6soz
         Q9yS8Hys4HcWWTNi3lfeJVSUy6Cb1Yivd0UayQSJLw42Ru3IVlwOAmkn7PehtICiEM91
         /KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJLIiedISCJRyHw16WvJSkD85mHHNgMIgGyWz+lopEc=;
        b=EQr7yJkv2KZQ7DHR7oxQfNEwMplJEk9h8vxFwlGFzY7319H+o0lQClJkHQBMRoY4LN
         ZKTPoURYZBASKE4DhhWaaHtLT51ykLwt+IksB5lwkDupIvVQKocW9wmIUlO5JAcvprxT
         c1qTx1r4bJU+FaxsQBIEIW24XsNzYYArcIaROb2ukrH9lGdyJypefcDh28FVfwl3aUZ1
         Kzd+RUMWfnwxGX56INIyG10o+j6Hwr8WLkbQtKw1QnmGyNsWrR+ZmWEB5Y7nLVS+28NF
         S9ptsffUNeB2FVvD+z7mwrV5ydlOTlV3PK4zKxhtFimAp5nqoqZWmpA+M+ZbgcHJL9Tf
         PlfA==
X-Gm-Message-State: AOAM533rGoUXuG2j+VPO5XIOk2JteEL0IVIyMQ8Re44ZRCwKfg8koMsI
        dSHkUNI8lSMFbl48j7fC2iHrLm2nzY2xkwUu5ln+Qg==
X-Google-Smtp-Source: ABdhPJxLXRFWyfyWl9ok1Aa6XveqWoo81KUXhljpBzB+4qFjXNrtY5Q8+BjSRLkRtw+s/CVzpVUYjS1INpOzcfunDRA=
X-Received: by 2002:a25:d2c8:: with SMTP id j191mr5657920ybg.412.1630600065503;
 Thu, 02 Sep 2021 09:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com>
 <CAGETcx9N34RyrdKDR8dQ7ECyz7ZXBx-Ft16t033NjTiU8p=Y0g@mail.gmail.com> <CAJZ5v0gt_1vKQXxSY6HoHRPR9O_e1f7VwcBnSjeMgCdCibrwgQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gt_1vKQXxSY6HoHRPR9O_e1f7VwcBnSjeMgCdCibrwgQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Sep 2021 09:27:09 -0700
Message-ID: <CAGETcx_dvpFKZnz2w43h=ybp-8YF=OdpW0f2mK+jvDPURDFQJQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Ulf reported an issue[1] with fw_devlink. This
 series tries to fix that issue.
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 8:56 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Sep 2, 2021 at 4:57 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Oops, forgot to use a proper subject. Sorry.
>
> Is this a replacement for the "Fix rtl8366rb issues with fw_devlink=on " series?

No. This is unrelated to that. This is the issue I'm trying to fix:
https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/

This is kind of a replacement to, but the patch below might be needed
in general (needs more thought):
https://lore.kernel.org/lkml/CAGETcx9U2M5i1CAx605fG3Qwm1xwjH2uy4kY4vrAF7YSRSSg+w@mail.gmail.com/

-Saravana
>
>
> > On Wed, Sep 1, 2021 at 7:55 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Ulf, mind testing this?
> > >
> > > Thanks,
> > > Saravana
> > > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > >
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > >
> > > Saravana Kannan (2):
> > >   driver core: Add support for FWNODE_FLAG_NEVER_PROBES
> > >   of: platform: Mark bus devices nodes with FWNODE_FLAG_NEVER_PROBES
> > >
> > >  drivers/base/core.c    |  8 ++++++++
> > >  drivers/of/platform.c  | 16 ++++++++++++++++
> > >  include/linux/fwnode.h |  8 +++++---
> > >  3 files changed, 29 insertions(+), 3 deletions(-)
> > >
> > > --
> > > 2.33.0.259.gc128427fd7-goog
> > >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B7E33EB81
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCQI3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhCQI3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:29:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7DFB64FAE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 08:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615969774;
        bh=HgPQ+EBa8p3tt62cOG8Ydk5U8qgRqHzmMtBST7Y6bFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dIA2l5ozEnTyEMKaBfpdxMvpVIgm2DEQK//kUzVzjz3h+Piw7wycz5JVJ41+fS42j
         jx7DDaMc+BSOizCfYW2lS7q5ATQkKnGI0Wp/yMWc3rxT+BPURbTeoFeE4hl0aaCQZm
         eJM0/1ByaWMWIVPNbjhDU1pB1m64hOnZy8PheDfXCuIMfZiByfxT1+yIxQK9tLzcUx
         p1tCVQlMgOmsj+Yer36x8TgJeXAPb3HP768eIRrfW11G8vO8f7mkQQvKOwoijgJPa0
         Ya3J1dMfDvU+C7/iDH+5eaL83fmFS1NXq+GK9uystaao6dPd+kV0ZXg6AJ3DV0ViNn
         4q8EPr0Mk7wLg==
Received: by mail-oo1-f50.google.com with SMTP id w1-20020a4adec10000b02901bc77feac3eso363820oou.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:29:34 -0700 (PDT)
X-Gm-Message-State: AOAM533+Ekf08I9f+EKf16Jlt0CU5Z5irG+1/w6HXbT6m5N1ZoQ8NiJO
        t1WBa1oLqzNbsq9AQuxXxspQphBGZfU3rkkHo5U=
X-Google-Smtp-Source: ABdhPJweBtcpfwEFs35n/3X53UX4jqzUN4CXwHjLTxST9PwRcM6AfhvQveq9WedvuMZ09BNJxHBd/sU5579vfzt+yhU=
X-Received: by 2002:a4a:bd1a:: with SMTP id n26mr2370461oop.45.1615969774195;
 Wed, 17 Mar 2021 01:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210312083653.38780-1-ran.wang_1@nxp.com> <20210317080442.GA3018337@jade>
In-Reply-To: <20210317080442.GA3018337@jade>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Mar 2021 09:29:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFg1a5ezoVBvrZ7xc7oM2zH-Phu1eNoXv+YZ+Yda1k7SQ@mail.gmail.com>
Message-ID: <CAMj1kXFg1a5ezoVBvrZ7xc7oM2zH-Phu1eNoXv+YZ+Yda1k7SQ@mail.gmail.com>
Subject: Re: [PATCH] optee: enable apci support
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Ran Wang <ran.wang_1@nxp.com>, op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 at 09:04, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Fri, Mar 12, 2021 at 04:36:53PM +0800, Ran Wang wrote:
> > This patch add ACPI support for optee driver.
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/tee/optee/core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index cf4718c6d35d..8fb261f4b9db 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -5,6 +5,7 @@
> >
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> > +#include <linux/acpi.h>
> >  #include <linux/arm-smccc.h>
> >  #include <linux/errno.h>
> >  #include <linux/io.h>
> > @@ -735,12 +736,21 @@ static const struct of_device_id optee_dt_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, optee_dt_match);
> >
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id optee_acpi_match[] = {
> > +     { "OPTEE01",},

You cannot just invent ACPI HIDs like that. The 4 character prefix is
a vendor ID that is assigned by the UEFI forum, the 4 following digits
are up to the vendor to assign,

> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);

dwc3_acpi_match ?? Does this even build?


> > +#endif
> > +
> >  static struct platform_driver optee_driver = {
> >       .probe  = optee_probe,
> >       .remove = optee_remove,
> >       .driver = {
> >               .name = "optee",
> >               .of_match_table = optee_dt_match,
> > +             .acpi_match_table = ACPI_PTR(optee_acpi_match),
> >       },
> >  };
> >  module_platform_driver(optee_driver);
> > --
> > 2.25.1
> >
>
> This looks simple enough. Ard, is this what you had in mind earlier?
>

Not really.

On SynQuacer, we use

    Device (TOS0) {
      Name (_HID, "PRP0001")
      Name (_UID, 0x0)
      Name (_DSD, Package () {
        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
          Package (2) { "compatible", "linaro,optee-tz" },
          Package (2) { "method", "smc" },
        }
      })
    }

which does not require any changes to Linux. So I don't think this
patch is needed at all tbh.

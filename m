Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FFF340066
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhCRHry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhCRHrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:47:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46D1464F38
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 07:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616053665;
        bh=XC3LFglAEZLbOOaRbRogcgjXVbO0jwmOopBAbeoCzrg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R/TIVuPI3ayXAehTysn4vGcUayjJWfpJGiHAokqLTeUDcSU3bDgr+RCId1hQvaJf1
         hzLuSU7JAVdsdKUhAYfwQBjeD+11gbSjEWKAtD8orc8/LPXIkwGDnSaUZ3a5HiIozh
         SIyai/k8fFfuoOzhRzA8WEowGcJTy4W18qss/EM0+w4RCE+jmRKMQgXBH18xukCI4j
         /yURQXHc/gzV2OLj1ALBX5Ruzzvh9VtUkLOYns5YuBMjf8o2BiUQYM0NBgDc17Qew4
         1gI4Wxhp8oiL/TszJIKmn7klo4YyKOkZbjcLDfMocIwTM6ewRHvAubb48DHSk+efuu
         LaAyHKax0276A==
Received: by mail-ot1-f44.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so4362933otk.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 00:47:45 -0700 (PDT)
X-Gm-Message-State: AOAM531sTwDehugMWC7/Y+k8nJVgk6qqQ0ET00Hl/W8c+oXZAy9Njik5
        B06rKtohdG/9g2ey1Hq92kfgPaCe7zxKstZnGOk=
X-Google-Smtp-Source: ABdhPJxPQenmd0w/Pj98FW80g/Ub5XIIgwxk2BOOyq9VU1khtiUSDCad6cLMTCWtTTxp78Z+/9XhwfZRdNCWfz+6450=
X-Received: by 2002:a9d:42c:: with SMTP id 41mr6293768otc.108.1616053664575;
 Thu, 18 Mar 2021 00:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210312083653.38780-1-ran.wang_1@nxp.com> <20210317080442.GA3018337@jade>
 <CAMj1kXFg1a5ezoVBvrZ7xc7oM2zH-Phu1eNoXv+YZ+Yda1k7SQ@mail.gmail.com> <AM6PR04MB54133297642949378521C6A9F1699@AM6PR04MB5413.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB54133297642949378521C6A9F1699@AM6PR04MB5413.eurprd04.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 Mar 2021 08:47:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEfVh-q=cae1RWTVwABYsmX=-OZbWmgRMm4DSK7NjQBEg@mail.gmail.com>
Message-ID: <CAMj1kXEfVh-q=cae1RWTVwABYsmX=-OZbWmgRMm4DSK7NjQBEg@mail.gmail.com>
Subject: Re: [PATCH] optee: enable apci support
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 at 08:29, Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Hi Ard,
>
>
> On Wednesday, March 17, 2021 4:29 PM, Ard Biesheuvel wrote:
> >
> > On Wed, 17 Mar 2021 at 09:04, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > On Fri, Mar 12, 2021 at 04:36:53PM +0800, Ran Wang wrote:
> > > > This patch add ACPI support for optee driver.
> > > >
> > > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > > ---
> > > >  drivers/tee/optee/core.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > > index cf4718c6d35d..8fb261f4b9db 100644
> > > > --- a/drivers/tee/optee/core.c
> > > > +++ b/drivers/tee/optee/core.c
> > > > @@ -5,6 +5,7 @@
> > > >
> > > >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > >
> > > > +#include <linux/acpi.h>
> > > >  #include <linux/arm-smccc.h>
> > > >  #include <linux/errno.h>
> > > >  #include <linux/io.h>
> > > > @@ -735,12 +736,21 @@ static const struct of_device_id
> > > > optee_dt_match[] =3D {  };  MODULE_DEVICE_TABLE(of, optee_dt_match)=
;
> > > >
> > > > +#ifdef CONFIG_ACPI
> > > > +static const struct acpi_device_id optee_acpi_match[] =3D {
> > > > +     { "OPTEE01",},
> >
> > You cannot just invent ACPI HIDs like that. The 4 character prefix is a=
 vendor ID that is assigned by the UEFI forum, the 4 following digits are
> > up to the vendor to assign,
>
> Thanks for this info. Could you please show me where I can find the guide=
/example for this assign process?
>

I think it is better to ask around internally. As far as I know, NXP
already owns a ACPI/PNP vendor prefix.

> > > > +     { },
> > > > +};
> > > > +MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
> >
> > dwc3_acpi_match ?? Does this even build?
>
> My bad, I was referring dwc3 code as an example, will correct it.
>
> But looks this typo didn=E2=80=99t trigger error in my unit-test.
>

Does your build have CONFIG_ACPI enabled?

> >
> > > > +#endif
> > > > +
> > > >  static struct platform_driver optee_driver =3D {
> > > >       .probe  =3D optee_probe,
> > > >       .remove =3D optee_remove,
> > > >       .driver =3D {
> > > >               .name =3D "optee",
> > > >               .of_match_table =3D optee_dt_match,
> > > > +             .acpi_match_table =3D ACPI_PTR(optee_acpi_match),
> > > >       },
> > > >  };
> > > >  module_platform_driver(optee_driver);
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > This looks simple enough. Ard, is this what you had in mind earlier?
> > >
> >
> > Not really.
> >
> > On SynQuacer, we use
> >
> >     Device (TOS0) {
> >       Name (_HID, "PRP0001")
> >       Name (_UID, 0x0)
> >       Name (_DSD, Package () {
> >         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >         Package () {
> >           Package (2) { "compatible", "linaro,optee-tz" },
> >           Package (2) { "method", "smc" },
> >         }
> >       })
> >     }
> >
> > which does not require any changes to Linux. So I don't think this patc=
h is needed at all tbh.
>
> Thanks for this example, but actually I failed to trigger kernel optee pr=
obe function by using
> above code in ACPI table.
>
> And I am curious how this 'compatible' properties be picked up by kernel =
when try to match driver in ACPI mode?
>

On SynQuacer,

$ cat /sys/devices/platform/PRP0001:00/firmware_node/modalias
of:Ntos0TClinaro,optee-tz

> My understanding is to get it done by feeding .acpi_match_table with some=
thing, right?
>

The PRP0001 HID is handled in a special way. Please grep the Linux
source if you are curious to understand how this is implemented.

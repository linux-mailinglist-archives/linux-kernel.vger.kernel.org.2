Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F713BC717
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 09:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhGFH2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 03:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhGFH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 03:28:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4524EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 00:25:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r16so27802629ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 00:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5VNmThjm4DmH+LnsaR0B3iwZoVfeb1fZ3oywOwn7G8=;
        b=cVGcrT9zB5JzTP0aE9nAkyAmZxivH9ZNxMEDzFbar62SLEYX7QeCRPEtCcuzB+zt76
         2WvL2z/tIUIDzTaL1iUq/x48nsuhSoxZTg9vDc9ybquiT4NBmQbPJP5YpueXbFyHx03M
         APlLoefqRDNQii2urEZRAy1AhwsxOdaFu2Tqbdx3EmGNnsKfseEzD+FnOQAXXKn0Ojif
         yVwS3JDB4ZTTxJP8/Q+1yCXnMKeAfNZzmMdY9PkPtLGIIsgFUYnp1/15SoOirApg81SE
         VD7qYJ1Nb9b6VuRlDJTCO1mmkv/ZEnUOnqH6Vkjppsk4Ub0yfTo0TzjUjbd1A6q+H+tw
         J3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5VNmThjm4DmH+LnsaR0B3iwZoVfeb1fZ3oywOwn7G8=;
        b=VBHIigukgGRH+weNCfyqI3f9Jabmi7U0eSwOiFdIfZsq/v/vFWyccMO4a/gjLmStIz
         49+wVxiuSyMSs9yOie31e1T0eNvfBMS8UKEzqwaBNWqVE0VCl/XO2F4VJR9k8ynxn3YI
         efmfe7Vmn0s/yGu/qYnIfvE7QWwsOzX7PAGHiC9Fn3BtqQJul3p4QDJtMa1aoL4h1zew
         ovLPCKrO0L2lnPZNzOlH+RnpgoU9++c1RgMeMAG98h52CTs9L4fpHz5dOTFfxDO4c0Er
         ZEMFgt7dGmJPESVRgvg6WYCGzBLLGjz8DO2WD3dZD8mjonsElZTkil/qpN2sAnmocKyp
         1glw==
X-Gm-Message-State: AOAM5323YDcnT+5dE1JwPfsmcqYgDmHupP8ReG1trOKNXKsgjOXlJ0O2
        YTcyIUSlv30ZSCDPINPHnepWLP/pr7eMr4rtLJ4z+viOmVA=
X-Google-Smtp-Source: ABdhPJzBqENHysNuz9woqwFmjD9B+KAL6Oj7Tqd92ssm66C+8dzfCqg5FMbGILRpUR9/vpr05KVEHQ/454HYf1iVLo0=
X-Received: by 2002:a2e:9059:: with SMTP id n25mr14700116ljg.314.1625556337523;
 Tue, 06 Jul 2021 00:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
 <CAFA6WYMrxNfR09doWQgYKCQSYKyUMVKqSTPuRYn=-nueY9pSvQ@mail.gmail.com> <CAHUa44EeAENHv+CxtXeLuqX_NGWW6w-6P8D-BLsb69+XmGaqEQ@mail.gmail.com>
In-Reply-To: <CAHUa44EeAENHv+CxtXeLuqX_NGWW6w-6P8D-BLsb69+XmGaqEQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 6 Jul 2021 12:55:26 +0530
Message-ID: <CAFA6WYMSAM2MDOXnhjuZFov3BtF8-nihZRUpR8ciUWsL4_nCWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 at 11:40, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Sumit,
>
> On Thu, Jun 17, 2021 at 6:33 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Jens,
> >
> > On Wed, 16 Jun 2021 at 16:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi all,
> > >
> > > This adds support for asynchronous notifications from OP-TEE in secure
> > > world to the OP-TEE driver. This allows a design with a top half and bottom
> > > half type of driver where the top half runs in secure interrupt context and
> > > a notifications tells normal world to schedule a yielding call to do the
> > > bottom half processing.
> > >
> > > An interrupt is used to notify the driver that there are asynchronous
> > > notifications pending.
> > >
> >
> > It looks like a nice feature. I would like to get hands on with this.
> > Can I test this feature on Qemu?
>
> Absolutely, you can get this into the normal OP-TEE development repo setup with:
> repo init -u https://github.com/OP-TEE/manifest.git -m default.xml
> repo sync
> Update optee_os with
> https://github.com/jenswi-linaro/optee_os/tree/async_notif_v2
> Update linux with https://github.com/jenswi-linaro/linux-1/tree/async_notif_v2
> cd build
> make all -j...
> make run-only
>
> If you type anything at the secure console you'll notice how it
> changes behaviour once the Linux kernel has booted.
>

Thanks for sharing instructions as I now got some time to test and
deep dive into this feature. It looks like a pretty useful feature to
realize interrupt support in the secure world in its true sense. This
feature works for me as per your instructions.

I could recognise it's requirement from the time while I was playing
with secure timer interrupt support for OP-TEE RNG driver on
Developerbox. In that case I had to strip down the secure interrupt
handler to a minimum that would just collect entropy and dump into the
secure buffer. But with asynchronous notifications support, I could
add more functionality like entropy health tests in the bottom half
instead of doing those health tests while retrieving entropy from the
secure world.

Given that, have you explored the possibility to leverage SGI rather
than a platform specific SPI for notifying the normal world? If it's
possible to leverage Architecture specific SGI for this purpose then I
think this feature will come automatically enabled for every platform
without the need to reserve a platform specific SPI.

-Sumit

> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > > v2:
> > > * Added documentation
> > > * Converted optee bindings to json-schema and added interrupt property
> > > * Configure notification interrupt from DT instead of getting it
> > >   from secure world, suggested by Ard Biesheuvel <ardb@kernel.org>.
> > >
> > > Thanks,
> > > Jens
> > >
> > > Jens Wiklander (7):
> > >   docs: staging/tee.rst: add a section on OP-TEE notifications
> > >   dt-bindings: arm: Convert optee binding to json-schema
> > >   dt-bindings: arm: optee: add interrupt property
> > >   tee: fix put order in teedev_close_context()
> > >   tee: add tee_dev_open_helper() primitive
> > >   optee: separate notification functions
> > >   optee: add asynchronous notifications
> > >
> > >  .../bindings/arm/firmware/linaro,optee-tz.txt |  31 ---
> > >  .../arm/firmware/linaro,optee-tz.yaml         |  57 +++++
> > >  Documentation/staging/tee.rst                 |  27 +++
> > >  drivers/tee/optee/Makefile                    |   1 +
> > >  drivers/tee/optee/call.c                      |  27 +++
> > >  drivers/tee/optee/core.c                      |  87 +++++--
> > >  drivers/tee/optee/notif.c                     | 226 ++++++++++++++++++
> > >  drivers/tee/optee/optee_msg.h                 |   9 +
> > >  drivers/tee/optee/optee_private.h             |  23 +-
> > >  drivers/tee/optee/optee_rpc_cmd.h             |  31 +--
> > >  drivers/tee/optee/optee_smc.h                 |  75 +++++-
> > >  drivers/tee/optee/rpc.c                       |  73 +-----
> > >  drivers/tee/tee_core.c                        |  37 ++-
> > >  include/linux/tee_drv.h                       |  27 +++
> > >  14 files changed, 576 insertions(+), 155 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > >  create mode 100644 drivers/tee/optee/notif.c
> > >
> > > --
> > > 2.31.1
> > >

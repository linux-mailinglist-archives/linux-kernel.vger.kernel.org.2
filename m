Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FCF3AABB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhFQGMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQGMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:12:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B961C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:10:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso2959732wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdEN2Vn0ZqAgaea6WuXSDsvEZZIPmQuRgjxrGHUy6RU=;
        b=WbEGeUkgSbDt4H0SwzDELXB6Cp96hE7OnIhoEx0zLDHwluepBNsHXSRVpOKDOLlW32
         efy5FMPhuYY4ZwFud67ZBHuzs8jSYxt1lsku8UFm5PtXJeiDcqQ/64BqDJE2dBEY/WL8
         flZ2Lo9nAAirZ6+dxcMEqWyeE+lGPwwcvmwquTKaIIkhukceh7WSUKtrvfR4D37b/TG2
         oaVbQ3DBp4fXqULFCAz6S5CgYmjMm5GZB8nywEHYSDdr/7TdBQPJxTEVc+5PZ/LdYRp9
         Ft2+A4pEWf1vEFFOoY2SwDuy3uha3NQFxbozXXYHdGYiDFVFEad3T2XTFn/U04sGDrPz
         DEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdEN2Vn0ZqAgaea6WuXSDsvEZZIPmQuRgjxrGHUy6RU=;
        b=gBbj2n5rkcN3ghtYHY0jF3gkKbM3g+fpZYr0LNHz75xPXsyiXlDF6wH1fXY65QRci0
         CzdI0FMMqmkLeIkvYlXKXaFggAxfUhvPysTLJZMd12B2P6ku269ck02Qox0ZHh0Jdk64
         snQdQXWlgudj9DL/Ei0Eq1WW7IzdTb6RvaI5z9MPwyysHZ8hPmz6TDzIv53EnFRKVBxE
         KtVRmuaHihl29OztkXqht4/uFbq50Nw1QczsJjlOSjXYw7ukUjHiCNS6y2XMqFwtQfYl
         YYXi6/Ngyn9bayIBWJc2/RiuaGKLccUckuDq/FoVzgcFFbissLEYAfSup8Ww/paeU0hp
         924w==
X-Gm-Message-State: AOAM533IQqZkOtFWtVRSzHHLQpXTp4xQOyDyab21pTL3I534JJ9+jvXk
        Vtx++1GfAh9WtqjNdMdlgRWQgaQ3exssK7r37XujgA==
X-Google-Smtp-Source: ABdhPJxKf3z6pwh4Nj+hbrkpDJZquWEKfvj17MQeD0zeMW7fLPQBjUMEL0NaBMr98rlCUkZPZO5E7qv9oDvS/kylg+U=
X-Received: by 2002:a7b:c853:: with SMTP id c19mr3097635wml.30.1623910212010;
 Wed, 16 Jun 2021 23:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210616103649.2662395-1-jens.wiklander@linaro.org> <CAFA6WYMrxNfR09doWQgYKCQSYKyUMVKqSTPuRYn=-nueY9pSvQ@mail.gmail.com>
In-Reply-To: <CAFA6WYMrxNfR09doWQgYKCQSYKyUMVKqSTPuRYn=-nueY9pSvQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 17 Jun 2021 08:10:01 +0200
Message-ID: <CAHUa44EeAENHv+CxtXeLuqX_NGWW6w-6P8D-BLsb69+XmGaqEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
To:     Sumit Garg <sumit.garg@linaro.org>
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

Hi Sumit,

On Thu, Jun 17, 2021 at 6:33 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jens,
>
> On Wed, 16 Jun 2021 at 16:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi all,
> >
> > This adds support for asynchronous notifications from OP-TEE in secure
> > world to the OP-TEE driver. This allows a design with a top half and bottom
> > half type of driver where the top half runs in secure interrupt context and
> > a notifications tells normal world to schedule a yielding call to do the
> > bottom half processing.
> >
> > An interrupt is used to notify the driver that there are asynchronous
> > notifications pending.
> >
>
> It looks like a nice feature. I would like to get hands on with this.
> Can I test this feature on Qemu?

Absolutely, you can get this into the normal OP-TEE development repo setup with:
repo init -u https://github.com/OP-TEE/manifest.git -m default.xml
repo sync
Update optee_os with
https://github.com/jenswi-linaro/optee_os/tree/async_notif_v2
Update linux with https://github.com/jenswi-linaro/linux-1/tree/async_notif_v2
cd build
make all -j...
make run-only

If you type anything at the secure console you'll notice how it
changes behaviour once the Linux kernel has booted.

Cheers,
Jens

>
> -Sumit
>
> > v2:
> > * Added documentation
> > * Converted optee bindings to json-schema and added interrupt property
> > * Configure notification interrupt from DT instead of getting it
> >   from secure world, suggested by Ard Biesheuvel <ardb@kernel.org>.
> >
> > Thanks,
> > Jens
> >
> > Jens Wiklander (7):
> >   docs: staging/tee.rst: add a section on OP-TEE notifications
> >   dt-bindings: arm: Convert optee binding to json-schema
> >   dt-bindings: arm: optee: add interrupt property
> >   tee: fix put order in teedev_close_context()
> >   tee: add tee_dev_open_helper() primitive
> >   optee: separate notification functions
> >   optee: add asynchronous notifications
> >
> >  .../bindings/arm/firmware/linaro,optee-tz.txt |  31 ---
> >  .../arm/firmware/linaro,optee-tz.yaml         |  57 +++++
> >  Documentation/staging/tee.rst                 |  27 +++
> >  drivers/tee/optee/Makefile                    |   1 +
> >  drivers/tee/optee/call.c                      |  27 +++
> >  drivers/tee/optee/core.c                      |  87 +++++--
> >  drivers/tee/optee/notif.c                     | 226 ++++++++++++++++++
> >  drivers/tee/optee/optee_msg.h                 |   9 +
> >  drivers/tee/optee/optee_private.h             |  23 +-
> >  drivers/tee/optee/optee_rpc_cmd.h             |  31 +--
> >  drivers/tee/optee/optee_smc.h                 |  75 +++++-
> >  drivers/tee/optee/rpc.c                       |  73 +-----
> >  drivers/tee/tee_core.c                        |  37 ++-
> >  include/linux/tee_drv.h                       |  27 +++
> >  14 files changed, 576 insertions(+), 155 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> >  create mode 100644 drivers/tee/optee/notif.c
> >
> > --
> > 2.31.1
> >

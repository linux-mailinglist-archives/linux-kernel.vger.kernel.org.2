Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046DF3AAA25
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 06:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFQEfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 00:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQEfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:35:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1AAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 21:33:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l15so2705808lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 21:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZjUR44YaNoQXcJB+dlktg3mNBZU4O2yhCDUy1ikvnA=;
        b=VTA9HcmiANLZolcCm6eIiiATqHIyWdcIcc/pObJ3eMq4PmtDTYhHmSCCMSEIG+AAYH
         JIMtKQg0rUlWhZh0BxBC6WbrtwS7DtZSEY+tivkhFdpNZ7WnoUf5E/L5gjDrxNp4bxIs
         rhPLQAsPvvaoPdEJ040GMoeD3Spe+426FQIQ11pnUCpa77ib3GALo1RxAqBPhMkm9TvV
         FEhqPO98wdT40c0ldFgbOmBsFPeLxJCqgR4/DfeW38Or3kmXng6LRI1+nmCqaWHHHPi1
         dAdJiGoPoj9MPX3wC+nF+gXynznwQE6cEL3a/m2S/N7rQHT2FW2hGxvlQVL7wkwDnxRc
         0Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZjUR44YaNoQXcJB+dlktg3mNBZU4O2yhCDUy1ikvnA=;
        b=U67jcG+lBhUfv6eqDcZTfz/c/AMvRY/agFA9GyADoOFkFpGhb5A/dNlMG87/RGvMt6
         J/rN4+8Olm3sRaUjY5viIt7YmGH8RaCjVDlyMYGEHQW7jLKt1yGiwcNamPZSsiB5lXFr
         /1V0TSEln3zn29LsiDLHGAEnQJcPTT/WaNO3bmK45FtT6XtXipVsAgUYoIt8w1i9NVzk
         +S9AP5Jkz35GJyuR4JJASCyRY8wi0bp61Ut2IpIGx/pNJ200VQsAPmf1HEAxVR6lyGz4
         KyAUqeC+Itr10d2aooF4DVP/XVkiguXKGyQydDwWxDtk1Gv0Ex85uusnxbWUlljrLDQ2
         iTcw==
X-Gm-Message-State: AOAM533YEWptv4sHCxcUy/2ZJ+VVN9sadozv5DwAyqZRcwNvdtqREWyJ
        krLHTRYWDPg/BAuS8dtH00DeKGP69YoKEbbDasUK/w==
X-Google-Smtp-Source: ABdhPJxaiyDi1aNHhmmcMlUBaaNXuxoKEaKMW5FSsqO8dU/Wz2t9fQ5Q9biZFQUJ797nIe45j6+PqatZ0FSdX6tHSnU=
X-Received: by 2002:a2e:311:: with SMTP id 17mr2780769ljd.442.1623904407105;
 Wed, 16 Jun 2021 21:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
In-Reply-To: <20210616103649.2662395-1-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 17 Jun 2021 10:03:14 +0530
Message-ID: <CAFA6WYMrxNfR09doWQgYKCQSYKyUMVKqSTPuRYn=-nueY9pSvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
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

Hi Jens,

On Wed, 16 Jun 2021 at 16:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi all,
>
> This adds support for asynchronous notifications from OP-TEE in secure
> world to the OP-TEE driver. This allows a design with a top half and bottom
> half type of driver where the top half runs in secure interrupt context and
> a notifications tells normal world to schedule a yielding call to do the
> bottom half processing.
>
> An interrupt is used to notify the driver that there are asynchronous
> notifications pending.
>

It looks like a nice feature. I would like to get hands on with this.
Can I test this feature on Qemu?

-Sumit

> v2:
> * Added documentation
> * Converted optee bindings to json-schema and added interrupt property
> * Configure notification interrupt from DT instead of getting it
>   from secure world, suggested by Ard Biesheuvel <ardb@kernel.org>.
>
> Thanks,
> Jens
>
> Jens Wiklander (7):
>   docs: staging/tee.rst: add a section on OP-TEE notifications
>   dt-bindings: arm: Convert optee binding to json-schema
>   dt-bindings: arm: optee: add interrupt property
>   tee: fix put order in teedev_close_context()
>   tee: add tee_dev_open_helper() primitive
>   optee: separate notification functions
>   optee: add asynchronous notifications
>
>  .../bindings/arm/firmware/linaro,optee-tz.txt |  31 ---
>  .../arm/firmware/linaro,optee-tz.yaml         |  57 +++++
>  Documentation/staging/tee.rst                 |  27 +++
>  drivers/tee/optee/Makefile                    |   1 +
>  drivers/tee/optee/call.c                      |  27 +++
>  drivers/tee/optee/core.c                      |  87 +++++--
>  drivers/tee/optee/notif.c                     | 226 ++++++++++++++++++
>  drivers/tee/optee/optee_msg.h                 |   9 +
>  drivers/tee/optee/optee_private.h             |  23 +-
>  drivers/tee/optee/optee_rpc_cmd.h             |  31 +--
>  drivers/tee/optee/optee_smc.h                 |  75 +++++-
>  drivers/tee/optee/rpc.c                       |  73 +-----
>  drivers/tee/tee_core.c                        |  37 ++-
>  include/linux/tee_drv.h                       |  27 +++
>  14 files changed, 576 insertions(+), 155 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
>  create mode 100644 drivers/tee/optee/notif.c
>
> --
> 2.31.1
>

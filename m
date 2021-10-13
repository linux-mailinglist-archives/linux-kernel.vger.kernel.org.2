Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E90F42B854
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbhJMHE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbhJMHEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:04:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC36CC061764
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:02:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n8so7376382lfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o94EXo+tToRKdwVEcwPQeGsy4jlHYaEW0KchhMFyAwo=;
        b=d4Z6s1mE9nV3QOSP2xgd/oC/dsl5gqCmcONZKoSsb+tfzeAOWd2vinDrYbTNqVcxqC
         zXithLyE7imAFDglSwSATMMQgJuafegmIEBD0V3kt+acLXkRceuFixFg0rBUlO2ZeLJw
         yo4IeiE/nn78D8FoyMF8FazhsTSBF+IVTsmr4pbiTcT4qssDIdTKWQUcFc8qczMAz5na
         EYeLuL56rN3Kb9ZkeIZCbNS8++9ZV1kbqgWexNEQ71M9ze4NWLTYs+0QDSk7YoGjK1Kb
         chMHk+b6lHpjERFXSuZPbjkOV/gbLrcmUYmRb+bN2zfwtrrM5GFr917dn5GMx+Mp18uh
         SPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o94EXo+tToRKdwVEcwPQeGsy4jlHYaEW0KchhMFyAwo=;
        b=0N014rNlfxd9zH7JVvkgv10Da6y0xLhATR0HOhbAYNCN9P9e/uH7njsZto0lpOOdQn
         LfH5Ip+pKEBBUGLMgrbkpzDVe4PRjuSze+nTZ7zq+xb9NgWu6LIq4/uFGZCjFpg3eKWh
         Jrn8/Yt6dxphpMyIFTTjRTSweMBMOWBD5luIFm9r/42wK6gPtt+mKbLQpq2liIIAx6af
         0npkBrZGP6M4CKgMuezZ6P3HGhIQa0/nCOcOAl9mFWlitTpt5yf3nfDSsNG/FfUT3YQI
         4oXEddVfpnS8TfD3+k+qMJHMUFzhNQF8XOnh9E7+fyZBKcCfz6IBYURjYeFEaOfxL7ho
         RLVg==
X-Gm-Message-State: AOAM530mwapMDcl2e8+3ZEBpopC4reeYefIydo3ZnF14rfoWyoP2npkQ
        3Qi/lkS+2Mc5CCiNhPIsH0lZV1VtnZ709jWufppBJ4imWKXe407V
X-Google-Smtp-Source: ABdhPJycxtfdhS8rLs6pHYukexW2sy/Bbc9quhCsIqztVJ/7NiBvbr5IASEZ6NZIs1+ZcsxlSZW9Bt7u/4B2Gr0Aug8=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr27140863ljj.271.1634108532602;
 Wed, 13 Oct 2021 00:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211006071546.2540920-1-jens.wiklander@linaro.org> <20211006071546.2540920-2-jens.wiklander@linaro.org>
In-Reply-To: <20211006071546.2540920-2-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 13 Oct 2021 12:32:01 +0530
Message-ID: <CAFA6WYPLCLmYhSa_-vJPvhy9fFpdD3u39YZenYgij4fSM-+JCw@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] docs: staging/tee.rst: add a section on OP-TEE notifications
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

On Wed, 6 Oct 2021 at 12:45, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Adds a section on notifications used by OP-TEE, synchronous and
> asynchronous.
>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  Documentation/staging/tee.rst | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> index 4d4b5f889603..3c63d8dcd61e 100644
> --- a/Documentation/staging/tee.rst
> +++ b/Documentation/staging/tee.rst
> @@ -184,6 +184,36 @@ order to support device enumeration. In other words, OP-TEE driver invokes this
>  application to retrieve a list of Trusted Applications which can be registered
>  as devices on the TEE bus.
>
> +OP-TEE notifications
> +--------------------
> +
> +There are two kinds of notifications that secure world can use to make
> +normal world aware of some event.
> +
> +1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFICATION``
> +   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
> +2. Asynchronous notifications delivered with a combination of a non-secure
> +   edge-triggered interrupt and a fast call from the non-secure interrupt
> +   handler.
> +
> +Synchronous notifications are limited by depending on RPC for delivery,
> +this is only usable when secure world is entered with a yielding call via
> +``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
> +world interrupt handlers.
> +
> +An asynchronous notification is delivered via a non-secure edge-triggered
> +interrupt to an interrupt handler registered in the OP-TEE driver. The
> +actual notification value are retrieved with the fast call
> +``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``. Note that one interrupt can represent
> +multiple notifications.
> +
> +One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`` has a
> +special meaning. When this value is received it means that normal world is
> +supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``. This
> +call is done from the thread assisting the interrupt handler. This is a
> +building block for OP-TEE OS in secure world to implement the top half and
> +bottom half style of device drivers.
> +
>  AMD-TEE driver
>  ==============
>
> --
> 2.31.1
>

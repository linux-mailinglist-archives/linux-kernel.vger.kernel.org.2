Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93C63A0DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhFIHnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:43:31 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:46908 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhFIHna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:43:30 -0400
Received: by mail-lj1-f169.google.com with SMTP id e11so30410727ljn.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vgtulZfYaV7F516pzL7teLfejhewOteSXEl5eaD4S78=;
        b=yD0a2dryIpxQR6ZJ3MADoveGbrGyG9EMeKg8b1o2gdjy2BVzieTQg/94Z/XYQ6z0A4
         EBT0XuFfOlv33MqFQHOMEsJ1cxrfQ4fbx1SLR8XcA8EQWt59NQhbEEYClEadf8DxroNv
         zNbxJEHyiAfx/CmdxJmIslv+D4W5sLM2buRNx3gsJ4zJc1ex756+No4lyNBUQmLeXFpT
         x9pFe+oWGPRGYToU1vqsdR9iVLPBiZE4ig6HWynEgF/ulzZg4iGNDf/3H0mwchecVUVV
         jtR8pHALijeXlHI8ZmORpDiqPxpR9pjVoNR9Kz1VVJT5Ld4OhIkurQZOnx/L4LZrlAiu
         O8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vgtulZfYaV7F516pzL7teLfejhewOteSXEl5eaD4S78=;
        b=BamqM9dHWxHsWVoTHblYFnSabc0731u2/uNmWlvk8+9vt/8sD6Od2OScUl92yjBN9S
         o3UFc6si4SaumjAwhjLyRQ+1nOqt27M+7i8tHQ3WUXuLuZ0pih5yUJoXVD1NTu+WsfF9
         HpBycW0NbX0HpJpywxuqFp+o/RzlhFHzgib4208hTfSNQ+bg94O215IOVTQ+wGY4jgIL
         GRVZN5PCAMnhwCsb+/+GQZ6y//m/KLGOIjR3Mbu3VPLB751zipn6ymVrCQ4ZpnVxGVM9
         zqbNoah6P5YpDd4cQ4toC90jISkR9c7clNAA48bpGB/kltYwcBAi67TegSl5pBrn4WVQ
         4/cg==
X-Gm-Message-State: AOAM531BAxCod4/pAjqqarYdZClNejYhbwLlJi6uPKVqkR0Dx3J1GDpy
        udnMooWNBDnBeMaXoRKwLcSqjA==
X-Google-Smtp-Source: ABdhPJz4Lof65D6+Jkt72L1MX4hHJDQ6mvQnHXrbQQ62eZ7yzFi2ZdSQyKShM9oFCwK+4oPdq1FUrA==
X-Received: by 2002:a05:651c:324:: with SMTP id b4mr21215875ljp.166.1623224435011;
        Wed, 09 Jun 2021 00:40:35 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id o21sm253439lfr.253.2021.06.09.00.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 00:40:34 -0700 (PDT)
Date:   Wed, 9 Jun 2021 09:40:33 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 4/4] optee: add asynchronous notifications
Message-ID: <20210609074033.GA1913856@jade>
References: <20210609060910.1500481-1-jens.wiklander@linaro.org>
 <20210609060910.1500481-5-jens.wiklander@linaro.org>
 <CAMj1kXGP=ZzVNTYZ3zuUS6G8wmbiu1f52nxmXk8QWeFgvXhBeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGP=ZzVNTYZ3zuUS6G8wmbiu1f52nxmXk8QWeFgvXhBeA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Wed, Jun 09, 2021 at 09:02:19AM +0200, Ard Biesheuvel wrote:
> (+ Marc)
> 
> Hi Jens,
> 
> On Wed, 9 Jun 2021 at 08:11, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Adds support for asynchronous notifications from secure world to normal
> > world. This allows a design with a top half and bottom half type of
> > driver where the top half runs in secure interrupt context and a
> > notifications tells normal world to schedule a yielding call to do the
> > bottom half processing.
> >
> > The protocol is defined in optee_msg.h optee_rpc_cmd.h and optee_smc.h.
> >
> > A notification consists of a 32-bit value which normal world can
> > retrieve using a fastcall into secure world. The value
> > OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF (0) has a special meaning.
> > When this value is sent it means that normal world is supposed to make a
> > yielding call OPTEE_MSG_CMD_DO_BOTTOM_HALF.
> >
> > Notification capability is negotiated while the driver is initialized.
> > If both sides supports these notifications then they are enabled.
> >
> > A SPI interrupt is used to notify the driver that there are asynchronous
> > notifications pending.
> 
> Wouldn't it be better for this interrupt to be described using DT or
> ACPI, and use the normal IRQ request API, rather than putting GIC
> specifics into this driver?

For this to work both OP-TEE in secure world and the kernel driver must
agree on the same configuration. Having the configuration hardcoded in
two different locations (DT/ACPI and OP-TEE) at the same time is going
to be painful so we should pick one place.

OP-TEE is normally compiled for a single platform at a time so compiling
with a preferred configuration for that platform is not an issue. On the
other hand, dynamic configuration with different optinally drivers is
something that we try to avoid. If nothing else just to conserve secure
memory. Dynamic configuration with a parameter like and interrupt ID or
such is fine though.

Regardless if the main configuration is kept in DT/ACPI or OP-TEE we
should preferably be able to convey that configuration to the other side
during the capability exchange when the driver is probed. Do you think
it's possible to come up with something generic enough using just a few
registers?

> 
> E.g., SynQuacer has a EXIU interrupt block that sits before the GIC,
> and would probably be more suitable for delivering secure-to-normal
> world software interrupts in this way, but I don't think your current
> design would support that.

Agree, we need to be a bit more flexible.

By the way, here's some documention on the design:
https://optee.readthedocs.io/en/latest/architecture/core.html#notifications

> 
> 
> > The interrupt number is transmitted during
> > capability exchange. The maximum needed notification value is also
> > communicated at this stage. This allows scaling up when needed.


Cheers,
Jens

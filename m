Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E72443DE74
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhJ1KLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhJ1KLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:11:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D746C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:09:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 5so21987068edw.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUQUiLYqhitEiT4BV3CCB9OgkI1P43GqZ1sfX26H2PM=;
        b=bGIuXF/3+6kzF9A51vwWZvDAp+f2Okt6rQgyNv0crZn2envIih5RwoeivvAlfVGa2h
         U2eEinE/t7jS3CE3I67P5dpHqWpEC/eRZHtPDeCaxYCrv40BnJyhOEXzUrUHEE/re91m
         e7DamiBROcf0/3ZPjHRrOPj5oOPIIDFMll0mvuf9AQfR4eguT+fyh2WLlbyQOU/ehuSZ
         c4J2Ihg7DPubD8zV/yfGYxVRHNpbwxp/xkZ5Qm3gAH4Tebm32gf+Gw2LxJIicmwvvSOO
         r/6keu70Ke1tVIE+22QhITbD3qSuS5+GKtAkA17SO12/s8fwZtE7Dmrqa9UeZ4GuROnU
         xFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUQUiLYqhitEiT4BV3CCB9OgkI1P43GqZ1sfX26H2PM=;
        b=ynPrwK5BnZC80d+vwmgh7j2pGaUNpNo5BURRA9B6CxrUv8KCrYWQNhkMWj0j12bhVj
         tzu9pGscqm2I7JgPPkWTCegKfkVzwlw+QUyJiALamYqVKWW64WNtO7iFwrIOrcA+tfRq
         jRrjj4ofxAm9K2ipHU3ixUVuQH9kZm7dC+qrsCRPwfLjnF3ugahs5eKqH+q+eEbFztpk
         kTdWga9XkJ5uNTs3ih0Yslhgi6maEZBttdG3+PJRfgbA6+tq8VgcJP8YInD3eK63hGbK
         CfIMlfcTb4zAU89vWMbJrUph6r5I2YtCfANq/y2JidVqFkJbLLvOlhAijbhLzYmen9VQ
         pRIg==
X-Gm-Message-State: AOAM530u/V5vYGxkKxa8oQY2msTuOFaqiIbx52YN4nnhxtDg5XUilro8
        6Z1rxzUl9h/IUxn2/2lY6r4252I/iLWeqlJLg5ra9Q==
X-Google-Smtp-Source: ABdhPJwY9gL7ew0aaQhSn5bhULKq60l6XEOXHCceaLnjgz4Bppw/jTQ/ks/HdleEq7HV1VBYdaP6clmoYihE/dAJSrQ=
X-Received: by 2002:a17:907:3f04:: with SMTP id hq4mr4067239ejc.202.1635415748967;
 Thu, 28 Oct 2021 03:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211028075344.1688-1-etienne.carriere@linaro.org>
 <20211028075344.1688-2-etienne.carriere@linaro.org> <20211028092651.GE6526@e120937-lin>
In-Reply-To: <20211028092651.GE6526@e120937-lin>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 28 Oct 2021 12:08:57 +0200
Message-ID: <CAN5uoS9Wb9tmXHzYM4mSJgibhS-HgcEroTG2T7yAerx6=8WWBw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] firmware: arm_scmi: Add optee transport
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Cristian,

On Thu, 28 Oct 2021 at 11:26, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Thu, Oct 28, 2021 at 09:53:44AM +0200, Etienne Carriere wrote:
> > Add a new transport channel to the SCMI firmware interface driver for
> > SCMI message exchange based on optee transport channel. The optee
> > transport is realized by connecting and invoking OP-TEE SCMI service
> > interface PTA.
> >
>
> Hi Etienne,
>
> I was going to just add Reviewed-by...but...
>
> > Optee transport support (CONFIG_ARM_SCMI_TRANSPORT_OPTEE) is default
> > enabled when optee driver (CONFIG_OPTEE) is enabled. Effective optee
> > transport is setup upon OP-TEE SCMI service discovery at optee
> > device initialization. For this SCMI UUID is registered to the optee
> > bus for probing. This is done from the link_supplier operator of the
> > SCMI optee transport.
> >
> > The optee transport can use a statically defined shared memory in
> > which case SCMI device tree node defines it using an "arm,scmi-shmem"
> > compatible phandle through property shmem. Alternatively, optee transport
> > allocates the shared memory buffer from the optee driver when no shmem
> > property is defined.
> >
> > The protocol used to exchange SCMI message over that shared memory is
> > negotiated between optee transport driver and the OP-TEE service through
> > capabilities exchange.
> >
> > OP-TEE SCMI service is integrated in OP-TEE since its release tag 3.13.0.
> > The service interface is published in [1].
> >
> > Link: [1] https://github.com/OP-TEE/optee_os/blob/3.13.0/lib/libutee/include/pta_scmi_client.h
> > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
>
> I build tested again...and booted without using it really, just to try load/unload
> of the core SCMI module (so building with ARM_SCMI_PROTOCOL=m) and unfortunately
> I spotted this warning:
>
> root@deb-buster-arm64:~# insmod ./scmi-module.ko
> root@deb-buster-arm64:~# rmmod ./scmi-module.ko
>
> [   99.860225] ------------[ cut here ]------------
> [   99.865006] Unexpected driver unregister!
> [   99.869116] WARNING: CPU: 0 PID: 339 at drivers/base/driver.c:194 driver_unregister+0x50/0x60
> [   99.877684] Modules linked in: scmi_module(-) [last unloaded: scmi_hwmon]
> [   99.884501] CPU: 0 PID: 339 Comm: rmmod Not tainted 5.15.0-rc1-00003-g46a1949d5e4f #8
> [   99.892352] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jun 30 2020
> [   99.903156] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   99.910136] pc : driver_unregister+0x50/0x60
> [   99.914419] lr : driver_unregister+0x50/0x60
> [   99.918701] sp : ffff80001259bd50
> [   99.922018] x29: ffff80001259bd50 x28: ffff0008010a5280 x27: 0000000000000000
> [   99.929182] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> [   99.936344] x23: 0000000000000000 x22: ffff8000121446d8 x21: ffff800011e19948
> [   99.943506] x20: ffff800011ea7548 x19: ffff80000900b340 x18: 0000000000000010
> [   99.950669] x17: 31333d4d554e5145 x16: 53007375623d4d45 x15: 000000000000017c
> [   99.957831] x14: ffff80001259ba60 x13: 00000000ffffffea x12: ffff800011ea2e70
> [   99.964994] x11: 0000000000000003 x10: ffff800011e8ae30 x9 : ffff800011e8ae88
> [   99.972156] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : ffff00097ef4e988
> [   99.979318] x5 : ffff00097ef4e988 x4 : 0000000000000000 x3 : ffff00097ef51910
> [   99.986480] x2 : ffff00097ef51910 x1 : c33162034fce8d00 x0 : 0000000000000000
> [   99.993643] Call trace:
> [   99.996092]  driver_unregister+0x50/0x60
> [  100.000028]  scmi_optee_exit+0x1c/0x28 [scmi_module]
> [  100.005040]  scmi_driver_exit+0x58/0x7c [scmi_module]
> [  100.010131]  __arm64_sys_delete_module+0x19c/0x228
> [  100.014938]  invoke_syscall+0x44/0x108
> [  100.018700]  el0_svc_common.constprop.3+0x94/0xf8
> [  100.023418]  do_el0_svc+0x24/0x88
> [  100.026743]  el0_svc+0x20/0x50
> [  100.029807]  el0t_64_sync_handler+0x90/0xb8
> [  100.034001]  el0t_64_sync+0x180/0x184
> [  100.037674] ---[ end trace 4c09a5e866689fa7 ]---
>
> I suppose it could be that on my system I have not defined an OPTEE DT node, so
> the transport is NEVER initialized (and driver_register) since you are doing it
> in .link_supplier not in .transport_init, BUT then it is indeed always .exited
> by the usual .transport_exit.
>
> I would recommend adding a check on your exit to avoid this (probably using
> scmi_optee_private to avoid unregistering if never registered ?).

Fully make sense, yes. If transport was not initialized (from scmi
link_supplier), it cannot be unregistered (from scmi transport_exit).
I'll follow your suggestion.

>
> Sorry, I think I thought about telling you about this check on .exit in previous
> version but I did not eventaully.

Don't be sorry and many thanks again for the reviews, feedback and guidelines.

>
> Additionally, I have a slight concern if default-enabling it or not; as an
> example virtio is default-N just because it felt like a more esoteric
> transport not generally needed...but this will probably change indeed with all the
> work you guys are doing on virtualizing the stack, so no strong opinion here ...
>
> ...and I'll happily let Sudeep decide on this :D.

Sure. From my view, once both CONFIG_ARM_SCMI_PROTOCOL and
CONFIG_OPTEE are enabled, we can enable SCMI optee transport since it
will be initialized only upon discovery of the OP-TEE firmware SCMI
service (using the tee bus).

Cheers,
Etienne

>
> Thanks,
> Cristian

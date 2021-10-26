Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C301843AD59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhJZHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhJZHkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:40:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B26CC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 00:38:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g10so9894451edj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 00:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=30q5kxIEdXiTAoHab49pvPfQEz8kl2WL3lf7EEJMaF8=;
        b=TQfVx5soOa0BZtTvqB1I3oo4HuDPx5/nJqFroAafHxEvA5kqq5LobK+t8NfNi00xCQ
         y5lJKVHTsk6b7YLFvPi4Y+8arq+5XOEE67HZsxKlidT14uzUhJzRzxr5C8nVsXAZ1siv
         QdroMvbUAY8kRAPcPsomHeW7hkPmXN70xKZ6HAyY9dW6f6v47gnI9ftKQpqzEMlgwPq8
         wIS+u+Lc5SLz6dCvhxp/kO0xn5DFnLmnTevzXFT6W/5Aib/ric/Fe+jp7ke5NZ6TWisZ
         S7BAugj0rKm9JLMbdG832pU9xCSAE8ZWaxDmtc9TVOA/DMoy5Jbm291Usk56g/y14kPe
         DXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=30q5kxIEdXiTAoHab49pvPfQEz8kl2WL3lf7EEJMaF8=;
        b=yAiHBY8YviouDK9birC5oogYDoBPprokM9EIjb+NAYtL8Vf83WHYRQeS6YmwsmM5ek
         wZmyUNB3ypKK4Kk/iFGaIhNrITPcJo1A8BO4mxMSY4ey/dYGA4hKgbfLYSaz3tdfbeHG
         MuPfIdmk4KTAFyTPpq1hmWjFDHw7soJpFenvMWbR00URBRdVHijCvnGjyz44qIM2JrVK
         RyTSC5Arkefc1VBDqBxo2PT+/yw0/nMp7YHfwspS5HkGf7yePIfc26VpgJ1C+i0E3aYU
         GXcrFEf+ocKy4Pl5K0xwhbh7M6hYl3IxtBl6zaT1UQMF+UqqJBJlrcpR+CP3Yjti9udM
         PU/Q==
X-Gm-Message-State: AOAM533e3hMl9EoMx9KxScTjoUKYV9qVaY3xIO4AavQw/sD3lH68TypU
        wMhWz+VfRsUSHKllzTCvds+hNCsYPwPXQmO1ap3tbQ==
X-Google-Smtp-Source: ABdhPJx7B2TobCFx2Vy6hU4XNbH4ffvrHAtRIH+4xbLo4bO3hLGuJyqnZ46wxEtI3VodVhi/E55aMtk6U4VeoCbsQcg=
X-Received: by 2002:a17:906:ca4a:: with SMTP id jx10mr27463057ejb.542.1635233900510;
 Tue, 26 Oct 2021 00:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211021150717.2718-1-etienne.carriere@linaro.org>
 <20211021150717.2718-2-etienne.carriere@linaro.org> <20211025154516.GD6526@e120937-lin>
In-Reply-To: <20211025154516.GD6526@e120937-lin>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 26 Oct 2021 09:38:09 +0200
Message-ID: <CAN5uoS-AVpmWAqFhK_XTbpwrFY4t_7dO4LdbLkxp-LCBDaCBPQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] firmware: arm_scmi: Add optee transport
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,


On Mon, 25 Oct 2021 at 17:45, Cristian Marussi <cristian.marussi@arm.com> w=
rote:
>
> On Thu, Oct 21, 2021 at 05:07:17PM +0200, Etienne Carriere wrote:
> > Add a new transport channel to the SCMI firmware interface driver for
> > SCMI message exchange based on optee transport channel. The optee
> > transport is realized by connecting and invoking OP-TEE SCMI service
> > interface PTA.
> >
>
> Hi Etienne,
>
> I buld-tested and verified previuos remarks and it looks good to me.
>
> A few more new small remarks down below, though, that I missed previously=
.
>
> > Optee transport support (CONFIG_ARM_SCMI_TRANSPORT_OPTEE) is default
> > enabled when optee driver (CFG_OPTEE) is enabled. Effective optee
> nit: CONFIG_OPTEE ?

True.
Thanks you also to J=C3=A9r=C3=B4me who pointed that to me but I forgot to =
fix :(


>
> > transport is setup upon OP-TEE SCMI service discovery at optee
> > device initialization. For this SCMI UUID is registered to the optee
> > bus for probing. This is done from the link_supplier operator of the
> > SCMI optee transport.
> >
> > The optee transport can use a statically defined shared memory in
> > which case SCMI device tree node defines it using an "arm,scmi-shmem"
> > compatible phandle through property shmem. Alternatively, optee transpo=
rt
> > allocates the shared memory buffer from the optee driver when no shmem
> > property is defined.
> >
> > The protocol used to exchange SCMI message over that shared memory is
> > negotiated between optee transport driver and the OP-TEE service throug=
h
> > capabilities exchange.
> >
> > OP-TEE SCMI service is integrated in OP-TEE since its release tag 3.13.=
0.
> > The service interface is published in [1].
> >
> > Link: [1] https://github.com/OP-TEE/optee_os/blob/3.13.0/lib/libutee/in=
clude/pta_scmi_client.h
> > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > Changes since v4:
> >  - Fix commit log that was not updated to v4 changes.
> >  - Operator scmi_optee_chan_setup() don't need the defer probe
> >    operation, it's already done from scmi_optee_link_supplier().
> >
> > Changes since v3:
> >  - Fix use of configuration switches when CONFIG_OPTEE and
> >    CONFIG_ARM_SCMI_PROTOCOL are enabled/modules/disabled.
> >    Mimics scmi virtio integration.
> >  - Implement link_supplier operator for the scmi_optee transport
> >    to possibly defer probing when optee bus has not yet enumerated
> >    the SCMI OP-TEE service. The function ensures scmi_optee registers
> >    to optee bus enumeration when probe is deferred.
> >  - Add memory barriers to protect global optee service reference
> >    when it's updated at transport initialization and removal.
> >  - Replace enum pta_scmi_caps with macro definitions as enumerated
> >    types do not really match bit flags definitions. The capabilities
> >    data is now of type u32.
> >  - Use scmi_optee_ prefix for scmi transport operator handles
> >    and few other resources.
> >  - Fix typo: s/optee_smci_pta_cmd/optee_scmi_pta_cmd/
> >  - Remove useless DRIVER_NAME.
> >  - Minor reordering in struct optee_channel.
> >  - Removed some useless empty lines.
> >
> > Changes since v2:
> > - Rebase on for-next/scmi, based on Linux v5.15-rc1.
> > - Implement support for dynamic and static shared memory.
> > - Factorize some functions and simplify transport exit sequence.
> > - Rename driver source file from optee_service.c to optee.c.
> >
> > No change since v1
> > ---
> >  drivers/firmware/arm_scmi/Kconfig  |  12 +
> >  drivers/firmware/arm_scmi/Makefile |   1 +
> >  drivers/firmware/arm_scmi/common.h |   3 +
> >  drivers/firmware/arm_scmi/driver.c |   3 +
> >  drivers/firmware/arm_scmi/optee.c  | 572 +++++++++++++++++++++++++++++
> >  5 files changed, 591 insertions(+)
> >  create mode 100644 drivers/firmware/arm_scmi/optee.c
> >
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_s=
cmi/Kconfig
> > index 3d7081e84853..30746350349c 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -77,6 +77,18 @@ config ARM_SCMI_TRANSPORT_VIRTIO
> >         If you want the ARM SCMI PROTOCOL stack to include support for =
a
> >         transport based on VirtIO, answer Y.
> >
> > +config ARM_SCMI_TRANSPORT_OPTEE
> > +     bool "SCMI transport based on OP-TEE service"
> > +     depends on OPTEE=3Dy || OPTEE=3DARM_SCMI_PROTOCOL
> > +     select ARM_SCMI_HAVE_TRANSPORT
> > +     select ARM_SCMI_HAVE_SHMEM
> > +     default y
> > +     help
> > +       This enables the OP-TEE service based transport for SCMI.
> > +
> > +       If you want the ARM SCMI PROTOCOL stack to include support for =
a
> > +       transport based on OP-TEE SCMI service, answer Y.
> > +
> >  endif #ARM_SCMI_PROTOCOL
> >
> >  config ARM_SCMI_POWER_DOMAIN
> > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_=
scmi/Makefile
> > index 1dcf123d64ab..ef66ec8ca917 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile
> > @@ -6,6 +6,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) +=
=3D mailbox.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=3D smc.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D msg.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) +=3D virtio.o
> > +scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
> >  scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o s=
ystem.o voltage.o
> >  scmi-module-objs :=3D $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-=
y) \
> >                   $(scmi-transport-y)
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_=
scmi/common.h
> > index dea1bfbe1052..6438b5248c24 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -421,6 +421,9 @@ extern const struct scmi_desc scmi_smc_desc;
> >  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
> >  extern const struct scmi_desc scmi_virtio_desc;
> >  #endif
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
> > +extern const struct scmi_desc scmi_optee_desc;
> > +#endif
> >
> >  void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void =
*priv);
> >  void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, =
int id);
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_=
scmi/driver.c
> > index b406b3f78f46..e3f87e0c4936 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -1999,6 +1999,9 @@ static const struct of_device_id scmi_of_match[] =
=3D {
> >  #endif
> >  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
> >       { .compatible =3D "arm,scmi-virtio", .data =3D &scmi_virtio_desc}=
,
> > +#endif
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
> > +     { .compatible =3D "linaro,scmi-optee", .data =3D &scmi_optee_desc=
 },
> >  #endif
> >       { /* Sentinel */ },
> >  };
> > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_s=
cmi/optee.c
> > new file mode 100644
> > index 000000000000..2b666c632800
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/optee.c
> > @@ -0,0 +1,572 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019-2021 Linaro Ltd.
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/slab.h>
> > +#include <linux/tee_drv.h>
> > +#include <linux/uuid.h>
> > +#include <uapi/linux/tee.h>
> > +
> > +#include "common.h"
> > +
> > +#define SCMI_OPTEE_MAX_MSG_SIZE              128
> > +
> > +enum scmi_optee_pta_cmd {
> > +     /*
> > +      * PTA_SCMI_CMD_CAPABILITIES - Get channel capabilities
> > +      *
> > +      * [out]    value[0].a: Capability bit mask (enum pta_scmi_caps)
> > +      * [out]    value[0].b: Extended capabilities or 0
> > +      */
> > +     PTA_SCMI_CMD_CAPABILITIES =3D 0,
> > +
> > +     /*
> > +      * PTA_SCMI_CMD_PROCESS_SMT_CHANNEL - Process SCMI message in SMT=
 buffer
> > +      *
> > +      * [in]     value[0].a: Channel handle
> > +      *
> > +      * Shared memory used for SCMI message/response exhange is expect=
ed
> > +      * already identified and bound to channel handle in both SCMI ag=
ent
> > +      * and SCMI server (OP-TEE) parts.
> > +      * The memory uses SMT header to carry SCMI meta-data (protocol I=
D and
> > +      * protocol message ID).
> > +      */
> > +     PTA_SCMI_CMD_PROCESS_SMT_CHANNEL =3D 1,
> > +
> > +     /*
> > +      * PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE - Process SMT/SCMI me=
ssage
> > +      *
> > +      * [in]     value[0].a: Channel handle
> > +      * [in/out] memref[1]: Message/response buffer (SMT and SCMI payl=
oad)
> > +      *
> > +      * Shared memory used for SCMI message/response is a SMT buffer
> > +      * referenced by param[1]. It shall be 128 bytes large to fit res=
ponse
> > +      * payload whatever message playload size.
> > +      * The memory uses SMT header to carry SCMI meta-data (protocol I=
D and
> > +      * protocol message ID).
> > +      */
> > +     PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE =3D 2,
> > +
> > +     /*
> > +      * PTA_SCMI_CMD_GET_CHANNEL - Get channel handle
> > +      *
> > +      * SCMI shm information are 0 if agent expects to use OP-TEE regu=
lar SHM
> > +      *
> > +      * [in]     value[0].a: Channel identifier
> > +      * [out]    value[0].a: Returned channel handle
> > +      * [in]     value[0].b: Requested capabilities mask (enum pta_scm=
i_caps)
> > +      */
> > +     PTA_SCMI_CMD_GET_CHANNEL =3D 3,
> > +};
> > +
> > +/*
> > + * OP-TEE SCMI service capabilities bit flags (32bit)
> > + *
> > + * PTA_SCMI_CAPS_SMT_HEADER
> > + * When set, OP-TEE supports command using SMT header protocol (SCMI s=
hmem) in
> > + * shared memory buffers to carry SCMI protocol synchronisation inform=
ation.
> > + */
> > +#define PTA_SCMI_CAPS_NONE           0
> > +#define PTA_SCMI_CAPS_SMT_HEADER     BIT(0)
> > +
> > +/**
> > + * struct scmi_optee_channel - Description of an OP-TEE SCMI channel
> > + *
> > + * @channel_id: OP-TEE channel ID used for this transport
> > + * @tee_session: TEE session identifier
> > + * @caps: OP-TEE SCMI channel capabilities
> > + * @mu: Mutex protection on channel access
> > + * @cinfo: SCMI channel information
> > + * @shmem: Virtual base address of the shared memory
> > + * @tee_shm: Reference to TEE shared memory or NULL if using static sh=
mem
> > + * @link: Reference in agent's channel list
> > + */
> > +struct scmi_optee_channel {
> > +     u32 channel_id;
> > +     u32 tee_session;
> > +     u32 caps;
> > +     struct mutex mu;
> > +     struct scmi_chan_info *cinfo;
> > +     struct scmi_shared_mem __iomem *shmem;
> > +     struct tee_shm *tee_shm;
> > +     struct list_head link;
> > +};
> > +
> > +/**
> > + * struct scmi_optee_agent - OP-TEE transport private data
> > + *
> > + * @dev: Device used for communication with TEE
> > + * @tee_ctx: TEE context used for communication
> > + * @caps: Supported channel capabilities
> > + * @mu: Mutex for protection of @channel_list
> > + * @channel_list: List of all created channels for the agent
> > + */
> > +struct scmi_optee_agent {
> > +     struct device *dev;
> > +     struct tee_context *tee_ctx;
> > +     u32 caps;
> > +     struct mutex mu;
> > +     struct list_head channel_list;
> > +};
> > +
> > +/* There can be only 1 SCMI service in OP-TEE we connect to */
> > +static struct scmi_optee_agent *scmi_optee_private;
> > +
> > +/* Forward reference to scmi_optee transport initialization */
> > +static int scmi_optee_init(void);
> > +
> > +/* Open a session toward SCMI OP-TEE service with REE_KERNEL identity =
*/
> > +static int open_session(struct scmi_optee_agent *agent, u32 *tee_sessi=
on)
> > +{
> > +     struct device *dev =3D agent->dev;
> > +     struct tee_client_device *scmi_pta =3D to_tee_client_device(dev);
> > +     struct tee_ioctl_open_session_arg arg =3D { };
> > +     int ret;
> > +
> > +     memcpy(arg.uuid, scmi_pta->id.uuid.b, TEE_IOCTL_UUID_LEN);
> > +     arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> > +
> > +     ret =3D tee_client_open_session(agent->tee_ctx, &arg, NULL);
> > +     if (ret < 0 || arg.ret) {
> > +             dev_err(dev, "Can't open tee session: %d / %#x\n", ret, a=
rg.ret);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     *tee_session =3D arg.session;
> > +
> > +     return 0;
> > +}
> > +
> > +static void close_session(struct scmi_optee_agent *agent, u32 tee_sess=
ion)
> > +{
> > +     tee_client_close_session(agent->tee_ctx, tee_session);
> > +}
> > +
> > +static int get_capabilities(struct scmi_optee_agent *agent)
> > +{
> > +     struct tee_ioctl_invoke_arg arg =3D { };
> > +     struct tee_param param[1] =3D { };
> > +     u32 caps;
> > +     u32 tee_session;
> > +     int ret;
> > +
> > +     ret =3D open_session(agent, &tee_session);
> > +     if (ret)
> > +             return ret;
> > +
> > +     arg.func =3D PTA_SCMI_CMD_CAPABILITIES;
> > +     arg.session =3D tee_session;
> > +     arg.num_params =3D 1;
> > +
> > +     param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> > +
> > +     ret =3D tee_client_invoke_func(agent->tee_ctx, &arg, param);
> > +
> > +     close_session(agent, tee_session);
> > +
> > +     if (ret < 0 || arg.ret) {
> > +             dev_err(agent->dev, "Can't get capabilities: %d / %#x\n",=
 ret, arg.ret);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     caps =3D param[0].u.value.a;
> > +
> > +     if (!(caps & PTA_SCMI_CAPS_SMT_HEADER)) {
> > +             dev_err(agent->dev, "OP-TEE SCMI PTA doesn't support SMT\=
n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     agent->caps =3D caps;
> > +
> > +     return 0;
> > +}
> > +
> > +static int get_channel(struct scmi_optee_channel *channel)
> > +{
> > +     struct device *dev =3D scmi_optee_private->dev;
> > +     struct tee_ioctl_invoke_arg arg =3D { };
> > +     struct tee_param param[1] =3D { };
> > +     unsigned int caps =3D PTA_SCMI_CAPS_SMT_HEADER;
> > +     int ret;
> > +
> > +     arg.func =3D PTA_SCMI_CMD_GET_CHANNEL;
> > +     arg.session =3D channel->tee_session;
> > +     arg.num_params =3D 1;
> > +
> > +     param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT;
> > +     param[0].u.value.a =3D channel->channel_id;
> > +     param[0].u.value.b =3D caps;
> > +
> > +     ret =3D tee_client_invoke_func(scmi_optee_private->tee_ctx, &arg,=
 param);
> > +
> > +     if (ret || arg.ret) {
> > +             dev_err(dev, "Can't get channel with caps %#x: %d / %#x\n=
", caps, ret, arg.ret);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     /* From now on use channel identifer provided by OP-TEE SCMI serv=
ice */
> > +     channel->channel_id =3D param[0].u.value.a;
> > +     channel->caps =3D caps;
> > +
> > +     return 0;
> > +}
> > +
> > +static int invoke_process_smt_channel(struct scmi_optee_channel *chann=
el)
> > +{
> > +     struct tee_ioctl_invoke_arg arg =3D { };
> > +     struct tee_param param[2] =3D { };
> > +     int ret;
> > +
> > +     arg.session =3D channel->tee_session;
> > +     param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> > +     param[0].u.value.a =3D channel->channel_id;
> > +
> > +     if (channel->tee_shm) {
> > +             param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
> > +             param[1].u.memref.shm =3D channel->tee_shm;
> > +             param[1].u.memref.size =3D SCMI_OPTEE_MAX_MSG_SIZE;
> > +             arg.num_params =3D 2;
> > +             arg.func =3D PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE;
> > +     } else {
> > +             arg.num_params =3D 1;
> > +             arg.func =3D PTA_SCMI_CMD_PROCESS_SMT_CHANNEL;
> > +     }
> > +
> > +     ret =3D tee_client_invoke_func(scmi_optee_private->tee_ctx, &arg,=
 param);
> > +     if (ret < 0 || arg.ret) {
> > +             dev_err(scmi_optee_private->dev, "Can't invoke channel %u=
: %d / %#x\n",
> > +                     channel->channel_id, ret, arg.ret);
> > +             return -EIO;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int scmi_optee_link_supplier(struct device *dev)
> > +{
> > +     if (!scmi_optee_private || !scmi_optee_private->tee_ctx) {
>
> Is not this !tee_ctx redundant since scmi_optee_private->tee_ctx is alrea=
dy
> assured not NULL when scmi_optee_private is found set, given the order of=
 ops in
> the probe() and the barrier you added ?

you're right, !scmi_optee_private is enough.

>
> > +             if (scmi_optee_init())
> > +                     dev_dbg(dev, "Optee bus not yet ready\n");
> > +
> > +             /* Wait for optee bus */
> > +             return -EPROBE_DEFER;
> > +     }
> > +
> > +     if (!device_link_add(dev, scmi_optee_private->dev, DL_FLAG_AUTORE=
MOVE_CONSUMER)) {
> > +             dev_err(dev, "Adding link to supplier optee device failed=
\n");
> > +             return -ECANCELED;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static bool scmi_optee_chan_available(struct device *dev, int idx)
> > +{
> > +     u32 channel_id;
> > +
> > +     return !of_property_read_u32_index(dev->of_node, "linaro,optee-ch=
annel-id",
> > +                                        idx, &channel_id);
> > +}
> > +
> > +static void scmi_optee_clear_channel(struct scmi_chan_info *cinfo)
> > +{
> > +     struct scmi_optee_channel *channel =3D cinfo->transport_info;
> > +
> > +     shmem_clear_channel(channel->shmem);
> > +}
> > +
> > +static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_c=
hannel *channel)
> > +{
> > +     const size_t msg_size =3D SCMI_OPTEE_MAX_MSG_SIZE;
> > +
> > +     channel->tee_shm =3D tee_shm_alloc_kernel_buf(scmi_optee_private-=
>tee_ctx, msg_size);
> > +     if (IS_ERR(channel->tee_shm)) {
> > +             dev_err(channel->cinfo->dev, "shmem allocation failed\n")=
;
> > +             return -ENOMEM;
> > +     }
> > +
> > +     channel->shmem =3D (void *)tee_shm_get_va(channel->tee_shm, 0);
> > +     memset(channel->shmem, 0, msg_size);
> > +     shmem_clear_channel(channel->shmem);
> > +
> > +     return 0;
> > +}
> > +
> > +static int setup_static_shmem(struct device *dev, struct scmi_chan_inf=
o *cinfo,
> > +                           struct scmi_optee_channel *channel)
> > +{
> > +     struct device_node *np;
> > +     resource_size_t size;
> > +     struct resource res;
> > +     int ret;
> > +
> > +     np =3D of_parse_phandle(cinfo->dev->of_node, "shmem", 0);
> > +     if (!of_device_is_compatible(np, "arm,scmi-shmem")) {
> > +             ret =3D -ENXIO;
> > +             goto out;
> > +     }
> > +
> > +     ret =3D of_address_to_resource(np, 0, &res);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to get SCMI Tx shared memory\n");
> > +             goto out;
> > +     }
> > +
> > +     size =3D resource_size(&res);
> > +
> > +     channel->shmem =3D devm_ioremap(dev, res.start, size);
> > +     if (!channel->shmem) {
> > +             dev_err(dev, "Failed to ioremap SCMI Tx shared memory\n")=
;
> > +             ret =3D -EADDRNOTAVAIL;
> > +             goto out;
> > +     }
> > +
> > +     ret =3D 0;
> > +
> > +out:
> > +     of_node_put(np);
> > +
> > +     return ret;
> > +}
> > +
> > +static int setup_shmem(struct device *dev, struct scmi_chan_info *cinf=
o,
> > +                    struct scmi_optee_channel *channel)
> > +{
> > +     if (of_find_property(cinfo->dev->of_node, "shmem", NULL))
> > +             return setup_static_shmem(dev, cinfo, channel);
> > +     else
> > +             return setup_dynamic_shmem(dev, channel);
> > +}
> > +
> > +static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct =
device *dev, bool tx)
> > +{
> > +     struct scmi_optee_channel *channel;
> > +     uint32_t channel_id;
> > +     int ret;
> > +
> > +     if (!tx)
> > +             return -ENODEV;
> > +
> > +     channel =3D devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
> > +     if (!channel)
> > +             return -ENOMEM;
> > +
> > +     ret =3D of_property_read_u32_index(cinfo->dev->of_node, "linaro,o=
ptee-channel-id",
> > +                                      0, &channel_id);
> > +     if (ret)
> > +             return ret;
> > +
> > +     cinfo->transport_info =3D channel;
> > +     channel->cinfo =3D cinfo;
> > +     channel->channel_id =3D channel_id;
> > +     mutex_init(&channel->mu);
> > +
> > +     ret =3D setup_shmem(dev, cinfo, channel);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D open_session(scmi_optee_private, &channel->tee_session);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D get_channel(channel);
> > +     if (ret) {
> > +             close_session(scmi_optee_private, channel->tee_session);
> > +             return ret;
> > +     }
>
> Shouldn't dynamic shmem (if used) be freed explicitly on the err path if
> open_session or get_channel fails (like you do in scmi_optee_chan_free())=
 ?
>
>         if (channel->tee_shm) {
>                 tee_shm_free(channel->tee_shm);
>                 ...
>
> Since if .chan_setup() fails here the SCMI core won't register this
> channel in the related IDR map and .chan_free won't be called ever.
> (or initialize shmem later once you have opened the session and got the
> channel and you know you cannot fail anymore...if it is not needed by
> open_session and get_channel as it seems but only later by the SCMI msg
> flow)

Thanks for pointing that. I missed it.
Yes, should release allocated shm upon failure.

>
> > +
> > +     mutex_lock(&scmi_optee_private->mu);
> > +     list_add(&channel->link, &scmi_optee_private->channel_list);
> > +     mutex_unlock(&scmi_optee_private->mu);
> > +
> > +     return 0;
> > +}
> > +
> > +static int scmi_optee_chan_free(int id, void *p, void *data)
> > +{
> > +     struct scmi_chan_info *cinfo =3D p;
> > +     struct scmi_optee_channel *channel =3D cinfo->transport_info;
> > +
> > +     mutex_lock(&scmi_optee_private->mu);
> > +     list_del(&channel->link);
> > +     mutex_unlock(&scmi_optee_private->mu);
> > +
>
> I may be wrong (not familiar wih optee) but, somewhere around here, shoul=
d
> you not also close the session left open on .chan_setup() success (which =
you
> used actively for SCMI msg exchanges via send_message()/
> invoke_process_smt_channel() ?

You are fully right. I failed most resource release path.
Will fix. Thanks again.

>
> > +     if (channel->tee_shm) {
> > +             tee_shm_free(channel->tee_shm);
> > +             channel->tee_shm =3D NULL;
> > +     }
> > +
> > +     cinfo->transport_info =3D NULL;
> > +     channel->cinfo =3D NULL;
> > +
> > +     scmi_free_channel(cinfo, data, id);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct scmi_shared_mem *get_channel_shm(struct scmi_optee_chann=
el *chan,
> > +                                            struct scmi_xfer *xfer)
> > +{
> > +     if (!chan)
> > +             return NULL;
> > +
> > +     return chan->shmem;
> > +}
> > +
> > +
> > +static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
> > +                                struct scmi_xfer *xfer)
> > +{
> > +     struct scmi_optee_channel *channel =3D cinfo->transport_info;
> > +     struct scmi_shared_mem *shmem =3D get_channel_shm(channel, xfer);
> > +     int ret;
> > +
> > +     mutex_lock(&channel->mu);
> > +     shmem_tx_prepare(shmem, xfer);
> > +
> > +     ret =3D invoke_process_smt_channel(channel);
> > +
> > +     scmi_rx_callback(cinfo, shmem_read_header(shmem), NULL);
> > +     mutex_unlock(&channel->mu);
> > +
> > +     return ret;
> > +}
> > +
> > +static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
> > +                                   struct scmi_xfer *xfer)
> > +{
> > +     struct scmi_optee_channel *channel =3D cinfo->transport_info;
> > +     struct scmi_shared_mem *shmem =3D get_channel_shm(channel, xfer);
> > +
> > +     shmem_fetch_response(shmem, xfer);
> > +}
> > +
> > +static bool scmi_optee_poll_done(struct scmi_chan_info *cinfo,
> > +                              struct scmi_xfer *xfer)
> > +{
> > +     struct scmi_optee_channel *channel =3D cinfo->transport_info;
> > +     struct scmi_shared_mem *shmem =3D get_channel_shm(channel, xfer);
> > +
> > +     return shmem_poll_done(shmem, xfer);
> > +}
>
> Will polling ever be a thing on this transport given that
> invoke_process_smt_channel() is supposed to return atomically ?
>
> (i.e. should we just drop this and .poll_done in the ops below,
> given with v5.15 you can safely omit polling support and the SCMI core
> will refuse to use it even if requested ?)

From the v5.15-rc7 implementation I understand that poll_done operator
is required when a caller explicitly asks for a polling mode. I can
find only SCMI perf as a caller upon a cpufreq fast switch request. So
It seems to me the SCMI transport should provide a handler for that,
in case it's needed, unless what do_xfer() would warn.
Am I wrong?

>
> > +
> > +static struct scmi_transport_ops scmi_optee_ops =3D {
> > +     .link_supplier =3D scmi_optee_link_supplier,
> > +     .chan_available =3D scmi_optee_chan_available,
> > +     .chan_setup =3D scmi_optee_chan_setup,
> > +     .chan_free =3D scmi_optee_chan_free,
> > +     .send_message =3D scmi_optee_send_message,
> > +     .fetch_response =3D scmi_optee_fetch_response,
> > +     .clear_channel =3D scmi_optee_clear_channel,
> > +     .poll_done =3D scmi_optee_poll_done,
> > +};
> > +
> > +static int scmi_optee_ctx_match(struct tee_ioctl_version_data *ver, co=
nst void *data)
> > +{
> > +     return ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE;
> > +}
> > +
> > +static int scmi_optee_service_probe(struct device *dev)
> > +{
> > +     struct scmi_optee_agent *agent;
> > +     struct tee_context *tee_ctx;
> > +     int ret;
> > +
> > +     /* Only one SCMI OP-TEE device allowed */
> > +     if (scmi_optee_private) {
> > +             dev_err(dev, "An SCMI OP-TEE device was already initializ=
ed: only one allowed\n");
> > +             return -EBUSY;
> > +     }
> > +
> > +     tee_ctx =3D tee_client_open_context(NULL, scmi_optee_ctx_match, N=
ULL, NULL);
> > +     if (IS_ERR(tee_ctx))
> > +             return -ENODEV;
> > +
> > +     agent =3D devm_kzalloc(dev, sizeof(*agent), GFP_KERNEL);
> > +     if (!agent) {
> > +             ret =3D -ENOMEM;
> > +             goto err;
> > +     }
> > +
> > +     agent->dev =3D dev;
> > +     agent->tee_ctx =3D tee_ctx;
> > +     INIT_LIST_HEAD(&agent->channel_list);
> > +
> > +     ret =3D get_capabilities(agent);
> > +     if (ret)
> > +             goto err;
> > +
> > +     /* Ensure agent resources are all visible before scmi_optee_priva=
te is */
> > +     smp_mb();
> > +     scmi_optee_private =3D agent;
> > +
> > +     return 0;
> > +
> > +err:
> > +     tee_client_close_context(tee_ctx);
> > +
> > +     return ret;
> > +}
> > +
> > +static int scmi_optee_service_remove(struct device *dev)
> > +{
> > +     struct scmi_optee_agent *agent =3D scmi_optee_private;
> > +
> > +     if (!scmi_optee_private)
> > +             return -EINVAL;
> > +
> > +     if (!list_empty(&scmi_optee_private->channel_list))
> > +             return -EBUSY;
> > +
> > +     /* Ensure cleared reference is visible before resources are relea=
sed */
> > +     smp_store_mb(scmi_optee_private, NULL);
> > +
> > +     tee_client_close_context(agent->tee_ctx);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct tee_client_device_id scmi_optee_service_id[] =3D {
> > +     {
> > +             UUID_INIT(0xa8cfe406, 0xd4f5, 0x4a2e,
> > +                       0x9f, 0x8d, 0xa2, 0x5d, 0xc7, 0x54, 0xc0, 0x99)
> > +     },
> > +     { }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(tee, scmi_optee_service_id);
> > +
> > +static struct tee_client_driver scmi_optee_driver =3D {
> > +     .id_table       =3D scmi_optee_service_id,
> > +     .driver         =3D {
> > +             .name =3D "scmi-optee",
> > +             .bus =3D &tee_bus_type,
> > +             .probe =3D scmi_optee_service_probe,
> > +             .remove =3D scmi_optee_service_remove,
> > +     },
> > +};
> > +
> > +static int scmi_optee_init(void)
> > +{
> > +     return driver_register(&scmi_optee_driver.driver);
> > +}
> > +
> > +static void scmi_optee_exit(void)
> > +{
> > +     driver_unregister(&scmi_optee_driver.driver);
> > +}
> > +
> > +const struct scmi_desc scmi_optee_desc =3D {
> > +     .transport_exit =3D scmi_optee_exit,
> > +     .ops =3D &scmi_optee_ops,
> > +     .max_rx_timeout_ms =3D 30,
> > +     .max_msg =3D 20,
> > +     .max_msg_size =3D 128,
>
> Shouldn't we use SCMI_OPTEE_MAX_MSG_SIZE now here too that we have it ?

indeed!

Thanks for all the findings.
Regards,
Etienne

>
> Thanks,
> Cristian

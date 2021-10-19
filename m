Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86F8433863
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhJSO2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhJSO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:28:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8943AC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:26:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ec8so13752174edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yW3YZybIiYOrNDmXT66FEbyuKAadk5Hmp6J68GVcIUo=;
        b=AslPLw8mXmVkiU4T17lnyvvEhOftOeRtCQsVgDuMcz05jL5pT0I72931u1VuZP/EZz
         mx81RoMKsffNu0/c5hc8zRHOyZH30r2BNnu7ASqhGUAu2FIJIvK4F2dZx6B0opfTBc1o
         6YChtJ1aTTP5qfZNtM5y8FEo6iaw4wss0RSLULKNq/QhVVe2kFyW0whWln0O2DqmGpM9
         1VpwJOg6dAi6FVapLR62zrJuMzDQy8tqpAoGHCtjTNJbWnP+v4+dlkBBwheciJUf20M2
         TMxqP5QeW6uxiLsiXhDFyZ7vMJ6PxV81s/XcK4qr2kFOd3Hdj7GVaoJtVCCmlZxTMU5y
         Pdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yW3YZybIiYOrNDmXT66FEbyuKAadk5Hmp6J68GVcIUo=;
        b=vO/EdS/P3QI2aDhx11Qiq1pnX4zC4Oy7ktK9zPiCxsBGxnSXJ/Dv5RE2oaytM7eJxe
         TFFW9i1SARvwIuKKTpQwvq96X4VaBa2YHdOYTUSxs22vQ+v482B4nM+Zo8d0OL7Z017E
         DiLXpcB4XO2YAeN6NUZHVCgmmiml88/M5pJ7OKj+bBzJ4uBAPR9d9AGCEphxlOAgRlmo
         cm4m7a8JLLxyDykqgV2AmZ+wYuxGLO0DaVpmGXNM9pWRJ0FnODc/AKnAhdhp38uqWe+p
         yTvp6Kr9nKVsxGpGVDY108MPxq1VPdzCopkTe7VkICT4gmSckh2Gfct1wD20jf1PzD0j
         5T0w==
X-Gm-Message-State: AOAM531q8VlTsBHCm4PbZDH9q1wMMfsrta/TNLL9aZzYsj7uAdq+du+M
        x0ex9TgajoZgOUF9uqln3v4QX3IOz3xhqQWeXVHNTw==
X-Google-Smtp-Source: ABdhPJxD5ZE6d0FXENcrQN//+yLHsxoCEzGuODuz45f4fwZiAlKhAIrTc/+QRZjP5t7AG69gJBQvmp+/ewoMx6nKcU8=
X-Received: by 2002:aa7:c2da:: with SMTP id m26mr55448769edp.89.1634653481834;
 Tue, 19 Oct 2021 07:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211018114046.25571-1-etienne.carriere@linaro.org>
 <20211018114046.25571-2-etienne.carriere@linaro.org> <20211018194317.GA6526@e120937-lin>
 <CAN5uoS_8E53=0rTeHuuc79_rBandfxVjXKwNcURVF6WsUY33pg@mail.gmail.com>
In-Reply-To: <CAN5uoS_8E53=0rTeHuuc79_rBandfxVjXKwNcURVF6WsUY33pg@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 19 Oct 2021 16:24:30 +0200
Message-ID: <CAN5uoS-qLOtNnD+jnaEn+Yf0W-zwmG9X-9oT=cM3-hesFCXJDw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] firmware: arm_scmi: Add optee transport
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

Hi,

On Tue, 19 Oct 2021 at 11:10, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
>  Hello Cristian,
>
> Thanks a lot for the review.
> I see I didn't understand and use correctly the config switch for the tra=
nsport.
> Thanks for all the fixes you sent, i'll integrate them in the patch v4.
>
> I don't know yet how to address your last comment. See my feedback on
> the optee bus dependency issue.
>
>
>
> On Mon, 18 Oct 2021 at 21:43, Cristian Marussi <cristian.marussi@arm.com>=
 wrote:
> >
> > On Mon, Oct 18, 2021 at 01:40:46PM +0200, Etienne Carriere wrote:
> > > Add a new transport channel to the SCMI firmware interface driver for
> > > SCMI message exchange based on optee transport channel. The optee
> > > transport is realized by connecting and invoking OP-TEE SCMI service
> > > interface PTA.
> > >
> > > Optee transport support (CONFIG_ARM_SCMI_TRANSPORT_OPTEE) is default
> > > enabled when optee driver (CFG_OPTEE) is enabled. Effective optee
> > > transport is setup upon OP-TEE SCMI service discovery at optee
> > > device initialization. For this SCMI UUID is registered to the optee
> > > bus for probing. This is done at device_init initcall level, after
> > > optee bus initialization that is done at subsys_init level, as the sc=
mi
> > > driver initialization.
> > >
> > > The optee transport can use a statically defined shared memory in
> > > which case SCMI device tree node defines it using an "arm,scmi-shmem"
> > > compatible phandle through property shmem. Alternatively, optee trans=
port
> > > allocates the shared memory buffer from the optee driver when no shme=
m
> > > property is defined.
> > >
> > > The protocol used to exchange SCMI message over that shared memory is
> > > negotiated between optee transport driver and the OP-TEE service thro=
ugh
> > > capabilities exchange.
> > >
> > > OP-TEE SCMI service is integrated in OP-TEE since its release tag 3.1=
3.0.
> > > The service interface is published in [1].
> > >
> > > Link: [1] https://github.com/OP-TEE/optee_os/blob/3.13.0/lib/libutee/=
include/pta_scmi_client.h
> > > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > ---
> > > Changes since v2:
> > > - Rebase on for-next/scmi, based on Linux v5.15-rc1.
> > > - Implement support for dynamic and static shared memory.
> > > - Factorize some functions and simplify transport exit sequence.
> > > - Rename driver source file from optee_service.c to optee.c.
> > >
> > > No change since v1
> > > ---
> >
> > Hi Etienne,
> >
> > a few remarks below.
> >
> > >  drivers/firmware/arm_scmi/Kconfig  |  12 +
> > >  drivers/firmware/arm_scmi/Makefile |   1 +
> > >  drivers/firmware/arm_scmi/common.h |   3 +
> > >  drivers/firmware/arm_scmi/driver.c |   3 +
> > >  drivers/firmware/arm_scmi/optee.c  | 559 +++++++++++++++++++++++++++=
++
> > >  5 files changed, 578 insertions(+)
> > >  create mode 100644 drivers/firmware/arm_scmi/optee.c
> > >
> > > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm=
_scmi/Kconfig
> > > index 3d7081e84853..9107e249023c 100644
> > > --- a/drivers/firmware/arm_scmi/Kconfig
> > > +++ b/drivers/firmware/arm_scmi/Kconfig
> > > @@ -77,6 +77,18 @@ config ARM_SCMI_TRANSPORT_VIRTIO
> > >         If you want the ARM SCMI PROTOCOL stack to include support fo=
r a
> > >         transport based on VirtIO, answer Y.
> > >
> > > +config ARM_SCMI_TRANSPORT_OPTEE
> > > +     bool "SCMI transport based on OP-TEE service"
> > > +     depends on OPTEE
> > > +     select ARM_SCMI_HAVE_TRANSPORT
> > > +     select ARM_SCMI_HAVE_SHMEM
> > > +     default y
> > > +     help
> > > +       This enables the OP-TEE service based transport for SCMI.
> > > +
> > > +       If you want the ARM SCMI PROTOCOL stack to include support fo=
r a
> > > +       transport based on OP-TEE SCMI service, answer Y.
> > > +
> > >  endif #ARM_SCMI_PROTOCOL
> > >
> >
> > So this 'depends on OPTEE' reminded me of a similar issue on VIRTIO
> > transport spotted by a bot (see the fix for Virtio at: c90521a0e94f fir=
mware:
> > arm_scmi: Fix virtio transport Kconfig dependency), that consiste in a =
broken
> > build when SCMI was compiled built-in with VIRTIO transport support wit=
h
> > ARM_SCMI_PROTOCOL=3Dy while the core was CONFIG_VIRTIO=3Dm.
> >
> > So I tried similarly to set CONFIG_OPTEE=3Dm while keeping ARM_SCMI_PRO=
TOCOL=3Dy
> > expecting to see a similar issue as in VirtIO (i.e. not being able to a=
ccess
> > optee module symbols from the builtin SCMI), instead I spotted a differ=
ent bug :D
>
> Sorry, I didn't try this config (optee=3Dm / scmi=3Dy). I though expectin=
g
> scmi over optee and scmi=3Dy would mandate optee=3Dy.
> For the fixup you propose below, i understand how you address the
> configuration dependencies.
>
> >
> >   AR      drivers/base/built-in.a
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
: In function =E2=80=98invoke_process_smt_channel=E2=80=99:
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:233:27: error: =E2=80=98scmi_optee_desc=E2=80=99 undeclared (first use in =
this function); did you mean =E2=80=98scmi_smc_desc=E2=80=99?
> >    const size_t msg_size =3D scmi_optee_desc.max_msg_size;
> >                            ^~~~~~~~~~~~~~~
> >                            scmi_smc_desc
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:233:27: note: each undeclared identifier is reported only once for each fu=
nction it appears in
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
: In function =E2=80=98setup_dynamic_shmem=E2=80=99:
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:266:26: error: =E2=80=98scmi_optee_desc=E2=80=99 undeclared (first use in =
this function); did you mean =E2=80=98scmi_smc_desc=E2=80=99?
> >   const size_t msg_size =3D scmi_optee_desc.max_msg_size;
> >                           ^~~~~~~~~~~~~~~
> >                           scmi_smc_desc
> > /home/crimar01/ARM/dev/src/pdsw/linux/scripts/Makefile.build:277: recip=
e for target 'drivers/firmware/arm_scmi/optee.o' failed
> > make[4]: *** [drivers/firmware/arm_scmi/optee.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> >
> > In fact those scmi_optee_desc are reference to a global only declared
> > down below. Fixed with a few defines to carry on:
> >
> > ---8<------------------
> >
> > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_s=
cmi/optee.c
> > index 64aaba4a8bf2..93a84c91457b 100644
> > --- a/drivers/firmware/arm_scmi/optee.c
> > +++ b/drivers/firmware/arm_scmi/optee.c
> > @@ -18,6 +18,8 @@
> >
> >  #define DRIVER_NAME "optee-scmi"
> >
> > +#define SCMI_OPTEE_MAX_MSG_SIZE                128
> > +
> >  enum optee_smci_pta_cmd {
> >         /*
> >          * PTA_SCMI_CMD_CAPABILITIES - Get channel capabilities
> > @@ -230,7 +232,7 @@ static int invoke_process_smt_channel(struct optee_=
channel *channel)
> >         param[0].u.value.a =3D channel->channel_id;
> >
> >         if (channel->tee_shm) {
> > -               const size_t msg_size =3D scmi_optee_desc.max_msg_size;
> > +               const size_t msg_size =3D SCMI_OPTEE_MAX_MSG_SIZE;
> >
> >                 param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOU=
T;
> >                 param[1].u.memref.shm =3D channel->tee_shm;
> > @@ -263,7 +265,7 @@ static bool optee_chan_available(struct device *dev=
, int idx)
> >
> >  static int setup_dynamic_shmem(struct device *dev, struct optee_channe=
l *channel)
> >  {
> > -       const size_t msg_size =3D scmi_optee_desc.max_msg_size;
> > +       const size_t msg_size =3D SCMI_OPTEE_MAX_MSG_SIZE;
> >
> >         channel->tee_shm =3D tee_shm_alloc_kernel_buf(optee_private->te=
e_ctx, msg_size);
> >         if (IS_ERR(channel->tee_shm)) {
> >
> > -----------------------------
> >
> > After the above change it compiled fine, so I went a step further and c=
onfigured also
> > CONFIG_TEE=3Dm (just trying to reproduce what bot saw on similar VirtIO=
 eeh.... not that
> > I am so evil and sadic :D)
> >
> > And indeed now (with ARM_SCMI_PROTOCOL=3Dy and CONFIG_TEE=3Dm) I get:
> >
> >
> >   GEN     modules.builtin
> >   LD      .tmp_vmlinux.kallsyms1
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `invoke_proc=
ess_smt_channel':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:247: undefined reference to `tee_client_invoke_func'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_=
scmi/optee.c:247: undefined reference to `tee_client_invoke_func'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `optee_chan_=
free':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:397: undefined reference to `tee_shm_free'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `open_sessio=
n':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:137: undefined reference to `tee_client_open_session'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `optee_servi=
ce_remove':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:516: undefined reference to `tee_client_close_context'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `optee_servi=
ce_probe':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:481: undefined reference to `tee_client_open_context'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_=
scmi/optee.c:501: undefined reference to `tee_client_close_context'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `get_capabil=
ities':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:172: undefined reference to `tee_client_invoke_func'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `close_sessi=
on':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:151: undefined reference to `tee_client_close_session'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `get_channel=
':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:209: undefined reference to `tee_client_invoke_func'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `setup_dynam=
ic_shmem':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:270: undefined reference to `tee_shm_alloc_kernel_buf'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_=
scmi/optee.c:276: undefined reference to `tee_shm_get_va'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `close_sessi=
on':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:151: undefined reference to `tee_client_close_session'
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o:(.data+0x10): undefined r=
eference to `tee_bus_type'
> > /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1189: recipe for target =
'vmlinux' failed
> > make[1]: *** [vmlinux] Error 1
> > make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
> > Makefile:219: recipe for target '__sub-make' failed
> >
> > Taking a similar approach to Virtio, this fixed for me
> >
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_s=
cmi/Kconfig
> > index 9107e249023c..30746350349c 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -79,7 +79,7 @@ config ARM_SCMI_TRANSPORT_VIRTIO
> >
> >  config ARM_SCMI_TRANSPORT_OPTEE
> >         bool "SCMI transport based on OP-TEE service"
> > -       depends on OPTEE
> > +       depends on OPTEE=3Dy || OPTEE=3DARM_SCMI_PROTOCOL
> >         select ARM_SCMI_HAVE_TRANSPORT
> >         select ARM_SCMI_HAVE_SHMEM
> >         default y
> >
> > which basically disables ARM_SCMI_TRANSPORT_OPTEE when CONFIG_OPTEE=3Dm=
 AND
> > ARM_SCMI_TRANSPORT_OPTEE=3Dy: in this scenario if TEE is =3Dm you have =
to build
> > ARM_SCMI_PROTOCOL=3Dm too to be able to include ARM_SCMI_TRANSPORT_OPTE=
E.
>
> Fully makes sense to me. Thanks. I understand.
>
> >
> >
> > >  config ARM_SCMI_POWER_DOMAIN
> > > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/ar=
m_scmi/Makefile
> > > index 1dcf123d64ab..ef66ec8ca917 100644
> > > --- a/drivers/firmware/arm_scmi/Makefile
> > > +++ b/drivers/firmware/arm_scmi/Makefile
> > > @@ -6,6 +6,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) +=
=3D mailbox.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=3D smc.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D msg.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) +=3D virtio.o
> > > +scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
> > >  scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o=
 system.o voltage.o
> > >  scmi-module-objs :=3D $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocol=
s-y) \
> > >                   $(scmi-transport-y)
> > > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/ar=
m_scmi/common.h
> > > index dea1bfbe1052..82ff3c3a6d2d 100644
> > > --- a/drivers/firmware/arm_scmi/common.h
> > > +++ b/drivers/firmware/arm_scmi/common.h
> > > @@ -421,6 +421,9 @@ extern const struct scmi_desc scmi_smc_desc;
> > >  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
> > >  extern const struct scmi_desc scmi_virtio_desc;
> > >  #endif
> > > +#ifdef CONFIG_OPTEE
> >
> > This should be:
> >
> > #ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
> >
> > if not disabling OPTEE transport in Kconfig breaks the build.
> >
> >  LD      .tmp_vmlinux.kallsyms1
> >  /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch=
64-linux-gnu-ld:
> >  drivers/firmware/arm_scmi/driver.o:(.rodata+0x280): undefined referenc=
e
> >  to `scmi_optee_desc'
> >  /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1189: recipe for target
> >  'vmlinux' failed
> >  make[1]: *** [vmlinux] Error 1
> >  make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
> >
> >
> > > +extern const struct scmi_desc scmi_optee_desc;
> > > +#endif
> > >
> > >  void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, voi=
d *priv);
> > >  void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr=
, int id);
> > > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/ar=
m_scmi/driver.c
> > > index b406b3f78f46..06f0a9846c7e 100644
> > > --- a/drivers/firmware/arm_scmi/driver.c
> > > +++ b/drivers/firmware/arm_scmi/driver.c
> > > @@ -1999,6 +1999,9 @@ static const struct of_device_id scmi_of_match[=
] =3D {
> > >  #endif
> > >  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
> > >       { .compatible =3D "arm,scmi-virtio", .data =3D &scmi_virtio_des=
c},
> > > +#endif
> > > +#ifdef CONFIG_OPTEE
> >
> > Same as above should be #if CONFIG_ARM_SCMI_TRANSPORT_OPTEE
> >
> > > +     { .compatible =3D "linaro,scmi-optee", .data =3D &scmi_optee_de=
sc },
> > >  #endif
> > >       { /* Sentinel */ },
> > >  };
> > > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm=
_scmi/optee.c
> > > new file mode 100644
> > > index 000000000000..e294cff37bea
> > > --- /dev/null
> > > +++ b/drivers/firmware/arm_scmi/optee.c
> > > @@ -0,0 +1,559 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2019-2021 Linaro Ltd.
> > > + */
> > > +
> > > +#include <linux/io.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/tee_drv.h>
> > > +#include <linux/uuid.h>
> > > +#include <uapi/linux/tee.h>
> > > +
> > > +#include "common.h"
> > > +
> > > +#define DRIVER_NAME "optee-scmi"
> > > +
> > > +enum optee_smci_pta_cmd {
> >               ^
> >               scmi ? or is it another fancy 4letters acronym :D
>
> :) nice catch!
>
> > > +     /*
> > > +      * PTA_SCMI_CMD_CAPABILITIES - Get channel capabilities
> > > +      *
> > > +      * [out]    value[0].a: Capability bit mask (enum pta_scmi_caps=
)
> > > +      * [out]    value[0].b: Extended capabilities or 0
> > > +      */
> > > +     PTA_SCMI_CMD_CAPABILITIES =3D 0,
> > > +
> > > +     /*
> > > +      * PTA_SCMI_CMD_PROCESS_SMT_CHANNEL - Process SCMI message in S=
MT buffer
> > > +      *
> > > +      * [in]     value[0].a: Channel handle
> > > +      *
> > > +      * Shared memory used for SCMI message/response exhange is expe=
cted
> > > +      * already identified and bound to channel handle in both SCMI =
agent
> > > +      * and SCMI server (OP-TEE) parts.
> > > +      * The memory uses SMT header to carry SCMI meta-data (protocol=
 ID and
> > > +      * protocol message ID).
> > > +      */
> > > +     PTA_SCMI_CMD_PROCESS_SMT_CHANNEL =3D 1,
> > > +
> > > +     /*
> > > +      * PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE - Process SMT/SCMI =
message
> > > +      *
> > > +      * [in]     value[0].a: Channel handle
> > > +      * [in/out] memref[1]: Message/response buffer (SMT and SCMI pa=
yload)
> > > +      *
> > > +      * Shared memory used for SCMI message/response is a SMT buffer
> > > +      * referenced by param[1]. It shall be 128 bytes large to fit r=
esponse
> > > +      * payload whatever message playload size.
> > > +      * The memory uses SMT header to carry SCMI meta-data (protocol=
 ID and
> > > +      * protocol message ID).
> > > +      */
> > > +     PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE =3D 2,
> > > +
> > > +     /*
> > > +      * PTA_SCMI_CMD_GET_CHANNEL - Get channel handle
> > > +      *
> > > +      * SCMI shm information are 0 if agent expects to use OP-TEE re=
gular SHM
> > > +      *
> > > +      * [in]     value[0].a: Channel identifier
> > > +      * [out]    value[0].a: Returned channel handle
> > > +      * [in]     value[0].b: Requested capabilities mask (enum pta_s=
cmi_caps)
> > > +      */
> > > +     PTA_SCMI_CMD_GET_CHANNEL =3D 3,
> > > +};
> > > +
> > > +/*
> > > + * Capabilities
> > > + */
> > > +enum pta_scmi_caps {
> > > +     PTA_SCMI_CAPS_NONE =3D 0,
> > > +     /*
> > > +      * Supports command using SMT header protocol (SCMI shmem) in s=
hared
> > > +      * memory buffers to carry SCMI protocol synchronisation inform=
ation.
> > > +      */
> > > +     PTA_SCMI_CAPS_SMT_HEADER =3D BIT(0),
> > > +};
> > > +
> > > +/**
> > > + * struct optee_channel - Description of an OP-TEE SCMI channel
> > > + *
> > > + * @channel_id: OP-TEE channel ID used for this transport
> > > + * @mu: Mutex protection on channel access
> > > + * @tee_session: TEE session identifier
> > > + * @cinfo: SCMI channel information
> > > + * @shmem: Virtual base address of the shared memory
> > > + * @tee_shm: Reference to TEE shared memory or NULL if using static =
shmem
> > > + * @caps: OP-TEE SCMI channel capabilities
> > > + * @link: Reference in agent's channel list
> > > + */
> > > +struct optee_channel {
> > > +     u32 channel_id;
> > > +     struct mutex mu;
> > > +     u32 tee_session;
> > > +     struct scmi_chan_info *cinfo;
> > > +     struct scmi_shared_mem __iomem *shmem;
> > > +     struct tee_shm *tee_shm;
> > > +     enum pta_scmi_caps caps;
> > > +     struct list_head link;
> > > +};
> > > +
> > > +/**
> > > + * struct optee_agent - OP-TEE transport private data
> > > + *
> > > + * @dev: Device used for communication with TEE
> > > + * @tee_ctx: TEE context used for communication
> > > + * @caps: Supported channel capabilities
> > > + * @mu: Mutex for protection of @channel_list
> > > + * @channel_list: List of all created channels for the agent
> > > + */
> > > +struct optee_agent {
> > > +     struct device *dev;
> > > +     struct tee_context *tee_ctx;
> > > +     enum pta_scmi_caps caps;
> > > +     struct mutex mu;
> > > +     struct list_head channel_list;
> > > +};
> > > +
> > > +/* There can be only 1 SCMI service in OP-TEE we connect to */
> > > +static struct optee_agent *optee_private;
> > > +
> >
> > Maybe naming these locally defined optee_ structs as scmi_optee_ ?
> >
> > When I see those optee_ refs around down below I tend to think they
> > are OPTEE core structs not locally defined containers.
> > (I uderstand that depends on my poor familiarity with OPTEE APIs
> > though...)
>
> Ok. If that help maintenance, I'm fine. I'll use scmi_optee_ where appiic=
able.
>
>
> >
> > > +/* Open a session toward SCMI OP-TEE service with REE_KERNEL identit=
y */
> > > +static int open_session(u32 *tee_session)
> > > +{
> > > +     struct device *dev =3D optee_private->dev;
> > > +     struct tee_client_device *scmi_pta =3D to_tee_client_device(dev=
);
> > > +     struct tee_ioctl_open_session_arg arg =3D { };
> > > +     int ret;
> > > +
> > > +     memcpy(arg.uuid, scmi_pta->id.uuid.b, TEE_IOCTL_UUID_LEN);
> > > +     arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> > > +
> > > +     ret =3D tee_client_open_session(optee_private->tee_ctx, &arg, N=
ULL);
> > > +     if (ret < 0 || arg.ret) {
> > > +             dev_err(dev, "Can't open tee session: %d / %#x\n", ret,=
 arg.ret);
> > > +
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> > > +     *tee_session =3D arg.session;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void close_session(u32 tee_session)
> > > +{
> > > +     tee_client_close_session(optee_private->tee_ctx, tee_session);
> > > +}
> > > +
> > > +static int get_capabilities(void)
> > > +{
> > > +     struct optee_agent *agent =3D optee_private;
> > > +     struct tee_ioctl_invoke_arg arg =3D { };
> > > +     struct tee_param param[1] =3D { };
> > > +     u32 tee_session;
> > > +     int ret;
> > > +
> > > +     ret =3D open_session(&tee_session);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     arg.func =3D PTA_SCMI_CMD_CAPABILITIES;
> > > +     arg.session =3D tee_session;
> > > +     arg.num_params =3D 1;
> > > +
> > > +     param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> > > +
> > > +     ret =3D tee_client_invoke_func(agent->tee_ctx, &arg, param);
> > > +
> > > +     close_session(tee_session);
> > > +
> > > +     if (ret < 0 || arg.ret) {
> > > +             dev_err(agent->dev, "Can't get capabilities: %d / %#x\n=
", ret, arg.ret);
> > > +
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> > > +     agent->caps =3D param[0].u.value.a;
> > > +
> > > +     if (!(agent->caps & PTA_SCMI_CAPS_SMT_HEADER)) {
> > > +             dev_err(agent->dev, "OP-TEE SCMI PTA doesn't support SM=
T\n");
> > > +
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int get_channel(struct optee_channel *channel)
> > > +{
> > > +     struct device *dev =3D optee_private->dev;
> > > +     struct tee_ioctl_invoke_arg arg =3D { };
> > > +     struct tee_param param[1] =3D { };
> > > +     unsigned int caps =3D PTA_SCMI_CAPS_SMT_HEADER;
> > > +     int ret;
> > > +
> > > +     arg.func =3D PTA_SCMI_CMD_GET_CHANNEL;
> > > +     arg.session =3D channel->tee_session;
> > > +     arg.num_params =3D 1;
> > > +
> > > +     param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT;
> > > +     param[0].u.value.a =3D channel->channel_id;
> > > +     param[0].u.value.b =3D caps;
> > > +
> > > +     ret =3D tee_client_invoke_func(optee_private->tee_ctx, &arg, pa=
ram);
> > > +
> > > +     if (ret || arg.ret) {
> > > +             dev_err(dev, "Can't get channel with caps %#x: %d / %#x=
\n", caps, ret, arg.ret);
> > > +
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> > > +     /* From now on use channel identifer provided by OP-TEE SCMI se=
rvice */
> > > +     channel->channel_id =3D param[0].u.value.a;
> > > +     channel->caps =3D caps;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int invoke_process_smt_channel(struct optee_channel *channel)
> > > +{
> > > +     struct tee_ioctl_invoke_arg arg =3D { };
> > > +     struct tee_param param[2] =3D { };
> > > +     int ret;
> > > +
> > > +     arg.session =3D channel->tee_session;
> > > +     param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> > > +     param[0].u.value.a =3D channel->channel_id;
> > > +
> > > +     if (channel->tee_shm) {
> > > +             const size_t msg_size =3D scmi_optee_desc.max_msg_size;
> > > +
> > > +             param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOU=
T;
> > > +             param[1].u.memref.shm =3D channel->tee_shm;
> > > +             param[1].u.memref.size =3D msg_size;
> > > +             arg.num_params =3D 2;
> > > +             arg.func =3D PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE;
> > > +     } else {
> > > +             arg.num_params =3D 1;
> > > +             arg.func =3D PTA_SCMI_CMD_PROCESS_SMT_CHANNEL;
> > > +     }
> > > +
> > > +     ret =3D tee_client_invoke_func(optee_private->tee_ctx, &arg, pa=
ram);
> > > +     if (ret < 0 || arg.ret) {
> > > +             dev_err(optee_private->dev, "Failed on channel %u: %d /=
 %#x\n",
> > > +                     channel->channel_id, ret, arg.ret);
> > > +
> > > +             return -EIO;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static bool optee_chan_available(struct device *dev, int idx)
> > > +{
> > > +     u32 channel_id;
> > > +
> > > +     return !of_property_read_u32_index(dev->of_node, "linaro,optee-=
channel-id",
> > > +                                        idx, &channel_id);
> > > +}
> > > +
> > > +static int setup_dynamic_shmem(struct device *dev, struct optee_chan=
nel *channel)
> > > +{
> > > +     const size_t msg_size =3D scmi_optee_desc.max_msg_size;
> > > +
> > > +     channel->tee_shm =3D tee_shm_alloc_kernel_buf(optee_private->te=
e_ctx, msg_size);
> > > +     if (IS_ERR(channel->tee_shm)) {
> > > +             dev_err(channel->cinfo->dev, "shmem allocation failed\n=
");
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     channel->shmem =3D (void *)tee_shm_get_va(channel->tee_shm, 0);
> > > +     memset(channel->shmem, 0, msg_size);
> > > +     shmem_clear_channel(channel->shmem);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int setup_static_shmem(struct device *dev, struct scmi_chan_i=
nfo *cinfo,
> > > +                           struct optee_channel *channel)
> > > +{
> > > +     struct device_node *np;
> > > +     resource_size_t size;
> > > +     struct resource res;
> > > +     int ret;
> > > +
> > > +     np =3D of_parse_phandle(cinfo->dev->of_node, "shmem", 0);
> > > +     if (!of_device_is_compatible(np, "arm,scmi-shmem")) {
> > > +             ret =3D -ENXIO;
> > > +             goto out;
> > > +     }
> > > +
> > > +     ret =3D of_address_to_resource(np, 0, &res);
> > > +     if (ret) {
> > > +             dev_err(dev, "Failed to get SCMI Tx shared memory\n");
> > > +             goto out;
> > > +     }
> > > +
> > > +     size =3D resource_size(&res);
> > > +
> > > +     channel->shmem =3D devm_ioremap(dev, res.start, size);
> > > +     if (!channel->shmem) {
> > > +             dev_err(dev, "Failed to ioremap SCMI Tx shared memory\n=
");
> > > +             ret =3D -EADDRNOTAVAIL;
> > > +             goto out;
> > > +     }
> > > +
> > > +     ret =3D 0;
> > > +
> > > +out:
> > > +     of_node_put(np);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int optee_chan_setup_shmem(struct device *dev, struct scmi_ch=
an_info *cinfo,
> > > +                               bool tx, struct optee_channel *channe=
l)
> > > +{
> > > +     struct device *cdev =3D cinfo->dev;
> > > +
> > > +     if (of_find_property(cdev->of_node, "shmem", NULL))
> > > +             return setup_static_shmem(dev, cinfo, channel);
> > > +     else
> > > +             return setup_dynamic_shmem(dev, channel);
> > > +}
> > > +
> > > +static void optee_clear_channel(struct scmi_chan_info *cinfo)
> > > +{
> > > +     struct optee_channel *channel =3D cinfo->transport_info;
> > > +
> > > +     shmem_clear_channel(channel->shmem);
> > > +}
> > > +
> > > +static int optee_chan_setup(struct scmi_chan_info *cinfo, struct dev=
ice *dev, bool tx)
> > > +{
> > > +     struct optee_channel *channel;
> > > +     uint32_t channel_id;
> > > +     int ret;
> > > +
> > > +     if (!tx)
> > > +             return -ENODEV;
> > > +
> > > +     /* Shall wait for OP-TEE driver to be up and ready */
> > > +     if (!optee_private || !optee_private->tee_ctx)
> > > +             return -EPROBE_DEFER;
> > > +
> > > +     channel =3D devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
> > > +     if (!channel)
> > > +             return -ENOMEM;
> > > +
> > > +     ret =3D of_property_read_u32_index(cinfo->dev->of_node, "linaro=
,optee-channel-id",
> > > +                                      0, &channel_id);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     cinfo->transport_info =3D channel;
> > > +     channel->cinfo =3D cinfo;
> > > +     channel->channel_id =3D channel_id;
> > > +     mutex_init(&channel->mu);
> > > +
> > > +     ret =3D optee_chan_setup_shmem(dev, cinfo, tx, channel);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D open_session(&channel->tee_session);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D get_channel(channel);
> > > +     if (ret) {
> > > +             close_session(channel->tee_session);
> > > +
> > > +             return ret;
> > > +     }
> > > +
> > > +     mutex_lock(&optee_private->mu);
> > > +     list_add(&channel->link, &optee_private->channel_list);
> > > +     mutex_unlock(&optee_private->mu);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int optee_chan_free(int id, void *p, void *data)
> > > +{
> > > +     struct scmi_chan_info *cinfo =3D p;
> > > +     struct optee_channel *channel =3D cinfo->transport_info;
> > > +
> > > +     mutex_lock(&optee_private->mu);
> > > +     list_del(&channel->link);
> > > +     mutex_unlock(&optee_private->mu);
> > > +
> > > +     if (channel->tee_shm) {
> > > +             tee_shm_free(channel->tee_shm);
> > > +             channel->tee_shm =3D NULL;
> > > +     }
> > > +
> > > +     cinfo->transport_info =3D NULL;
> > > +     channel->cinfo =3D NULL;
> > > +
> > > +     scmi_free_channel(cinfo, data, id);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static struct scmi_shared_mem *get_channel_shm(struct optee_channel =
*chan, struct scmi_xfer *xfer)
> > > +{
> > > +     if (!chan)
> > > +             return NULL;
> > > +
> > > +     return chan->shmem;
> > > +}
> > > +
> > > +
> > > +static int optee_send_message(struct scmi_chan_info *cinfo,
> > > +                           struct scmi_xfer *xfer)
> > > +{
> > > +     struct optee_channel *channel =3D cinfo->transport_info;
> > > +     struct scmi_shared_mem *shmem =3D get_channel_shm(channel, xfer=
);
> > > +     int ret;
> > > +
> > > +     mutex_lock(&channel->mu);
> > > +     shmem_tx_prepare(shmem, xfer);
> > > +
> > > +     ret =3D invoke_process_smt_channel(channel);
> >
> > Here all the associated processing in the TrustedOS is fully completed
> > right ? i.e. all the possible reply values have been put into shmem by
> > the TrustedOS process before the underlying SMC call returns.
> > (just to understand better how OPTEE transport is supposed to behave)
>
> Yes, once we're back from invoke_process_smt_channel() the SCMI
> message has been processed and the response can be read.
> If no response is found, it will be reported as a communication error.
>
> >
> > > +
> > > +     scmi_rx_callback(cinfo, shmem_read_header(shmem), NULL);
> > > +     mutex_unlock(&channel->mu);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static void optee_fetch_response(struct scmi_chan_info *cinfo,
> > > +                              struct scmi_xfer *xfer)
> > > +{
> > > +     struct optee_channel *channel =3D cinfo->transport_info;
> > > +     struct scmi_shared_mem *shmem =3D get_channel_shm(channel, xfer=
);
> > > +
> > > +     shmem_fetch_response(shmem, xfer);
> > > +}
> > > +
> > > +static bool optee_poll_done(struct scmi_chan_info *cinfo,
> > > +                         struct scmi_xfer *xfer)
> > > +{
> > > +     struct optee_channel *channel =3D cinfo->transport_info;
> > > +     struct scmi_shared_mem *shmem =3D get_channel_shm(channel, xfer=
);
> > > +
> > > +     return shmem_poll_done(shmem, xfer);
> > > +}
> > > +
> > > +static struct scmi_transport_ops scmi_optee_ops =3D {
> > > +     .chan_available =3D optee_chan_available,
> > > +     .chan_setup =3D optee_chan_setup,
> > > +     .chan_free =3D optee_chan_free,
> > > +     .send_message =3D optee_send_message,
> > > +     .fetch_response =3D optee_fetch_response,
> > > +     .clear_channel =3D optee_clear_channel,
> > > +     .poll_done =3D optee_poll_done,
> > > +};
> > > +
> > > +const struct scmi_desc scmi_optee_desc =3D {
> > > +     .ops =3D &scmi_optee_ops,
> > > +     .max_rx_timeout_ms =3D 30,
> > > +     .max_msg =3D 20,
> > > +     .max_msg_size =3D 128,
> > > +};
> > > +
> > > +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const=
 void *data)
> > > +{
> > > +     return ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE;
> > > +}
> > > +
> > > +static int optee_service_probe(struct device *dev)
> > > +{
> > > +     struct optee_agent *agent;
> > > +     struct tee_context *tee_ctx;
> > > +     int ret;
> > > +
> > > +     /* Only one SCMI OP-TEE device allowed */
> > > +     if (optee_private) {
> > > +             dev_err(dev, "An SCMI OP-TEE device was already initial=
ized: only one allowed\n");
> > > +             return -EBUSY;
> > > +     }
> > > +
> > > +     tee_ctx =3D tee_client_open_context(NULL, optee_ctx_match, NULL=
, NULL);
> > > +     if (IS_ERR(tee_ctx))
> > > +             return -ENODEV;
> > > +
> > > +     agent =3D devm_kzalloc(dev, sizeof(*agent), GFP_KERNEL);
> > > +     if (!agent) {
> > > +             ret =3D -ENOMEM;
> > > +             goto out;
> > > +     }
> > > +
> > > +     agent->dev =3D dev;
> > > +     agent->tee_ctx =3D tee_ctx;
> > > +     INIT_LIST_HEAD(&agent->channel_list);
> > > +
> > > +     optee_private =3D agent;
> >
> > Barrier here to be sure this global is visible and not reordered ?
> >
> > Not sure if it is plausible that without a barrier the subsequent
> > optee_chan_setup could run on another core and simply miss this update
> > and bail out. (cannot see any locking of any kind either in the
> > chan_available/chan_setup TX path that could trigger a implicit memory
> > barrier....bah maybe I'm paranoid)
>
> No barrier needed IMO. optee_private is standard cached memory visible
> to all participant cores
> and chan_setup cannot be called before this function completes.
> Do I miss something?
>

I see why you ask for a barrier. Indeed, at module insertion we can
face consistency issues.

I agree barriers are needed. Looking at the scmi_virtio
implementation, i think the barriers are misplaced in the sequences.
The barrier should be placed before the global reference is loaded at
device probe, so that its content is visible before the device
reference itself.
On the other hand in the remove sequence, the barrier should be placed
after device ref is cleared but before device resources are released.
Note that, in smp_store_mb() implementation, the memory barrier is
places after the data is loaded, not before.
See the patch-like snippet below:

 static int scmi_vio_probe(struct virtio_device *vdev)
 {
     (...)

-    vdev->priv =3D channels;
-    /* Ensure initialized scmi_vdev is visible */
-    smp_store_mb(scmi_vdev, vdev);
+    /* Ensure initialized scmi_vdev is visible before scmi_vdev is */
+    smp_store_mb(vdev->priv, channels);
+    scmi_vdev =3D vdev;

    return 0;
 }

 static void scmi_vio_remove(struct virtio_device *vdev)
 {
+    /* Ensure scmi_vdev is visible as NULL before resources are released *=
/
+    smp_store_mb(scmi_vdev, NULL);
+
     /*
      * Once we get here, virtio_chan_free() will have already been called =
by
      * the SCMI core for any existing channel and, as a consequence, all t=
he
      * virtio channels will have been already marked NOT ready, causing an=
y
      * outstanding message on any vqueue to be ignored by complete_cb: now
      * we can just stop processing buffers and destroy the vqueues.
      */
     vdev->config->reset(vdev);
     vdev->config->del_vqs(vdev);
-    /* Ensure scmi_vdev is visible as NULL */
-    smp_store_mb(scmi_vdev, NULL);
 }

Does that make sense to you?

> >
> > > +
> > > +     ret =3D get_capabilities();
> > > +
> > > +out:
> > > +     if (ret) {
> > > +             tee_client_close_context(tee_ctx);
> > > +             optee_private =3D NULL;
> >
> > Barrier ? (not sure as above...)
> >
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int optee_service_remove(struct device *dev)
> > > +{
> > > +     if (optee_private)
> > > +             return -EINVAL;
> >
> > Is it  instead: if (!optee_private) ?
>
> Oups! indeed :(
>
> > > +
> > > +     if (!list_empty(&optee_private->channel_list))
> > > +             return -EBUSY;
> > > +
> > > +     tee_client_close_context(optee_private->tee_ctx);
> > > +
> > > +     optee_private =3D NULL;
> > > +
> >
> > Barrier ? (not sure as above...)
> >
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct tee_client_device_id scmi_optee_service_id[] =3D=
 {
> > > +     {
> > > +             UUID_INIT(0xa8cfe406, 0xd4f5, 0x4a2e,
> > > +                       0x9f, 0x8d, 0xa2, 0x5d, 0xc7, 0x54, 0xc0, 0x9=
9)
> > > +     },
> > > +     { }
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(tee, scmi_optee_service_id);
> > > +
> > > +static struct tee_client_driver scmi_optee_driver =3D {
> > > +     .id_table       =3D scmi_optee_service_id,
> > > +     .driver         =3D {
> > > +             .name =3D "scmi-optee",
> > > +             .bus =3D &tee_bus_type,
> > > +             .probe =3D optee_service_probe,
> > > +             .remove =3D optee_service_remove,
> > > +     },
> > > +};
> > > +
> > > +static int __init scmi_optee_init(void)
> > > +{
> > > +     return driver_register(&scmi_optee_driver.driver);
> > > +}
> > > +
> > > +static void __exit scmi_optee_exit(void)
> > > +{
> > > +     driver_unregister(&scmi_optee_driver.driver);
> > > +}
> > > +
> > > +device_initcall(scmi_optee_init)
> > > +module_exit(scmi_optee_exit);
> >
> > This breaks the build when ARM_SCMI_PROTOCOL=3Dm and SCMI OPTEE transpo=
rt is enabled,
> > since the SCMI transports are not full fledged drivers but they are bui=
lt into
> > the SCMI stack core module, so if you endup trying to define multiple i=
nits.
> >
> >  LD [M]  drivers/firmware/arm_scmi/scmi-module.o
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `scmi_optee_=
init':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:549: multiple definition of `init_module'; drivers/firmware/arm_scmi/drive=
r.o:/home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/driver.=
c:2070: first defined here
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch6=
4-linux-gnu-ld: drivers/firmware/arm_scmi/optee.o: in function `scmi_optee_=
exit':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee.c=
:554: multiple definition of `cleanup_module'; drivers/firmware/arm_scmi/dr=
iver.o:/home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/driv=
er.c:2099: first defined he> /home/crimar01/ARM/dev/src/pdsw/linux/scripts/=
Makefile.build:474: recipe for target 'drivers/firmware/arm_scmi/scmi-modul=
e.o' failed
> > make[4]: *** [drivers/firmware/arm_scmi/scmi-module.o] Error 1
> > /home/crimar01/ARM/dev/src/pdsw/linux/scripts/Makefile.build:540: recip=
e for target 'drivers/firmware/arm_scmi' failed
> > make[3]: *** [drivers/firmware/arm_scmi] Error 2
> > /home/crimar01/ARM/dev/src/pdsw/linux/scripts/Makefile.build:540: recip=
e for target 'drivers/firmware' failed
> > make[2]: *** [drivers/firmware] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> > /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1874: recipe for target =
'drivers' failed
> > make[1]: *** [drivers] Error 2
> > make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
> > Makefile:219: recipe for target '__sub-make' failed
> >
> > In order to address this issue (same happended with VirtIO) I added
> > transport_init/transport_exit optional hooks into scmi_desc, so that
> > you can ask the core SCMI stack to perform whatever your transport
> > needs at SCMI core init-time, before the SCMI core stack is probed.
> >
> > In other words the fix here down below fixes for me the build as a
> > module of the SCMI stack.
>
> To ensure scmi/optee transport can register to the tee bus, it must
> wait tee bus is initialized.
> The issue is optee driver initializes its tee bus at subsys_initcall
> level, same level as the scmi driver.
> So I had to call scmi_optee_init() at an earlier init level: device_initc=
all().
>
> Virtio bus is registered at core_initcall level hence scmi/virtio init
> a subsys_initcall has the dependency resolved.

I have a proposal to address this.

You suggested to use ::transport_init operator from struct scmi_desc
for this registration to the optee bus.
For the reason above, it does not apply to OP-TEE.
My idea is to not ue ::transport_init hook but to register from
::link_supplier hook from struct scmi_transport_ops.
The first time a scmi_optee channel to requested, it will be deferred
and scmi_optee registering to optee bus done.
Something like the below:

  static int scmi_optee_link_supplier(struct device *dev)
  {
      if (!scmi_optee_private) {
          static int register_to_optee =3D -ENODEV;

          // register to optee bus enumeration if not already successfully =
done
          if (register_to_optee)
              register_to_optee =3D driver_register(&scmi_optee_driver.driv=
er);

          // defer channel setup until
          return -EPROBE_DEFER;
      }

      if (!device_link_add(dev, scmi_optee_private->dev,
DL_FLAG_AUTOREMOVE_CONSUMER)) {
          dev_err(dev, "Adding link to supplier optee device failed\n");
          return -ECANCELED;
      }

      return 0;
  }

Note the exit sequence can still use struct scmi_desc::transport_ext hook:

  static void scmi_optee_exit(void)
  {
      driver_unregister(&scmi_optee_driver.driver);
  }
  module_exit(scmi_optee_exit);

May I get your opinion?

Regards,
Etienne

>
>
> >
> > Note that also __exit on scmi_optee_exit( )ha sbeen removed to avoid
> > some complains spotted by Arnd on SCMI VirtIO (1cd73200dad2 firmware:
> > arm_scmi: Remove __exit annotation)
>
> Ok, thanks.
>
> Regards,
> Etienne
>
> >
> > Thanks,
> > Cristian
> >
> > ---8<-----------------------
> >
> > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_s=
cmi/optee.c
> > index e294cff37bea..af6d52438b04 100644
> > --- a/drivers/firmware/arm_scmi/optee.c
> > +++ b/drivers/firmware/arm_scmi/optee.c
> > @@ -459,13 +459,6 @@ static struct scmi_transport_ops scmi_optee_ops =
=3D {
> >         .poll_done =3D optee_poll_done,
> >  };
> >
> > -const struct scmi_desc scmi_optee_desc =3D {
> > -       .ops =3D &scmi_optee_ops,
> > -       .max_rx_timeout_ms =3D 30,
> > -       .max_msg =3D 20,
> > -       .max_msg_size =3D 128,
> > -};
> > -
> >  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const v=
oid *data)
> >  {
> >         return ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE;
> > @@ -550,10 +543,16 @@ static int __init scmi_optee_init(void)
> >         return driver_register(&scmi_optee_driver.driver);
> >  }
> >
> > -static void __exit scmi_optee_exit(void)
> > +static void scmi_optee_exit(void)
> >  {
> >         driver_unregister(&scmi_optee_driver.driver);
> >  }
> >
> > -device_initcall(scmi_optee_init)
> > -module_exit(scmi_optee_exit);
> > +const struct scmi_desc scmi_optee_desc =3D {
> > +       .transport_init =3D scmi_optee_init,
> > +       .transport_exit =3D scmi_optee_exit,
> > +       .ops =3D &scmi_optee_ops,
> > +       .max_rx_timeout_ms =3D 30,
> > +       .max_msg =3D 20,
> > +       .max_msg_size =3D 128,
> > +};
> >
> > > --
> > > 2.17.1
> > >

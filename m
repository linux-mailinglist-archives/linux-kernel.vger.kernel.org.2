Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67563971B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhFAKni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:43:38 -0400
Received: from foss.arm.com ([217.140.110.172]:46962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhFAKnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:43:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9CB411FB;
        Tue,  1 Jun 2021 03:41:55 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89E093F73D;
        Tue,  1 Jun 2021 03:41:54 -0700 (PDT)
Date:   Tue, 1 Jun 2021 11:41:48 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 4/4] firmware: arm_scmi: add optee transport
Message-ID: <20210601104148.GW28060@e120937-lin>
References: <20210521134055.24271-1-etienne.carriere@linaro.org>
 <20210521134055.24271-4-etienne.carriere@linaro.org>
 <20210527151118.GV28060@e120937-lin>
 <CAN5uoS_0SMndmAvTwZnsCeQSUAfvBRz1diU_94CSYrsBxsZeew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS_0SMndmAvTwZnsCeQSUAfvBRz1diU_94CSYrsBxsZeew@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne,

On Fri, May 28, 2021 at 11:43:24AM +0200, Etienne Carriere wrote:
> Hello Christian,
> 
> On Thu, 27 May 2021 at 17:11, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >

[snip]

> > > +
> > > +static struct tee_client_driver optee_scmi_driver = {
> > > +     .id_table       = optee_scmi_id_table,
> > > +     .driver         = {
> > > +             .name = DRIVER_NAME,
> > > +             .bus = &tee_bus_type,
> > > +             .probe = optee_scmi_probe,
> > > +             .remove = optee_scmi_remove,
> > > +     },
> > > +};
> > > +
> > > +static int __init optee_scmi_init(void)
> > > +{
> > > +     return driver_register(&optee_scmi_driver.driver);
> > > +}
> > > +
> > > +static void __exit optee_scmi_exit(void)
> > > +{
> > > +     driver_unregister(&optee_scmi_driver.driver);
> > > +}
> > > +
> > > +module_init(optee_scmi_init);
> > > +module_exit(optee_scmi_exit);
> > > +
> >
> > This cannot compile is the full SCMI statck ARM_SCMI_PROTOCOL is configured as =m
> >
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-ld:
> > drivers/firmware/arm_scmi/optee_service.o: in function
> > `optee_scmi_init':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee_service.c:515:
> > multiple definition of `init_module';
> > drivers/firmware/arm_scmi/driver.o:/home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/driver.c:1593:
> > first defined here
> > /opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-ld:
> > drivers/firmware/arm_scmi/optee_service.o: in function
> > `optee_scmi_exit':
> > /home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/optee_service.c:520:
> > multiple definition of `cleanup_module';
> > drivers/firmware/arm_scmi/driver.o:/home/crimar01/ARM/dev/src/pdsw/linux/drivers/firmware/arm_scmi/driver.c:1611:
> > first defined here
> > /home/crimar01/ARM/dev/src/pdsw/linux/scripts/Makefile.build:449: recipe
> > for target 'drivers/firmware/arm_scmi/scmi-module.o' failed
> > make[4]: *** [drivers/firmware/arm_scmi/scmi-module.o] Error 1
> >
> >
> > Indeed it was the same issue we faced in the virtio-scmi series, and it
> > derives from the fact that SCMI transports 'driver' are really NOT
> > standalone drivers but only extension of the main SCMI module, so you
> > cannot have them initialize their stuff using usual kernel module_ machinery.
> >
> > In order to address this, and avoid a hell of ifdeffery probably,
> > in the context of virtio-scmi, I added a couple of transport's
> > optionalily provided init/deinit functions so that a transport can provide
> > some specific init code and be assured they are called at SCMI stack init,
> > so definitely even before the SCMI stack is probed and the selected
> > transport used.
> >
> > This is the patch from the virtio-scmi series:
> >
> > https://lore.kernel.org/linux-arm-kernel/20210511002040.802226-3-peter.hilber@opensynergy.com/
> >
> > which in that context is used like:
> >
> > +static int __init virtio_scmi_init(void)
> > +{
> > +       return register_virtio_driver(&virtio_scmi_driver);
> > +}
> > +
> > +static void __exit virtio_scmi_exit(void)
> > +{
> > +       unregister_virtio_driver(&virtio_scmi_driver);
> > +}
> > +
> > +const struct scmi_desc scmi_virtio_desc = {
> > +       .init = virtio_scmi_init,
> > +       .exit = virtio_scmi_exit,
> > +       .ops = &scmi_virtio_ops,
> >
> > I'll cleanup further that init/deinit patch and move it out into that bunch
> > of SCMI core changes that I'm making (in a separate series) to aid in virtio-scmi
> > devel.
> > In the meantime for your testing the above lore patch should work fine.
> 
> Thanks for the details, i'll upgrade to the series.
> 

This is the udpated patch above about init/exit now included in that
bunch of SCMI core transport changes I'm making:

https://lore.kernel.org/linux-arm-kernel/20210601102421.26581-4-cristian.marussi@arm.com/T/#u

but there's really no functional change from the one I mentioned above
that was part of the virtio-scmi series.

Thanks,
Cristian

> Cheers,
> Etienne
> 
> >
> > Thanks,
> > Cristian
> >
> > > +MODULE_LICENSE("GPL v2");
> > > +MODULE_AUTHOR("Etienne Carriere <etienne.carriere@linaro.org>");
> > > +MODULE_DESCRIPTION("OP-TEE SCMI transport driver");
> > > --
> > > 2.17.1
> > >

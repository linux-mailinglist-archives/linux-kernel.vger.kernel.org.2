Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1843CFF1D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhGTPh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:37:59 -0400
Received: from foss.arm.com ([217.140.110.172]:34170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235347AbhGTPge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:36:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BFCF31B;
        Tue, 20 Jul 2021 09:17:09 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69F973F694;
        Tue, 20 Jul 2021 09:17:07 -0700 (PDT)
Date:   Tue, 20 Jul 2021 17:16:31 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Jon Nettleton <jon@solid-run.com>
Subject: Re: [PATCH v2] hwrng: Add Arm SMCCC TRNG based driver
Message-ID: <20210720171631.071f84f5@slackpad.fritz.box>
In-Reply-To: <CAMj1kXEW7DT3P3FuV+poFykf6wwm4FTJuV6emGSWabCp7UZX9A@mail.gmail.com>
References: <20210720152158.31804-1-andre.przywara@arm.com>
        <CAMj1kXEW7DT3P3FuV+poFykf6wwm4FTJuV6emGSWabCp7UZX9A@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2021 18:03:37 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:

Hi Ard,

> On Tue, 20 Jul 2021 at 17:22, Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > The "Arm True Random Number Generator Firmware Interface"[1] provides
> > an SMCCC based interface to a true hardware random number generator.
> > So far we are using that in arch_get_random_seed(), but it might be
> > useful to expose the entropy through the /dev/hwrng device as well. This
> > allows to assess the quality of the implementation, by using "rngtest"
> > from the rng-tools package, for example.
> >
> > Add a simple platform driver implementing the hw_random interface.
> > We unconditionally instantiate the platform device in the driver file,
> > then probe for the existence of the SMCCC TRNG implementation in the
> > driver's probe routine.
> > Since the firmware takes care about serialisation, this can happily
> > coexist with the arch_get_random_seed() bits.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >
> > [1] https://developer.arm.com/documentation/den0098/latest/
> > ---
> > Changelog v1 ... v2:
> > - fix building as a module
> > - de-register device upon exit
> > - mention module name in Kconfig
> >
> >  drivers/char/hw_random/Kconfig          |  14 ++
> >  drivers/char/hw_random/Makefile         |   1 +
> >  drivers/char/hw_random/arm_smccc_trng.c | 171 ++++++++++++++++++++++++
> >  3 files changed, 186 insertions(+)
> >  create mode 100644 drivers/char/hw_random/arm_smccc_trng.c
> >
> > diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> > index 3f166c8a4099..239eca4d6805 100644
> > --- a/drivers/char/hw_random/Kconfig
> > +++ b/drivers/char/hw_random/Kconfig
> > @@ -524,6 +524,20 @@ config HW_RANDOM_XIPHERA
> >           To compile this driver as a module, choose M here: the
> >           module will be called xiphera-trng.
> >
> > +config HW_RANDOM_ARM_SMCCC_TRNG
> > +       tristate "Arm SMCCC TRNG firmware interface support"
> > +       depends on HAVE_ARM_SMCCC_DISCOVERY
> > +       default HW_RANDOM
> > +       help
> > +         Say 'Y' to enable the True Random Number Generator driver using
> > +         the Arm SMCCC TRNG firmware interface. This reads entropy from
> > +         higher exception levels (firmware, hypervisor). Uses SMCCC for
> > +         communicating with the firmware:
> > +         https://developer.arm.com/documentation/den0098/latest/
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called arm_smccc_trng.
> > +
> >  endif # HW_RANDOM
> >
> >  config UML_RANDOM
> > diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> > index 8933fada74f2..a5a1c765a394 100644
> > --- a/drivers/char/hw_random/Makefile
> > +++ b/drivers/char/hw_random/Makefile
> > @@ -45,3 +45,4 @@ obj-$(CONFIG_HW_RANDOM_OPTEE) += optee-rng.o
> >  obj-$(CONFIG_HW_RANDOM_NPCM) += npcm-rng.o
> >  obj-$(CONFIG_HW_RANDOM_CCTRNG) += cctrng.o
> >  obj-$(CONFIG_HW_RANDOM_XIPHERA) += xiphera-trng.o
> > +obj-$(CONFIG_HW_RANDOM_ARM_SMCCC_TRNG) += arm_smccc_trng.o
> > diff --git a/drivers/char/hw_random/arm_smccc_trng.c b/drivers/char/hw_random/arm_smccc_trng.c
> > new file mode 100644
> > index 000000000000..3bd510a98882
> > --- /dev/null
> > +++ b/drivers/char/hw_random/arm_smccc_trng.c
> > @@ -0,0 +1,171 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Randomness driver for the ARM SMCCC TRNG Firmware Interface
> > + * https://developer.arm.com/documentation/den0098/latest/
> > + *
> > + *  Copyright (C) 2020 Arm Ltd.
> > + *
> > + * The ARM TRNG firmware interface specifies a protocol to read entropy
> > + * from a higher exception level, to abstract from any machine specific
> > + * implemenations and allow easier use in hypervisors.
> > + *
> > + * The firmware interface is realised using the SMCCC specification.
> > + */
> > +
> > +#include <linux/bits.h>
> > +#include <linux/device.h>
> > +#include <linux/hw_random.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/arm-smccc.h>
> > +
> > +#ifdef CONFIG_ARM64
> > +#define ARM_SMCCC_TRNG_RND     ARM_SMCCC_TRNG_RND64
> > +#define MAX_BITS_PER_CALL      (3 * 64UL)
> > +#else
> > +#define ARM_SMCCC_TRNG_RND     ARM_SMCCC_TRNG_RND32
> > +#define MAX_BITS_PER_CALL      (3 * 32UL)
> > +#endif
> > +
> > +/* We don't want to allow the firmware to stall us forever. */
> > +#define SMCCC_TRNG_MAX_TRIES   20
> > +
> > +#define SMCCC_RET_TRNG_INVALID_PARAMETER       -2
> > +#define SMCCC_RET_TRNG_NO_ENTROPY              -3
> > +
> > +static struct platform_device *smccc_trng_pdev;
> > +  
> 
> Can we split the platform device and the platform driver? The platform
> device should be registered by the core code once it discovers the
> SMCCC TRNG availabily. The platform driver can then use ordinary
> module alias autoloading etc based on the platform device availabilty.

Yes, a similar idea was already brought up before. I think there is even
the potential for something like an artificial SMCCC "bus", where those
services presentable as devices could be auto-detected (by checking
known function IDs), the respective drivers would then probe
automatically?

I will try to implement your approach first, to see what it looks like.

Cheers,
Andre

> 
> This requires the following to be added though
> 
> MODULE_ALIAS("platform: smccc_trng")
> 
> but all the smccc calls could be dropped from the probe function in that case.
> 
> 
> 
> > +static int smccc_trng_init(struct hwrng *rng)
> > +{
> > +       return 0;
> > +}
> > +
> > +static int copy_from_registers(char *buf, struct arm_smccc_res *res,
> > +                              size_t bytes)
> > +{
> > +       unsigned int chunk, copied;
> > +
> > +       if (bytes == 0)
> > +               return 0;
> > +
> > +       chunk = min(bytes, sizeof(long));
> > +       memcpy(buf, &res->a3, chunk);
> > +       copied = chunk;
> > +       if (copied >= bytes)
> > +               return copied;
> > +
> > +       chunk = min((bytes - copied), sizeof(long));
> > +       memcpy(&buf[copied], &res->a2, chunk);
> > +       copied += chunk;
> > +       if (copied >= bytes)
> > +               return copied;
> > +
> > +       chunk = min((bytes - copied), sizeof(long));
> > +       memcpy(&buf[copied], &res->a1, chunk);
> > +
> > +       return copied + chunk;
> > +}
> > +
> > +static int smccc_trng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> > +{
> > +       struct arm_smccc_res res;
> > +       u8 *buf = data;
> > +       unsigned int copied = 0;
> > +       int tries = 0;
> > +
> > +       while (copied < max) {
> > +               size_t bits = min_t(size_t, (max - copied) * BITS_PER_BYTE,
> > +                                 MAX_BITS_PER_CALL);
> > +
> > +               arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND, bits, &res);
> > +               if ((int)res.a0 < 0)
> > +                       return (int)res.a0;
> > +
> > +               switch ((int)res.a0) {
> > +               case SMCCC_RET_SUCCESS:
> > +                       copied += copy_from_registers(buf + copied, &res,
> > +                                                     bits / BITS_PER_BYTE);
> > +                       tries = 0;
> > +                       break;
> > +               case SMCCC_RET_TRNG_NO_ENTROPY:
> > +                       if (!wait)
> > +                               return copied;
> > +                       tries++;
> > +                       if (tries >= SMCCC_TRNG_MAX_TRIES)
> > +                               return copied;
> > +                       cond_resched();
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return copied;
> > +}
> > +
> > +static int smccc_trng_probe(struct platform_device *pdev)
> > +{
> > +       struct arm_smccc_res res;
> > +       struct hwrng *trng;
> > +       u32 version;
> > +       int ret;
> > +
> > +       /* We need ARM SMCCC v1.1, with its autodetection feature. */
> > +       if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_1)
> > +               return -ENODEV;
> > +
> > +       arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_VERSION, &res);
> > +       if ((int)res.a0 < 0)
> > +               return -ENODEV;
> > +       version = res.a0;
> > +
> > +       arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_FEATURES,
> > +                            ARM_SMCCC_TRNG_RND, &res);
> > +       if ((int)res.a0 < 0)
> > +               return -ENODEV;
> > +
> > +       trng = devm_kzalloc(&pdev->dev, sizeof(*trng), GFP_KERNEL);
> > +       if (!trng)
> > +               return -ENOMEM;
> > +
> > +       trng->name = "smccc_trng";
> > +       trng->init = smccc_trng_init;
> > +       trng->read = smccc_trng_read;
> > +
> > +       platform_set_drvdata(pdev, trng);
> > +       ret = devm_hwrng_register(&pdev->dev, trng);
> > +       if (ret)
> > +               return -ENOENT;
> > +
> > +       dev_info(&pdev->dev,
> > +                "ARM SMCCC TRNG firmware random number generator v%d.%d\n",
> > +                version >> 16, version & 0xffff);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver smccc_trng_driver = {
> > +       .driver = {
> > +               .name           = "smccc_trng",
> > +       },
> > +       .probe          = smccc_trng_probe,
> > +};
> > +
> > +static int __init smccc_trng_driver_init(void)
> > +{
> > +       smccc_trng_pdev = platform_device_register_simple("smccc_trng",
> > +                                                         -1, NULL, 0);
> > +       if (IS_ERR(smccc_trng_pdev))
> > +               return PTR_ERR(smccc_trng_pdev);
> > +
> > +       return platform_driver_register(&smccc_trng_driver);
> > +}
> > +module_init(smccc_trng_driver_init);
> > +
> > +static void __exit smccc_trng_driver_exit(void)
> > +{
> > +       platform_driver_unregister(&smccc_trng_driver);
> > +       platform_device_unregister(smccc_trng_pdev);
> > +}
> > +module_exit(smccc_trng_driver_exit);
> > +
> > +MODULE_AUTHOR("Andre Przywara");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.17.6
> >  


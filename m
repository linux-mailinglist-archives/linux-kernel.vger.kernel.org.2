Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C944D3F9F69
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhH0TCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhH0TCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:02:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3543C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 12:01:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m17so4514739plc.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/U7J2zbHihSdDWyMksV/TtPa1+B5X6iFwKDUZ4o7Zw=;
        b=sNiLRr0jnkRhT0wgY8kV7FUDGk9UCmwtOo4CLz4mVmrUvRZQ1k66UkBAaWVrf05Pf8
         SidchKjAWmO5yBjR3lsgVTfcfRVxHsuBcVJZ2EETSlxr8GqGehoDyG7mmX+69YR5nBCf
         UPBEcajkZB1mkw2BNgnhBSOvBNh9gxFqAozC7nbTpCvzSbNEgrgiHj4F1m8HwIDGE3JJ
         aewbwFkDW1E8r78472WlBd9AoO0zutKNwJI+S7M3TUUxUpyubMeQPR5Ry7NSVZxXK32A
         8BVGTGjzDFculpRZeheVLC7E5i1R2SxEtUNyn2wqpMBdBkUxFH3cIM9p8hpOd0avFJjK
         dk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/U7J2zbHihSdDWyMksV/TtPa1+B5X6iFwKDUZ4o7Zw=;
        b=alO9zT40R+BCSpB/Ub2GLzVqvtPm3glv32p7a2WEJ522SB5INordIGZIdZ2udKT7pE
         Ifr9WHDP2g24NsIRVvLptztdrEAJaYhnxEN91VuYYQlkRDGvpWxWeUM8XnnVQMzvGBM8
         uWY5B84dAejYtzJHLrt2e9oJ+kIWZMRVlh5zKmm83Iv0mnCyYIxPuiPvdo974X66lZux
         l90ClZibwVDZha0CJEIHELC0nDQtMV7kl8mLar/TZwJJh9jijSILCzY/DLHoy1dRcxED
         6q8ScE/adOzPGhTP1eeywPhodYLKPNFtcvogE+zbktWEIwLoxWW5Nb2U+7eLCPrm1eey
         mupQ==
X-Gm-Message-State: AOAM533WUXgBsOQ0XncxcPLCIkVk8cB8dorw1cxpHDKNho78Wh0W09z2
        9GSkVKbGRTnjBC7uxFQ0nbvlpQ51eKWBEzv7S4QQ8Q==
X-Google-Smtp-Source: ABdhPJyDHGtcUmamBi1VJ/OEE/F574NsPBSWaCUCkgBo2sbiTYmr6i2tzPq3PLz1T1+kWen10Mmg+phyLSrOwyeHzHE=
X-Received: by 2002:a17:902:ba90:b0:135:6709:705 with SMTP id
 k16-20020a170902ba9000b0013567090705mr9825009pls.79.1630090877059; Fri, 27
 Aug 2021 12:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210803113134.2262882-1-iwona.winiarska@intel.com> <20210803113134.2262882-9-iwona.winiarska@intel.com>
In-Reply-To: <20210803113134.2262882-9-iwona.winiarska@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 27 Aug 2021 12:01:06 -0700
Message-ID: <CAPcyv4hPLReB6wGTDBM_tnqRUXxNASFCtgCw0=aDW+PPfSJ57A@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] peci: Add device detection
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        Device Tree <devicetree@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 4:35 AM Iwona Winiarska
<iwona.winiarska@intel.com> wrote:
>
> Since PECI devices are discoverable, we can dynamically detect devices
> that are actually available in the system.
>
> This change complements the earlier implementation by rescanning PECI
> bus to detect available devices. For this purpose, it also introduces the
> minimal API for PECI requests.
>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/peci/Makefile   |   2 +-
>  drivers/peci/core.c     |  33 ++++++++++++
>  drivers/peci/device.c   | 114 ++++++++++++++++++++++++++++++++++++++++
>  drivers/peci/internal.h |  14 +++++
>  drivers/peci/request.c  |  50 ++++++++++++++++++
>  5 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/peci/device.c
>  create mode 100644 drivers/peci/request.c
>
> diff --git a/drivers/peci/Makefile b/drivers/peci/Makefile
> index 926d8df15cbd..c5f9d3fe21bb 100644
> --- a/drivers/peci/Makefile
> +++ b/drivers/peci/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
>  # Core functionality
> -peci-y := core.o
> +peci-y := core.o request.o device.o
>  obj-$(CONFIG_PECI) += peci.o
>
>  # Hardware specific bus drivers
> diff --git a/drivers/peci/core.c b/drivers/peci/core.c
> index 7b3938af0396..d143f1a7fe98 100644
> --- a/drivers/peci/core.c
> +++ b/drivers/peci/core.c
> @@ -34,6 +34,20 @@ struct device_type peci_controller_type = {
>         .release        = peci_controller_dev_release,
>  };
>
> +static int peci_controller_scan_devices(struct peci_controller *controller)
> +{
> +       int ret;
> +       u8 addr;
> +
> +       for (addr = PECI_BASE_ADDR; addr < PECI_BASE_ADDR + PECI_DEVICE_NUM_MAX; addr++) {
> +               ret = peci_device_create(controller, addr);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static struct peci_controller *peci_controller_alloc(struct device *dev,
>                                                      struct peci_controller_ops *ops)
>  {
> @@ -76,10 +90,23 @@ static struct peci_controller *peci_controller_alloc(struct device *dev,
>         return ERR_PTR(ret);
>  }
>
> +static int unregister_child(struct device *dev, void *dummy)
> +{
> +       peci_device_destroy(to_peci_device(dev));
> +
> +       return 0;
> +}
> +
>  static void unregister_controller(void *_controller)
>  {
>         struct peci_controller *controller = _controller;
>
> +       /*
> +        * Detach any active PECI devices. This can't fail, thus we do not
> +        * check the returned value.
> +        */
> +       device_for_each_child_reverse(&controller->dev, NULL, unregister_child);
> +
>         device_unregister(&controller->dev);
>  }
>
> @@ -115,6 +142,12 @@ struct peci_controller *devm_peci_controller_add(struct device *dev,
>         if (ret)
>                 return ERR_PTR(ret);
>
> +       /*
> +        * Ignoring retval since failures during scan are non-critical for
> +        * controller itself.
> +        */
> +       peci_controller_scan_devices(controller);
> +
>         return controller;
>
>  err:
> diff --git a/drivers/peci/device.c b/drivers/peci/device.c
> new file mode 100644
> index 000000000000..32811248997b
> --- /dev/null
> +++ b/drivers/peci/device.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2018-2021 Intel Corporation
> +
> +#include <linux/peci.h>
> +#include <linux/slab.h>
> +
> +#include "internal.h"
> +
> +static int peci_detect(struct peci_controller *controller, u8 addr)
> +{
> +       struct peci_request *req;
> +       int ret;
> +
> +       /*
> +        * PECI Ping is a command encoded by tx_len = 0, rx_len = 0.
> +        * We expect correct Write FCS if the device at the target address
> +        * is able to respond.
> +        */
> +       req = peci_request_alloc(NULL, 0, 0);
> +       if (!req)
> +               return -ENOMEM;

Seems a waste to do a heap allocation for this routine. Why not:

       /*
        * PECI Ping is a command encoded by tx_len = 0, rx_len = 0.
        * We expect correct Write FCS if the device at the target address
        * is able to respond.
        */
       struct peci_request req = { 0 };

> +
> +       mutex_lock(&controller->bus_lock);
> +       ret = controller->ops->xfer(controller, addr, req);
> +       mutex_unlock(&controller->bus_lock);
> +
> +       peci_request_free(req);
> +
> +       return ret;
> +}
> +
> +static bool peci_addr_valid(u8 addr)
> +{
> +       return addr >= PECI_BASE_ADDR && addr < PECI_BASE_ADDR + PECI_DEVICE_NUM_MAX;
> +}
> +
> +static int peci_dev_exists(struct device *dev, void *data)
> +{
> +       struct peci_device *device = to_peci_device(dev);
> +       u8 *addr = data;
> +
> +       if (device->addr == *addr)
> +               return -EBUSY;
> +
> +       return 0;
> +}
> +
> +int peci_device_create(struct peci_controller *controller, u8 addr)
> +{
> +       struct peci_device *device;
> +       int ret;
> +
> +       if (WARN_ON(!peci_addr_valid(addr)))

The WARN_ON is overkill, especially as there is only one caller of
this and it loops through valid addresses.

> +               return -EINVAL;
> +
> +       /* Check if we have already detected this device before. */
> +       ret = device_for_each_child(&controller->dev, &addr, peci_dev_exists);
> +       if (ret)
> +               return 0;
> +
> +       ret = peci_detect(controller, addr);
> +       if (ret) {
> +               /*
> +                * Device not present or host state doesn't allow successful
> +                * detection at this time.
> +                */
> +               if (ret == -EIO || ret == -ETIMEDOUT)
> +                       return 0;
> +
> +               return ret;
> +       }
> +
> +       device = kzalloc(sizeof(*device), GFP_KERNEL);
> +       if (!device)
> +               return -ENOMEM;
> +
> +       device->addr = addr;
> +       device->dev.parent = &controller->dev;
> +       device->dev.bus = &peci_bus_type;
> +       device->dev.type = &peci_device_type;
> +
> +       ret = dev_set_name(&device->dev, "%d-%02x", controller->id, device->addr);
> +       if (ret)
> +               goto err_free;

It's cleaner to just have one unified error exit using put_device().
Use the device_initialize() + device_add() pattern, not
device_register().


> +
> +       ret = device_register(&device->dev);
> +       if (ret)
> +               goto err_put;
> +
> +       return 0;
> +
> +err_put:
> +       put_device(&device->dev);
> +err_free:
> +       kfree(device);
> +
> +       return ret;
> +}
> +
> +void peci_device_destroy(struct peci_device *device)
> +{
> +       device_unregister(&device->dev);

No clear value for this wrapper, in fact in one caller it causes it to
do a to_peci_device() just this helper can undo that up-cast.

> +}
> +
> +static void peci_device_release(struct device *dev)
> +{
> +       struct peci_device *device = to_peci_device(dev);
> +
> +       kfree(device);
> +}
> +
> +struct device_type peci_device_type = {
> +       .release        = peci_device_release,
> +};
> diff --git a/drivers/peci/internal.h b/drivers/peci/internal.h
> index 918dea745a86..57d11a902c5d 100644
> --- a/drivers/peci/internal.h
> +++ b/drivers/peci/internal.h
> @@ -8,6 +8,20 @@
>  #include <linux/types.h>
>
>  struct peci_controller;
> +struct peci_device;
> +struct peci_request;
> +
> +/* PECI CPU address range 0x30-0x37 */
> +#define PECI_BASE_ADDR         0x30
> +#define PECI_DEVICE_NUM_MAX    8
> +
> +struct peci_request *peci_request_alloc(struct peci_device *device, u8 tx_len, u8 rx_len);
> +void peci_request_free(struct peci_request *req);
> +
> +extern struct device_type peci_device_type;
> +
> +int peci_device_create(struct peci_controller *controller, u8 addr);
> +void peci_device_destroy(struct peci_device *device);
>
>  extern struct bus_type peci_bus_type;
>
> diff --git a/drivers/peci/request.c b/drivers/peci/request.c
> new file mode 100644
> index 000000000000..81b567bc7b87
> --- /dev/null
> +++ b/drivers/peci/request.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2021 Intel Corporation
> +
> +#include <linux/export.h>
> +#include <linux/peci.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "internal.h"
> +
> +/**
> + * peci_request_alloc() - allocate &struct peci_requests
> + * @device: PECI device to which request is going to be sent
> + * @tx_len: TX length
> + * @rx_len: RX length
> + *
> + * Return: A pointer to a newly allocated &struct peci_request on success or NULL otherwise.
> + */
> +struct peci_request *peci_request_alloc(struct peci_device *device, u8 tx_len, u8 rx_len)
> +{
> +       struct peci_request *req;
> +
> +       if (WARN_ON_ONCE(tx_len > PECI_REQUEST_MAX_BUF_SIZE || rx_len > PECI_REQUEST_MAX_BUF_SIZE))

WARN_ON_ONCE() should only be here to help other kernel developers not
make this mistake However, another way to enforce this is to stop
exporting peci_request_alloc() and instead export helpers for specific
command types, and keep this detail internal to the core. If you keep
this, it needs a comment that it is only here to warn other
peci-client developers of their bug before it goes upstream.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B053FD483
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242641AbhIAHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbhIAHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:37:44 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6640C061575;
        Wed,  1 Sep 2021 00:36:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id w78so945325qkb.4;
        Wed, 01 Sep 2021 00:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6GGQMLeJpx/q02LlQGr7UraUXBopkzTRg5QpBvPD4L8=;
        b=lE49Hq2QkYzVFGuK/+R0xtGWn9lbFkW4/Rzhg3EL41Ny1ZXklmrU18GjV9OjGHjwen
         LsLmJ86eWxpR9xC8Xg84m5+SUTQmZRoRJ9qEVpeYscuvw3pp5RmyaVN9ztVd2UEJmfVz
         uQAF7O7Ksh0jvkPXBiLyur3dzD7Fb+Kpq9ZlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GGQMLeJpx/q02LlQGr7UraUXBopkzTRg5QpBvPD4L8=;
        b=Vd9plJTTRrEeR6wQtryxZTG17U5+sxL6oRDuNf5JCd1ffRkavt9Zopl62ghIab6Ynd
         r4+gprIMwhcmeJnED7oaW460G7Bssq9ROpAlNGicMNZbEAZp5oJWisrS8JDnk9uOBjB4
         Hw90erb5tO7v6AX9TMhCMUqBsgaSs2o2tkpzLD16oslHxSCt4bHfsWW5R3mCL47BM4mH
         BYP4zD3v48RPzzVySt93ktXTqwzx1kB+WEEe+qNNDtHaletkdJenMA9PFInDwM8RU4ap
         uEPBgrHznXky40x4z72PgazLozl3YOC5bpjv5LtfaiGB+USt+aOt13XNQoosc36MJfWR
         AFEA==
X-Gm-Message-State: AOAM530SfGm5XRln4fSG3StqaSaEe4TXbNK0a0f1Dp6+G3cIf685uBm6
        /OdPA60JiEdFZ24K2MkMK0pGnCH0kU4sjH3XEGQ=
X-Google-Smtp-Source: ABdhPJyie0xJcmHZwAATJEwixM4E0x2KE6vf4jVw8Dxi71j6J0IuXKVe12GaBx+AhgdDePvt65e1tE4ewfpXEwT4nF0=
X-Received: by 2002:a05:620a:4092:: with SMTP id f18mr6853416qko.91.1630481806719;
 Wed, 01 Sep 2021 00:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210901062216.32675-1-chiawei_wang@aspeedtech.com> <20210901062216.32675-2-chiawei_wang@aspeedtech.com>
In-Reply-To: <20210901062216.32675-2-chiawei_wang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 1 Sep 2021 07:36:34 +0000
Message-ID: <CACPK8XerokBaLMZ3J=9rcRLD5eFqmNOSsXYGgf_Ze01=X6NwPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: aspeed: Add LPC UART routing support
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Oskar Senft <osk@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sept 2021 at 06:22, Chia-Wei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Add driver support for the LPC UART routing control. Users can perform

As we discussed, remove the "LPC" part of the name.

> runtime configuration of the RX muxes among the UART controllers and the
> UART TXD/RXD IO pins. This is achieved through the exported sysfs interface.
>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>

It would be good to have some example of how to use it, and the output
from sysfs.

You should also add a patch to document the sysfs files in Documentation/ABI.

> +++ b/drivers/soc/aspeed/aspeed-lpc-uart-routing.c
> @@ -0,0 +1,621 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2018 Google LLC
> + * Copyright (c) 2021 Aspeed Technology Inc.
> + */
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>

You can drop this one.

> +#include <linux/of_platform.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +
> +/* register offsets */
> +#define HICR9  0x98
> +#define HICRA  0x9c
> +
> +/* attributes options */
> +#define UART_ROUTING_IO1       "io1"
> +#define UART_ROUTING_IO2       "io2"
> +#define UART_ROUTING_IO3       "io3"
> +#define UART_ROUTING_IO4       "io4"
> +#define UART_ROUTING_IO5       "io5"
> +#define UART_ROUTING_IO6       "io6"
> +#define UART_ROUTING_IO10      "io10"
> +#define UART_ROUTING_UART1     "uart1"
> +#define UART_ROUTING_UART2     "uart2"
> +#define UART_ROUTING_UART3     "uart3"
> +#define UART_ROUTING_UART4     "uart4"
> +#define UART_ROUTING_UART5     "uart5"
> +#define UART_ROUTING_UART6     "uart6"
> +#define UART_ROUTING_UART10    "uart10"
> +#define UART_ROUTING_RES       "reserved"
> +
> +struct aspeed_uart_routing {
> +       struct regmap *map;
> +       spinlock_t lock;
> +       struct attribute_group const *attr_grp;
> +};
> +
> +struct aspeed_uart_routing_selector {
> +       struct device_attribute dev_attr;
> +       uint32_t reg;
> +       uint32_t mask;
> +       uint32_t shift;

These can be u8.

> +static ssize_t aspeed_uart_routing_show(struct device *dev,
> +                                       struct device_attribute *attr,
> +                                       char *buf)
> +{
> +       struct aspeed_uart_routing *uart_routing = dev_get_drvdata(dev);
> +       struct aspeed_uart_routing_selector *sel = to_routing_selector(attr);
> +       int val, pos, len;
> +
> +       regmap_read(uart_routing->map, sel->reg, &val);
> +       val = (val >> sel->shift) & sel->mask;
> +
> +       len = 0;
> +       for (pos = 0; sel->options[pos] != NULL; ++pos) {
> +               if (pos == val) {
> +                       len += snprintf(buf + len, PAGE_SIZE - 1 - len,
> +                                       "[%s] ", sel->options[pos]);
> +               } else {
> +                       len += snprintf(buf + len, PAGE_SIZE - 1 - len,
> +                                       "%s ", sel->options[pos]);

The kernel prefers sysfs_emit and sysfs_emit_at insteading of using
snprintf directly.

> +               }
> +       }
> +
> +       if (val >= pos) {
> +               len += snprintf(buf + len, PAGE_SIZE - 1 - len,
> +                               "[unknown(%d)]", val);
> +       }
> +
> +       len += snprintf(buf + len, PAGE_SIZE - 1 - len, "\n");
> +
> +       return len;
> +}
> +
> +static ssize_t aspeed_uart_routing_store(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        const char *buf, size_t count)
> +{
> +       unsigned long flags;
> +       struct aspeed_uart_routing *uart_routing = dev_get_drvdata(dev);
> +       struct aspeed_uart_routing_selector *sel = to_routing_selector(attr);
> +       int val;
> +
> +       val = match_string(sel->options, -1, buf);
> +       if (val < 0) {
> +               dev_err(dev, "invalid value \"%s\"\n", buf);
> +               return -EINVAL;
> +       }
> +
> +       spin_lock_irqsave(&uart_routing->lock, flags);

I can't see why you would need a spinlock here. The regmap has it's
own locking so it will protect against concurrent updates to the
registers.

> +
> +       regmap_update_bits(uart_routing->map, sel->reg,
> +                       (sel->mask << sel->shift),
> +                       (val & sel->mask) << sel->shift);
> +
> +       spin_unlock_irqrestore(&uart_routing->lock, flags);
> +
> +       return count;
> +}
> +
> +static int aspeed_uart_routing_probe(struct platform_device *pdev)
> +{
> +       int rc;
> +       struct device *dev = &pdev->dev;
> +       struct aspeed_uart_routing *uart_routing;
> +
> +       uart_routing = devm_kzalloc(&pdev->dev,
> +                                   sizeof(*uart_routing),
> +                                   GFP_KERNEL);

You can reformat this file to have longer lines; the kernel is ok with
up to 100 columsn these days.

> +       if (!uart_routing) {
> +               dev_err(dev, "cannot allocate memory\n");

I'd drop this error message.

> +               return -ENOMEM;
> +       }
> +
> +       uart_routing->map = syscon_node_to_regmap(dev->parent->of_node);
> +       if (IS_ERR(uart_routing->map)) {
> +               dev_err(dev, "cannot get regmap\n");
> +               return PTR_ERR(uart_routing->map);
> +       }
> +
> +       uart_routing->attr_grp = of_device_get_match_data(dev);
> +
> +       spin_lock_init(&uart_routing->lock);

I don't think you need the lock at all.

Cheers,

Joel

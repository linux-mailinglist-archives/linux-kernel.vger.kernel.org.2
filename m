Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFDB40D4A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhIPIg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhIPIgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:36:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61953C061574;
        Thu, 16 Sep 2021 01:35:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v24so13838011eda.3;
        Thu, 16 Sep 2021 01:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EE37vT9qdZ4HNZJVRImRF2UydQGoo6wE1WSQNbkg2/c=;
        b=DPBCACg5bkwGwhxoPNKGQeoWNxEsbxz5Tr9HMb7Yo/E4YtjbBdln0XS6EGwGSBxQxl
         8TDK0bvsLM0WyASYcWdGq72inXYgCWMDOr9HeVWAHM5hwDAHD6EZRGfc87RFyEuuuXDg
         ErWPrNzeADmTArcPDqelMcd3QEhTDEdUiLZsCCRH+rYVO9OINglJSLFu1gKHA90S9iJl
         zY8Fg7PlcUqxw57l0A6un/EMIKM1AX0Si2w5fAjDrocLC2zvirnxjBShsQMkW6KObe3H
         THa8i9FhJ8XTdgjn/i7wErfnFKmtkybNAjG/QymWivK3EttxpyarC4GKxiC/9VAtAtN5
         ndiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EE37vT9qdZ4HNZJVRImRF2UydQGoo6wE1WSQNbkg2/c=;
        b=8Pkgkduk4gWgyTQffFUsw5YIQ8DnnpUsEGC1RbDWtSD8N1+HnNEojcxuR+swjhQqkY
         AF40he1sFJnydKjQ3prG3YjValyfE6OOr6aaQUXi5E15p3GFrFaDsEe8dGUWcklCG8VU
         oPQdkN/AuEQMXZ9fU0Jg67buizRq7Lf5R7e0Vq1aUCuFKQmTFhy5c1n/0Pr7/aH1NB1I
         srYR9ozGMZJG5f4hxELgIZ2s6tKhJHeaGc3PBAUTEVqEuHs5AXPpa9fp23lUvSaA7tHr
         sa8QY4DoR+Ic3NoHRD3TqVL7ap7o1T8z2KzQ/+lItPmVJaU2N3mvqX50mHYARcO4Eng4
         ODKw==
X-Gm-Message-State: AOAM530WXDagqx5U3oNc1iyj5aWZweUsqgzjErU0A/XSewiZfqfNRXN6
        hjhHsThc8PF+pcGBcOHWbzmwlKgaOT+HCTtEm1M=
X-Google-Smtp-Source: ABdhPJzP0UbSoeBYkpBL0GHzyjpaMQ2JDsNK8LJ4T9crDVSzf+Llrx/rSS2mKFjkJIw4oC7Ddoy56JjyjQ/0kfR4bWA=
X-Received: by 2002:a50:be89:: with SMTP id b9mr2675307edk.240.1631781328822;
 Thu, 16 Sep 2021 01:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210915204251.26081-1-pauk.denis@gmail.com> <20210915204251.26081-4-pauk.denis@gmail.com>
In-Reply-To: <20210915204251.26081-4-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Sep 2021 11:34:50 +0300
Message-ID: <CAHp75Vfj6yUrYxbCmYuw=poVjY3GmEBrhF2tJHqkKDVtQ4mywA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] hwmon: (nct6775) Support access via Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?Q?P=C3=A4r_Ekholm?= <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Sahan Fernando <sahan.h.fernando@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:45 PM Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Support accessing the NCT677x via Asus WMI functions.
>
> On mainboards that support this way of accessing the chip, the driver will
> usually not work without this option since in these mainboards, ACPI will
> mark the I/O port as used.
>
> Code uses ACPI firmware interface to commucate with sensors with ASUS

communicate

> motherboards:
> * PRIME B460-PLUS,
> * ROG CROSSHAIR VIII IMPACT,
> * ROG STRIX B550-E GAMING,
> * ROG STRIX B550-F GAMING,
> * ROG STRIX B550-F GAMING (WI-FI),
> * ROG STRIX Z490-I GAMING,
> * TUF GAMING B550M-PLUS,
> * TUF GAMING B550M-PLUS (WI-FI),
> * TUF GAMING B550-PLUS,
> * TUF GAMING X570-PLUS,
> * TUF GAMING X570-PRO (WI-FI).

...

> +static int asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg, u8 val, u32 *retval)
> +{

> +#if IS_ENABLED(CONFIG_ACPI_WMI)

The idea behind IS_ENABLED() macro is that it may be used in C
conditionals, like

if (IS_ENABLED(...))

> +       u32 args = bank | (reg << 8) | (val << 16);
> +       struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
> +       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +       acpi_status status;
> +       union acpi_object *obj;
> +       u32 tmp = 0;

> +       obj = output.pointer;
> +       if (obj && obj->type == ACPI_TYPE_INTEGER)
> +               tmp = obj->integer.value;
> +
> +       if (retval)
> +               *retval = tmp;
> +
> +       kfree(obj);

> +       if (tmp == ASUSWMI_UNSUPPORTED_METHOD)

This is uninitialized tmp in case when no obj, or obj is of the wrong type.

> +               return -ENODEV;
> +       return 0;
> +#else
> +       return -EOPNOTSUPP;
> +#endif
> +}

...

> +static u16 nct6775_wmi_read_value(struct nct6775_data *data, u16 reg)
> +{
> +       int res, word_sized = is_word_sized(data, reg);
> +       u8 tmp;
> +
> +       nct6775_wmi_set_bank(data, reg);
> +
> +       nct6775_asuswmi_read(data->bank, reg, &tmp);

> +       res = (tmp & 0xff);

Too many parentheses.
tnp is u8, ' & 0xff' is redundant.

> +       if (word_sized) {
> +               nct6775_asuswmi_read(data->bank, (reg & 0xff) + 1, &tmp);
> +               res = (res << 8) + (tmp & 0xff);

Ditto.

> +       }
> +       return res;
> +}
> +
> +static int nct6775_wmi_write_value(struct nct6775_data *data, u16 reg, u16 value)
> +{
> +       int word_sized = is_word_sized(data, reg);
> +
> +       nct6775_wmi_set_bank(data, reg);
> +
> +       if (word_sized) {

> +               nct6775_asuswmi_write(data->bank, (reg & 0xff),

Too many parentheses

> +                                     (value >> 8) & 0xff);

' & 0xff' part is redundant.

> +               nct6775_asuswmi_write(data->bank, (reg & 0xff) + 1,
> +                                     value & 0xff);
> +       } else {
> +               nct6775_asuswmi_write(data->bank, (reg & 0xff), value);
> +       }
> +
> +       return 0;
> +}

...

> +               err = match_string(asus_wmi_boards, ARRAY_SIZE(asus_wmi_boards),
> +                                  board_name);

> +               if (err != -EINVAL) {

I believe I commented on this in the way as

if (err >= 0)

The rationale behind is that you shouldn't really care what kind of
error codes the API may return.

> +                       /* if reading chip id via WMI succeeds, use WMI */
> +                       if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
> +                               pr_info("Using Asus WMI to access %#x chip.\n", tmp);
> +                               access = access_asuswmi;
> +                       } else {
> +                               pr_err("Can't read ChipID by Asus WMI.\n");
> +                       }
> +               }

-- 
With Best Regards,
Andy Shevchenko

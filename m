Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FA8420372
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJCShV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhJCShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:37:19 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B59C0613EC;
        Sun,  3 Oct 2021 11:35:32 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id y15so15990697ilu.12;
        Sun, 03 Oct 2021 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3zKRb0iXvq1kjachqtiRna8BobohfMUyicQ87NDlYk=;
        b=Arhn8iq4yRKneH0PzOfopq/HMm/+wK/C8Af3X5D9CukGeelH6lUeL0BtRjEyrwZ/yi
         9KjIyuGvZMDKLVpH4ey7wvMeQe34FOWG2pCnH9HvPOiIdmPsQFfsjh68ax7ESKSISg5q
         BTDYlMRgK8ByV5mt0ZhOQCt7Cp4maK8dAYwyvFdeYVYQJcu8VfDelAwFbMwEykG4H9XM
         3IttdCOGsTNfZQt62oZwoo05yFt3qvEiDp5LLSvT/coXw+/+0JPb+gjD6Neb9r2FfgJe
         RvvNDuEdBPJOFAfuy2KCl7NWzIG+9Srelh1Ew7/6xfjbVi95TTCYhtTF0GLntB7TKzlG
         7xwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3zKRb0iXvq1kjachqtiRna8BobohfMUyicQ87NDlYk=;
        b=3lGJzp89mN+9N52UVtqabbIg/Oiavwb+LeaP0jj0lTi4pGZh8AFGL6TRYr6NB1+AFR
         yL3pywEVv++gbQCjGeocD1Z0luGIBBd82Fc4iqJ6bN9lE8jnj3SOwqIWlEP2L3GpXBLW
         1vduw7IUfLP7DShowW4Zwba6wJaSxntdnb+VRxwclwtFNDz52VuSj3HxTHjh0yjtEYsO
         P2jUWBfiasnfo3jQ1bzW/kgqJ9fu4TlY7FwYtC1MHjvUhSjpvpsjHal7Q6ke9jW1tVJ/
         JFqBm815RyfoTM9OxiBpBfHlkc0lEtUQRyLg2Y5ua8xaob4IdYVVZLw3ehZizaX3gAFN
         695Q==
X-Gm-Message-State: AOAM533OnDZlw9njePFrWdRk2a7OO9V4luf9iaoOodHZZemgdGGshFhP
        Mcyjmyt28ir1bUBFirm2d7pSxqG62GhDlBduPzc=
X-Google-Smtp-Source: ABdhPJxhar6w8tddlqjksFXOuCpCvUdAg2/eX3HYGmvUfiVnquoGPgXave1VLOFOr+UXfvazr9IWXrCGH7F6R+wuaX0=
X-Received: by 2002:a05:6e02:921:: with SMTP id o1mr6550554ilt.289.1633286131789;
 Sun, 03 Oct 2021 11:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211002210857.709956-1-pauk.denis@gmail.com> <20211002210857.709956-4-pauk.denis@gmail.com>
 <CAB95QASk7JGqP2_qLtkb-PXUmKPDMcOvLr_8FLrKpv3S2602mw@mail.gmail.com>
In-Reply-To: <CAB95QASk7JGqP2_qLtkb-PXUmKPDMcOvLr_8FLrKpv3S2602mw@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sun, 3 Oct 2021 20:35:20 +0200
Message-ID: <CAB95QAS-yKFmy1bM7U4S2wtzGL7FA2G6hU=_Kurg0So-HXZLzQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (asus_wmi_sensors) Support access via Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Denis,

I've reworked module initialisation [1] to support automatic loading
via MODULE_DEVICE_TABLE(dmi, ...). Could you, please, fetch these
changes?

Best regards,
Eugene

[1] https://github.com/zeule/asus-wmi-ec-sensors/pull/3

On Sat, 2 Oct 2021 at 23:56, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
>
> Hi, Denis!
>
> Thank you for submitting this driver to the mainline! I have a few
> comments/suggestions, please find them below.
>
> > +#define HWMON_MAX      9
>
> There is a hwmon_max enum member, whose current value is 10.
>
> > +#define ASUS_WMI_BLOCK_READ_REGISTERS_MAX 0x10 /* from the ASUS DSDT source */
> > +/* from the ASUS_WMI_BLOCK_READ_REGISTERS_MAX value */
> > +#define ASUS_WMI_MAX_BUF_LEN 0x80
> Suggestion:
> #define ASUS_WMI_MAX_BUF_LEN 0x80 /* from the
> ASUS_WMI_BLOCK_READ_REGISTERS_MAX value */
>
> > +#define ASUSWMI_SENSORS_MAX 11
> This one is for the EC only, maybe rename it accordingly?
>
> > +struct asus_wmi_data {
> > +       int ec_board;
> > +};
>
> Duplicates the value in the asus_wmi_sensors struct. Refactoring artifact?
>
>              asus_wmi_ec_set_sensor_info(si++, "Water", hwmon_fan,
> > +                                           asus_wmi_ec_make_sensor_address(2, 0x00, 0xBC),
> > +                                           &ec->nr_registers);
> This one is named "W_FLOW" in the BIOS and ASUS software. Maybe append
> "_flow" to the label?
>
> > + * The next four functions converts to/from BRxx string argument format
> convert (remove "s")
>
> > +       // assert(len <= 30)
> Makes little sense in the kernel.
>
> > +static void asus_wmi_ec_make_block_read_query(struct asus_wmi_ec_info *ec)
> > +{
> > +       u16 registers[ASUS_EC_KNOWN_EC_REGISTERS];
> > +       u8 i, j, register_idx = 0;
> > +
> > +       /* if we can get values for all the registers in a single query,
> > +        * the query will not change from call to call
> > +        */
> > +       if (ec->nr_registers <= ASUS_WMI_BLOCK_READ_REGISTERS_MAX &&
> > +           ec->read_arg[0] > 0) {
> > +               /* no need to update */
> > +               return;
> > +       }
> > +
> I would add a test for ec->nr_registers >
> ASUS_WMI_BLOCK_READ_REGISTERS_MAX and a warning log message here.
>
> > +static int asus_wmi_probe(struct platform_device *pdev)
>
> Can we add a module alias or to load the module automatically by other
> means? For module aliases we know DMI parameters for the supported
> boards.
>
> Best regards,
> Eugene

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2726041FE56
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 23:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhJBV6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 17:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbhJBV6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 17:58:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD68C061714;
        Sat,  2 Oct 2021 14:56:32 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r75so15819533iod.7;
        Sat, 02 Oct 2021 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2DM8y7xwlyINDZajLE8dKUAZiDUpT+YKcFOLMtesDU=;
        b=Pvjn/YqVqhJc5tod2Ko4mjutNscU7OJzUkh8EUHkN08RsaXHTVWrs01mp2Fnk4Pbun
         mQU+8SV875f0SKHu4qVT+pdR19oIFmlvi+/4d13zF8r/nIrd/cXlwmcj1129GJVxAS7t
         Xhz7A8gkIHbVZZe9aXxHAZT9n9zpCod+kO4hHNZW17CRqBjHeaz7OKnLToeYxdIBsHsK
         xADr5UJe92JhTdrE1Gdy+8I6wd541lfboJA+vDFgzpWFjDCMRTe7f0dqnTW0VvL2TRGI
         mw70W+op7HrqBUqlBld22u+rjCpscNFdxITgG63KkEKoRe16A1iU7GYfsjilergF02Br
         nRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2DM8y7xwlyINDZajLE8dKUAZiDUpT+YKcFOLMtesDU=;
        b=0WCe48KPiQaEUIL0VFDC4ua8dPPYq8hRN/sDJJKRmcP6c52iiv4hC1Kd4xi5ioLDTl
         bCAOT1/erKruHL5TjTd1/FrV4gd3E0bJB+HrURdiVRFOY9jL5HmqaYc8Y31dQS8cQTbk
         d/P+db47rgRgYpvp49K2MfWIVp2M6Di74JX7nSiF8CkwoNwOd5pFOAuVFrZR0erA1O9f
         zyvI96TWzGcpuj6UT9WszIkuyJwQOgIlYU4k1lMMLw7VFXqpC3Kw7QDLYOt0eBKOL/SQ
         zAA6lg7wZymR4pIaaIh8aY8Y0zRlfLBznyVFEyS2BY1dxbQh8N43Lh6LFKK+iMUp18iM
         MQFw==
X-Gm-Message-State: AOAM533h2+oZukUY7Lbg7OlLAjkXhxvd7+tyYX3A+G4QXIUEE7KHi+OM
        rLl854LEYgdMj1f1IH3yk3km2LxhznVuhayIzNM=
X-Google-Smtp-Source: ABdhPJwIfP+P3PFn1htl3SuiyBxn+mmQaerdFtDb59xXbcIUZIunIKuVOtL7KTJIvDZ4otSbTRYIIgHwNIgStr2stZI=
X-Received: by 2002:a6b:b242:: with SMTP id b63mr3531734iof.133.1633211791501;
 Sat, 02 Oct 2021 14:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211002210857.709956-1-pauk.denis@gmail.com> <20211002210857.709956-4-pauk.denis@gmail.com>
In-Reply-To: <20211002210857.709956-4-pauk.denis@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sat, 2 Oct 2021 23:56:20 +0200
Message-ID: <CAB95QASk7JGqP2_qLtkb-PXUmKPDMcOvLr_8FLrKpv3S2602mw@mail.gmail.com>
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

Hi, Denis!

Thank you for submitting this driver to the mainline! I have a few
comments/suggestions, please find them below.

> +#define HWMON_MAX      9

There is a hwmon_max enum member, whose current value is 10.

> +#define ASUS_WMI_BLOCK_READ_REGISTERS_MAX 0x10 /* from the ASUS DSDT source */
> +/* from the ASUS_WMI_BLOCK_READ_REGISTERS_MAX value */
> +#define ASUS_WMI_MAX_BUF_LEN 0x80
Suggestion:
#define ASUS_WMI_MAX_BUF_LEN 0x80 /* from the
ASUS_WMI_BLOCK_READ_REGISTERS_MAX value */

> +#define ASUSWMI_SENSORS_MAX 11
This one is for the EC only, maybe rename it accordingly?

> +struct asus_wmi_data {
> +       int ec_board;
> +};

Duplicates the value in the asus_wmi_sensors struct. Refactoring artifact?

             asus_wmi_ec_set_sensor_info(si++, "Water", hwmon_fan,
> +                                           asus_wmi_ec_make_sensor_address(2, 0x00, 0xBC),
> +                                           &ec->nr_registers);
This one is named "W_FLOW" in the BIOS and ASUS software. Maybe append
"_flow" to the label?

> + * The next four functions converts to/from BRxx string argument format
convert (remove "s")

> +       // assert(len <= 30)
Makes little sense in the kernel.

> +static void asus_wmi_ec_make_block_read_query(struct asus_wmi_ec_info *ec)
> +{
> +       u16 registers[ASUS_EC_KNOWN_EC_REGISTERS];
> +       u8 i, j, register_idx = 0;
> +
> +       /* if we can get values for all the registers in a single query,
> +        * the query will not change from call to call
> +        */
> +       if (ec->nr_registers <= ASUS_WMI_BLOCK_READ_REGISTERS_MAX &&
> +           ec->read_arg[0] > 0) {
> +               /* no need to update */
> +               return;
> +       }
> +
I would add a test for ec->nr_registers >
ASUS_WMI_BLOCK_READ_REGISTERS_MAX and a warning log message here.

> +static int asus_wmi_probe(struct platform_device *pdev)

Can we add a module alias or to load the module automatically by other
means? For module aliases we know DMI parameters for the supported
boards.

Best regards,
Eugene

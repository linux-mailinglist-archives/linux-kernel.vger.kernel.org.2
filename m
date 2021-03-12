Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD8338658
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhCLHFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhCLHF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:05:28 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AE3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:05:28 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id b10so1441947uap.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCWiCgZgy0rQubjdbPrqQeeH4Nm7CRjuGtpK8dVdbJE=;
        b=bUPXRMgowlrM4ZzMctIpARCjLvHSazlKGgAYOdpoxsdda7CreRNXBaEeadTPxxAyMj
         lMrMT2AQPDrEZWqfabrHsmfNXNErSDIBRqUK2XK31+p/2OExqJun5V7pWMq0Xs+xLlTz
         N27SHrVoFEI4+mXwAFZxO6GUkuMjQ7YwtJIAsH2LyvUnjo/VK6JqzsELcCjViMKykrh6
         3g9mR73rttRerVa4kSnw8Hor65Xhiw63EEROlPaKt4BCh7kcNRyBydd4DtATqGpJwOTP
         yUiVEd7hhozbHat8hJGqYcL5qd5NUBrQQ8TkidGwKyb3+QHBVtj8TYSg/Crlvyr8wJuM
         /qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCWiCgZgy0rQubjdbPrqQeeH4Nm7CRjuGtpK8dVdbJE=;
        b=KbzYIJcWUrBVkefXYVPaxrDmLsNz74az4Vd7YlK6V9Jf4Wgd/DY5bGG+IOHp/U5fb1
         Sx+4NCY11tpbVTG+JyjWSVQfFu5uKgUiJFG+YRBcQIV1XfO0zKXL8HQZIHiolcAXl6GP
         GIaKPxEeFr/rCiQLwHjLcPigobuWK3c9YWJUzfjYJuDuBckBYBuYFz8SjbRA33irs6Fi
         wRtTcB4qMUl7XRVJHBTu/9hEXsJcZp0IbAFfD8K71UaQePtHErTXf5FRISJn7rshyyJo
         2n4sHSkgTuSofoThanXs/dyn1TqfeItg1fgekLM0wK8ew0WmcxSFquB4RYG16Ni7BT4F
         XEhg==
X-Gm-Message-State: AOAM533uzSHPX30TFgvarxZ5Xy6dreex0gXhyjDPlCZ37qmG+b4f1M+J
        i7AkIip5bemjz0A+iqjXClnEI23ojgpFwTChNgVmQA==
X-Google-Smtp-Source: ABdhPJzbI8eoQprNIlBFOmEK4fN/XYLPnSccl1qjGnbhAnOZVPy/uSzXgMUaAbesaSQpuulGcJW7ZGr8198Zyccb0Ks=
X-Received: by 2002:ab0:6903:: with SMTP id b3mr7459633uas.65.1615532727640;
 Thu, 11 Mar 2021 23:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20210312052443.3797674-1-badhri@google.com> <20210312052443.3797674-2-badhri@google.com>
 <dba54e90-17e7-ab42-bc82-4ca39ee5de30@roeck-us.net>
In-Reply-To: <dba54e90-17e7-ab42-bc82-4ca39ee5de30@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 11 Mar 2021 23:04:51 -0800
Message-ID: <CAPTae5KdDh-+UTwxQ7v_g-vp0QPHcjC_myBnc+vsHCkkq+BCXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: typec: tcpci_maxim: configure charging & data paths
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:39 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/11/21 9:24 PM, Badhri Jagan Sridharan wrote:
> > The change exposes the data_role and the orientation as a extcon
> > interface for configuring the USB data controller.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> > Changes since V1:
> > - Dropped changes related to get_/set_current_limit and pd_capable
> >   callback. Will send them in as separate patches.
> > ---
> >  drivers/usb/typec/tcpm/tcpci_maxim.c | 56 ++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > index 041a1c393594..1210445713ee 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > @@ -7,6 +7,8 @@
> >
> >  #include <linux/interrupt.h>
> >  #include <linux/i2c.h>
> > +#include <linux/extcon.h>
> > +#include <linux/extcon-provider.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/regmap.h>
> > @@ -46,6 +48,8 @@ struct max_tcpci_chip {
> >       struct device *dev;
> >       struct i2c_client *client;
> >       struct tcpm_port *port;
> > +     bool attached;
> > +     struct extcon_dev *extcon;
> >  };
> >
> >  static const struct regmap_range max_tcpci_tcpci_range[] = {
> > @@ -439,6 +443,39 @@ static int tcpci_init(struct tcpci *tcpci, struct tcpci_data *data)
> >       return -1;
> >  }
> >
> > +static void max_tcpci_set_roles(struct tcpci *tcpci, struct tcpci_data *data, bool attached,
> > +                             enum typec_role role, enum typec_data_role data_role)
> > +{
> > +     struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
> > +
> > +     chip->attached = attached;
> > +
> > +     if (!attached) {
> > +             extcon_set_state_sync(chip->extcon, EXTCON_USB_HOST, 0);
> > +             extcon_set_state_sync(chip->extcon, EXTCON_USB, 0);
> > +             return;
> > +     }
> > +
> > +     extcon_set_state_sync(chip->extcon, data_role == TYPEC_HOST ? EXTCON_USB_HOST : EXTCON_USB,
> > +                           1);
> > +}
> > +
> > +static void max_tcpci_set_cc_polarity(struct tcpci *tcpci, struct tcpci_data *data,
> > +                                   enum typec_cc_polarity polarity)
> > +{
> > +     struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
> > +
> > +     extcon_set_property(chip->extcon, EXTCON_USB, EXTCON_PROP_USB_TYPEC_POLARITY,
> > +                         (union extcon_property_value)(int)polarity);
> > +     extcon_set_property(chip->extcon, EXTCON_USB_HOST, EXTCON_PROP_USB_TYPEC_POLARITY,
> > +                         (union extcon_property_value)(int)polarity);
> > +}
> > +
> > +static const unsigned int usbpd_extcon[] = {
> > +     EXTCON_USB,
> > +     EXTCON_USB_HOST,
> > +};
> > +
> >  static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id *i2c_id)
> >  {
> >       int ret;
> > @@ -472,6 +509,8 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
> >       chip->data.auto_discharge_disconnect = true;
> >       chip->data.vbus_vsafe0v = true;
> >       chip->data.set_partner_usb_comm_capable = max_tcpci_set_partner_usb_comm_capable;
> > +     chip->data.set_roles = max_tcpci_set_roles;
> > +     chip->data.set_cc_polarity = max_tcpci_set_cc_polarity;
> >
> >       max_tcpci_init_regs(chip);
> >       chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> > @@ -484,6 +523,23 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
> >       if (ret < 0)
> >               goto unreg_port;
> >
> > +     chip->extcon = devm_extcon_dev_allocate(&client->dev, usbpd_extcon);
> > +     if (IS_ERR(chip->extcon)) {
> > +             dev_err(&client->dev, "Error allocating extcon: %ld\n", PTR_ERR(chip->extcon));
> > +             ret = PTR_ERR(chip->extcon);
> > +             goto unreg_port;
> > +     }
> > +
> > +     ret = devm_extcon_dev_register(&client->dev, chip->extcon);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "failed to register extcon device");
> > +             goto unreg_port;
> > +     }
>
> Effectively this mandates extcon support to be able to use this driver/chip.
> Does that make sense ? If this is indeed mandatory, how did it work so far ?
Hi Guenter,

We had this in our downstream branch but didnt get a chance to send it
to linux upstream.
I should wrap it in "if(IS_ENABLED(CONFIG_EXTCON))", the tcpc can work
without the
extcon.

>
> Also, what makes this code chip specific ?

Extcon here as is not chip code specific, but, the driver which
subscribes to the extcon interface is chip specific.
I hope it's ok to still send this.

Thanks,
Badhri


>
> Thanks,
> Guenter
>
> > +
> > +     extcon_set_property_capability(chip->extcon, EXTCON_USB, EXTCON_PROP_USB_TYPEC_POLARITY);
> > +     extcon_set_property_capability(chip->extcon, EXTCON_USB_HOST,
> > +                                    EXTCON_PROP_USB_TYPEC_POLARITY);
> > +
> >       device_init_wakeup(chip->dev, true);
> >       return 0;
> >
> >
>

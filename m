Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60C03413ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhCSEAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhCSEAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:00:31 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFEEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:00:26 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g5so2609867uan.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nctu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vcbQhCBSTHhh4wUDjxq0sMUlDR6VBtbKvipEsaSPf2M=;
        b=dXR9JbcV4tSdwigcVzFfyC7uPxLvHXzVgKynh1RDKOo/eJ3WFMJxULUwwaV+o30Mc3
         xIksGO66RfRHqcN7N3fxMRcPksJye/1WTppR8RS5G9/6cCAETKjk7ocnkBhd+xFNPa6u
         /ztJtKMD9qLO+w27LgcD36xMXiKNECYWZVIaQdZKE2DTfZWfKFdPbqLSad/CUcbt24gt
         GI8sM7EP5eeqMSwMx8OVSWw3XeBfKX+yjCOOcKWvVr9qkpWrUrq+HFVLpybu+2DAG0b0
         wOzvXsrxBX4dxKIKNKu+nJ42Z8uKqRPd16tC9Fb9WBAMnjNGFln+3tXczEEDBNSqrRU9
         GK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vcbQhCBSTHhh4wUDjxq0sMUlDR6VBtbKvipEsaSPf2M=;
        b=idAOHxMAewRJl0bhQbOMJKbOHP7EKQQHpHG8rnqBnETNEAecb0mQmxN0WQ6iOpSrt/
         eJlkfmD5UM1n2hsUq1ciaEUGmZb0LsYsOshHBBvYPrdCzos1Uno5J7YFYJGOv+9ArdeI
         JbcrCXRpr4GBDZILmeFpW/9ZsFJthAIzo6bhyzVRhKc6zYqh4I8qfxZo+kvtpQYZqZ+K
         HdiJYBTERyrh4yyExWkBJxrts7aoSs2/91Zo+3ctVbByh2RvVyDO7O4l/e9IbZE35jwS
         sPjtdNCWGa68w4AM0PR5y9ngADFM+aiW9KeNG2frd4tU3O9AtMwD611ko+tytK6QrxJW
         V51A==
X-Gm-Message-State: AOAM530iZ/Hlm2XODSgtxtuJBXzvIyX2bsUp0+Q/xnlp4UEHozhZXNK3
        r+hQK2zns252VjzfJwhb081tk1tg5ENVE8GRL2fLnvZaYRStEQ==
X-Google-Smtp-Source: ABdhPJwid95pRFTszqd56DV6dPKErqBR9xqag7LrGlUeEpd/xzmzJcQXyw5YKIYDyo0KSH216SuiG+zowi9Rb+2DdHk=
X-Received: by 2002:ab0:3c4a:: with SMTP id u10mr1559977uaw.11.1616126425211;
 Thu, 18 Mar 2021 21:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAGBRx8NKMqYxz=PWHnHQoxP4f9J4faooMt82DwUAKT8oWYH34w@mail.gmail.com>
 <283c9df1-9911-d0bd-7db5-2349927c21d1@redhat.com>
In-Reply-To: <283c9df1-9911-d0bd-7db5-2349927c21d1@redhat.com>
From:   "YingChieh, Ho" <andrea.cs97g@nctu.edu.tw>
Date:   Fri, 19 Mar 2021 12:00:20 +0800
Message-ID: <CAFysUkREZtoMj7YgiRBGryjWNLTaKoUaZVFSB7jQV7j-o3CGLw@mail.gmail.com>
Subject: Re: [V2,1/1] platform/x86: add support for Advantech software defined button
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrea Ho <andrea.ho@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thank you for your kindly review.
As a beginner in driver coding, I got gains much from your suggestions.
Path v3 is ready at patchwork.^^

Hans de Goede <hdegoede@redhat.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:21=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi,
>
> On 3/12/21 9:11 AM, YingChieh Ho wrote:
> > From: "Andrea.Ho" <Andrea.Ho@advantech.com.tw>
> >
> > Advantech sw_button is a ACPI event trigger button.
> >
> > With this driver, we can report KEY_EVENT on the
> > Advantech Tabletop Network Appliances products and it has been
> > tested in FWA1112VC.
> >
> > Add the software define button support to report EV_REP key_event
> > (KEY_PROG1) by pressing button that cloud be get on user
> > interface and trigger the customized actions.
> >
> > Signed-off-by: Andrea.Ho <Andrea.Ho@advantech.com.tw>
> >
> > v2:
> >         - change evdev key-code from BTN_TRIGGER_HAPPY to KEY_PROG1
> >         - to rewrite the driver to be a regular platform_driver
> >         - use specific names instead of generic names,
> >           "Software Button" to "Advantech Software Button",
> >           "button" to "adv_swbutton"
> >         - remove unused defines or use-once defines, ACPI_BUTTON_FILE_I=
NFO,
> >           ACPI_BUTTON_FILE_STATE, ACPI_BUTTON_TYPE_UNKNOWN, ACPI_SWBTN_=
NAME
>
> Thank you this version is much better, I have various review remarks belo=
w.
>
> Please send a v3 with those fixed.
>
>
> > ---
> >  MAINTAINERS                         |   5 +
> >  drivers/platform/x86/Kconfig        |  11 ++
> >  drivers/platform/x86/Makefile       |   3 +
> >  drivers/platform/x86/adv_swbutton.c | 192 ++++++++++++++++++++++++++++
> >  4 files changed, 211 insertions(+)
> >  create mode 100644 drivers/platform/x86/adv_swbutton.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 68f21d46614c..e35c48e411b7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -562,6 +562,11 @@ S: Maintained
> >  F:     Documentation/scsi/advansys.rst
> >  F:     drivers/scsi/advansys.c
> >
> > +ADVANTECH SWBTN DRIVER
> > +M:     Andrea Ho <Andrea.Ho@advantech.com.tw>
> > +S:     Maintained
> > +F:     drivers/platform/x86/adv_swbutton.c
> > +
> >  ADXL34X THREE-AXIS DIGITAL ACCELEROMETER DRIVER (ADXL345/ADXL346)
> >  M:     Michael Hennerich <michael.hennerich@analog.com>
> >  S:     Supported
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 0581a54cf562..b1340135c5e9 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -180,6 +180,17 @@ config ACER_WMI
> >           If you have an ACPI-WMI compatible Acer/ Wistron laptop, say =
Y or M
> >           here.
>
> This is supposed to be indented by a space (from the diff format) and the=
n
> a tab + 2 spaces, but in your patch this is now indented by 10 spaces.
>
> In general your entire patch has all tabs replaced by spaces, I guess tha=
t
> your mail-client or editor is mangling things. Please do the following:
>
> 1. Check your patch for checkpatch errors:
>
> git format-patch HEAD~
> scripts/checkpatch.pl 0001-platform...patch
>
> And fix all reported issues, both whitespace issues and others.
>
> 2. Send the next version of the patch like this:
>
> git format-patch -v3 HEAD~
> git send-email v3-0001-platform...patch
>
> Do NOT edit the v3-0001-platform...patch file between these 2 steps.
>
>
> > +config ADV_SWBUTTON
> > +    tristate "Advantech ACPI Software Button Driver"
>
> You are using indent steps of 4 spaces here, that should be a tab
> > +    depends on ACPI
> > +    help
> > +      Say Y here to enable support for Advantech software defined
> > +      button feature. More information can be fount at
> > +      <http://www.advantech.com.tw/products/>
>
> And a tab and 2 spaces for the help text.
>
> > +
> > +      To compile this driver as a module, choose M here. The module wi=
ll
> > +      be called adv_swbutton.
> > +
> >  config APPLE_GMUX
> >         tristate "Apple Gmux Driver"
> >         depends on ACPI && PCI
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
> > index 2b85852a1a87..76a321fc58ba 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -22,6 +22,9 @@ obj-$(CONFIG_ACERHDF)         +=3D acerhdf.o
> >  obj-$(CONFIG_ACER_WIRELESS)    +=3D acer-wireless.o
> >  obj-$(CONFIG_ACER_WMI)         +=3D acer-wmi.o
> >
> > +# Advantech
> > +obj-$(CONFIG_ADV_SWBUTTON)  +=3D adv_swbutton.o
> > +
>
> The indent before the +=3D should use tabs not spaces.
>
> >  # Apple
> >  obj-$(CONFIG_APPLE_GMUX)       +=3D apple-gmux.o
> >
> > diff --git a/drivers/platform/x86/adv_swbutton.c
> > b/drivers/platform/x86/adv_swbutton.c
> > new file mode 100644
> > index 000000000000..f4387220e8a0
> > --- /dev/null
> > +++ b/drivers/platform/x86/adv_swbutton.c
> > @@ -0,0 +1,192 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + *  adv_swbutton.c - Software Button Interface Driver.
> > + *
> > + *  (C) Copyright 2020 Advantech Corporation, Inc
> > + *
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/version.h>
> > +#include <linux/types.h>
> > +#include <linux/proc_fs.h>
> > +#include <linux/input.h>
> > +#include <linux/slab.h>
> > +#include <linux/acpi.h>
> > +#include <linux/platform_device.h>
> > +#include <acpi/button.h>
> > +#include <acpi/acpi_drivers.h>
>
> Please drop the following unused defines:
>
> #include <linux/init.h>
> #include <linux/version.h>
> #include <linux/types.h>
> #include <linux/proc_fs.h>
> #include <linux/slab.h>
> #include <acpi/button.h>
> #include <acpi/acpi_drivers.h>
>
> And sort the remaining includes alphabetically.
>
> > +
> > +#define MODULE_NAME                         "adv_swbutton"
>
> Please drop this define, instead just set the .driver.name part of the pl=
atform_driver struct directly to "adv_swbutton".
>
> > +
> > +#define ACPI_BUTTON_HID_SWBTN               "AHC0310"
> > +#define ACPI_BUTTON_TYPE_SOFTWARE           0x07
>
> Please drop the ACPI_BUTTON_TYPE_SOFTWARE define.
>
> > +
> > +#define ACPI_BUTTON_NOTIFY_SWBTN_RELEASE    0x86
> > +#define ACPI_BUTTON_NOTIFY_SWBTN_PRESSED    0x85
> > +
> > +#define SOFTWARE_BUTTON                     KEY_PROG1
>
> Please drop this unnecessary define and just use KEY_PROG1 directly.
>
> > +
> > +#define _COMPONENT                          ACPI_BUTTON_COMPONENT
> > +
> > +struct acpi_button {
>
> Please give this struct-type a different name, e.g. use:
>
> struct adv_swbutton {
>
> > +       unsigned int type;
>
> And drop the type here, it is always set to ACPI_BUTTON_TYPE_SOFTWARE, so=
 it has no function.
>
> > +       struct input_dev *input;
> > +       char phys[32];
> > +       bool pressed;
>
> Also please drop the pressed bool, see below.
>
>
> > +};
> > +
> > +/*--------------------------------------------------------------------=
-----
> > + *                               Driver Interface
> > + *--------------------------------------------------------------------=
------
> > + */
> > +static void acpi_button_notify(acpi_handle handle, u32 event, void *co=
ntext)
> > +{
> > +       struct acpi_device *device =3D context;
> > +
> > +       struct acpi_button *button =3D dev_get_drvdata(&device->dev);
>
> You must not call dev_set_drvdata on the acpi_device since you are not bi=
nding
> to the acpi_device, you are binding to the platform_device, so set the dr=
v_data
> there and please don't touch the acpi_device.
>
> > +       struct input_dev *input;
> > +
> > +       int keycode, BTN_KEYCODE =3D SOFTWARE_BUTTON;
>
> Please drop these 3 variables, they are not necessary.
>
> > +
> > +       switch (event) {
> > +       case ACPI_BUTTON_NOTIFY_SWBTN_RELEASE:
> > +               input =3D button->input;
>
> Just use button->input below instead of having this unnecessary
> helper variable.
>
> > +
> > +               if (!button->pressed)
> > +                       return;
>
> This is not necessary, the input core takes care of not sending
> events when the state does not change.
>
> > +
> > +               keycode =3D test_bit(BTN_KEYCODE, input->keybit) ?
> > +                               BTN_KEYCODE : KEY_UNKNOWN;
>
> No idea why you are doing this, but it is not necessary,
> also it is wrong, you should be using KEY_PROG1 here.
>
> > +
> > +               button->pressed =3D false;
>
> Keeping track of the pressed state is not necessary.
>
> > +
> > +               input_report_key(input, keycode, 0);
> > +               input_sync(input);
>
> Basically this entire case can be simplified to:
>
>        case ACPI_BUTTON_NOTIFY_SWBTN_RELEASE:
>                input_report_key(button->input, KEY_PROG1, 0);
>                input_sync(button->input);
>                break;
>
>
> > +       break;
>
> This break is indented wrong.
>
> > +       case ACPI_BUTTON_NOTIFY_SWBTN_PRESSED:
> > +               input =3D button->input;
> > +               button->pressed =3D true;
> > +
> > +               keycode =3D test_bit(BTN_KEYCODE, input->keybit) ?
> > +                           BTN_KEYCODE : KEY_UNKNOWN;
> > +
> > +               input_report_key(input, keycode, 1);
> > +               input_sync(input);
> > +       break;
>
> And the same as above here, this can be simplified to:
>
>        case ACPI_BUTTON_NOTIFY_SWBTN_PRESSED:
>                input_report_key(button->input, KEY_PROG1, 1);
>                input_sync(button->input);
>                break;
>
>
> > +       default:
> > +               ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > +                                 "Unsupported event [0x%x]\n", event))=
;
>
> Please don't use ACPI_DEBUG_PRINTF outside of drivers/acpi, instead
> use:
>
>                   dev_dbg(&platform_device->dev, ...);
>
> > +       break;
>
> There is no need for a break at the end of a switch-case
>
> > +       }
> > +}
> > +
> > +static int acpi_button_probe(struct platform_device *device)
> > +{
> > +       struct acpi_device *acpi_device;
> > +       struct acpi_button *button;
> > +       struct input_dev *input;
> > +       acpi_status status;
> > +
> > +       int error;
> > +
> > +       acpi_device =3D ACPI_COMPANION(&device->dev);
> > +       if (!acpi_device) {
> > +               dev_err(&device->dev, "ACPI companion is missing\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       status =3D acpi_install_notify_handler(acpi_device->handle,
> > +                                            ACPI_DEVICE_NOTIFY,
> > +                                            acpi_button_notify,
> > +                                            acpi_device);
> > +       if (ACPI_FAILURE(status)) {
> > +               dev_err(&device->dev, "Error installing notify handler\=
n");
> > +               error =3D -ENODEV;
> > +       }
>
> This needs to be done at the end of probe, if the notifier now runs, befo=
re
> you have called dev_set_drvdata(), you will have a NULL pointer deref,
> and even if the dev_set_drvdata() then the notifier may run before you ha=
ve
> set button->input =3D input and you still have a NULL pointer deref.
>
> So first setup everything and only then call acpi_install_notify_handler(=
).
>
> > +
> > +       button =3D devm_kzalloc(&acpi_device->dev, sizeof(*button), GFP=
_KERNEL);
> > +       if (!button)
> > +               return -ENOMEM;
> > +
> > +       dev_set_drvdata(&acpi_device->dev, button);
>
> Call this on the platform_device, so:
>
>        dev_set_drvdata(&device->dev, button);
>
> Also see above.
>
> > +
> > +       input =3D devm_input_allocate_device(&acpi_device->dev);
> > +       if (!input) {
> > +               error =3D  -ENOMEM;
> > +               goto err_free_mem;
>
> There is no need for the goto err_free_mem here (see below), so this
> can be simplified to just:
>
>       input =3D devm_input_allocate_device(&acpi_device->dev);
>       if (!input)
>                return -ENOMEM;
>
> > +       }
> > +
> > +       button->input =3D input;
> > +       button->type =3D ACPI_BUTTON_TYPE_SOFTWARE;
> > +       button->pressed =3D false;
>
> Drop the setting of type/pressed, see above.
>
>
> > +
> > +       snprintf(button->phys, sizeof(button->phys),
> > "%s/button/input0", ACPI_BUTTON_HID_SWBTN);
> > +
> > +       input->name =3D "Advantech Software Button";
> > +       input->phys =3D button->phys;
> > +       input->id.bustype =3D BUS_HOST;
> > +       input->id.product =3D button->type;
>
> Don't set product to some semi-random value. Just leave it at 0.
>
> > +       input->dev.parent =3D &acpi_device->dev;
>
> This should be:
>
>         input->dev.parent =3D &device->dev;
>
> > +
> > +       switch (button->type) {
> > +       case ACPI_BUTTON_TYPE_SOFTWARE:
> > +               set_bit(EV_KEY, input->evbit);
> > +               set_bit(EV_REP, input->evbit);
> > +
> > +               input_set_capability(input, EV_KEY, SOFTWARE_BUTTON);
> > +       break;
> > +       }
>
> button->type always equals ACPI_BUTTON_TYPE_SOFTWARE, so you can drop the=
 whole
> switch-case here and input_set_capability(input, EV_KEY, ...) already doe=
s:
> set_bit(EV_KEY, input->evbit);, so this entire block can be simplified to=
 just:
>
>           set_bit(EV_REP, input->evbit);
>           input_set_capability(input, EV_KEY, KEY_PROG1);
>
>
> > +
> > +       input_set_drvdata(input, acpi_device);
>
> You are never using the drvdata associated with the input_dev, so
> this can be dropped. Also please don't use acpi_device for this/
>
> > +       error =3D input_register_device(input);
> > +       if (error)
> > +               return error;
> > +
> > +       device_init_wakeup(&acpi_device->dev, true);
>
> Don't use acpi_device, instead do:
>
>           device_init_wakeup(&device->dev, true);
>
>
>
>
> > +
> > +       return 0;
> > +
> > +err_free_mem:
> > +       devm_kfree(&device->dev, button);
>
> devm_kzalloced mem will automatically be free-ed when the probe function
> returns with an error, or when the driver is unbound (removed) so there
> is no need to call devm_kfree() here.
>
> > +       return error;
> > +}
> > +
> > +static int acpi_button_remove(struct platform_device *device)
> > +{
> > +       struct acpi_device *acpi_device =3D ACPI_COMPANION(&device->dev=
);
> > +       struct acpi_button *button =3D dev_get_drvdata(&acpi_device->de=
v);
> > +
> > +       acpi_remove_notify_handler(acpi_device->handle, ACPI_DEVICE_NOT=
IFY,
> > +                                  acpi_button_notify);
> > +
> > +       input_unregister_device(button->input);
> > +       devm_kfree(&acpi_device->dev, button);
>
> The input_unregister_device() and devm_kfree() will be done automatically
> when the remove function exits, so you can drop these 2 calls.
>
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct acpi_device_id button_device_ids[] =3D {
> > +       {ACPI_BUTTON_HID_SWBTN, 0},
> > +       {"", 0},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(acpi, button_device_ids);
> > +
> > +static struct platform_driver acpi_button_driver =3D {
> > +       .driver =3D {
> > +               .name =3D MODULE_NAME,
> > +               .acpi_match_table =3D button_device_ids,
> > +       },
> > +       .probe =3D acpi_button_probe,
> > +       .remove =3D acpi_button_remove,
> > +};
> > +
> > +module_platform_driver(acpi_button_driver);
> > +
>
> This is not an ACPI driver, please drop the ACPI_MODULE_NAME() call.
>
> > +ACPI_MODULE_NAME(MODULE_NAME);
> > +
> > +MODULE_AUTHOR("Andrea Ho");
> > +MODULE_DESCRIPTION("Advantech ACPI SW Button Driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.1
> >
>
> Regards,
>
> Hans
>

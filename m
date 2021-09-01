Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293013FDE8F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbhIAPZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:25:42 -0400
Received: from mail-4323.protonmail.ch ([185.70.43.23]:49618 "EHLO
        mail-4323.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343673AbhIAPZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:25:41 -0400
Date:   Wed, 01 Sep 2021 15:24:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630509882;
        bh=JM4uDiMJsApQbN3SvBBRU1K31XYBclLBZcIW1vSbVtk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=KkJ6n9nT8J4FgWAH+gPcfiAF1jmryaH0oUkIajigLutkBcsD26LyCNvKqZ6XZEUrF
         oQjIxB3611QDA7NcjGD1trcub4a/zBsjC2hK0J6NTHIEiaQq/CypT+/fuVMhM1Kwb0
         MaV6IS6Vcl4/0kifp6S/fH5+l/dY+gL/QJ5Zsp2A=
To:     Luke Jones <luke@ljones.dev>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v7] asus-wmi: Add support for custom fan curves
Message-ID: <Z3uTWHyeRPzaHU0iSW56m1ltGsYr5DOfRoJLyGlfnObU0ph-mVf9M6KCbSV66AeY_voEARTrP6bOtqXS1ZubuSj4Cu25VSRu0VMBIf3whow=@protonmail.com>
In-Reply-To: <BLFOYQ.DC67MOSNFFNW2@ljones.dev>
References: <20210830113137.1338683-1-luke@ljones.dev> <20210830113137.1338683-2-luke@ljones.dev> <1o94oJFiia_xvrFrSPI_zG1Xfv4FAlJNY96x39rg-zX3-3N5Czw4KmTiJtzCy1So7kYXLu0FTkRkmwUUudeuTyLHSsx5sJGhfsZaYrXKEic=@protonmail.com> <BLFOYQ.DC67MOSNFFNW2@ljones.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


> [...]
> >>  --- a/drivers/platform/x86/asus-wmi.c
> >>  +++ b/drivers/platform/x86/asus-wmi.c
> >>  [...]
> >>  +/*
> >>  + * Returns as an error if the method output is not a buffer.
> >> Typically this
> >
> > It seems to me it will simply leave the output buffer uninitialized
> > if something
> > other than ACPI_TYPE_BUFFER and ACPI_TYPE_INTEGER is encountered and
> > return 0.
>
> Oops, see below inline reply:
>
> >
> >
> >>  + * means that the method called is unsupported.
> >>  + */
> >>  +static int asus_wmi_evaluate_method_buf(u32 method_id,
> >>  +=09=09u32 arg0, u32 arg1, u8 *ret_buffer)
> >>  +{
> >>  +=09struct bios_args args =3D {
> >>  +=09=09.arg0 =3D arg0,
> >>  +=09=09.arg1 =3D arg1,
> >>  +=09=09.arg2 =3D 0,
> >>  +=09};
> >>  +=09struct acpi_buffer input =3D { (acpi_size) sizeof(args), &args };
> >>  +=09struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> >>  +=09acpi_status status;
> >>  +=09union acpi_object *obj;
> >>  +=09u32 int_tmp =3D 0;
> >>  +
> >>  +=09status =3D wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
> >>  +=09=09=09=09     &input, &output);
> >>  +
> >>  +=09if (ACPI_FAILURE(status))
> >>  +=09=09return -EIO;
> >>  +
> >>  +=09obj =3D (union acpi_object *)output.pointer;
> >>  +
> >>  +=09if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
> >>  +=09=09int_tmp =3D (u32) obj->integer.value;
> >>  +=09=09if (int_tmp =3D=3D ASUS_WMI_UNSUPPORTED_METHOD)
> >>  +=09=09=09return -ENODEV;
> >>  +=09=09return int_tmp;
> >
> > Is anything known about the possible values? You are later
> > using it as if it was an errno (e.g. in `custom_fan_check_present()`).
> >
> > And `obj` is leaked in both of the previous two returns.
>
> The return for the method we're calling in this patch returns 0 if the
> input arg has no match.
>
> >
> >
> >>  +=09}
> >>  +
> >>  +=09if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER)
> >>  +=09=09memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
> >
> > I would suggest you add a "size_t size" argument to this function, and
> > return -ENOSPC/-ENODATA depending on whether the returned buffer is
> > too
> > big/small. Maybe return -ENODATA if `obj` is NULL, too.
>
> Got it. So something like this would be suitable?
>
> =09if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER)
> =09=09if (obj->buffer.length < size)
> =09=09=09err =3D -ENOSPC;
> =09=09if (!obj->buffer.length)
> =09=09=09err =3D -ENODATA;
> =09=09if (err) {
> =09=09=09kfree(obj);
> =09=09=09return err;
> =09=09}
> =09=09memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
> =09}
>
> =09if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
> =09=09int_tmp =3D (u32) obj->integer.value;
>
> =09kfree(obj);
>
> =09if (int_tmp =3D=3D ASUS_WMI_UNSUPPORTED_METHOD)
> =09=09return -ENODEV;
>
> =09/* There is at least one method that returns a 0 with no buffer */
> =09if (obj =3D=3D NULL || int_tmp =3D=3D 0)
> =09=09return -ENODATA;
>
> =09return 0;
>

I had something like the following in mind:

  int err =3D 0;
  /* ... */
  obj =3D output.pointer;
  if (!obj)
    return -ENODATA;

  switch (obj->type) {
  case ACPI_TYPE_BUFFER:
    if (obj->buffer.length < size)
      err =3D -ENODATA;
    else if (obj->buffer.length > size)
      err =3D -ENOSPC;
    else
      memcpy(ret_buffer, obj->buffer.pointer, size);
    break;
  case ACPI_TYPE_INTEGER:
    switch (obj->integer.value) {
      case ASUS_WMI_UNSUPPORTED_METHOD:
        err =3D -EOPNOTSUPP;
=09break;
      default:
        err =3D -ENODATA;
=09break;
    }
    break;
  default:
    err =3D -ENODATA;
    break;
  }

  kfree(obj);

  return err;


> >
> >
> >>  +
> >>  +=09kfree(obj);
> >>  +
> >>  +=09return 0;
> >>  +}
> [...]
> >>  +/*
> >>  + * Called only by throttle_thermal_policy_write()
> >>  + */
> >
> > Am I correct in thinking that the firmware does not actually
> > support specifying fan curves for each mode, only a single one,
> > and the fan curve switching is done by this driver when
> > the performance mode is changed?
>
> I'm not 100% certain on this. The WMI method 0x00110024 takes an arg
> 0,1,2 which then returns some factory stored fan profiles, these fit
> the profiles of ASUS_THROTTLE_THERMAL_POLICY_*, but with 1 and 2
> swapped.
>
> Looking at the SET part, it seems to write to a different location than
> where the GET is fetching information.
>

The, unfortunately, that is not as simple as I initially thought...


> Because of the fact there are three sets of curves to get, I thought it
> would be good for users to be able to set per profile. I don't think
> the set is retained in acpi if the profile is switched.
>
> Do you think it would be best to not have the ability to store per
> profile in kernel?

If there was a method to set a fan curve, and one to retrieve it,
I would suggest just exposing that via the pwmN_auto_pointM_{pwm,temp}
attributes on a hwmon device, and that the profile-dependent switching
be implemented somewhere else. As far as I see, there is already
existing infrastructure for integrating such a feature [0]
(but please correct me if I'm wrong).

This would simplify the kernel code, add no new ABI, and
potentially provide greater control over policy for the
user space.


> How would I choose which profile get to populate the
> initial data with if so?

I assume there isn't a method that can query
the current fan curve (or it is unknown)?


> [...]

[0]: https://gitlab.com/asus-linux/asusctl


Best regards,
Barnab=C3=A1s P=C5=91cze

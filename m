Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A40A3FA63C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 16:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhH1Okh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 10:40:37 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:53722 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhH1Okf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 10:40:35 -0400
Date:   Sat, 28 Aug 2021 14:39:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630161583;
        bh=SU97U4k+BG9WpT9upZ0CTmH1ekBpmGjusEIO35UmWHw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Rn9ltSP6ephgT5FKCjO/mRb+b/iIJ1AkBh4QtiBlnhyV3WdZWc7Yn6yPPN/1YCili
         3CT0JciaEyVe8ahQN4vnKq9xedLnMe6Dyn2sIoa8bq3FqzZniqt9eRehM2Z5RORfRu
         W/EFqNsezy1eXjUehcnLt9DRNotuSnSFeLfawpGA=
To:     Luke Jones <luke@ljones.dev>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        hadess@hadess.net, platform-driver-x86@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v5] asus-wmi: Add support for custom fan curves
Message-ID: <MPiYn0QuHwkWya44TXiM0sSRYZMNs-1J5vsUMxsN4LegmaEKqNr9RVr7ALJFhU7JQfChIOWqNEkXkE_rqPA1TUb9B72cuVi0tq_h0VhXt0U=@protonmail.com>
In-Reply-To: <P9FJYQ.MFQ4LNL2O0AY@ljones.dev>
References: <20210826234259.5980-1-luke@ljones.dev> <20210826234259.5980-2-luke@ljones.dev> <l_wjZlSh5I-iPC46H7er23ScdheWKul7iVjIbCUAKyz1sMPoZsFiAMVZa7N2W8Kv8RnFiksYwnWkPv9X428OYZtN5Q1OtI0L8zyHc-6cs2g=@protonmail.com> <P9FJYQ.MFQ4LNL2O0AY@ljones.dev>
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


2021. augusztus 28., szombat 8:56 keltez=C3=A9ssel, Luke Jones =C3=ADrta:
> [...]
> >>  +/*
> >>  + * The expected input is of the format
> >>  + *     "30:1,49:2,59:3,69:4,79:31,89:49,99:56,109:58"
> >>  + * where a pair is 30:1, with 30 =3D temperature, and 1 =3D percenta=
ge
> >>  +*/
> >>  +static int fan_curve_write(struct asus_wmi *asus, u32 dev, char
> >> *curve)
> >>  +{
> >>  +    char * buf, *set, *pair_tmp, *pair, *set_end, *pair_end;
> >>  +    int err, ret;
> >>  +
> >>  +=09char *set_delimiter =3D ",";
> >>  +=09char *pair_delimiter =3D ":";
> >>  +=09bool half_complete =3D false;
> >>  +=09bool pair_start =3D true;
> >>  +=09u32 prev_percent =3D 0;
> >>  +=09u32 prev_temp =3D 0;
> >>  +=09u32 percent =3D 0;
> >>  +=09u32 shift =3D 0;
> >>  +=09u32 temp =3D 0;
> >>  +    u32 arg1 =3D 0;
> >>  +    u32 arg2 =3D 0;
> >>  +    u32 arg3 =3D 0;
> >>  +    u32 arg4 =3D 0;
> >>  +
> >>  +    buf =3D set_end =3D pair_end =3D kstrdup(curve, GFP_KERNEL);
> >>  +
> >>  +=09while( (set =3D strsep(&set_end, set_delimiter)) !=3D NULL ) {
> >>  +=09=09pair_tmp =3D kstrdup(set, GFP_KERNEL);
> >>  +        pair_start =3D true;
> >>  +=09=09while( (pair =3D strsep(&pair_tmp, pair_delimiter)) !=3D NULL =
) {
> >>  +=09=09=09err =3D kstrtouint(pair, 10, &ret);
> >>  +            if (err) {
> >>  +                kfree(pair_tmp);
> >>  +                kfree(buf);
> >>  +                return err;
> >>  +            }
> >>  +
> >>  +            if (pair_start) {
> >>  +                temp =3D ret;
> >>  +                pair_start =3D false;
> >>  +            } else {
> >>  +                percent =3D ret;
> >>  +            }
> >>  +=09=09}
> >>  +=09=09kfree(pair_tmp);
> >>  +
> >>  +=09=09if (temp < prev_temp || percent < prev_percent || percent > 10=
0)
> >> {
> >>  +            pr_info("Fan curve invalid");
> >>  +=09=09=09pr_info("A value is sequentially lower or percentage is > 1=
00");
> >>  +            kfree(buf);
> >>  +            return -EINVAL;
> >>  +        }
> >>  +
> >>  +        prev_temp =3D temp;
> >>  +        prev_percent =3D percent;
> >>  +
> >>  +        if (!half_complete) {
> >>  +            arg1 +=3D temp << shift;
> >>  +            arg3 +=3D percent << shift;
> >>  +        } else {
> >>  +            arg2 +=3D temp << shift;
> >>  +            arg4 +=3D percent << shift;
> >>  +        }
> >
> > As far as I see using 64-bit integers would avoid the need for
> > `half_complete`, et al.
>
> Reworked all that as part of the u8-array stuff. Look forward to seeing
> what you think.
>
> >
> >
> >>  +        shift +=3D 8;
> >>  +
> >>  +        if (shift =3D=3D 32) {
> >>  +            shift =3D 0;
> >>  +            half_complete =3D true;
> >>  +        }
> >>  +=09}
> >>  +=09kfree(buf);
> >>  +
> >
> > If you don't insist on using commas, I think it is much simpler to
> > parse it using `sscanf()`, e.g.:
> >
> >   unsigned int temp, prct;
> >   int at =3D 0, len;
> >
> >   while (sscanf(&buf[at], "%u:%u %n", &temp, &prct, &len) =3D=3D 2) {
> >     /* process `temp` and `prct` */
> >
> >     at +=3D len;
> >   }
> >
> >   if (buf[at] !=3D '\0')
> >     /* error */;
> >
> > This also has the advantage that you don't need dynamic memory
> > allocation.
>
> Half the reason I did it in the format of 10:20,30:40,.. is to keep
> close to a format that many people using some external tools for fan
> curves (using acpi_call modue!) are using. I'm open to improvements ofc.
>

If you don't insist on *requiring* commas, then I think the following works=
:

  while (sscanf(&buf[at], "%u:%u %n", &temp, &prct, &len) =3D=3D 2) {
    /* process `temp` and `prct` */

    at +=3D len;
    at +=3D strspn(&buf[at], ",");
  }

But please, whatever parser you end up submitting, make sure it is thorough=
ly tested.


> [...]
> >>  +static ssize_t gpu_fan_curve_quiet_show(struct device *dev,
> >>  +=09=09=09=09   struct device_attribute *attr, char *buf)
> >>  +{
> >>  +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> >>  +=09return scnprintf(buf, PAGE_SIZE, "%s", asus->gpu_fan_curve.quiet)=
;
> >>  +}
> >>  +
> >>  +static ssize_t gpu_fan_curve_quiet_store(struct device *dev,
> >>  +=09=09=09=09    struct device_attribute *attr,
> >>  +=09=09=09=09    const char *buf, size_t count)
> >>  +{
> >>  +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
> >>  +    return fan_curve_store(asus, buf, count,
> >> ASUS_WMI_DEVID_GPU_FAN_CURVE,
> >>  +=09=09=09=09=09=09=09&asus->gpu_fan_curve.quiet,
> >>  +=09=09=09=09=09=09=09asus->gpu_fan_curve.quiet_default);
> >>  +}
> >>  +
> >>  +static DEVICE_ATTR_RW(gpu_fan_curve_quiet);
> >
> > Even though it is a hwmon thing, I think `SENSOR_ATTR_2()` (from
> > linux/hwmon-sysfs.h)
> > would be very useful here as you'd avoid creating n+1 functions, e.g:
> >
> >   static ssize_t fan_curve_show(struct device *dev, struct
> > device_attribute *attr, char *buf)
> >   {
> >     struct sensor_device_attribute_2 *sattr =3D
> > to_sensor_dev_attr_2(attr);
> >     struct asus_wmi *asus =3D dev_get_drvdata(dev);
> >
> >     /*
> >      * if you stored fan curves in an array, you could then access
> > the fan
> >      * curve in `asus->fans[sattr->index].curves[sattr->nr]`
> >      * /
> >   }
> >
> >   static SENSOR_DEVICE_ATTR_2(some_name1, 0644, fan_curve_show,
> > fan_curve_store,
> >                               FAN_CPU /* index in the "fans" array */,
> >                               ASUS_THROTTLE_THERMAL_POLICY_SILENT /*
> > index in the "curves" array */);
> >
>
> I'm sorry I don't really understand how this works. Is there a good doc
> for it anywhere? Being unfamiliar with C makes it look a little more
> intimidating than what I've managed to do so far.
>

I am not sure, you can find some uses among hwmon drivers.

If you look into linux/hwmon-sysfs.h, then you can see that `SENSOR_DEVICE_=
ATTR_2()`
defines and initializes a `struct sensor_device_attribute_2` object:

  struct sensor_device_attribute_2 {
    struct device_attribute dev_attr;
    u8 index;
    u8 nr;
  };

So it has a normal device attribute inside it, and two extra pieces of data=
.
One difference is that when you create the `struct attribute` array
(`platform_attributes`), then you will need to use `&some_name1.dev_attr.at=
tr`.

And the idea here is that the show/store callbacks receive a pointer to the
device attribute that is being read/written, and we know for a fact, that t=
his
device attribute is inside a `sensor_device_attribute_2` struct. And thus w=
e can
use the `to_sensor_dev_attr_2()` macro to get a pointer to the "outer"
`sensor_device_attribute_2` struct that contains the `device_attribute` str=
uct
that we have a pointer to.

So now the `index` and `nr` members of that struct can be accessed. You cou=
ld
store the index of the fan (e.g. 0 for CPU, 1 for GPU) in `index`, and the =
profile
in `nr`. The `ASUS_THROTTLE_THERMAL_POLICY_*` macros go from 0 to 2, so I t=
hink
those would be perfect candidates for the curve index. That's why I used
`ASUS_THROTTLE_THERMAL_POLICY_SILENT` in the example.

The fan curve associated with the attribute can now be
accessed in `asus->fans[sattr->index].curves[sattr->nr]`.

`to_sensor_dev_attr_2()` is just a wrapper around `container_of()`, so if y=
ou're
familiar with the idea behind that, this shouldn't be too hard to wrap your
head around.

  #define to_sensor_dev_attr_2(_dev_attr) \
    container_of(_dev_attr, struct sensor_device_attribute_2, dev_attr)

What it does, is that if you give it a pointer to the `dev_attr` member of =
a
`struct sensor_device_attribute_2`, then it'll give you back a pointer
to the `struct sensor_device_attribute_2`. `container_of()` basically does =
a
"conversion" from pointer-to-member-of-struct-X to pointer-to-struct-X.

In some sense, you might think of `struct device_attribute` as the "base cl=
ass",
and the `struct sensor_device_attribute_2` as the "derived class" here. And=
 what
`to_sensor_dev_attr_2()` is a down-cast from the base class to the derived,
e.g. something like this in C++:

  struct device_attribute { ... };
  struct sensor_device_attribute_2 : device_attribute {
    u8 index;
    u8 nr;
  };

  /* `device_attr` is of type `struct device_attribute *` */
  static_cast<sensor_device_attribute_2 *>(device_attr);
  /* there's also dynamic_cast which can do the same down-cast,
     but it does runtime type checking as well */
  /* both of the mentioned C++ casts check if the pointer is nullptr,
     normal container_of() does not that, but there is container_of_safe() =
*/

It may be too detailed, I'm not sure; please let me know if you have other =
questions.


> [...]


Best regards,
Barnab=C3=A1s P=C5=91cze

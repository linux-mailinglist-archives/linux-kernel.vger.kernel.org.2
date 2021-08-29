Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD31A3FA9D5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 09:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhH2HLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 03:11:49 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51775 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232001AbhH2HLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 03:11:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 0B4C4320005D;
        Sun, 29 Aug 2021 03:10:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 29 Aug 2021 03:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=k4GENPVQzXkTBpR5Mj3VZ7EMGmUVe20kCLvV9m7dQ
        YA=; b=Aoo9MrmTokyQq3+k8fhr1jNZxP6nrQsAfFx+XU7K5KADS2P1nUCwFGEbB
        EnWOjVasn0+SN37EnBnnbpPMsJHuwww4ydzXW4+QQFoOGkHu9/dMPt7gZEqye9Sd
        G9NRi3kN8oyiwajCjatw0ELZTtlNdgkMk5htZI997Y7JdAHZvEPUsdbFmcyyT490
        Spjbz7qdVOoJFR61Ap/G3bNNYrTOiEff8cY2jAfrCsINBx7h5LDTKywlH1gm2mlu
        H5JLHCBc/wawN0lDkSsUVHjWQMRH8KQRSCiXjdPpU613/bcKS+Enkv0eDAwYuNQK
        2NGVFdL2wGbURdal8BSlVUlF67lhw==
X-ME-Sender: <xms:_TIrYSsWEeDMSOgTbqmn2SzEYSjAKEv4BJk25ZBoNALytviQcAREZA>
    <xme:_TIrYXcuy8JYegM_psyu9cWXtHErWitS8Zor4qf6rjW9pH9vZ1WmxP0MSnrYOjq_A
    6uYhWMYn_5Udv1Wzrk>
X-ME-Received: <xmr:_TIrYdwKVnvQL0lzKyjwYDVIoAPG1T6sVfrQe27KnGv9C-QurHAfvAw5oJwlyEC2GoDDmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduiedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhuffvkfgjfhfogggtgfesth
    hqredtredtshenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnhepkeevffeiheeuleegleetveelhedutefhhf
    egffetvedtfefgleelgeetleekgfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:_TIrYdOzF-Fe1d2qJ7PflJtwIBQAk6SKUP-MG2cuuIl5kZ8gcOaH1w>
    <xmx:_TIrYS_nbh9al9PxZ1Uue4tRRXuS5rT6hloxfxy7iTl3ybUu33vdHQ>
    <xmx:_TIrYVVFJ2gzNef47qwCCSFOwaB_jN5BuXcoW73wRTXBgOMun1Sxqg>
    <xmx:_jIrYZYgEYeNTW4Ygrs5o_5plXr8ljzZ75iohpB00mHXFW2VCJUf9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Aug 2021 03:10:47 -0400 (EDT)
Date:   Sun, 29 Aug 2021 19:10:32 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v5] asus-wmi: Add support for custom fan curves
To:     =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        hadess@hadess.net, platform-driver-x86@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Message-Id: <KLALYQ.CV9F9R51SB3N@ljones.dev>
In-Reply-To: <MPiYn0QuHwkWya44TXiM0sSRYZMNs-1J5vsUMxsN4LegmaEKqNr9RVr7ALJFhU7JQfChIOWqNEkXkE_rqPA1TUb9B72cuVi0tq_h0VhXt0U=@protonmail.com>
References: <20210826234259.5980-1-luke@ljones.dev>
        <20210826234259.5980-2-luke@ljones.dev>
        <l_wjZlSh5I-iPC46H7er23ScdheWKul7iVjIbCUAKyz1sMPoZsFiAMVZa7N2W8Kv8RnFiksYwnWkPv9X428OYZtN5Q1OtI0L8zyHc-6cs2g=@protonmail.com>
        <P9FJYQ.MFQ4LNL2O0AY@ljones.dev>
        <MPiYn0QuHwkWya44TXiM0sSRYZMNs-1J5vsUMxsN4LegmaEKqNr9RVr7ALJFhU7JQfChIOWqNEkXkE_rqPA1TUb9B72cuVi0tq_h0VhXt0U=@protonmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks heaps Barnab=E1s, I think I've gotten a very good improvement=20
with your help. Let's see how V6 fairs.

On Sat, Aug 28 2021 at 14:39:40 +0000, Barnab=E1s P=F5cze=20
<pobrn@protonmail.com> wrote:
> Hi
>=20
>=20
> 2021. augusztus 28., szombat 8:56 keltez=E9ssel, Luke Jones =EDrta:
>>  [...]
>>  >>  +/*
>>  >>  + * The expected input is of the format
>>  >>  + *     "30:1,49:2,59:3,69:4,79:31,89:49,99:56,109:58"
>>  >>  + * where a pair is 30:1, with 30 =3D temperature, and 1 =3D=20
>> percentage
>>  >>  +*/
>>  >>  +static int fan_curve_write(struct asus_wmi *asus, u32 dev, char
>>  >> *curve)
>>  >>  +{
>>  >>  +    char * buf, *set, *pair_tmp, *pair, *set_end, *pair_end;
>>  >>  +    int err, ret;
>>  >>  +
>>  >>  +	char *set_delimiter =3D ",";
>>  >>  +	char *pair_delimiter =3D ":";
>>  >>  +	bool half_complete =3D false;
>>  >>  +	bool pair_start =3D true;
>>  >>  +	u32 prev_percent =3D 0;
>>  >>  +	u32 prev_temp =3D 0;
>>  >>  +	u32 percent =3D 0;
>>  >>  +	u32 shift =3D 0;
>>  >>  +	u32 temp =3D 0;
>>  >>  +    u32 arg1 =3D 0;
>>  >>  +    u32 arg2 =3D 0;
>>  >>  +    u32 arg3 =3D 0;
>>  >>  +    u32 arg4 =3D 0;
>>  >>  +
>>  >>  +    buf =3D set_end =3D pair_end =3D kstrdup(curve, GFP_KERNEL);
>>  >>  +
>>  >>  +	while( (set =3D strsep(&set_end, set_delimiter)) !=3D NULL ) {
>>  >>  +		pair_tmp =3D kstrdup(set, GFP_KERNEL);
>>  >>  +        pair_start =3D true;
>>  >>  +		while( (pair =3D strsep(&pair_tmp, pair_delimiter)) !=3D NULL ) =
{
>>  >>  +			err =3D kstrtouint(pair, 10, &ret);
>>  >>  +            if (err) {
>>  >>  +                kfree(pair_tmp);
>>  >>  +                kfree(buf);
>>  >>  +                return err;
>>  >>  +            }
>>  >>  +
>>  >>  +            if (pair_start) {
>>  >>  +                temp =3D ret;
>>  >>  +                pair_start =3D false;
>>  >>  +            } else {
>>  >>  +                percent =3D ret;
>>  >>  +            }
>>  >>  +		}
>>  >>  +		kfree(pair_tmp);
>>  >>  +
>>  >>  +		if (temp < prev_temp || percent < prev_percent || percent >=20
>> 100)
>>  >> {
>>  >>  +            pr_info("Fan curve invalid");
>>  >>  +			pr_info("A value is sequentially lower or percentage is >=20
>> 100");
>>  >>  +            kfree(buf);
>>  >>  +            return -EINVAL;
>>  >>  +        }
>>  >>  +
>>  >>  +        prev_temp =3D temp;
>>  >>  +        prev_percent =3D percent;
>>  >>  +
>>  >>  +        if (!half_complete) {
>>  >>  +            arg1 +=3D temp << shift;
>>  >>  +            arg3 +=3D percent << shift;
>>  >>  +        } else {
>>  >>  +            arg2 +=3D temp << shift;
>>  >>  +            arg4 +=3D percent << shift;
>>  >>  +        }
>>  >
>>  > As far as I see using 64-bit integers would avoid the need for
>>  > `half_complete`, et al.
>>=20
>>  Reworked all that as part of the u8-array stuff. Look forward to=20
>> seeing
>>  what you think.
>>=20
>>  >
>>  >
>>  >>  +        shift +=3D 8;
>>  >>  +
>>  >>  +        if (shift =3D=3D 32) {
>>  >>  +            shift =3D 0;
>>  >>  +            half_complete =3D true;
>>  >>  +        }
>>  >>  +	}
>>  >>  +	kfree(buf);
>>  >>  +
>>  >
>>  > If you don't insist on using commas, I think it is much simpler to
>>  > parse it using `sscanf()`, e.g.:
>>  >
>>  >   unsigned int temp, prct;
>>  >   int at =3D 0, len;
>>  >
>>  >   while (sscanf(&buf[at], "%u:%u %n", &temp, &prct, &len) =3D=3D 2) {
>>  >     /* process `temp` and `prct` */
>>  >
>>  >     at +=3D len;
>>  >   }
>>  >
>>  >   if (buf[at] !=3D '\0')
>>  >     /* error */;
>>  >
>>  > This also has the advantage that you don't need dynamic memory
>>  > allocation.
>>=20
>>  Half the reason I did it in the format of 10:20,30:40,.. is to keep
>>  close to a format that many people using some external tools for fan
>>  curves (using acpi_call modue!) are using. I'm open to improvements=20
>> ofc.
>>=20
>=20
> If you don't insist on *requiring* commas, then I think the following=20
> works:
>=20
>   while (sscanf(&buf[at], "%u:%u %n", &temp, &prct, &len) =3D=3D 2) {
>     /* process `temp` and `prct` */
>=20
>     at +=3D len;
>     at +=3D strspn(&buf[at], ",");
>   }
>=20
> But please, whatever parser you end up submitting, make sure it is=20
> thoroughly tested.
>=20
>=20
>>  [...]
>>  >>  +static ssize_t gpu_fan_curve_quiet_show(struct device *dev,
>>  >>  +				   struct device_attribute *attr, char *buf)
>>  >>  +{
>>  >>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  >>  +	return scnprintf(buf, PAGE_SIZE, "%s",=20
>> asus->gpu_fan_curve.quiet);
>>  >>  +}
>>  >>  +
>>  >>  +static ssize_t gpu_fan_curve_quiet_store(struct device *dev,
>>  >>  +				    struct device_attribute *attr,
>>  >>  +				    const char *buf, size_t count)
>>  >>  +{
>>  >>  +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  >>  +    return fan_curve_store(asus, buf, count,
>>  >> ASUS_WMI_DEVID_GPU_FAN_CURVE,
>>  >>  +							&asus->gpu_fan_curve.quiet,
>>  >>  +							asus->gpu_fan_curve.quiet_default);
>>  >>  +}
>>  >>  +
>>  >>  +static DEVICE_ATTR_RW(gpu_fan_curve_quiet);
>>  >
>>  > Even though it is a hwmon thing, I think `SENSOR_ATTR_2()` (from
>>  > linux/hwmon-sysfs.h)
>>  > would be very useful here as you'd avoid creating n+1 functions,=20
>> e.g:
>>  >
>>  >   static ssize_t fan_curve_show(struct device *dev, struct
>>  > device_attribute *attr, char *buf)
>>  >   {
>>  >     struct sensor_device_attribute_2 *sattr =3D
>>  > to_sensor_dev_attr_2(attr);
>>  >     struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  >
>>  >     /*
>>  >      * if you stored fan curves in an array, you could then access
>>  > the fan
>>  >      * curve in `asus->fans[sattr->index].curves[sattr->nr]`
>>  >      * /
>>  >   }
>>  >
>>  >   static SENSOR_DEVICE_ATTR_2(some_name1, 0644, fan_curve_show,
>>  > fan_curve_store,
>>  >                               FAN_CPU /* index in the "fans"=20
>> array */,
>>  >                               ASUS_THROTTLE_THERMAL_POLICY_SILENT=20
>> /*
>>  > index in the "curves" array */);
>>  >
>>=20
>>  I'm sorry I don't really understand how this works. Is there a good=20
>> doc
>>  for it anywhere? Being unfamiliar with C makes it look a little more
>>  intimidating than what I've managed to do so far.
>>=20
>=20
> I am not sure, you can find some uses among hwmon drivers.
>=20
> If you look into linux/hwmon-sysfs.h, then you can see that=20
> `SENSOR_DEVICE_ATTR_2()`
> defines and initializes a `struct sensor_device_attribute_2` object:
>=20
>   struct sensor_device_attribute_2 {
>     struct device_attribute dev_attr;
>     u8 index;
>     u8 nr;
>   };
>=20
> So it has a normal device attribute inside it, and two extra pieces=20
> of data.
> One difference is that when you create the `struct attribute` array
> (`platform_attributes`), then you will need to use=20
> `&some_name1.dev_attr.attr`.
>=20
> And the idea here is that the show/store callbacks receive a pointer=20
> to the
> device attribute that is being read/written, and we know for a fact,=20
> that this
> device attribute is inside a `sensor_device_attribute_2` struct. And=20
> thus we can
> use the `to_sensor_dev_attr_2()` macro to get a pointer to the "outer"
> `sensor_device_attribute_2` struct that contains the=20
> `device_attribute` struct
> that we have a pointer to.
>=20
> So now the `index` and `nr` members of that struct can be accessed.=20
> You could
> store the index of the fan (e.g. 0 for CPU, 1 for GPU) in `index`,=20
> and the profile
> in `nr`. The `ASUS_THROTTLE_THERMAL_POLICY_*` macros go from 0 to 2,=20
> so I think
> those would be perfect candidates for the curve index. That's why I=20
> used
> `ASUS_THROTTLE_THERMAL_POLICY_SILENT` in the example.
>=20
> The fan curve associated with the attribute can now be
> accessed in `asus->fans[sattr->index].curves[sattr->nr]`.
>=20
> `to_sensor_dev_attr_2()` is just a wrapper around `container_of()`,=20
> so if you're
> familiar with the idea behind that, this shouldn't be too hard to=20
> wrap your
> head around.
>=20
>   #define to_sensor_dev_attr_2(_dev_attr) \
>     container_of(_dev_attr, struct sensor_device_attribute_2,=20
> dev_attr)
>=20
> What it does, is that if you give it a pointer to the `dev_attr`=20
> member of a
> `struct sensor_device_attribute_2`, then it'll give you back a pointer
> to the `struct sensor_device_attribute_2`. `container_of()` basically=20
> does a
> "conversion" from pointer-to-member-of-struct-X to=20
> pointer-to-struct-X.
>=20
> In some sense, you might think of `struct device_attribute` as the=20
> "base class",
> and the `struct sensor_device_attribute_2` as the "derived class"=20
> here. And what
> `to_sensor_dev_attr_2()` is a down-cast from the base class to the=20
> derived,
> e.g. something like this in C++:
>=20
>   struct device_attribute { ... };
>   struct sensor_device_attribute_2 : device_attribute {
>     u8 index;
>     u8 nr;
>   };
>=20
>   /* `device_attr` is of type `struct device_attribute *` */
>   static_cast<sensor_device_attribute_2 *>(device_attr);
>   /* there's also dynamic_cast which can do the same down-cast,
>      but it does runtime type checking as well */
>   /* both of the mentioned C++ casts check if the pointer is nullptr,
>      normal container_of() does not that, but there is=20
> container_of_safe() */
>=20
> It may be too detailed, I'm not sure; please let me know if you have=20
> other questions.
>=20
>=20
>>  [...]
>=20
>=20
> Best regards,
> Barnab=E1s P=F5cze



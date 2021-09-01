Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF0C3FE529
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242801AbhIAWCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:02:46 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:49221 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232860AbhIAWCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:02:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B700D3200124;
        Wed,  1 Sep 2021 18:01:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Sep 2021 18:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=eD2Cp1itsRC6wxZANFuIexTHV/hakXfB0J2wP7kN2
        CA=; b=iE3bNH4VTtaonrnWiYCkd3Q2rfCo7Vhrm9r4U3mbUf+AX4ADuuivIrNf8
        eNB126mKq6/wXVEDUN6UvqYNUkfKFe35Fc7FkYokkp/HGjMcMqa+2eb2bHQu8gIZ
        FHhQ9MgDZQIDxU61Aoxkmio6BopT6d9dccLsshOpP9JKLFVLAlBFAVPihh9G91L0
        uGuc0fUmgJTbVesDui5cmvl5bJuctyryDw53/qWi/oxjANnUBjf9Bh7fYVtieZVm
        AlWZjuE5AYh1qVJ6wnduE+O3ElNFX/8D7jgJfaOD3z/0POovgVuFXCUgNxgvm95U
        TWAnrpmb+ROIXbht5b3bD7xF/8Fug==
X-ME-Sender: <xms:SfgvYdMFC9_0-y_GqEWvzgYIb_xMRR2hKIjB0aVtWBqZ8jRxgiBjKg>
    <xme:SfgvYf8oZ39cXFds_usPIAw1vu-jtPBvJ-FFaCnst3ZDkYCGyHXExOHDdyMNimtmC
    olkzCVbPrvWQYYMo_g>
X-ME-Received: <xmr:SfgvYcTmNdJuCyfw3KcA9F6pwJvwDIoGl2EaXyZ1xXcfJoZ0SET3SWSKHRGtxORbcCNrYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvffkjghfofggtgfgsehtqh
    ertdertdhsnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghs
    rdguvghvqeenucggtffrrghtthgvrhhnpeefleetjeeihffgveeiffelleeuteeiueejff
    evkeduteegfeelffehleduhfdtffenucffohhmrghinhepghhithhlrggsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:SfgvYZvF2uf3GatXtZ3kTBdnwVZsnrmAmapWONDFb8XnadTG9BhwbA>
    <xmx:SfgvYVcp1xY4G9je8bcoUv0zJI-MnCnXwMBDTwEr0rkuy-ZwuqFqvA>
    <xmx:SfgvYV1g2xcq6emHhukedlDzFCQXzZozl_d8eeGGr9HPFnD9tHFdFg>
    <xmx:SvgvYWpqx1Nl1syu5GjjKiV-lchSowMUIo9lFWXx7OqaM3jUWlwI-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 18:01:40 -0400 (EDT)
Date:   Thu, 02 Sep 2021 10:01:24 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v7] asus-wmi: Add support for custom fan curves
To:     =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org
Message-Id: <CUZRYQ.HUS5YU6QXUBU@ljones.dev>
In-Reply-To: <Z3uTWHyeRPzaHU0iSW56m1ltGsYr5DOfRoJLyGlfnObU0ph-mVf9M6KCbSV66AeY_voEARTrP6bOtqXS1ZubuSj4Cu25VSRu0VMBIf3whow=@protonmail.com>
References: <20210830113137.1338683-1-luke@ljones.dev>
        <20210830113137.1338683-2-luke@ljones.dev>
        <1o94oJFiia_xvrFrSPI_zG1Xfv4FAlJNY96x39rg-zX3-3N5Czw4KmTiJtzCy1So7kYXLu0FTkRkmwUUudeuTyLHSsx5sJGhfsZaYrXKEic=@protonmail.com>
        <BLFOYQ.DC67MOSNFFNW2@ljones.dev>
        <Z3uTWHyeRPzaHU0iSW56m1ltGsYr5DOfRoJLyGlfnObU0ph-mVf9M6KCbSV66AeY_voEARTrP6bOtqXS1ZubuSj4Cu25VSRu0VMBIf3whow=@protonmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Sep 1 2021 at 15:24:40 +0000, Barnab=E1s P=F5cze=20
<pobrn@protonmail.com> wrote:
> Hi
>=20
>=20
>>  [...]
>>  >>  --- a/drivers/platform/x86/asus-wmi.c
>>  >>  +++ b/drivers/platform/x86/asus-wmi.c
>>  >>  [...]
>>  >>  +/*
>>  >>  + * Returns as an error if the method output is not a buffer.
>>  >> Typically this
>>  >
>>  > It seems to me it will simply leave the output buffer=20
>> uninitialized
>>  > if something
>>  > other than ACPI_TYPE_BUFFER and ACPI_TYPE_INTEGER is encountered=20
>> and
>>  > return 0.
>>=20
>>  Oops, see below inline reply:
>>=20
>>  >
>>  >
>>  >>  + * means that the method called is unsupported.
>>  >>  + */
>>  >>  +static int asus_wmi_evaluate_method_buf(u32 method_id,
>>  >>  +		u32 arg0, u32 arg1, u8 *ret_buffer)
>>  >>  +{
>>  >>  +	struct bios_args args =3D {
>>  >>  +		.arg0 =3D arg0,
>>  >>  +		.arg1 =3D arg1,
>>  >>  +		.arg2 =3D 0,
>>  >>  +	};
>>  >>  +	struct acpi_buffer input =3D { (acpi_size) sizeof(args), &args=20
>> };
>>  >>  +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
>>  >>  +	acpi_status status;
>>  >>  +	union acpi_object *obj;
>>  >>  +	u32 int_tmp =3D 0;
>>  >>  +
>>  >>  +	status =3D wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
>>  >>  +				     &input, &output);
>>  >>  +
>>  >>  +	if (ACPI_FAILURE(status))
>>  >>  +		return -EIO;
>>  >>  +
>>  >>  +	obj =3D (union acpi_object *)output.pointer;
>>  >>  +
>>  >>  +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
>>  >>  +		int_tmp =3D (u32) obj->integer.value;
>>  >>  +		if (int_tmp =3D=3D ASUS_WMI_UNSUPPORTED_METHOD)
>>  >>  +			return -ENODEV;
>>  >>  +		return int_tmp;
>>  >
>>  > Is anything known about the possible values? You are later
>>  > using it as if it was an errno (e.g. in=20
>> `custom_fan_check_present()`).
>>  >
>>  > And `obj` is leaked in both of the previous two returns.
>>=20
>>  The return for the method we're calling in this patch returns 0 if=20
>> the
>>  input arg has no match.
>>=20
>>  >
>>  >
>>  >>  +	}
>>  >>  +
>>  >>  +	if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER)
>>  >>  +		memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
>>  >
>>  > I would suggest you add a "size_t size" argument to this=20
>> function, and
>>  > return -ENOSPC/-ENODATA depending on whether the returned buffer=20
>> is
>>  > too
>>  > big/small. Maybe return -ENODATA if `obj` is NULL, too.
>>=20
>>  Got it. So something like this would be suitable?
>>=20
>>  	if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER)
>>  		if (obj->buffer.length < size)
>>  			err =3D -ENOSPC;
>>  		if (!obj->buffer.length)
>>  			err =3D -ENODATA;
>>  		if (err) {
>>  			kfree(obj);
>>  			return err;
>>  		}
>>  		memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
>>  	}
>>=20
>>  	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
>>  		int_tmp =3D (u32) obj->integer.value;
>>=20
>>  	kfree(obj);
>>=20
>>  	if (int_tmp =3D=3D ASUS_WMI_UNSUPPORTED_METHOD)
>>  		return -ENODEV;
>>=20
>>  	/* There is at least one method that returns a 0 with no buffer */
>>  	if (obj =3D=3D NULL || int_tmp =3D=3D 0)
>>  		return -ENODATA;
>>=20
>>  	return 0;
>>=20
>=20
> I had something like the following in mind:
>=20
>   int err =3D 0;
>   /* ... */
>   obj =3D output.pointer;
>   if (!obj)
>     return -ENODATA;
>=20
>   switch (obj->type) {
>   case ACPI_TYPE_BUFFER:
>     if (obj->buffer.length < size)
>       err =3D -ENODATA;
>     else if (obj->buffer.length > size)
>       err =3D -ENOSPC;
>     else
>       memcpy(ret_buffer, obj->buffer.pointer, size);
>     break;
>   case ACPI_TYPE_INTEGER:
>     switch (obj->integer.value) {
>       case ASUS_WMI_UNSUPPORTED_METHOD:
>         err =3D -EOPNOTSUPP;
> 	break;
>       default:
>         err =3D -ENODATA;
> 	break;
>     }
>     break;
>   default:
>     err =3D -ENODATA;
>     break;
>   }
>=20
>   kfree(obj);
>=20
>   return err;
>=20

Got it. Sometimes I forget switch/case exists. I'll adjust the v8 patch=20
I sent out earlier.

>=20
>>  >
>>  >
>>  >>  +
>>  >>  +	kfree(obj);
>>  >>  +
>>  >>  +	return 0;
>>  >>  +}
>>  [...]
>>  >>  +/*
>>  >>  + * Called only by throttle_thermal_policy_write()
>>  >>  + */
>>  >
>>  > Am I correct in thinking that the firmware does not actually
>>  > support specifying fan curves for each mode, only a single one,
>>  > and the fan curve switching is done by this driver when
>>  > the performance mode is changed?
>>=20
>>  I'm not 100% certain on this. The WMI method 0x00110024 takes an arg
>>  0,1,2 which then returns some factory stored fan profiles, these fit
>>  the profiles of ASUS_THROTTLE_THERMAL_POLICY_*, but with 1 and 2
>>  swapped.
>>=20
>>  Looking at the SET part, it seems to write to a different location=20
>> than
>>  where the GET is fetching information.
>>=20
>=20
> The, unfortunately, that is not as simple as I initially thought...

We can add the fact that a variation exists with a more typical setup=20
also. The G713Q has no throttle_thermal and in the dsdt dump looks like=20
it possible can read back the curve that is set by the user. This works=20
in our favour though.

>=20
>=20
>>  Because of the fact there are three sets of curves to get, I=20
>> thought it
>>  would be good for users to be able to set per profile. I don't think
>>  the set is retained in acpi if the profile is switched.
>>=20
>>  Do you think it would be best to not have the ability to store per
>>  profile in kernel?
>=20
> If there was a method to set a fan curve, and one to retrieve it,
> I would suggest just exposing that via the pwmN_auto_pointM_{pwm,temp}
> attributes on a hwmon device, and that the profile-dependent switching
> be implemented somewhere else. As far as I see, there is already
> existing infrastructure for integrating such a feature [0]
> (but please correct me if I'm wrong).

There is. I develop asusctl in conjunction with these patches. I'd=20
certainly like to find the best way to fit all of this together.

>=20
> This would simplify the kernel code, add no new ABI, and
> potentially provide greater control over policy for the
> user space.

I agree.

>=20
>=20
>>  How would I choose which profile get to populate the
>>  initial data with if so?
>=20
> I assume there isn't a method that can query
> the current fan curve (or it is unknown)?

It looks like I need to adjust how pwm[n]_enable works anyway:

`pwm[1-*]_enable`
Fan speed control method:
- 0: no fan speed control (i.e. fan at full speed)
- 1: manual fan speed control enabled (using `pwm[1-*]`)
- 2+: automatic fan speed control enabled

So maybe on "manual" I can make it so the get method does what is in=20
fan_curve_check_present() (and change that part also) and fetches the=20
"defaults" on enable. This might even give us the fan curve that was=20
set (and looks like it will on the machine that has no thermal throttle=20
profile, v8 patch) - I'll try this anyway and see what it looks like.=20
This seems to be the best approach given how the G713Q works anyway.

The issue I have with the above is that it overwrites any curve set.=20
But given that it'll most likely be managed in userspace that's maybe=20
*not* an issue. Otherwise would it be sensible to add something like=20
`pwm1_reset`? I don't see anything like that in the related docs=20
though. `pwm1_reset` would be to re-read the defaults from the acpi=20
method.

Central to the above is that we can still read 0, 1, 2 curves from acpi=20
- I was thinking to use the throttle_thermal mode to choose which one=20
and that would be the only use of it. And won't store them as=20
per-profile, which becomes a moot point when userspace is managing it=20
anyway.

Many thanks,
Luke.


>=20
>=20
>>  [...]
>=20
> [0]: https://gitlab.com/asus-linux/asusctl
>=20
>=20
> Best regards,
> Barnab=E1s P=F5cze



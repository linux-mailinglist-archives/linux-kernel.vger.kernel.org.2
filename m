Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9D33CBF9B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 01:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhGPXMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 19:12:44 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:49537 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231293AbhGPXMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 19:12:42 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6B8F53200940;
        Fri, 16 Jul 2021 19:09:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 16 Jul 2021 19:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=pLA6ljGCHmS4nzSzhKkQ7EBOtuCU9nTxikkq8KQJL
        +k=; b=bbWSUkkPu11wL919+4j2qyK7TFP8iJ3w3QTtECklvt7tzB54hYxbp61IH
        ULmdWxee1sE03ozyFPC/H2pAwVESmHMJWEjG/JYAwlZ1oM58LFGQ9g9KUlqKvtXZ
        fSjBJ+yvxgGOgNPXDyJVrJlI9o8u0ZhzWmpA12hM7Dg/dvu4GF0HIwCEdmkXR/en
        Z7K8l266BxC2WnKNdWiaWB2vJCrz6oNjqCzZKy33ABhzBiRCM/DTjFFAe32O0eRz
        Ucuf/okhjuY/SF6MCVoGVdmy7bytrhanhMZOeVnU3Y8Yg+u1WlZzUWwJx08zJeHY
        t/HYqbCFooNPCGpvX3FH/yh+Wyljw==
X-ME-Sender: <xms:uRHyYJ6la8VonaN_xaxzcMjy6qmFf1CRZ7v0hbO-EnVusiYs5EUGGQ>
    <xme:uRHyYG6UP78YEQrI82tWsA1kSbSx1sM_V3tqB3P50nAuHY97D4_O9MLrhymD6UZ58
    Pb97mZPZc2aopBfVVM>
X-ME-Received: <xmr:uRHyYAdfNb5DFJnGv8UmE_OAUw6WF7UCo4VWUroMe3SykSHo84lJREd0E2gHl4nl8Ceyrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdeggdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhuffvkfgjfhfogggtgfesthhqre
    dtredtshenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdr
    uggvvheqnecuggftrfgrthhtvghrnhepkeevffeiheeuleegleetveelhedutefhhfegff
    etvedtfefgleelgeetleekgfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:uRHyYCIsceFDqS4AJQq0l9av9dmcuO4iyaeMsY52l5it7hQv2MwzrA>
    <xmx:uRHyYNIachKVqbDo1OFXLVZokn5q_UXGDfrHtxxUD3qXnuXha6qhKw>
    <xmx:uRHyYLyzLLVux3VtKn4CbavBLJ3SfwZttUt7swl8NNIQEchD7w4JtQ>
    <xmx:uhHyYLiDjCscWLNtblRIQ_6LhZAwgTGz07mBWaX9MsdhAJs4CfrqUA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jul 2021 19:09:37 -0400 (EDT)
Date:   Sat, 17 Jul 2021 11:09:19 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 2/3] asus-wmi: Add dgpu disable method
To:     =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>
Cc:     hdegoede@redhat.com, corentin.chary@gmail.com,
        mgross@linux.intel.com, jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <JN1DWQ.EEHJJGGRQTP72@ljones.dev>
In-Reply-To: <knw744OJB1AYrrFpo77N1Eei0JZC3SjKzg6SMoMhOsEchAiE8-klOIPTyFCAUSiVeTopPNqgFSefQJ2av6Gs_cS4TuIRXVQcHUxvw8YvSl0=@protonmail.com>
References: <20210704222148.880848-1-luke@ljones.dev>
        <20210704222148.880848-3-luke@ljones.dev>
        <knw744OJB1AYrrFpo77N1Eei0JZC3SjKzg6SMoMhOsEchAiE8-klOIPTyFCAUSiVeTopPNqgFSefQJ2av6Gs_cS4TuIRXVQcHUxvw8YvSl0=@protonmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the insightful feedback.

On Mon, Jul 5 2021 at 00:47:31 +0000, Barnab=E1s P=F5cze=20
<pobrn@protonmail.com> wrote:
> Hi
>=20
> I have added a couple comments inline.
>=20
>=20
> 2021. j=FAlius 5., h=E9tf=F5 0:21 keltez=E9ssel, Luke D. Jones =EDrta:
>=20
>>  In Windows the ASUS Armory Crate progrm can enable or disable the
>                                         ^
> "program"
>=20
My "a" key is a little hard to press sometimes :(

>=20
>>  dGPU via a WMI call. This functions much the same as various Linux
>>  methods in software where the dGPU is removed from the device tree.
>>=20
>>  However the WMI call saves the state of dGPU enabled or not and this
>=20
> I think "[...] the WMI call saves whether the dGPU is enabled or not,=20
> and [...]"
> might be better.
> Or "[...] the WMI call saves the state of the dGPU (enabled or not)=20
> and [...]".
>=20
I've used the second option, thanks for pointing this out.

>=20
>>  then changes the dGPU visibility in Linux with no way for Linux
>>  users to re-enable it. We expose the WMI method so users can see
>>  and change the dGPU ACPI state.
>>=20
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   drivers/platform/x86/asus-wmi.c            | 98=20
>> ++++++++++++++++++++++
>>   include/linux/platform_data/x86/asus-wmi.h |  3 +
>>   2 files changed, 101 insertions(+)
>>=20
>>  diff --git a/drivers/platform/x86/asus-wmi.c=20
>> b/drivers/platform/x86/asus-wmi.c
>>  index 2468076d6cd8..8dc3f7ed021f 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -210,6 +210,9 @@ struct asus_wmi {
>>   	u8 fan_boost_mode_mask;
>>   	u8 fan_boost_mode;
>>=20
>>  +	bool dgpu_disable_available;
>>  +	u8 dgpu_disable_mode;
>>  +
>>   	bool throttle_thermal_policy_available;
>>   	u8 throttle_thermal_policy_mode;
>>=20
>>  @@ -427,6 +430,93 @@ static void=20
>> lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
>>   	}
>>   }
>>=20
>>  +/* dGPU=20
>> ********************************************************************/
>>  +static int dgpu_disable_check_present(struct asus_wmi *asus)
>>  +{
>>  +	u32 result;
>>  +	int err;
>>  +
>>  +	asus->dgpu_disable_available =3D false;
>>  +
>>  +	err =3D asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_DGPU, &result);
>>  +	if (err) {
>>  +		if (err =3D=3D -ENODEV)
>>  +			return 0;
>>  +		return err;
>>  +	}
>>  +
>>  +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
>>  +		asus->dgpu_disable_available =3D true;
>>  +		asus->dgpu_disable_mode =3D result & ASUS_WMI_DSTS_STATUS_BIT;
>>  +
>=20
> Aren't braces missing here?
>=20
Yep. Fixed.

>=20
>>  +	return 0;
>>  +}
>>  +
>>  +static int dgpu_disable_write(struct asus_wmi *asus)
>>  +{
>>  +	int err;
>>  +	u8 value;
>>  +	u32 retval;
>>  +
>>  +	value =3D asus->dgpu_disable_mode;
>>  +
>>  +	err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
>>  +
>>  +	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
>>  +			"dgpu_disable");
>=20
> A similar line with the exact same length in patch 3/3 is not broken=20
> in two.
> And shouldn't the notification be sent if the operation succeeded?
>=20
Fixed. I moved the sysfs_notify down below the error returns.
>=20
>>  +
>>  +	if (err) {
>>  +		pr_warn("Failed to set dgpu disable: %d\n", err);
>>  +		return err;
>>  +	}
>>  +
>>  +	if (retval > 1 || retval < 0) {
>>  +		pr_warn("Failed to set dgpu disable (retval): 0x%x\n",
>>  +			retval);
>>  +		return -EIO;
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static ssize_t dgpu_disable_show(struct device *dev,
>>  +				   struct device_attribute *attr, char *buf)
>>  +{
>>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +	u8 mode =3D asus->dgpu_disable_mode;
>>  +
>>  +	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
>=20
> You could use `sysfs_emit()`.
>=20
Thanks. Many things like this I'm actually unaware of. Most of these=20
patches are done by reading existing code.

>=20
>>  +}
>>  +
>>  +static ssize_t dgpu_disable_store(struct device *dev,
>>  +				    struct device_attribute *attr,
>>  +				    const char *buf, size_t count)
>>  +{
>>  +	int result;
>>  +	u8 disable;
>>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +
>>  +	result =3D kstrtou8(buf, 10, &disable);
>=20
> You could use `kstrtobool()`. I think that would be better since it=20
> accepts
> 'y', 'n', etc. in addition to 0 and 1.
>=20
Thanks! Wasn't aware of that. And since the setting for all 3 patches=20
can only ever be 0/1 I've changed to use a bool instead of u8

>=20
>>  +	if (result < 0)
>>  +		return result;
>>  +
>>  +	if (disable > 1 || disable < 0)
>>  +		return -EINVAL;
>>  +
>>  +	asus->dgpu_disable_mode =3D disable;
>>  +	/*
>>  +	 * The ACPI call used does not save the mode unless the call is=20
>> run twice.
>>  +	 * Once to disable, then once to check status and save - this is=20
>> two code
>>  +	 * paths in the method in the ACPI dumps.
>>  +	*/
>>  +	dgpu_disable_write(asus);
>>  +	dgpu_disable_write(asus);
>=20
> Is there any reason the potential error codes are not returned?
>=20
No I've fixed now. Guess I missed it.

>=20
>>  +
>>  +	return count;
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(dgpu_disable);
>>  +
>>   /* Battery=20
>> ********************************************************************/
>>=20
>>   /* The battery maximum charging percentage */
>>  @@ -2412,6 +2502,7 @@ static struct attribute=20
>> *platform_attributes[] =3D {
>>   	&dev_attr_camera.attr,
>>   	&dev_attr_cardr.attr,
>>   	&dev_attr_touchpad.attr,
>>  +	&dev_attr_dgpu_disable.attr,
>>   	&dev_attr_lid_resume.attr,
>>   	&dev_attr_als_enable.attr,
>>   	&dev_attr_fan_boost_mode.attr,
>>  @@ -2438,6 +2529,8 @@ static umode_t asus_sysfs_is_visible(struct=20
>> kobject *kobj,
>>   		devid =3D ASUS_WMI_DEVID_LID_RESUME;
>>   	else if (attr =3D=3D &dev_attr_als_enable.attr)
>>   		devid =3D ASUS_WMI_DEVID_ALS_ENABLE;
>>  +	else if (attr =3D=3D &dev_attr_dgpu_disable.attr)
>>  +		ok =3D asus->dgpu_disable_available;
>>   	else if (attr =3D=3D &dev_attr_fan_boost_mode.attr)
>>   		ok =3D asus->fan_boost_mode_available;
>>   	else if (attr =3D=3D &dev_attr_throttle_thermal_policy.attr)
>>  @@ -2699,6 +2792,10 @@ static int asus_wmi_add(struct=20
>> platform_device *pdev)
>>   	if (err)
>>   		goto fail_platform;
>>=20
>>  +	err =3D dgpu_disable_check_present(asus);
>>  +	if (err)
>>  +		goto fail_dgpu_disable;
>>  +
>=20
> Should this really be considered a "fatal" error?
>=20
I was modelling this on fail_fan_boost_mode and=20
fail_throttle_thermal_policy since a laptop can't have both of those=20
which indicates that a failed one is fine, it seemed appropriate to=20
follow the same behaviour here

>=20
>>   	err =3D fan_boost_mode_check_present(asus);
>>   	if (err)
>>   		goto fail_fan_boost_mode;
>>  @@ -2799,6 +2896,7 @@ static int asus_wmi_add(struct=20
>> platform_device *pdev)
>>   fail_sysfs:
>>   fail_throttle_thermal_policy:
>>   fail_fan_boost_mode:
>>  +fail_dgpu_disable:
>>   fail_platform:
>>   fail_panel_od:
>>   	kfree(asus);
>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h=20
>> b/include/linux/platform_data/x86/asus-wmi.h
>>  index 428aea701c7b..a528f9d0e4b7 100644
>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>  @@ -90,6 +90,9 @@
>>   /* Keyboard dock */
>>   #define ASUS_WMI_DEVID_KBD_DOCK		0x00120063
>>=20
>>  +/* dgpu on/off */
>>  +#define ASUS_WMI_DEVID_DGPU		0x00090020
>>  +
>>   /* DSTS masks */
>>   #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>>   #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
>>  --
>>  2.31.1
>=20
>=20
> Regards,
> Barnab=E1s P=F5cze

Many thanks for your feedback again.
Luke.



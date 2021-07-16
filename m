Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F053CBF9E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 01:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhGPXPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 19:15:53 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:48955 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231293AbhGPXPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 19:15:52 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 50742320090B;
        Fri, 16 Jul 2021 19:12:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 16 Jul 2021 19:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=fA+1HODoZQcutj798yq9JulkSr255lZt5DkzNMvK9
        Do=; b=oRvFvChLCLTyOJOq14eWCBueyuxDZIJ9KEOg+znza11TPiYdO27FzlXGD
        W869JSQwD0732/MVYAeA/JHCeBTInVpaFUyf176YV4LJcklte6bn4nfhZ+Nt7z6R
        FsWr3qsUJdhLCov3cCRniReg2vkNuwMRMPZvxVN/bx+bvXPEsWsxyAlpuFdmv+a8
        FqaR5teI2IuPIto0rdDH96QcGG03rK99fw88NGw4qew1MBZTIgpt1ZuOK9PrVdaO
        BmU/UCVjmYmNDFokiefiVFkP23fXtnVQU/w6FQT3XiRRgjDRWphkZiJqjbgipqdK
        DOiVNK1fsENAkKCUe8FaXiMLNUCcA==
X-ME-Sender: <xms:dhLyYM3mDjEasbkbE8eyimTykasQfEJt_1Vjd-1hiv60kHD7AXOJlQ>
    <xme:dhLyYHGPphkeux5Il8GzTKUZT9Qx1l9YhiVN-So-fua-Mer7IsP82XBoyX-D7Gutd
    WPybWWUtkj5632l4RU>
X-ME-Received: <xmr:dhLyYE7xVsL0C0O8EESL4b5PTHu_akyYvHAH8F4mhifDDD8SbmKRMRBd1TKgHdw59mJe_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdeggdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvffkjghfofggtgfgsehtqhertdertddunecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    dvvdeufefhvdfhgedukeffudejfeejleefkefgheeujeefjeejkeeviefgueduudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslh
    hjohhnvghsrdguvghv
X-ME-Proxy: <xmx:dhLyYF0-nDiSy5TeD5bdYmq3Ca98ZLqHbpe0y5EA4Pl-EhuywtzUHA>
    <xmx:dhLyYPHfjdpHOKy-qra5-3Z-vJkM0276nGvMOCc3LtoQrcEYjiuszQ>
    <xmx:dhLyYO97rXZQXl53Xcrh3S-PZ7RNeps6Qo-BkRrj2HyhYxw92JodEg>
    <xmx:dxLyYDj_xYctAW5OwWH1mL8chzj-tdXLsw0f741sr5QWXtMqx5NQHA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jul 2021 19:12:47 -0400 (EDT)
Date:   Sat, 17 Jul 2021 11:12:31 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 2/3] asus-wmi: Add dgpu disable method
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     corentin.chary@gmail.com, mgross@linux.intel.com,
        jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <VS1DWQ.9BA41EL19VZC1@ljones.dev>
In-Reply-To: <fa826d11-6cc6-be22-2a8b-b8a76248a5d4@redhat.com>
References: <20210704222148.880848-1-luke@ljones.dev>
        <20210704222148.880848-3-luke@ljones.dev>
        <fa826d11-6cc6-be22-2a8b-b8a76248a5d4@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Hans, all feedback applied.

On Tue, Jul 6 2021 at 12:10:45 +0200, Hans de Goede=20
<hdegoede@redhat.com> wrote:
> Hi,
>=20
> Some review remarks inline (mostly just echo-ing what Barnab=E1s=20
> already said):
>=20
> On 7/5/21 12:21 AM, Luke D. Jones wrote:
>>  In Windows the ASUS Armory Crate progrm can enable or disable the
>>  dGPU via a WMI call. This functions much the same as various Linux
>>  methods in software where the dGPU is removed from the device tree.
>>=20
>>  However the WMI call saves the state of dGPU enabled or not and this
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
>=20
> Missing {}
>=20
>>  +
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
> Make this one line please.
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
>=20
> Make this one line please.
>=20
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
> sysfs_emit() please.
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
>>  +	if (result < 0)
>>  +		return result;
>>  +
>>  +	if (disable > 1 || disable < 0)
>>  +		return -EINVAL;
>=20
> Drop the "disable < 0" check please.
>=20
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
>>=20
>=20
> Otherwise this looks good to me.
>=20
> Regards,
>=20
> Hans
>=20



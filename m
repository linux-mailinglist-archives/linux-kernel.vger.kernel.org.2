Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C3A3D4754
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhGXKfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 06:35:44 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53847 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232258AbhGXKfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 06:35:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6770B5C00FB;
        Sat, 24 Jul 2021 07:16:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 24 Jul 2021 07:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PFNFdy
        fdU5X2vymOxPQd7rD3K0B37oj83GtG5AXVzFQ=; b=QVTxQDAHR2/76x7TARwXn0
        ZK6CfO99KgcKHSxGSfAYqHyfyfIJ3np7lxJY+G6pbjix2KoLP82XYv8pZHeJa++3
        lHdnV0zpD2/3C0QaiUMBZcwXH2sIbJEsheRO2A1SvLjhHp0RAiDs1Eu0AvAeKxkN
        0IrX479HSRSzz4izAtJIZjZMMtlW9bUH5yluyvZTWh3FxXlI3SJkP8CZzkOkrXyv
        czqIkPK0Su4k/yhqqjFpJ6BsEIHRPHhtPgn9b1j1DoKKP0XrLsPr4r1G3DMMzazf
        QMYsoKMND0PXUFmKhDf2z50d/s7HpbhJbkAj5aNGvqhTpjSaCrRGAjyX/mVDR3Aw
        ==
X-ME-Sender: <xms:ffb7YGUysChcFQqBqqFJ1i_PJMPDdNM_IT8ZIxm5kVBPISu4tqDRYQ>
    <xme:ffb7YClPXvNMjWBYW9xI5VdL2pFi4YrVg9CuAvfVss5xlrkupRZM4n_GocsjUe8l3
    qzpz5Fv7BA43SeoiMs>
X-ME-Received: <xmr:ffb7YKbictnQZrNb9I1nVItzL932DKxmw3-xHLvM23-X-wJtrRtDPMj2fFf3bs2gQ8hybA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgedtgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvffkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgvucfl
    ohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgf
    effedufffhgfeuheegffffgeegveeifeeutefhieejffetudfgueevteehtdetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljh
    honhgvshdruggvvh
X-ME-Proxy: <xmx:ffb7YNUQd_dMal7IQNa_4pOV8CrtTAxi0m11kyeWCIgTqP_SnWk5nQ>
    <xmx:ffb7YAlNcc3sw3obDyhZCyw8yj01C3gCvKRJayfBgXoRaMZK8X2zhA>
    <xmx:ffb7YCd_ppfjr5rdizvXxV0gNe8PeolHEDVIvb1hhugGnJndVI_ibg>
    <xmx:fvb7YBCxdrPKy5HRSSopHz9UdPbzTb94FxAPHvoLSNE6diTDxR3lxQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jul 2021 07:16:06 -0400 (EDT)
Date:   Sat, 24 Jul 2021 23:15:50 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 3/4] asus-wmi: Add egpu enable method
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     pobrn@protonmail.com, mgross@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net
Message-Id: <EYXQWQ.O2RLFGQXKOHO2@ljones.dev>
In-Reply-To: <adb670de-e69a-6944-3d37-d2c0ef36d378@redhat.com>
References: <20210717081323.7925-1-luke@ljones.dev>
        <20210717081323.7925-3-luke@ljones.dev> <UXQDWQ.MHGH7K6W57R5@ljones.dev>
        <65RDWQ.DNBXEUQTBV352@ljones.dev>
        <adb670de-e69a-6944-3d37-d2c0ef36d378@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh I see, thanks. I was trying to do the "-v3" on send-email part.

On Sat, Jul 17 2021 at 17:57:54 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi Luke,
> 
> On 7/17/21 10:19 AM, Luke Jones wrote:
>>  Damn. I thought `-v2` on `git send-email` would bump patch version 
>> too. What is the correct way to do that for a full patch sequence?
> 
> You need to split the sending of patches into 2 steps, which 
> generally is a good
> idea anyways, since that will also allow you to easily add a 
> cover-letter to the
> series:
> 
> Lets say you are ready to send v3 and you have the 3 patches as the 
> last 3
> commits in your git tree's current HEAD, then you would do:
> 
> git format-patch --cover-letter -v3 HEAD~3
> $EDITOR v3-0000*.patch
> # Edit the cover letter, say something like:
> # Hi All here is v3 of my ... series, which does foobar
> # new in v3 is ...
> # And don't forget to set the Subject
> git send-email v3-00*.patch
> 
> And you're done. I hope this helps.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>> 
>>  On Sat, Jul 17 2021 at 20:15:30 +1200, Luke Jones <luke@ljones.dev> 
>> wrote:
>>>  Apologies, I forgot that the patches contain sequence. There is 
>>> actually no 4th patch (the patch itself was already upstreamed).
>>> 
>>>  Sincere regards,
>>>  Luke.
>>> 
>>>  On Sat, Jul 17 2021 at 20:13:23 +1200, Luke D. Jones 
>>> <luke@ljones.dev> wrote:
>>>>  The X13 Flow laptops can utilise an external GPU. This requires
>>>>  toggling an ACPI method which will first disable the internal
>>>>  dGPU, and then enable the eGPU.
>>>> 
>>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>  ---
>>>>   drivers/platform/x86/asus-wmi.c            | 91 
>>>> ++++++++++++++++++++++
>>>>   include/linux/platform_data/x86/asus-wmi.h |  3 +
>>>>   2 files changed, 94 insertions(+)
>>>> 
>>>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>>>> b/drivers/platform/x86/asus-wmi.c
>>>>  index 02762a60d27a..ee5d8656641e 100644
>>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>>  @@ -210,6 +210,9 @@ struct asus_wmi {
>>>>       u8 fan_boost_mode_mask;
>>>>       u8 fan_boost_mode;
>>>> 
>>>>  +    bool egpu_enable_available; // 0 = enable
>>>>  +    bool egpu_enable;
>>>>  +
>>>>       bool dgpu_disable_available;
>>>>       bool dgpu_disable;
>>>> 
>>>>  @@ -430,6 +433,86 @@ static void 
>>>> lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
>>>>       }
>>>>   }
>>>> 
>>>>  +/* eGPU 
>>>> ********************************************************************/
>>>>  +static int egpu_enable_check_present(struct asus_wmi *asus)
>>>>  +{
>>>>  +    u32 result;
>>>>  +    int err;
>>>>  +
>>>>  +    asus->egpu_enable_available = false;
>>>>  +
>>>>  +    err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_EGPU, 
>>>> &result);
>>>>  +    if (err) {
>>>>  +        if (err == -ENODEV)
>>>>  +            return 0;
>>>>  +        return err;
>>>>  +    }
>>>>  +
>>>>  +    if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
>>>>  +        asus->egpu_enable_available = true;
>>>>  +        asus->egpu_enable = result & ASUS_WMI_DSTS_STATUS_BIT;
>>>>  +    }
>>>>  +
>>>>  +    return 0;
>>>>  +}
>>>>  +
>>>>  +static int egpu_enable_write(struct asus_wmi *asus)
>>>>  +{
>>>>  +    int err;
>>>>  +    u8 value;
>>>>  +    u32 retval;
>>>>  +
>>>>  +    value = asus->egpu_enable;
>>>>  +
>>>>  +    err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, value, 
>>>> &retval);
>>>>  +
>>>>  +    if (err) {
>>>>  +        pr_warn("Failed to set egpu disable: %d\n", err);
>>>>  +        return err;
>>>>  +    }
>>>>  +
>>>>  +    if (retval > 1 || retval < 0) {
>>>>  +        pr_warn("Failed to set egpu disable (retval): 0x%x\n", 
>>>> retval);
>>>>  +        return -EIO;
>>>>  +    }
>>>>  +
>>>>  +    sysfs_notify(&asus->platform_device->dev.kobj, NULL, 
>>>> "egpu_enable");
>>>>  +
>>>>  +    return 0;
>>>>  +}
>>>>  +
>>>>  +static ssize_t egpu_enable_show(struct device *dev,
>>>>  +                   struct device_attribute *attr, char *buf)
>>>>  +{
>>>>  +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>  +    bool mode = asus->egpu_enable;
>>>>  +
>>>>  +    return sysfs_emit(buf, "%d\n", mode);
>>>>  +}
>>>>  +
>>>>  +static ssize_t egpu_enable_store(struct device *dev,
>>>>  +                    struct device_attribute *attr,
>>>>  +                    const char *buf, size_t count)
>>>>  +{
>>>>  +    int result;
>>>>  +    bool disable;
>>>>  +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>  +
>>>>  +    result = kstrtobool(buf, &disable);
>>>>  +    if (result == -EINVAL)
>>>>  +        return result;
>>>>  +
>>>>  +    asus->egpu_enable = disable;
>>>>  +
>>>>  +    result = egpu_enable_write(asus);
>>>>  +    if (result != 0)
>>>>  +        return result;
>>>>  +
>>>>  +    return count;
>>>>  +}
>>>>  +
>>>>  +static DEVICE_ATTR_RW(egpu_enable);
>>>>  +
>>>>   /* dGPU 
>>>> ********************************************************************/
>>>>   static int dgpu_disable_check_present(struct asus_wmi *asus)
>>>>   {
>>>>  @@ -2502,6 +2585,7 @@ static struct attribute 
>>>> *platform_attributes[] = {
>>>>       &dev_attr_camera.attr,
>>>>       &dev_attr_cardr.attr,
>>>>       &dev_attr_touchpad.attr,
>>>>  +    &dev_attr_egpu_enable.attr,
>>>>       &dev_attr_dgpu_disable.attr,
>>>>       &dev_attr_lid_resume.attr,
>>>>       &dev_attr_als_enable.attr,
>>>>  @@ -2529,6 +2613,8 @@ static umode_t asus_sysfs_is_visible(struct 
>>>> kobject *kobj,
>>>>           devid = ASUS_WMI_DEVID_LID_RESUME;
>>>>       else if (attr == &dev_attr_als_enable.attr)
>>>>           devid = ASUS_WMI_DEVID_ALS_ENABLE;
>>>>  +    else if (attr == &dev_attr_egpu_enable.attr)
>>>>  +        ok = asus->egpu_enable_available;
>>>>       else if (attr == &dev_attr_dgpu_disable.attr)
>>>>           ok = asus->dgpu_disable_available;
>>>>       else if (attr == &dev_attr_fan_boost_mode.attr)
>>>>  @@ -2792,6 +2878,10 @@ static int asus_wmi_add(struct 
>>>> platform_device *pdev)
>>>>       if (err)
>>>>           goto fail_platform;
>>>> 
>>>>  +    err = egpu_enable_check_present(asus);
>>>>  +    if (err)
>>>>  +        goto fail_egpu_enable;
>>>>  +
>>>>       err = dgpu_disable_check_present(asus);
>>>>       if (err)
>>>>           goto fail_dgpu_disable;
>>>>  @@ -2896,6 +2986,7 @@ static int asus_wmi_add(struct 
>>>> platform_device *pdev)
>>>>   fail_sysfs:
>>>>   fail_throttle_thermal_policy:
>>>>   fail_fan_boost_mode:
>>>>  +fail_egpu_enable:
>>>>   fail_dgpu_disable:
>>>>   fail_platform:
>>>>   fail_panel_od:
>>>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>>>> b/include/linux/platform_data/x86/asus-wmi.h
>>>>  index a528f9d0e4b7..17dc5cb6f3f2 100644
>>>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>>  @@ -90,6 +90,9 @@
>>>>   /* Keyboard dock */
>>>>   #define ASUS_WMI_DEVID_KBD_DOCK        0x00120063
>>>> 
>>>>  +/* dgpu on/off */
>>>>  +#define ASUS_WMI_DEVID_EGPU        0x00090019
>>>>  +
>>>>   /* dgpu on/off */
>>>>   #define ASUS_WMI_DEVID_DGPU        0x00090020
>>>> 
>>>>  --
>>>>  2.31.1
>>>> 
>>> 
>> 
>> 
> 



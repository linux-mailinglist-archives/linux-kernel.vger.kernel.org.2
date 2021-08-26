Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516503F85ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbhHZK5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:57:18 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38426 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241491AbhHZK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:57:16 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17Q5tlP8023865;
        Thu, 26 Aug 2021 05:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=rKbGnFewnvquiODNsJhrKCT/ltFar1VCwKiMo46phr4=;
 b=mtUwhHf/r/6OPjcv+AAhRvCQEs3tHWbVXh2AZTmzcSkiw1Phc1gFDs9D5QeC+YRdjcOL
 bkKIA7wuboYj5wYYaytGaYPbr6Xs6+gaWj1mJOkho2TAXpFS+SZLS4WQ3I7NqK+NNVMk
 dXNkhuvQ2G4hNAKiDBWUSLlJIVZx29wA6W6TfQiuEOinercjPvHxToK48kToQpW7B2lh
 l+5sZokVwDcxWi731BiulpxKXEAAn7n98/QrVik1vL6CMr186MzihCXyJTmiC5ZD65Sb
 FxMBcITCoGjEJANm/hSK/5FqtRjJeeqb0+5ZIifV5fGxuApVQBCHb4Au2oUXOgaJ+kru 9g== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3anr2esha4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Aug 2021 05:56:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 11:56:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 26 Aug 2021 11:56:15 +0100
Received: from [198.90.238.186] (unknown [198.90.238.186])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 09A312BA;
        Thu, 26 Aug 2021 10:56:14 +0000 (UTC)
Subject: Re: [PATCH 2/2] ALSA: hda/cs8409: Prevent pops and clicks during
 reboot
To:     Takashi Iwai <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
References: <20210812183433.6330-1-vitalyr@opensource.cirrus.com>
 <20210812183433.6330-2-vitalyr@opensource.cirrus.com>
 <s5h1r6xlvrs.wl-tiwai@suse.de> <s5hczqgil3v.wl-tiwai@suse.de>
 <6595e87d-1dae-b536-c17b-eafa07d04bbe@opensource.cirrus.com>
 <s5hpmuce05m.wl-tiwai@suse.de>
 <e3df5f97-bf43-7eb8-e15d-4ab11dbae7ef@opensource.cirrus.com>
 <s5hczq0yc72.wl-tiwai@suse.de> <s5hfsuwwkew.wl-tiwai@suse.de>
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <2974107a-787f-8788-2ee1-86b6c8055035@opensource.cirrus.com>
Date:   Thu, 26 Aug 2021 11:56:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <s5hfsuwwkew.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-GUID: SoaxBqdzVWYlswpM0hroqg8cXsUk-RLq
X-Proofpoint-ORIG-GUID: SoaxBqdzVWYlswpM0hroqg8cXsUk-RLq
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2021 11:49 am, Takashi Iwai wrote:
> On Thu, 26 Aug 2021 08:03:45 +0200,
> Takashi Iwai wrote:
>> On Wed, 25 Aug 2021 20:04:05 +0200,
>> Vitaly Rodionov wrote:
>>> Actually when codec is suspended and we do reboot from UI, then sometimes we
>>> see suspend() calls in kernel log and no pops, but sometimes
>>>
>>> we still have no suspend() on reboot and we hear pops. But when we do reboot
>>> from command line: > sudo reboot  then we always have pops and no suspend()
>>> called.
>>>
>>> Then we have added extra logging and we can see that on reboot codec somehow
>>> getting resume() call and we run jack detect on resume that causing pops.
>> Hm, it's interesting who triggers the runtime resume.
>>
>>> We were thinking about possible solution for that and we would propose some
>>> changes in generic code hda_bind.c:
>>>
>>> static void hda_codec_driver_shutdown(struct device *dev) { +   if (codec->
>>> patch_ops.suspend) +      codec->patch_ops.suspend(codec);
>>> snd_hda_codec_shutdown(dev_to_hda_codec(dev)); +  hda_codec_driver_remove
>>> (dev_to_hda_codec(dev)); }
>> Sorry, it's no-no.  The suspend can't be called unconditionally, and
>> the driver unbind must not be called in the callback itself.
>>
>> Does the patch below work instead?
> Sorry there was a typo.  A bit more revised patch is below.
>
>
> Takashi

Hi Takashi,

Thanks a lot for quick response. I have tested previous patch and it did 
not fix an issue, as suspend() was not called.

Now I will test new revised patch and let you know ASAP.

I am adding some extra logging, unfortunately on reboot these messages 
are missing from kernel log, however I managed to capture reboot screen

and I will attach an image where last messages shown.

Thanks,

Vitaly

>
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1383,14 +1383,17 @@ static void azx_free(struct azx *chip)
>   	hda->freed = 1;
>   }
>   
> -static int azx_dev_disconnect(struct snd_device *device)
> +static void __azx_disconnect(struct azx *chip)
>   {
> -	struct azx *chip = device->device_data;
>   	struct hdac_bus *bus = azx_bus(chip);
>   
>   	chip->bus.shutdown = 1;
>   	cancel_work_sync(&bus->unsol_work);
> +}
>   
> +static int azx_dev_disconnect(struct snd_device *device)
> +{
> +	__azx_disconnect(device->device_data);
>   	return 0;
>   }
>   
> @@ -2356,8 +2359,10 @@ static void azx_shutdown(struct pci_dev *pci)
>   	if (!card)
>   		return;
>   	chip = card->private_data;
> -	if (chip && chip->running)
> +	if (chip && chip->running) {
> +		__azx_disconnect(chip);
>   		azx_shutdown_chip(chip);
> +	}
>   }
>   
>   /* PCI IDs */



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02204305E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhA0Oov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhA0OnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:43:07 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80949C0613ED;
        Wed, 27 Jan 2021 06:42:27 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id r4so1133219pls.11;
        Wed, 27 Jan 2021 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=V84nax4uPiIRK3Ufm8I3oar5ASXqfRLm08ezm3r0gtk=;
        b=H91R7vLnvB6obJFIJO/Lw/yHdg4zQzA5YmrYKG8nkgPV9mUeGxAxdROdnlK5DGlU/+
         Jgy7If3KVKVy5cvHcYDHoSROmv71sH+353edWuUOjNa+KQ6Pi2q0YolNTn4i6Cldc4Y6
         HfEKWdjX7+dWtsb/Xe/9SjkGOe/pXw0Vf5n9R35H6gbUmNtamfmaXEUixVQ3122ZgFa4
         7/KhLI2Ao9S+/XlpBU194cGhzP65DycBF444y7EK365LgXiKmrmAQjtv9xWF4Brn7ukm
         17p48n7wFOnPzwHwzq5kVZaKdHZmm/5BSDRnZmuoPaQDMG8Fxvmh7fYMXR22/q/o+DA2
         Us6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V84nax4uPiIRK3Ufm8I3oar5ASXqfRLm08ezm3r0gtk=;
        b=guT9XyAl+D/D92mRinpB5IORywJzGK04JL5OL9STuAPuT+uGv2Z+4Un0Bo0eP0SzJI
         xm7Ln1JHBs+8vR+iMM3vPDMSCKdikls1BjC/21yOee80PQdHyl+IBN2wRu4mVd/kcTIR
         WxayTpmZxPN6QXp73/gXhqe7vzrX2rYzOLgNKyU/CiXsj3iM7aD77ZJFRFvia7ZTTW4r
         yUcluF7xCfm+j7mXVaThAIOh6e5zUBNSWg37WNUfoX2kWYGutq161aqeNHUK4Vp9QCsK
         ZMCc5g00a82D24GJHHYdPqpTP6ASw8WBTkpa5rBw8x1Q68KuszXI2kinnqX8dMVPwp3C
         ePlA==
X-Gm-Message-State: AOAM532wusvzhNE8vHgB5bYd6WOyATV1Ythwmkp+Vb5OehIZCVzSFq5s
        r92OcJ2tVk35wnMh6w8LHetpHGKoiTnycsi9yCE=
X-Google-Smtp-Source: ABdhPJytO+tek4jvzWyig+q9XAqWJ1MQTFzrk7uLK1EwdjTxRIXqLkWywj86fHzwCf/sSCMzvEg5ow==
X-Received: by 2002:a17:90b:881:: with SMTP id bj1mr5958333pjb.150.1611758546440;
        Wed, 27 Jan 2021 06:42:26 -0800 (PST)
Received: from [192.168.0.104] ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id h1sm2619929pgj.59.2021.01.27.06.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 06:42:25 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Subject: Re: [PATCH v3 01/12] usb: misc: appledisplay: update to use the
 usb_control_msg_{send|recv}() API
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Xu Wang <vulab@iscas.ac.cn>,
        Liu Shixin <liushixin2@huawei.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183403.911653-2-anant.thazhemadam@gmail.com>
 <YBFxkSlWPQRMuaGo@hovoldconsulting.com>
Message-ID: <f82c8fae-251f-12e9-6e43-28824a5ff3e5@gmail.com>
Date:   Wed, 27 Jan 2021 20:12:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBFxkSlWPQRMuaGo@hovoldconsulting.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/01/21 7:28 pm, Johan Hovold wrote:
> On Wed, Jan 27, 2021 at 12:03:52AM +0530, Anant Thazhemadam wrote:
>> The newer usb_control_msg_{send|recv}() API are an improvement on the
>> existing usb_control_msg() as it ensures that a short read/write is treated
> As I mentioned in my comments on v2, a short write has always been
> treated as an error so you shouldn't imply that it wasn't here (and in
> the other commit messages).

The newer API ensures that a short send/recv is an error, as they either
complete the complete translation, or return an error, and remove the need
for explicit return value checking that was previously expected to detect the short
read/write (which wasn't present in a lot of places).
That's what I was trying to say. But if the commit message isn't representative of
that, I'll try and modify it.

Does this sound like a better commit message?

"The newer usb_control_msg_{send|recv}() API are an improvement on the
existing usb_control_msg().

The new API ensures either the full translation is completed,
or an error is returned. This ensures that all short send/recv are detected as
errors even if there is no explicit return value checking performed.

The new API also allows us to use data off the stack, and don't require raw usb
pipes to be created in the calling functions."


>> as an error, data can be used off the stack, and raw usb pipes need not be
>> created in the calling functions.
>> For this reason, instances of usb_control_msg() have been replaced with
>> usb_control_msg_{recv|send}(), and all return value checking
>> conditions have also been modified appropriately.
>>
>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
>> ---
>>  drivers/usb/misc/appledisplay.c | 46 ++++++++++++++-------------------
>>  1 file changed, 19 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
>> index c8098e9b432e..117deb2fdc29 100644
>> --- a/drivers/usb/misc/appledisplay.c
>> +++ b/drivers/usb/misc/appledisplay.c
>> @@ -132,21 +132,17 @@ static int appledisplay_bl_update_status(struct backlight_device *bd)
>>  	pdata->msgdata[0] = 0x10;
>>  	pdata->msgdata[1] = bd->props.brightness;
>>  
>> -	retval = usb_control_msg(
>> -		pdata->udev,
>> -		usb_sndctrlpipe(pdata->udev, 0),
>> -		USB_REQ_SET_REPORT,
>> -		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
>> -		ACD_USB_BRIGHTNESS,
>> -		0,
>> -		pdata->msgdata, 2,
> In this case, the buffer is already DMA-able (and is in fact only used
> for this purpose) so this patch introduces an extra allocation and
> memcpy for no really good reason.
>
>> -		ACD_USB_TIMEOUT);
>> +	retval = usb_control_msg_send(pdata->udev,
>> +				      0,
>> +				      USB_REQ_SET_REPORT,
>> +				      USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
>> +				      ACD_USB_BRIGHTNESS,
>> +				      0,
>> +				      pdata->msgdata, 2,
>> +				      ACD_USB_TIMEOUT, GFP_KERNEL);
>>  	mutex_unlock(&pdata->sysfslock);
>>  
>> -	if (retval < 0)
>> -		return retval;
>> -	else
>> -		return 0;
>> +	return retval;
>>  }
>>  
>>  static int appledisplay_bl_get_brightness(struct backlight_device *bd)
>> @@ -155,21 +151,17 @@ static int appledisplay_bl_get_brightness(struct backlight_device *bd)
>>  	int retval, brightness;
>>  
>>  	mutex_lock(&pdata->sysfslock);
>> -	retval = usb_control_msg(
>> -		pdata->udev,
>> -		usb_rcvctrlpipe(pdata->udev, 0),
>> -		USB_REQ_GET_REPORT,
>> -		USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
>> -		ACD_USB_BRIGHTNESS,
>> -		0,
>> -		pdata->msgdata, 2,
>> -		ACD_USB_TIMEOUT);
>> -	if (retval < 2) {
>> -		if (retval >= 0)
>> -			retval = -EMSGSIZE;
>> -	} else {
>> +	retval = usb_control_msg_recv(pdata->udev,
>> +				      0,
>> +				      USB_REQ_GET_REPORT,
>> +				      USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
>> +				      ACD_USB_BRIGHTNESS,
>> +				      0,
>> +				      pdata->msgdata, 2,
>> +				      ACD_USB_TIMEOUT, GFP_KERNEL);
>> +	if (retval == 0)
>>  		brightness = pdata->msgdata[1];
>> -	}
>> +
> Same here, this introduces an extra allocation and memcpy and the only
> thing you gain is essentially the removal of the two lines for handling
> a short read.
>
>>  	mutex_unlock(&pdata->sysfslock);
>>  
>>  	if (retval < 0)
> I'd consider dropping this one as well.


Yes, that's probably the better thing to do here.


Thanks,
Anant


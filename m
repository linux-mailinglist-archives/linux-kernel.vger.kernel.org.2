Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3B401CF0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243283AbhIFOXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243062AbhIFOXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:23:53 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CFEC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 07:22:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l18so11584861lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mG8tNKUvhm36FHkpW6dMAH1JMCzSmycVFv0CHA2JrTU=;
        b=oTeOncfwbF5FaDVUIEJPG/rR4mNO8+/1Vw17pycGaisfoqyFVu+UClUg6taLQKI+r3
         S7mQhDWdpEFhF1gT+dCU3b/jCloIV8m+y04seagNAXymiMXhsiCI6U+u7ELXJPT7HcLZ
         Zt9l19hA6kgAbIc+E3FLJayHA8bkH5F3CLO0Pw/8laBbBiiFNBQ6ojVjiq/7kVveP2mL
         WSF9mMGFjRt7a/HMK9e9FZhIoybRAyH4MpV49M1ODzppNCiAfhdfAG9IzshBU31Q1JH+
         NnanP1OvXu92a0D6bGJnSDRtp9fryzPquS1HUc3TdBdT1kAq08NeB4ctTL+1O1XI/g2M
         JF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mG8tNKUvhm36FHkpW6dMAH1JMCzSmycVFv0CHA2JrTU=;
        b=gblc2DnEKmXeTBFywYVZf2piMdYq+2ihk16jdtFwBegK7308MSVfr8shbfN1whp6r5
         58DFfCFrrvbaLrbNimc0H8FNyAnmuSiAXqSuQz9OsPmVXRzB4Z3dekJOkQLQ9dNz+30j
         dRgwGfMOaKm5ykn6PqMePvRBY4eoGCUbrZKn5ag/Qysx2MbzL1rsuJ50b9uLdAzKSgFB
         wsA/Q6jNBOtYO6lB4Lpz3Vf5QrZ6DJiSdo1U3EoB3iADZvQboG9rEZj2rxrX9z/tu6X3
         KgIBL1Un4/4Xt4JD4qTXa5TgB0u59KkAXwqC1sMHwWVftL5yoyWG3LLJol/tVYokNaW7
         KG8A==
X-Gm-Message-State: AOAM532rpLi2pxugRd0//8SBg5yh0ywpJNSoTLiqlVIrmyDr/LnzlnB3
        3anapw2qAEl2ErV1A1zY8GugGVuh7B+S9g==
X-Google-Smtp-Source: ABdhPJwDPKxGvRNAKHv4gLf4CtMNzkxaLxIRq0fUtRw4WKyXL83YGRRvI1aAAb3fhHyF/7IuD5ulgg==
X-Received: by 2002:a05:651c:98c:: with SMTP id b12mr10927539ljq.83.1630938166643;
        Mon, 06 Sep 2021 07:22:46 -0700 (PDT)
Received: from localhost.localdomain ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id d4sm750103lfg.261.2021.09.06.07.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 07:22:46 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] staging: r8188eu: Shorten calls chain of
 rtw_read8/16/32()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210904220048.12822-1-fmdefrancesco@gmail.com>
 <20210904220048.12822-3-fmdefrancesco@gmail.com> <YTYgnrvwxNt4+CvR@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <ed989e91-7b3a-5a6d-1b3c-0e9c5d677d1c@gmail.com>
Date:   Mon, 6 Sep 2021 17:22:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YTYgnrvwxNt4+CvR@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 5:07 PM, Greg Kroah-Hartman wrote:
> On Sun, Sep 05, 2021 at 12:00:47AM +0200, Fabio M. De Francesco wrote:
>> Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
>> For this purpose unify the three usb_read8/16/32 into the new
>> usb_read(); make the latter parameterizable with 'size'; embed most of
>> the code of usbctrl_vendorreq() into usb_read() and use in it the new
>> usb_control_msg_recv() API of USB Core.
>> 
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> ---
>> 
>> v2->v3: No changes.
>> 
>> v1->v2: No changes.
>> 
>>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 92 +++++++++++++++++----
>>  1 file changed, 78 insertions(+), 14 deletions(-)
>> 
>> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> index a87b0d2e87d0..f9c4fd5a2c53 100644
>> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> @@ -97,38 +97,102 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>>  	return status;
>>  }
>>  
>> +static int usb_read(struct intf_hdl *intfhdl, u32 addr, void *data, u8 size)
>> +{
>> +	u16 value = (u16)(addr & 0x0000ffff);
> 
> Why not just pass in the address as a 16bit value?
> 
> 
>> +	struct adapter *adapt = intfhdl->padapter;
>> +	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
>> +	struct usb_device *udev = dvobjpriv->pusbdev;
>> +	int status;
>> +	u8 *io_buf;
>> +	int vendorreq_times = 0;
>> +
>> +	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx) {
>> +		status = -EPERM;
>> +		goto exit;
> 
> This is "interesting" to see if it's really even working as they think
> it does, but let's leave it alone for now...
> 
>> +	}
>> +
>> +	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
>> +
>> +	/*  Acquire IO memory for vendorreq */
>> +	io_buf = dvobjpriv->usb_vendor_req_buf;
>> +
>> +	if (!io_buf) {
>> +		DBG_88E("[%s] io_buf == NULL\n", __func__);
> 
> How can this buffer ever be NULL?
> 
>> +		status = -ENOMEM;
>> +		goto release_mutex;
>> +	}
> 
> Why share a buffer at all anyway?
> 
>> +	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
>> +		status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
>> +					      REALTEK_USB_VENQT_READ, value,
>> +					      REALTEK_USB_VENQT_CMD_IDX, io_buf,
>> +					      size, RTW_USB_CONTROL_MSG_TIMEOUT,
>> +					      GFP_KERNEL);
>> +		if (!status) {   /*  Success this control transfer. */
> 
> Comments go on the next line.
> 
>> +			rtw_reset_continual_urb_error(dvobjpriv);
>> +			memcpy(data, io_buf, size);
>> +		} else { /*  error cases */
> 
> Again, next line for the comment.
> 
>> +			DBG_88E("reg 0x%x, usb %s %u fail, status:%d vendorreq_times:%d\n",
>> +				value, "read", size, status, vendorreq_times);
> 
> These should be removed eventually...
> 
>> +
>> +			if (status == (-ESHUTDOWN) || status == -ENODEV) {
>> +				adapt->bSurpriseRemoved = true;
> 
> Odd, but ok...
> 
>> +			} else {
>> +				struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
>> +
>> +				haldata->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
> 
> Why are we not saying the command failed even if the device was removed?
> 
> But if we do say an error happened, why are we trying to send this out
> again?  What would happen to make it work the second time?
> 
>> +			}
>> +
>> +			if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
>> +				adapt->bSurpriseRemoved = true;
> 
> So we try to see if the device was removed again?
> 
>> +				break;
>> +			}
>> +		}
>> +
>> +		/*  firmware download is checksummed, don't retry */
>> +		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || !status)
>> +			break;
> 
> Nothing like a special case for firmware magic.
> 
> Those calls should just use a different write function entirely,
> eventually, to remove this...
> 
> Ok, I know you are just moving code around, this is fine, just pointing
> out things that should be fixed up eventually...
> 

I agree with all statements, and I've asked maintainers about some of 
them before. It's 100% should be fixed, but we (me and Fabio) want to 
fix them step by step to not rebase every time new clean up goes in.

Our plan is: (Fabio, please, correct me, if I am wrong here)

1. ops removal + shorten call chain (this patch series)
2. my error handling series [1]
3. Clean ups for rtw_* functions (old usb_*)
4. Remove dead proc code + introduce new sysfs interface, based on old 
proc code.


We can prepare them all at once, but, IMO:

1. It will be really hard to review
2. A lot of rebasing through new versions, since there are a lot
clean ups appear every day.


I believe, our step-by-step plan should be more comfortable for all of us :)


Thank you!


[1] 
https://lore.kernel.org/linux-staging/cover.1629479152.git.paskripkin@gmail.com/



With regards,
Pavel Skripkin

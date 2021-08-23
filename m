Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503073F46A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhHWIbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbhHWIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:31:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B11C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:30:58 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s12so4855577ljg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=o8bRgpXLwrExM1LA3b3XAfafPz1Ks2zqsEsUrezojIA=;
        b=gXIJ+EPXq6WquhFmcHLrHI5PtTC8hU3RxwDtgbMruOWE1uFSRg+ROFMgiG+L26sms1
         u6BedvqKOr8mkZIBV3qgRaWfPMymLKM6TVBjmlzjcOthUv3WjVlwiZuADts8U6hUT/x0
         EOVl1tmAWS+xpJQFaTt0bbPZI4ZLpo6QwrJrDaHp8fWaqGJRI31Gh/3tBQ35hke1qhgh
         yf0cIsGSb1p019A4CIPzZ2uesg/S7JfziB2qzRoxK0PSZaZMyX4PTzeNFOTk6xiBkzOF
         l2derMbvPHxfuybSogODoUtfFHfvhZAPOux7WDPhOab53WoIWMJFvV8YxaNaSeYLgOXA
         njYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o8bRgpXLwrExM1LA3b3XAfafPz1Ks2zqsEsUrezojIA=;
        b=FErlDDvhevxSO6sH26zN7fGhZfjejpgrTYc9bF/YgN87k9B5lJTURW+Wwe3YIyY7lJ
         Wxx4pobdevO575kn48tKwry/q8koO4XK5Zss2PaFvHBPVk036v01MumyrxTucvq1WwBZ
         y821XC0WrwWT+eYiJArrJvRUVDspZLlXsYwsla3Q9OxnvdYOv0fTz3p8Bx0zVx2cMyMX
         DrOqa7MDWboWsZjjTlQ7xaZz7GYBTCE4YukOzsQoXyHaqf3ysBNaHRNHwyMEPAASoEbJ
         lb1ehpy286WKJfSCLeYj5ndv+DIfqDN9tm00aIRW72GGOr9crYQUGqejPFbO1MuFn5yw
         T4gg==
X-Gm-Message-State: AOAM532Wlr1oTejPf1q3ZDheinEXcTWA0XW2tcpPO9KO2lK2EXuTSYnl
        Skzjl66TvfYeQ5QTCd6srptDc765iHAj/A==
X-Google-Smtp-Source: ABdhPJyK7vZ/p4uOhfEmj1AMw4UKN0GqBn9sjtjKLLGqZcDs5K0m7+oNOvrn2jpqEylmbqyB21P5og==
X-Received: by 2002:a2e:a801:: with SMTP id l1mr19349361ljq.41.1629707455366;
        Mon, 23 Aug 2021 01:30:55 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id g7sm1384551ljk.130.2021.08.23.01.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 01:30:54 -0700 (PDT)
Subject: Re: [PATCH RFC] staging: r8188eu: Use usb_control_msg_recv/send() in
 usbctrl_vendorreq()
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
References: <20210822230235.10953-1-fmdefrancesco@gmail.com>
 <69bbb80c-2b30-28b9-ad8c-6862a6c3b911@gmail.com>
Message-ID: <8d37d8e5-7ba5-d49b-f2c5-f7e8844ae8e1@gmail.com>
Date:   Mon, 23 Aug 2021 11:30:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <69bbb80c-2b30-28b9-ad8c-6862a6c3b911@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 11:11 AM, Pavel Skripkin wrote:
> On 8/23/21 2:02 AM, Fabio M. De Francesco wrote:
>> Replace usb_control_msg() with the new usb_control_msg_recv() and
>> usb_control_msg_send() API of USB Core.
>> 
>> This patch is an RFC for different reasons:
>> 
>> 1) I'm not sure if it is needed: while Greg Kroah-Hartman suggested to
>> use the new API in a message to a thread that was about a series of patches
>> submitted by Pavel Skripkin (who decided to not use it), I cannot explain
>> if and why the driver would benefit from this patch.
>> 2) I have doubts about the sematic of the API I use here, so I'd like to
>> know whether or not I'm using them properly.
>> 3) At the moment I cannot test the driver because I don't have my device
>> with me.
>> 4) This patch could probably lead to a slight change in some lines of
>> Pavel's series (for sure in usb_read*()).
>> 
>> I'd like to hear from the Maintainers and other interested people if this
>> patch is worth to be considered and, in this case, if there are suggestions
>> for the purpose to improve it.
>> 
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> ---
>>   drivers/staging/r8188eu/hal/usb_ops_linux.c | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> index 6a0a24acf292..9e290c1cc449 100644
>> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> @@ -15,7 +15,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>>   	struct adapter	*adapt = pintfhdl->padapter;
>>   	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
>>   	struct usb_device *udev = dvobjpriv->pusbdev;
>> -	unsigned int pipe;
>> +	u8 pipe;
>>   	int status = 0;
>>   	u8 reqtype;
> 
> I think, we can pass REALTEK_USB_VENQT_{READ,WRITE} directly as
> requesttype argument and get rid of u8 reqtype. + we can define these
> macros:
> 
> #define
> usbctrl_vendor_read(...)   usbctrl_vendorreq(...,REALTEK_USB_VENQT_READ)
> 
> 
> #define
> usbctrl_vendor_write()    usbctrl_vendorreq(...,REALTEK_USB_VENQT_WRITE)
> 
> 
> This will make code more nice, IMO  :)
> 
> 
> (Sorry for this formatting, my email client disabled "paste without
> formatting" option)
> 
>>   	u8 *pIo_buf;
>> @@ -47,19 +47,20 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>>   		memset(pIo_buf, 0, len);
>>   

		^^^^^^^^^^^^^^^^^^^^^^^

And this memset becomes useless, since usb_control_msg_recv cannot 
receive only part of the message

>>   		if (requesttype == 0x01) {
>> -			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
>>   			reqtype =  REALTEK_USB_VENQT_READ;
>> +			status = usb_control_msg_recv(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
>> +						      reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
>> +						      pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
>> +						      GFP_KERNEL);
>>   		} else {
>> -			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
>>   			reqtype =  REALTEK_USB_VENQT_WRITE;
>> -			memcpy(pIo_buf, pdata, len);
> 
> I guess, this memcpy is needed, since we want to send data from pdata
> 
> 
>> +			status = usb_control_msg_send(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
>> +						      reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
>> +						      pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
>> +						      GFP_KERNEL);
>>   		}
>>   
>> -		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
>> -					 reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
>> -					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
>> -
>> -		if (status == len) {   /*  Success this control transfer. */
>> +		if (!status) {   /*  Success this control transfer. */
>>   			rtw_reset_continual_urb_error(dvobjpriv);
>>   			if (requesttype == 0x01)
>>   				memcpy(pdata, pIo_buf,  len);
>> 
> 


With regards,
Pavel Skripkin

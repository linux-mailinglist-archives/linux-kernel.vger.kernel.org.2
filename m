Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114AE3F6080
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbhHXOg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbhHXOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:36:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E0EC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:35:43 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h1so9839727ljl.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XDw/kvT50dNyyGmvBIKtXFQpyrAzH9NNuFdmxwHIYsc=;
        b=DqCXEGtn2eftu8SfoWL+ftTBA6f4Rw6OxufFq+Qv/gqe8bQ8lsiMH3FYH1GI+txSt5
         crseptiEgQL+txXt9JkDavpisX88QKnEgKat0fdy1YLPh2TNEf6yZvN7tqUfOulqmSuW
         UNa12N50W2DPW755jP+T3BQZFPHIOGNUSPMFRIAvlJHcVPE5Sh43tlcrpXucg+tMgZAP
         dDpKyYX48hFp1XIVY5lbjuKhvftbcmewWsbEW8gnC9CpoSj5p5/YOVA/9RZj82X6jI8P
         PJFTlWI2jZrbGVDHnjjHT9sKQHwcU1xfagq6pzc+H99da0Q1kK8et6dEPNNkVyW1MNPR
         50Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XDw/kvT50dNyyGmvBIKtXFQpyrAzH9NNuFdmxwHIYsc=;
        b=p/w4cjKJycHXJZVIDIo/NzQ/C8CGdZvumgOIUXerNaOCBGXwJX3E2ZOCiHKNlzqRp1
         1cz2tiunbqmCjxjHjQoAv5z5KNdKlTfaSyRrAAIa5mWWpiaXFYLUEa+JjDqbiOCJgPBB
         M8xUURyO0hyefC9UVbxcDPWbGfBjRWk7PKVRaa0bSxPQkZZO/Fq1BHc0C1pvyOVz3Ne1
         tBKuNYMTdkiuavwXO7qBXbBDvKkFZgIx/7t/M+Bn4Qf5bJOa8JcSb6R3Xquv86ka9gm/
         BcGsoQ4LNWN7NRIL+W+up5fwe7kqErAlmLfJ+JA4x6u9O/ZwM2cKebubtxkpC2dlNcdQ
         6tSw==
X-Gm-Message-State: AOAM533NgPgH1VmFqJ7XlKsG+AqyVrt6AQjGve3V/J7gqh9vDW1V7rKA
        ozm9gq4tRQ0fpEiKLbcP2AE=
X-Google-Smtp-Source: ABdhPJxalxd7ppVv+FX6TnFK1kYh/otnjxSG7f2a4UyFqxXAxTo+7Y0weU4Fdb6Z/zbDrn0iS0Xr2Q==
X-Received: by 2002:a2e:81c2:: with SMTP id s2mr31029400ljg.48.1629815739973;
        Tue, 24 Aug 2021 07:35:39 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id j13sm1766103lfe.48.2021.08.24.07.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:35:39 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] staging: r8188eu: Use usb_control_msg_recv/send()
 in usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com>
 <20210824142823.16845-2-fmdefrancesco@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <ac4b9c30-fceb-6838-a6d5-b9f03d5a0246@gmail.com>
Date:   Tue, 24 Aug 2021 17:35:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824142823.16845-2-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 5:28 PM, Fabio M. De Francesco wrote:
> Replace usb_control_msg() with the new usb_control_msg_recv() and
> usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
> Remove no more needed variables. Move out of an if-else block
> some code that it is no more dependent on status < 0. Remove
> redundant code depending on status > 0 or status == len.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1->v2: According to suggestions by Christophe JAILLET
> <christophe.jaillet@wanadoo.fr>, remove 'pipe' and pass an explicit 0
> to the new API. According to suggestions by Pavel Skripkin
> <paskripkin@gmail.com>, remove an extra if-else that is no more needed,
> since status can be 0 and < 0 and there is no 3rd state, like it was before.
> Many thanks to both them and to Phillip Potter <phil@philpotter.co.uk>
> who kindly offered his time for the purpose of testing v1.
>   
> 
>   drivers/staging/r8188eu/hal/usb_ops_linux.c | 45 ++++++++-------------
>   1 file changed, 17 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index a93d5cfe4635..13e925d21e00 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -15,9 +15,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>   	struct adapter	*adapt = pintfhdl->padapter;
>   	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
>   	struct usb_device *udev = dvobjpriv->pusbdev;
> -	unsigned int pipe;
>   	int status = 0;
> -	u8 reqtype;
>   	u8 *pIo_buf;
>   	int vendorreq_times = 0;
>   
> @@ -44,22 +42,22 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>   	}
>   
>   	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
> -		memset(pIo_buf, 0, len);
> -
>   		if (requesttype == 0x01) {
> -			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> -			reqtype =  REALTEK_USB_VENQT_READ;
> +			status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
> +						      REALTEK_USB_VENQT_READ, value,
> +						      REALTEK_USB_VENQT_CMD_IDX, pIo_buf,
> +						      len, RTW_USB_CONTROL_MSG_TIMEOUT,
> +						      GFP_KERNEL);
>   		} else {
> -			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> -			reqtype =  REALTEK_USB_VENQT_WRITE;
>   			memcpy(pIo_buf, pdata, len);
> +			status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
> +						      REALTEK_USB_VENQT_WRITE, value,
> +						      REALTEK_USB_VENQT_CMD_IDX, pIo_buf,
> +						      len, RTW_USB_CONTROL_MSG_TIMEOUT,
> +						      GFP_KERNEL);
>   		}
>   
> -		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> -					 reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> -					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
> -
> -		if (status == len) {   /*  Success this control transfer. */
> +		if (!status) {   /*  Success this control transfer. */
>   			rtw_reset_continual_urb_error(dvobjpriv);
>   			if (requesttype == 0x01)
>   				memcpy(pdata, pIo_buf,  len);
> @@ -68,20 +66,11 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>   				value, (requesttype == 0x01) ? "read" : "write",
>   				len, status, *(u32 *)pdata, vendorreq_times);
>   
> -			if (status < 0) {
> -				if (status == (-ESHUTDOWN) || status == -ENODEV) {
> -					adapt->bSurpriseRemoved = true;
> -				} else {
> -					struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
> -					haldata->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
> -				}
> -			} else { /*  status != len && status >= 0 */
> -				if (status > 0) {
> -					if (requesttype == 0x01) {
> -						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
> -						memcpy(pdata, pIo_buf,  len);
> -					}
> -				}
> +			if (status == (-ESHUTDOWN) || status == -ENODEV) {
> +				adapt->bSurpriseRemoved = true;
> +			} else {
> +				struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
> +				haldata->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
>   			}
>   
>   			if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
> @@ -92,7 +81,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>   		}
>   
>   		/*  firmware download is checksumed, don't retry */
> -		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
> +		if (value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS)
>   			break;


Shouldn't we break the loop when we have received all data? I think,
status == len should be replaced with !status. Correct me if I am wrong.


Other changes look good to me, thanks



With regards,
Pavel Skripkin

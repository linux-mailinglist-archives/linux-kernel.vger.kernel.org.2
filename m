Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E43F3F35
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhHVMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhHVMJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 08:09:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48690C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:09:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f13-20020a1c6a0d000000b002e6fd0b0b3fso10471440wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yrHmqJgYiCnFBXm9AiWUhA/1pbucn9i33DWUkMdwUBg=;
        b=EI0HZVKihoDm8X33wiVBqbGePCEnCZ//AvjWK8U9KFOt+Wq7VUYHVNxgGZlFIQtWV0
         n7YNlsXA3wVk27AI2PrL0xN1AFeL5wCTKd0re+J6umwrMsMylp5jpYgCtUQQYu6hBCnv
         zOSew12fPVNciSGCIcu6ojnqoM4q5XkmduEGA9mwlJOguzgzR5a8rPCXnIAaeBQunQPm
         CDvNnMdwrZXBdAFcKjGYOyBdbJfALdA9EXYehxQUvpp+Mt6KnCbiSrTZbOTulyq0vchU
         mV+b7+6sdUbdrzCf9Kd0bKPoFKhoCZWwaCckaJ528J85hd4eheKBNPy755uBahbWJOYA
         FTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yrHmqJgYiCnFBXm9AiWUhA/1pbucn9i33DWUkMdwUBg=;
        b=CkL5Zgl4rJlc8Dtl9PRtTZT7VU/2rVDU4gvvzHtZeF1HIPjGJ52Cc+knysL18zYmrm
         4xnckvzyrd0tYuAINS4xPEOYytSA1pHQw7GIQMK0JKSx9JznKF5oPz9tgkmefIMHmol/
         7Ed3coXIcoVMRLNCWl11uvg6NrshRV+wayEUBJtaTruQ68T1t+nU1Tvb3i9ihB/fSJA/
         AZB5sjisf60mPwYU2SKSP/JjwNBqKFvsCviUlMB1ZgUY35ief1m2mg0orpXsjrx5lWWF
         FKnutw9Wko1MjvOyfFJkyd/LRSSJjiQe2I1IgXumiwi2cNsNo/zKjbochxTBgAv0tPvV
         NRcA==
X-Gm-Message-State: AOAM5334gr4uZFYHqMzOE2PWhxH/gFvtTKD0arplxDZpCpzKXWy/STHB
        N0GHIvvKQm5X2xGJwEyN50YHqz+F380=
X-Google-Smtp-Source: ABdhPJwNAUvslkNQpWa3LWvtsi1LGCCrrq0zb57A+we3zgFjHEwL1ZMP5aHqTIELvajaeI2UwgwYqg==
X-Received: by 2002:a1c:a903:: with SMTP id s3mr3032545wme.171.1629634153864;
        Sun, 22 Aug 2021 05:09:13 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id b12sm14293662wrx.72.2021.08.22.05.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 05:09:13 -0700 (PDT)
Subject: Re: [PATCH 03/10] staging: rtl8188eu: use actual request type as
 parameter
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210821164859.4351-1-martin@kaiser.cx>
 <20210821164859.4351-3-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <0e95cd4f-6374-76bf-86b3-115277f5e9d9@gmail.com>
Date:   Sun, 22 Aug 2021 14:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821164859.4351-3-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 6:48 PM, Martin Kaiser wrote:
> At the moment, usbctrl_vendorreq's requesttype parameter must be set to
> 1 for reading and 0 for writing. It's then converted to the actual
> bmRequestType for the USB control request. We can simplify the code and
> avoid this conversion if the caller passes the actual bmRequestType.
> 
> This patch is an adaptation of commit 788fde031027 ("staging: rtl8188eu:
> use actual request type as parameter") for the new r8188eu driver.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_ops_linux.c | 46 ++++++---------------
>   1 file changed, 12 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index a11a0597e515..dccb9fd34777 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -15,7 +15,6 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>   	struct usb_device *udev = dvobjpriv->pusbdev;
>   	unsigned int pipe;
>   	int status = 0;
> -	u8 reqtype;
>   	u8 *pIo_buf;
>   	int vendorreq_times = 0;
>   
> @@ -44,26 +43,24 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>   	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
>   		memset(pIo_buf, 0, len);
>   
> -		if (requesttype == 0x01) {
> +		if (requesttype == REALTEK_USB_VENQT_READ) {
>   			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> -			reqtype =  REALTEK_USB_VENQT_READ;
>   		} else {
>   			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> -			reqtype =  REALTEK_USB_VENQT_WRITE;
>   			memcpy(pIo_buf, pdata, len);
>   		}
>   
>   		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> -					 reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> +					 requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
>   					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
>   
>   		if (status == len) {   /*  Success this control transfer. */
>   			rtw_reset_continual_urb_error(dvobjpriv);
> -			if (requesttype == 0x01)
> +			if (requesttype == REALTEK_USB_VENQT_READ)
>   				memcpy(pdata, pIo_buf,  len);
>   		} else { /*  error cases */
>   			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
> -				value, (requesttype == 0x01) ? "read" : "write",
> +				value, (requesttype == REALTEK_USB_VENQT_READ) ? "read" : "write",
>   				len, status, *(u32 *)pdata, vendorreq_times);
>   
>   			if (status < 0) {
> @@ -75,7 +72,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>   				}
>   			} else { /*  status != len && status >= 0 */
>   				if (status > 0) {
> -					if (requesttype == 0x01) {
> +					if (requesttype == REALTEK_USB_VENQT_READ) {
>   						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
>   						memcpy(pdata, pIo_buf,  len);
>   					}
> @@ -101,19 +98,16 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>   
>   static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
>   {
> -	u8 requesttype;
>   	u16 wvalue;
>   	u16 len;
>   	u8 data = 0;
>   
>   
>   
> -	requesttype = 0x01;/* read_in */
> -
>   	wvalue = (u16)(addr & 0x0000ffff);
>   	len = 1;
>   
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
>   
>   
>   
> @@ -123,57 +117,49 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
>   
>   static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
>   {
> -	u8 requesttype;
>   	u16 wvalue;
>   	u16 len;
>   	__le32 data;
>   
> -	requesttype = 0x01;/* read_in */
>   	wvalue = (u16)(addr & 0x0000ffff);
>   	len = 2;
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
>   
>   	return (u16)(le32_to_cpu(data) & 0xffff);
>   }
>   
>   static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>   {
> -	u8 requesttype;
>   	u16 wvalue;
>   	u16 len;
>   	__le32 data;
>   
> -	requesttype = 0x01;/* read_in */
> -
>   	wvalue = (u16)(addr & 0x0000ffff);
>   	len = 4;
>   
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
>   
>   	return le32_to_cpu(data);
>   }
>   
>   static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
>   {
> -	u8 requesttype;
>   	u16 wvalue;
>   	u16 len;
>   	u8 data;
>   	int ret;
>   
>   
> -	requesttype = 0x00;/* write_out */
>   	wvalue = (u16)(addr & 0x0000ffff);
>   	len = 1;
>   	data = val;
> -	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
>   
>   	return ret;
>   }
>   
>   static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>   {
> -	u8 requesttype;
>   	u16 wvalue;
>   	u16 len;
>   	__le32 data;
> @@ -181,14 +167,12 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>   
>   
>   
> -	requesttype = 0x00;/* write_out */
> -
>   	wvalue = (u16)(addr & 0x0000ffff);
>   	len = 2;
>   
>   	data = cpu_to_le32(val & 0x0000ffff);
>   
> -	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
>   
>   
>   
> @@ -197,7 +181,6 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>   
>   static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>   {
> -	u8 requesttype;
>   	u16 wvalue;
>   	u16 len;
>   	__le32 data;
> @@ -205,13 +188,11 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>   
>   
>   
> -	requesttype = 0x00;/* write_out */
> -
>   	wvalue = (u16)(addr & 0x0000ffff);
>   	len = 4;
>   	data = cpu_to_le32(val);
>   
> -	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
>   
>   
>   
> @@ -220,7 +201,6 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>   
>   static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
>   {
> -	u8 requesttype;
>   	u16 wvalue;
>   	u16 len;
>   	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
> @@ -228,13 +208,11 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
>   
>   
>   
> -	requesttype = 0x00;/* write_out */
> -
>   	wvalue = (u16)(addr & 0x0000ffff);
>   	len = length;
>   	memcpy(buf, pdata, len);
>   
> -	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, len, requesttype);
> +	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, len, REALTEK_USB_VENQT_WRITE);
>   
>   	return ret;
>   }
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B6F3F710F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbhHYIXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhHYIXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:23:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8E1C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 01:22:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so51199583lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 01:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5e2CYVsWK7yif+ZWhIuMzcEgDnkaLIfgz62zQHIC1l4=;
        b=a4Kr7LuOcN0EeqnWmsBBFFPCJ8asQGmFso4pA8RfZVN+Ib7jeTXgtHhKMJRiQ41Qmz
         E8SMqK4Heq/ikjOJVSvv2yb2MPOXriDjrIMr8tcYtOcUDNRixNcaD4B9tj7oe0Ky8Ism
         P3eE9GjsubhYYeuV0g7KQEBJZaZkKXn9ruxMIt1DZ4QmRZu02VeSNiC5j/CvgAxgcLWY
         69rxApImZKSkxl7Nzz0jCskBWdWE6UjJ2X7Uc/1bKBoXDVdjSI5zymzDLp9NRSER3jy5
         dW8NqjQe88kGfcK4F5tparnB0xTanAh1DWOtGHQEfhtkDxm9m8KbzA3FjGXP+v229of8
         zHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5e2CYVsWK7yif+ZWhIuMzcEgDnkaLIfgz62zQHIC1l4=;
        b=EEXFIl2xBcISUIfxKwfzPlWIqYNgiNzZBAWMVelAm2ted3OLt4y1ZDo2XA5MnpERTU
         0C5nb6y+eyQj17i46AYl5pxlF2x9XCXJAk3hBbhW6g/S2zz5TokOuYLnW81ZixPZxJhH
         zY4htdil0VsKXuvix22XWLsWYZW8373UQ3EKhaGFMdsknKXaYgIRHZlOP9MXUASxLy7p
         pK0vB0e2+gA3Fg5xrBy4jZgbI53P/KXkF7Ss7myAeC69KdDjLo35RXxqsVVn7QvREdA9
         8n4uh7eZ0CKtR6tAHeh356SLOy0yKSFU9o8xnFGx9qT0zsR8TpCDVY8IzfvyXQ/iroQB
         xFCw==
X-Gm-Message-State: AOAM5317TwJD+aEhQ08fhpZJhIA04tH/NR7BTA1xRsTaJk/QbbooR8p6
        6N1NdwstdsdlkcQbB+qlxslkyq0+S97lGo5H
X-Google-Smtp-Source: ABdhPJx9ah3lG2IN9SggrEJai3dxMuYeLkvSlw7cKqY/OD8jUTB8PcwPIhpWpPor4x571SmyhmP56w==
X-Received: by 2002:ac2:5231:: with SMTP id i17mr32422120lfl.497.1629879739813;
        Wed, 25 Aug 2021 01:22:19 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id r8sm2030339ljc.7.2021.08.25.01.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 01:22:19 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1629789580.git.paskripkin@gmail.com>
 <d06f3173e0a4c6f5449d5551cbfb0202849332b7.1629789580.git.paskripkin@gmail.com>
 <1665728.ljvk3MsED4@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <ab20fcd7-69a8-0530-7770-0e309178b0f0@gmail.com>
Date:   Wed, 25 Aug 2021 11:22:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1665728.ljvk3MsED4@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 7:35 AM, Fabio M. De Francesco wrote:
> On Tuesday, August 24, 2021 9:27:35 AM CEST Pavel Skripkin wrote:
>> _rtw_read16 function can fail in case of usb transfer failure. But
>> previous function prototype wasn't designed to return an error to
>> caller. It can cause a lot uninit value bugs all across the driver code,
>> since rtw_read16() returns local stack variable to caller.
>> 
>> Fix it by changing the prototype of this function. Now it returns an
>> int: 0 on success, negative error value on failure and callers should pass
>> the pointer to storage location for register value.
>> 
>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>> 
>> [...]
>>
>> -static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
>> +static int usb_read16(struct intf_hdl *pintfhdl, u32 addr, u16 *data)
>>  {
>>  	u8 requesttype;
>>  	u16 wvalue;
>>  	u16 len;
>> -	__le32 data;
>> +	int res;
>> +	__le32 tmp;
>> +
>> +	if (WARN_ON(unlikely(!data)))
>> +		return -EINVAL;
>>  
>>  	requesttype = 0x01;/* read_in */
>>  	wvalue = (u16)(addr & 0x0000ffff);
>>  	len = 2;
>> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>> +	res = usbctrl_vendorreq(pintfhdl, wvalue, &tmp, len, requesttype);
>> +	if (res < 0) {
>> +		dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 16 bytes: %d\n", res);
>> +		return res;
>> +	} else if (res != len) {
> 
> Dear Pavel,
> 
> Please note that if and when my patch "Use usb_control_msg_recv / send () in
> usbctrl_vendorreq ()" will be merged, "if (res! = len)" will always evaluate 'true'
> and usb_read16 () will always return -EIO even if usbctrl_vendorreq () succeeds.
> 

Yep, thank you, but it depends on which series will go in first :)

There is a chance, that you will need to clean up this part, if mine 
will be merged before yours



With regards,
Pavel Skripkin

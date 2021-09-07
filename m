Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231DC4026FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245365AbhIGKSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245240AbhIGKSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:18:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C561CC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 03:17:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q21so15658898ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ByxqDJoNSKwEprYR76zP4whjJer5vtw08GNWxCQ8n/Y=;
        b=PZXbFfG0SOPa/2i8YDrkhKdhxnszMwNNorHNDijKwyKoWDzlkakgrFijc5j6EgmEbB
         YXFW0l692qR3vxgbsnkuyvKVLZ+ZSA/2NC32PV7H2W3cZ3dtz5jf0I9wIlw3HQ6sjwa0
         gzOevyKT7mqXW5vLlcDp/tnx6X07G/SdNHgo2x+UbxkHm3DNwYkKlaaSOd3bPT7fN4Fd
         kK2fk5RpkW3nx/UUa1FR+VXRaNXwCSuNHxjizrzWSwSRFpDh10nxKaSVNuhBhGeAtgw6
         IPwUHQ0iU+W5GG8eeDHto1kRNKq6T0bh+/i9wc+zdC87fR8KtTzZAviDe3rhTmOb+gr5
         56oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ByxqDJoNSKwEprYR76zP4whjJer5vtw08GNWxCQ8n/Y=;
        b=dhHm0MxhpLK1+CexQTpb9YC3XbZcUPU26YQyT43302jMxb+exFky5GWD/CphqKTgoT
         n0XD3Lrf0RmKRWxjwLw0O0X6WwID3TCxLHzPXZfe3HucIFOPlXxAMSLDfIWeoT0G4CKb
         egbXXAMUX9hXzZ3nQIOnMpD8NK/cl6U4HphuEI5gxyJ7SyqdAABJB2MLFDLH+RMVMisE
         oRKxec1EDwp4Vzj/A6exis9qnQjKK9eKtAVpX1Pn6udDK8x+TUa+Vh/IiI5+2IDgtKeU
         vErP0T+vOfFtm+zVf3RF9PuUsJfz9PmA/2OqB0N1mJ6QhlOLyVqrULeUCR8NvKr8pmET
         rb+w==
X-Gm-Message-State: AOAM5302LMw6vFNz0P/EwLFVGy6ER/nRltRrPFVJUQAyM/+9BLV7YH3Z
        Z4ZssmDZUwIh7BCfOVLmPlkmb9jSK648fg==
X-Google-Smtp-Source: ABdhPJxEuF4/Bq75l3xzrrYQIU/VAtYZiJgOy4M67nKlZctxGqE+aGi2JBiQkKtR0hyQH22D/K46Sg==
X-Received: by 2002:a05:651c:88e:: with SMTP id d14mr13865894ljq.472.1631009823347;
        Tue, 07 Sep 2021 03:17:03 -0700 (PDT)
Received: from localhost.localdomain ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id k17sm964080lfv.285.2021.09.07.03.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 03:17:03 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] staging: r8188eu: Shorten calls chain of
 rtw_write8/16/32/N()
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Fabio M. De Francesco'" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210904220048.12822-1-fmdefrancesco@gmail.com>
 <20210904220048.12822-4-fmdefrancesco@gmail.com>
 <5a359f20e80341c9910ecc6286eb0aec@AcuMS.aculab.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <17d78a9f-9eee-1085-20b5-62fcd700965f@gmail.com>
Date:   Tue, 7 Sep 2021 13:17:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5a359f20e80341c9910ecc6286eb0aec@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 1:10 PM, David Laight wrote:
> From: Fabio M. De Francesco
>> Sent: 04 September 2021 23:01
>>
>> Shorten the calls chain of rtw_write8/16/32() down to the actual writes.
>> For this purpose unify the four usb_write8/16/32/N() into the new
>> usb_write(); make the latter parameterizable with 'size'; embed most of
>> the code of usbctrl_vendorreq() into usb_write() and use in it the new
>> usb_control_msg_send() API of USB Core.
>> 
> ...
>> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> index f9c4fd5a2c53..e31d1b1fdb12 100644
>> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> @@ -8,76 +8,51 @@
>>  #include "../include/recv_osdep.h"
>>  #include "../include/rtl8188e_hal.h"
>> 
>> -static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata, u16 len, u8
>> requesttype)
>> +static int usb_read(struct intf_hdl *intfhdl, u32 addr, void *data, u8 size)
>>  {
>> -	struct adapter	*adapt = pintfhdl->padapter;
>> -	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
>> +	u16 value = (u16)(addr & 0x0000ffff);
>> +	struct adapter *adapt = intfhdl->padapter;
>> +	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
>>  	struct usb_device *udev = dvobjpriv->pusbdev;
>> -	unsigned int pipe;
>> -	int status = 0;
>> -	u8 *pIo_buf;
>> +	int status;
>> +	u8 *io_buf;
> 
> Some of these changes are whitespace or renames.
> They ought to be in a different patch.
> 
> I think you'll need 'reverse xmas tree' ordering as well.
> 
> 	David
> 
You are right, thank you. We will revert it in v4 in all patches in this 
series :)




With regards,
Pavel Skripkin

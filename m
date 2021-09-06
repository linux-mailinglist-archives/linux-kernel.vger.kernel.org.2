Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5E401CBE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbhIFOFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbhIFOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:05:50 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50AEC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 07:04:45 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y6so11554273lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z66n7Klv98ugqFOF5GUDxxDBgLweu1M8Wtpm3iZu2pU=;
        b=pyoBGjP2KlMAvkfNzkOaOTVl/6MmW1ctP9c0Z09ut+tciH6Up98jF9/On32+ziYb6y
         OLtgbWXH5Y9yGUKq1qx6AQuWQNFmOwcKw2J7nZ47kHIlfFL08uGQkGToC1DiVG9dsy3g
         vDkDlTyKqGw/OrV/zUvAsIXiBzP+vYvOXfBgn4Bwp7FnTqBUCoAVxwiiYTowqJ1+s0zp
         3kCiHeXY3oESNMO00NzXYsHOFb5YMHHiSsAYotf4xBU2fDrj4AoYXXID25M2fGLrRrzR
         t23+rMaXe4Kmwj61AFfWUtD9yUv35FUwgUzInw7aFQlhZsJF8wzNYpqnti4AYw71Gp5r
         v5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z66n7Klv98ugqFOF5GUDxxDBgLweu1M8Wtpm3iZu2pU=;
        b=AZ9jil1/MvO8dpYH9X2a48qVmaBl4IMk9iLMY29BiSe/LKy9/h/SrfPSNl0F950BDo
         /FI4gN24usk4bSyd5KhF+Pvk2jaOUyS0IowLb5imvlcisd1gK+69KBqszneJnIPbfz3D
         OFtI88R+9R+8x/OjIrI/Fl3O2p0fQkZtkI0qTz1ORGzd2LwfaymJgB+wRomGkRuouLkX
         ZJhdnZTN3kr90b0U/zKXByz4zsyPAucvGHRau6YXwzaeiAVag3btWF2hgfh8RutUczkG
         zn2d1C4tEErukh7rwetg4m7HdXAv+XBCy/Q5p+gZ8AjD+Ci+GeoMFpanNWpr5JxE2nlc
         WssQ==
X-Gm-Message-State: AOAM5325oZ/peu7sfV07R3VWH2EQxvGBxxByfqx11IxmQoiNnZUMsc0+
        e1FpfKgaf0FT8+ScQBvnx2RFEi6Gxj4nMw==
X-Google-Smtp-Source: ABdhPJycvZ90BGex/QMFxYA45cl3Cr2egPrVoIDho5a0HnrXAvlphkwcnx3O+RleIzImvuPWSlftVw==
X-Received: by 2002:a05:651c:211c:: with SMTP id a28mr10859531ljq.8.1630937083627;
        Mon, 06 Sep 2021 07:04:43 -0700 (PDT)
Received: from localhost.localdomain ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id q189sm1035298ljb.68.2021.09.06.07.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 07:04:43 -0700 (PDT)
Subject: Re: [PATCH 1/3] staging: r8188eu: remove _io_ops structure
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210904150447.14659-1-fmdefrancesco@gmail.com>
 <20210904150447.14659-2-fmdefrancesco@gmail.com>
 <20210906074910.GG1957@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <aec7eb51-721a-d2c1-4eba-c4adbb8265c3@gmail.com>
Date:   Mon, 6 Sep 2021 17:04:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210906074910.GG1957@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 10:49 AM, Dan Carpenter wrote:
> On Sat, Sep 04, 2021 at 05:04:45PM +0200, Fabio M. De Francesco wrote:
>> -static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
>> +int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata)
>>  {
>> +	struct io_priv *pio_priv = &adapter->iopriv;
>> +	struct intf_hdl *pintfhdl = &pio_priv->intf;
>>  	u16 wvalue = (u16)(addr & 0x0000ffff);
>>  	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
>> +	int ret;
>>  
>>  	if (length > VENDOR_CMD_MAX_DATA_LEN)
>>  		return -EINVAL;
> 
> The caller treats this negative return as success.
> 

Oh, good catch, thank you so much for pointing it out... This driver 
uses unusual approach for error handling with private _SUCCESS and _FAIL 
macros and I forgot to call RTW_ERROR_CODE :(

>>  
>>  	memcpy(buf, pdata, length);
>> +	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
>>  
>> -	return usbctrl_vendorreq(pintfhdl, wvalue, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
>> +	return RTW_STATUS_CODE(ret);
>>  }
> 
> [ snip ]
> 
> 
>> -void usb_read_port_cancel(struct intf_hdl *pintfhdl)
>> +void rtw_read_port_cancel(struct adapter *adapter)
>>  {
>>  	int i;
>> -	struct recv_buf *precvbuf;
>> -	struct adapter	*padapter = pintfhdl->padapter;
>> -	precvbuf = (struct recv_buf *)padapter->recvpriv.precv_buf;
>> +	struct recv_buf *precvbuf = (struct recv_buf *) adapter->recvpriv.precv_buf;
>>  
>>  	DBG_88E("%s\n", __func__);
>>  
>> -	padapter->bReadPortCancel = true;
>> +	adapter->bReadPortCancel = true;
> 
> In these functions it would be better to rename "padapter" as "adapter"
> in a follow on function.  Keep it the same for now just to make review
> easier.
> 

Ok, will bring old name back in v4. Thank you for review :)




With regards,
Pavel Skripkin

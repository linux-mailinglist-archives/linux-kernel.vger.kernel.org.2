Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDDF3F85F8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241761AbhHZK7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhHZK7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:59:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B178C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 03:58:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k5so5941643lfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 03:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5b4nVpxfO8+NW6CZGRFVhkfRZGNTXTJfSlprSFO/SUc=;
        b=hSnH37Gz97HUiPA9Iv84KZEa8lYGj8z7xoa7efQ50GAJ19HS4m6QoOsNQ6kxT8+O9T
         H3ZWG+2Z+0Rx0r34Hih+3IOPEcPKulLgTwk8ZdDW3xhr9btKN5DDmqpzz5j2gy98rfBQ
         Cl8fzQq3NfloQ6pWweFkd1Kvsx+Tjz9un/xMmWqCKfX9yNNHz5b1rounJ9eW4HRO3M2b
         oZuUqoycE2qzb96dEw7x8tF2rqryuVwjjyAOunoC6jYz/B/+4hlXbUjTojGJ6A2xkjGz
         gc1c9lQAxMXhdFTtLy4/KygOFnPBghLkrWar3Sn77IqGrCKS2kMxRfTzPLWc4Ya9bLid
         uuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5b4nVpxfO8+NW6CZGRFVhkfRZGNTXTJfSlprSFO/SUc=;
        b=VwTB11NOhfBlSgIxBiwCnC2kURSCn+AVUGhGww8K9xC1Oq16zPsdlgSDLFrpGQp1xw
         D/ZdWyz3ZFXtp21rsgCrr2bQWsTdchXqwEF0M+WBFKuA1BI4/tf43gQ/bUZzPvSTmrng
         FdeSiTTNmsgMjk9X35UXOMqInHSluZ6dzEgx/6n5fl4kKwukD0Dvm5SzH+l1k+7ZHOxk
         w9r4Pt9Rp4u8sreVVPSu1MQWr1WQWQTpamftNv3YWtusqS8b0CRq5Idw2G3aRV7Y6QDM
         Gp3him4UX8cTG/HIJ5l+OKS1CBDO120l+2pqpSCCLEYm4tTIFLWNQnrHzMYjpKRT2qP/
         xfQA==
X-Gm-Message-State: AOAM532FrTc0fjijkcej5NMpjQjsjBvpp3O8Y9cag/mtxYojegtE1SIB
        cH71k8dOPMnNdII59T4SA32xC101D03yTw==
X-Google-Smtp-Source: ABdhPJxtZciDlTE0gnbhK5e2fl7b2yxfmam1d6kJUpnab2Faffe3FszLMv/toy3qAuhLyM+xnOrBGw==
X-Received: by 2002:a05:6512:3ca4:: with SMTP id h36mr2240189lfv.170.1629975513576;
        Thu, 26 Aug 2021 03:58:33 -0700 (PDT)
Received: from localhost.localdomain ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id q9sm314463lfn.170.2021.08.26.03.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 03:58:33 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1629789580.git.paskripkin@gmail.com>
 <d06f3173e0a4c6f5449d5551cbfb0202849332b7.1629789580.git.paskripkin@gmail.com>
 <YSdx4ixYYAyZkOzR@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <ce0db9b5-9222-0b84-81ba-d584b0dd5739@gmail.com>
Date:   Thu, 26 Aug 2021 13:58:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YSdx4ixYYAyZkOzR@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 1:50 PM, Greg KH wrote:
> On Tue, Aug 24, 2021 at 10:27:35AM +0300, Pavel Skripkin wrote:
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
>> ---
>>  drivers/staging/r8188eu/core/rtw_debug.c      |  7 +++-
>>  drivers/staging/r8188eu/core/rtw_io.c         |  9 ++---
>>  drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  4 +-
>>  drivers/staging/r8188eu/hal/odm_interface.c   |  4 +-
>>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 29 +++++++++++----
>>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  5 ++-
>>  drivers/staging/r8188eu/hal/usb_halinit.c     | 37 ++++++++++++++++---
>>  drivers/staging/r8188eu/hal/usb_ops_linux.c   | 22 +++++++++--
>>  .../staging/r8188eu/include/odm_interface.h   |  2 +-
>>  drivers/staging/r8188eu/include/rtw_io.h      |  6 +--
>>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 28 +++++++++++---
>>  11 files changed, 115 insertions(+), 38 deletions(-)
>> 
>> diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
>> index 8b7d3eb12bd0..a41675e101ac 100644
>> --- a/drivers/staging/r8188eu/core/rtw_debug.c
>> +++ b/drivers/staging/r8188eu/core/rtw_debug.c
>> @@ -91,7 +91,12 @@ int proc_get_read_reg(char *page, char **start,
>>  				proc_get_read_addr, (u8) tmp);
>>  		break;
>>  	case 2:
>> -		len += snprintf(page + len, count - len, "rtw_read16(0x%x)=0x%x\n", proc_get_read_addr, rtw_read16(padapter, proc_get_read_addr));
>> +		error = rtw_read16(padapter, proc_get_read_addr, (u16 *) &tmp);
>> +		if (error)
>> +			return len;
>> +
>> +		len += snprintf(page + len, count - len, "rtw_read16(0x%x)=0x%x\n",
>> +				proc_get_read_addr, (u16) tmp);
>>  		break;
>>  	case 4:
>>  		len += snprintf(page + len, count - len, "rtw_read32(0x%x)=0x%x\n", proc_get_read_addr, rtw_read32(padapter, proc_get_read_addr));
>> diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
>> index 2714506c8ffb..fd64893c778d 100644
>> --- a/drivers/staging/r8188eu/core/rtw_io.c
>> +++ b/drivers/staging/r8188eu/core/rtw_io.c
>> @@ -45,18 +45,15 @@ int __must_check _rtw_read8(struct adapter *adapter, u32 addr, u8 *data)
>>  	return _read8(pintfhdl, addr, data);
>>  }
>>  
>> -u16 _rtw_read16(struct adapter *adapter, u32 addr)
>> +int __must_check _rtw_read16(struct adapter *adapter, u32 addr, u16 *data)
>>  {
>> -	u16 r_val;
>>  	struct io_priv *pio_priv = &adapter->iopriv;
>>  	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
>> -	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
>> +	int (*_read16)(struct intf_hdl *pintfhdl, u32 addr, u16 *data);
>>  
>>  	_read16 = pintfhdl->io_ops._read16;
> 
> Why do you need this extra pointer abstraction anyway?  Please unwind
> that first, which will make this function go away (or get easier to
> understand at the least...)
> 
It was there before my changes :) I had a plan to clean up DBG macros 
and this abstraction after adding error handling...


If you feel, that these clean up are needed before error handling, I can 
add them to this series :) Anyway, some of them are already in my local 
tree



With regards,
Pavel Skripkin

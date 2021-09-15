Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4054540CBCD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhIORl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhIORl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:41:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC83BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:40:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 72so1803167ljf.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=glA49UBbneeDxKiA10gj2NCjnJt0xnzb/O/wVbrIuGk=;
        b=PXbbNIkY57KJgM2M3dYz9KTUe93b2rSPILzcWOa9qGw/+EV0OCouyba7J0IMHJ8/cX
         9HyHYezN/hHMGlqnFq/5gkkWiJlnbrbjqJ0uiBX6MeIC9jZgc1t7HTvrwv7uPu5SD0Ew
         SozelOMKQvmxTgTM3MuaXNGN8+CUtIotFMnHHqFUVTPCWsksVtKMz61sZskrAMxzwv9d
         AMhbCDD+S09t9mKv15Ul/0iadYg0YotbBRyWkAFJ/jMY7X1UGYBbiV1EwYtySutKKLDi
         8OSzt7IwvLwH3qTrP2FzHdXhRNZZabWm5vbVBiqXHlNrPS18/iGwcnaUymjklNX8BCS4
         ZWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=glA49UBbneeDxKiA10gj2NCjnJt0xnzb/O/wVbrIuGk=;
        b=1M7vKLmXWe/mQ/hR5ukv9Vyosr5mLAMAh7gXpPY6PRkPbSQXTtIuILBZ/pcoA6/hbj
         Mqpm+VkkpbI6pC191ZKz+jt+lc2DVLY8E8aSTs4c6O2CLarFA61wHutKoT5TcrgGTI9z
         uh3jK1h/i6GJMjCS3lZNtQDtjF+hdM8GIL1JrO65c1lBjPeDto6scUxstTv+gxcK1YUX
         3MXBk3QD+zQOFilOyKUqxvnBHjN7wUcg61etbH+kHEkvy6z+UP5n78VMgw5Tcz5I84yV
         B7u/QpXrA/UzL8qeeKqoi4904IsBtGBMG8HLbWFOSKtPXe3YftHNZk9skNsx8ZU0NQXV
         2mog==
X-Gm-Message-State: AOAM531WmLD+qr1sIr5GN3fuboDdPXRbe9YVzJFu9PEbqUd813BQMR0B
        6JWcUW96tBaRcm3yEMCvX3w=
X-Google-Smtp-Source: ABdhPJzsdgWnMG+4hTNplvDr0l5z0Lyj2Md1GZOkhMYfd2S4nEtyz47CfS5kT8nfSKH0Lsj7LurenA==
X-Received: by 2002:a2e:9999:: with SMTP id w25mr1054660lji.359.1631727606993;
        Wed, 15 Sep 2021 10:40:06 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.49])
        by smtp.gmail.com with ESMTPSA id m1sm39129lfr.35.2021.09.15.10.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 10:40:06 -0700 (PDT)
Message-ID: <80c95bc7-aac3-000d-2749-d470fb71933d@gmail.com>
Date:   Wed, 15 Sep 2021 20:40:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v5 10/19] staging: r8188eu: remove the helpers of
 usb_write_port()
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
 <20210915124149.27543-11-fmdefrancesco@gmail.com>
 <6f89f419-edaf-296a-1021-cdc12f218e7a@lwfinger.net>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <6f89f419-edaf-296a-1021-cdc12f218e7a@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 19:06, Larry Finger wrote:
> On 9/15/21 07:41, Fabio M. De Francesco wrote:
>> From: Pavel Skripkin <paskripkin@gmail.com>
>> 
>> Remove the unnecessary _rtw_write_port() and usb_write_port() and embed
>> their code into the caller (i.e., rtw_write_port()).
>> 
>> _rtw_write_port() is a mere redefinition of rtw_write_port() and it is
>> unneeded. usb_write_port() was the only functions assigned to the
>> (*_usb_write_port) pointer, so we can simply remove it and make a direct
>> call.
>> 
>> This patch is in preparation for the _io_ops structure removal.
>> 
>> Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>> ---
>>   drivers/staging/r8188eu/core/rtw_io.c         | 20 +------------------
>>   drivers/staging/r8188eu/hal/usb_ops_linux.c   |  1 -
>>   drivers/staging/r8188eu/include/rtw_io.h      |  4 +---
>>   .../staging/r8188eu/include/usb_ops_linux.h   |  1 -
>>   .../staging/r8188eu/os_dep/usb_ops_linux.c    |  3 +--
>>   5 files changed, 3 insertions(+), 26 deletions(-)
>> 
>> diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
>> index ac72f894da75..3a5e9dbfcb12 100644
>> --- a/drivers/staging/r8188eu/core/rtw_io.c
>> +++ b/drivers/staging/r8188eu/core/rtw_io.c
>> @@ -87,24 +87,6 @@ void _rtw_read_port_cancel(struct adapter *adapter)
>>   		_read_port_cancel(pintfhdl);
>>   }
>>   
>> -u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
>> -{
>> -	u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
>> -	struct io_priv *pio_priv = &adapter->iopriv;
>> -	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
>> -	u32 ret = _SUCCESS;
>> -
>> -
>> -
>> -	_write_port = pintfhdl->io_ops._write_port;
>> -
>> -	ret = _write_port(pintfhdl, addr, cnt, pmem);
>> -
>> -
>> -
>> -	return ret;
>> -}
>> -
>>   u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem, int timeout_ms)
>>   {
>>   	int ret = _SUCCESS;
>> @@ -114,7 +96,7 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt, u8 *pme
>>   	rtw_sctx_init(&sctx, timeout_ms);
>>   	pxmitbuf->sctx = &sctx;
>>   
>> -	ret = _rtw_write_port(adapter, addr, cnt, pmem);
>> +	ret = rtw_write_port(adapter, addr, cnt, pmem);
>>   
>>   	if (ret == _SUCCESS)
>>   		ret = rtw_sctx_wait(&sctx);
>> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> index a104e3fac7d1..4fea21c0f7af 100644
>> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> @@ -562,7 +562,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
>>   {
>>   
>>   	memset((u8 *)pops, 0, sizeof(struct _io_ops));
>> -	pops->_write_port = &usb_write_port;
>>   	pops->_read_port_cancel = &usb_read_port_cancel;
>>   	pops->_write_port_cancel = &usb_write_port_cancel;
>>   
>> diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
>> index 600c6e7a375b..f2b1978b6e80 100644
>> --- a/drivers/staging/r8188eu/include/rtw_io.h
>> +++ b/drivers/staging/r8188eu/include/rtw_io.h
>> @@ -262,7 +262,7 @@ int _rtw_write16_async(struct adapter *adapter, u32 addr, u16 val);
>>   int _rtw_write32_async(struct adapter *adapter, u32 addr, u32 val);
>>   
>>   void _rtw_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
>> -u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
>> +u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
>>   u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
>>   			     u8 *pmem, int timeout_ms);
>>   void _rtw_write_port_cancel(struct adapter *adapter);
>> @@ -275,8 +275,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
>>   	_rtw_write16_async((adapter), (addr), (val))
>>   #define rtw_write32_async(adapter, addr, val)				\
>>   	_rtw_write32_async((adapter), (addr), (val))
>> -#define rtw_write_port(adapter, addr, cnt, mem)				\
>> -	_rtw_write_port((adapter), (addr), (cnt), (mem))
>>   #define rtw_write_port_and_wait(adapter, addr, cnt, mem, timeout_ms)	\
>>   	_rtw_write_port_and_wait((adapter), (addr), (cnt), (mem), (timeout_ms))
>>   #define rtw_write_port_cancel(adapter) _rtw_write_port_cancel((adapter))
>> diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
>> index 37e0614fd15c..bdc596fe5854 100644
>> --- a/drivers/staging/r8188eu/include/usb_ops_linux.h
>> +++ b/drivers/staging/r8188eu/include/usb_ops_linux.h
>> @@ -30,7 +30,6 @@ unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
>>   
>>   void usb_read_port_cancel(struct intf_hdl *pintfhdl);
>>   
>> -u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem);
>>   void usb_write_port_cancel(struct intf_hdl *pintfhdl);
>>   
>>   #endif
>> diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
>> index 9afb4df71969..36ef06f88fdd 100644
>> --- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
>> +++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
>> @@ -124,14 +124,13 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
>>   
>>   }
>>   
>> -u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
>> +u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
>>   {
>>   	unsigned long irqL;
>>   	unsigned int pipe;
>>   	int status;
>>   	u32 ret = _FAIL;
>>   	struct urb *purb = NULL;
>> -	struct adapter *padapter = (struct adapter *)pintfhdl->padapter;
>>   	struct dvobj_priv	*pdvobj = adapter_to_dvobj(padapter);
>>   	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
>>   	struct xmit_buf *pxmitbuf = (struct xmit_buf *)wmem;
>> 
> 
> Patch 1 failed to apply to Greg's staging-testing branch. Particularly with the
> changes with large number of patches, you need to remove the commits in
> question, got a 'git pull', and then test that your changes still apply.
> 

Hi, Larry, thank you for taking a look a the series.

We based our series on top staging-testing. My local working branch has 
following log:

aadf1e6fd0ca (HEAD -> ops-v5) staging: r8188eu: remove shared buffer for 
usb requests
4a2945ded9d0 staging: r8188eu: Shorten calls chain of rtw_write8/16/32/N()
dc5dd914be8a staging: r8188eu: Shorten calls chain of rtw_read8/16/32()
f6510936cbc9 staging: r8188eu: hal: Clean up rtw_read*() and rtw_write*()
92fc64725670 staging: r8188eu: hal: Clean up usbctrl_vendorreq()
2787e96f1649 staging: remove struct _io_ops
9a94c8d23439 staging: r8188eu: remove core/rtw_io.c
7bc0a60021a8 staging: r8188eu: remove the helpers of usb_write_port_cancel
ccc309c8cb36 staging: r8188eu: remove the helpers of usb_read_port_cancel
c0633b64266f staging: r8188eu: remove the helpers of usb_write_port
c0b56158b2ba staging: r8188eu: remove the helpers of usb_read_port
6bbfbaa06af3 staging: r8188eu: remove the helpers of usb_writeN
d5339c7287c4 staging: r8188eu: remove the helpers of usb_write32
8af95fe85c54 staging: r8188eu: remove the helpers of usb_write16
03f7642f7975 staging: r8188eu: remove the helpers of usb_write8
ce1a4ce58bbd staging: r8188eu: remove the helpers of rtw_read32()
5ecd53227cfa staging: r8188eu: remove the helpers of rtw_read16()
c36c862fd32e staging: r8188eu: remove the helpers of rtw_read8()
01edcf8fcbfe staging: r8188eu: remove usb_{read,write}_mem
5e57c668dc09 (origin/staging-testing, staging-testing) staging: wfx: 
ensure IRQ is ready before enabling it


Can you share your error? Thank you



With regards,
Pavel Skripkin

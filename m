Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A3F3F589F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhHXHCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhHXHCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:02:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D79EC061575
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:01:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p38so43387267lfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=boY+WRSmsQxyePrjVtd+KgGUQgAKGN9c4xSQZsDSEfk=;
        b=tiQTu5qkMepoCpYNmDf5S9OEh7vMa/BOBctsTK/YAeAaS0Swkun2sk5rI4M+6n8AvC
         9LOjCS66QrDxgYXv52+4MlAepNbqZs6NoEs/C7jlWKbXfM19Plu72yUW43emvNvtDIp1
         HAZ+LSJ2nBzsvdsfAdCOLw9Z4RkIOFsunsGijEwNuKkONHD+zhv5ZKH+3T7WcDBkzRQA
         PLk1+T+e/ghzLwaEn3AxG0y5NZHHPkXaoGwv2u2WwMKl5GXNHlqnK+b/kkHLxPSTxoa+
         1WnhUdTE0lP1hLpWZfWE5/mf3MUNOrMyc50GrcJWk2VjkV8X9qneEtYUTGX1pXRUVyay
         x1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=boY+WRSmsQxyePrjVtd+KgGUQgAKGN9c4xSQZsDSEfk=;
        b=R04o9XwvPzNCG9hTEzTuwnpKPRzPH61IVBsLAJM9jWqPf1u9g5GCN4ILs31dDNLrEE
         /V7gsyrkPhPOXy26vOuJ32eEn17c7Va0+BsKi/S2pKDSRQWz+x2rzAFpVq2KXGlwKO3u
         jD2/ovNVsKpwJ1b9abaPTuP2gjPU2viuEczbiFZh94FiAAUeeRwdRfFlydLLqf5Q09/C
         tRNEV4AnoMS10w+Hu4sqdNjsXTACloJqapTH2Gx2IGOJxyIMZ1pXpQsUjv+LpQ9+uzvG
         rLB1JUFFq4q5D4V3+R9vqwqB3SbVzRqz/lfDTigFn59UPR66yfVsUHTskbuqCijijccX
         zuGQ==
X-Gm-Message-State: AOAM533slHu92g+C/jlvddON2/B1ke9gJktqwwUcXJ1Q7SCxUEMhRKEZ
        7ymwwbmKoIxS296YYS0N/yASkVjUuMOjIQ==
X-Google-Smtp-Source: ABdhPJxvLYzO5TKP3tO4p0eiAuxJeWoX/3q1jj/HvSPFhOW6BACouNbdVdBrhMv8b3xiQra1lDvYiw==
X-Received: by 2002:a19:ac42:: with SMTP id r2mr27670685lfc.167.1629788484487;
        Tue, 24 Aug 2021 00:01:24 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id g27sm1782929lfh.300.2021.08.24.00.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 00:01:24 -0700 (PDT)
Subject: Re: [PATCH RFC v2 5/6] staging: r8188eu: add error handling of
 rtw_read32
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1629642658.git.paskripkin@gmail.com>
 <9004eb2972780455db4cba9694244a2c572abba8.1629642658.git.paskripkin@gmail.com>
 <20210824065825.GL1931@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <e50d266f-410c-34cb-e28f-f27dc429ef37@gmail.com>
Date:   Tue, 24 Aug 2021 10:01:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824065825.GL1931@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 9:58 AM, Dan Carpenter wrote:
> On Sun, Aug 22, 2021 at 05:36:01PM +0300, Pavel Skripkin wrote:
>> -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>> +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
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
>>  
>>  	wvalue = (u16)(addr & 0x0000ffff);
>>  	len = 4;
>>  
>> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>> +	res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
>> +	if (res < 0) {
>> +		dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);
> 
> Add a return here.  Try to keep the success path and the failure path
> as separate as possible.  Try to keep the success path indented at one
> tab so the code looks like this:
> 
> 	success();
> 	success();
> 	if (fail)
> 		handle_failure();
> 	success();
> 	success();
> 
> Try to deal with exceptions as quickly as possible so that the reader
> has less to remember.
> 
>> +	} else {
>> +		/* Noone cares about positive return value */
> 
> Ugh...  That's unfortunate.  We should actually care.  The
> usbctrl_vendorreq() has an information leak where it copies len (4)
> bytes of data even if usb_control_msg() is not able to read len bytes.
> 
> The best fix would be to remove the information leak and make
> usbctrl_vendorreq() return zero on success.  In other words something
> like:
> 
> 	status = usb_control_msg();
> 	if (status < 0)
> 		return status;
> 	if (status != len)
> 		return -EIO;
> 	status = 0;
> 

I see, thank you for reviewing, will fix in v3! I fully forgot, that 
usb_control_msg() can receive only part of the message :)



With regards,
Pavel Skripkin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56823F40A7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 19:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhHVRSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhHVRSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 13:18:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F46C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 10:17:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l24-20020a05600c089800b002e71a10130eso5961387wmp.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sEl/hyZ7kkBatB0+Pybs8eAVxEoG8hdkIB6+FOqjRRg=;
        b=KyuGkNnUR/vjYSUpnJZcdZ0hV8DY4buDzPJ7GDW8/XPGHFZfwFOeENLdNPEB0j4MSQ
         mZM0skYLFOPOK5tvLURCaY09x7PBNCsyzp2FllsS1EHLclw3Iv2OFcEoHMT3Aov3FW2/
         Qn0HzVDpYPqZvYT4ZwfzNSnwBr4nfucPbNIXTuDgzMh9tuXe3Q1xLzmkU3Z/NREJ+P7F
         HMuClsBrCNrRo1Rl0oE4DdJ2XybfVbt7PQvuLjPU9pQfqA44khgk62g2e0GBaRTArUD8
         DvtR3gCFpfw4maQv6CD7VgSATu/850IUf2SasGGQPOPJU+VJR39Jm1EnS6Ou5tz/RHXt
         X+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sEl/hyZ7kkBatB0+Pybs8eAVxEoG8hdkIB6+FOqjRRg=;
        b=URGCnW8qaz9R2cVSFyNqHXwahrivyzJUP4LwqQmv0E1HG9pso7eNU0KaRVDBzUwJds
         tyU/64f5P8HIDiS90kLUB8IvZT9fuyRcmEHEQ1YPt9PdKvyNl9wMevuePgSJ+T05nz/2
         yzG+jG1Nn7RXwcdNB64Pkz+9KG2yXQDC/x2QaKt8eUPSEKpjojmdSNrp95+S9yQ9qRbl
         inOnF448p4uuA8wxdIdjwYCexVUK5/88Yh2SeMTUsxZ8zT6EccX7W6wjKPkA2RnGiW3K
         SwFt0AGzpH+SqbnS+rOrgf68Wx8l9KUVxo2eSjaZYOmuRPNF7kLZxp+88XZqzvwzCCIJ
         31hg==
X-Gm-Message-State: AOAM531isQEzLrKkpg36fL/tqYdJbB0iMDdaU/oPFdjQc74lxGVDgTJP
        3ajEKuTXCnfALJhmmaizO2ligD74sDk=
X-Google-Smtp-Source: ABdhPJwMdTTythl9UPl8D2UOCATZXrUEuzbRmIgB7XwCGOj0CStOhdauWTQ8UN+9Z6PHL0h1SM1TzA==
X-Received: by 2002:a1c:443:: with SMTP id 64mr6703026wme.180.1629652676880;
        Sun, 22 Aug 2021 10:17:56 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id q11sm15857796wmc.41.2021.08.22.10.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 10:17:56 -0700 (PDT)
Subject: Re: [PATCH 08/10] staging: r8188eu: clean up the usb_writeN
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210821164859.4351-1-martin@kaiser.cx>
 <20210821164859.4351-8-martin@kaiser.cx>
 <6593f24b-8986-df5f-e2ba-5358360939df@gmail.com>
 <20210822165844.2h6yt42ejshw7tnc@viti.kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <1706da7b-ca98-2288-6e07-ae5912b90139@gmail.com>
Date:   Sun, 22 Aug 2021 19:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210822165844.2h6yt42ejshw7tnc@viti.kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/21 6:58 PM, Martin Kaiser wrote:
> Hi Michael,
> 
> Thus wrote Michael Straube (straube.linux@gmail.com):
> 
>> On 8/21/21 6:48 PM, Martin Kaiser wrote:
>>> Remove unnecessary variables, check the length.
> 
>>> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
>>> ---
>>>    drivers/staging/r8188eu/hal/usb_ops_linux.c | 15 +++++----------
>>>    1 file changed, 5 insertions(+), 10 deletions(-)
> 
>>> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>>> index e01f1ac19596..5408383ccec3 100644
>>> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
>>> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>>> @@ -151,20 +151,15 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>>>    static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
>>>    {
>>> -	u16 wvalue;
>>> -	u16 len;
>>> +	u16 wvalue = (u16)(addr & 0x0000ffff);
>>>    	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
>>> -	int ret;
>>> -
>>> +	if (length > VENDOR_CMD_MAX_DATA_LEN)
>>> +		return -EINVAL;
>>> -	wvalue = (u16)(addr & 0x0000ffff);
>>> -	len = length;
>>> -	memcpy(buf, pdata, len);
>>> +	memcpy(buf, pdata, length);
> 
>> Hi Martin, shouldn't this be
> 
>> memcpy(buf, pdata, (length & 0xffff));
> 
> I don't think this makes any difference. I've already checked that
> length <= VENDOR_CMD_MAX_DATA_LEN, which is 254. memcpy takes a size_t
> parameter for the number of bytes to copy. length will not overflow
> this.
> 
> Best regards,
> Martin
> 

Hi Martin,

ah, I see now. You are right.

Acked-by: Michael Straube <straube.linux@gmail.com>


Thanks,
Michael


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06CD38B6DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhETTOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbhETTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:14:49 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF553C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:13:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t30so12526367pgl.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DJDVCA+gTY1ofVftg2mVfT8s7c57BrdQNCyue4FC79U=;
        b=fqDPoTeEENofYmVixN+R6rC1iBE5poBxhjsTTBYa5t0Ir0T4vSc02Mbi2oq3FnlL6/
         SOBJjSzB5ctf1Hxgy6PDxMj+6Pa0BHoWzvIp3r0A7My8G4+1uiqfOmiT1orXjxa3Yehb
         OG9CSlY3iRu2EOoT5neOuA7021091Q8ZRMuy/OPo0PM/KU0loSUaF9ECAPs0CVT5UPiT
         EMgildhnZN9f53huiu+cpnKV71hT5n6pmsTRYktxDZraFp3q2sZMIzq3VAKrhulRrNH8
         HLDXOIHNdYKPkr3O+fukoDa4mKJRuRqqUaJB8yt9w71TVTw1Bs/kuP0j3c6e6WVhRVUR
         ERUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DJDVCA+gTY1ofVftg2mVfT8s7c57BrdQNCyue4FC79U=;
        b=p5b6rRpNdFkJGbNDJQyaA4ZYOYmJaX67PkLYnatoEehSyzVTSRE13Kfa+TfX74KynY
         iT+adkYe14mLLr7PTsUfH98tFD7AFjcpET9tykx6VqIW4SbADs/5F8aVEPph3nLg7EsW
         Q5VABiYhv++xgTCh8EEpmsshI5Eqhcca853rHQnnVtA9N3mZ8zB7Yi0CR9gbqIaQfT26
         eVaAJMyDXLUmk/kVs5Ry6A5V1pomwFCe1vd4EEXja3aKzinJErh4kzdO1gu6OC2CZjRZ
         B1/qOp0SSRK2u1uKscMyrYn9pV3hCvnTRi6r6Wd1WxV/5r49MWyWSukgKDLDJju5C8YC
         VJTw==
X-Gm-Message-State: AOAM530Bs7LcR+FU/GtbYbrDGx35uS18qHZUiMjV3PAqnYwKgmmGlWF2
        QEIJuwC2cN4QCoLl92O/dtw/Q1i9lwsvbIhV
X-Google-Smtp-Source: ABdhPJymTnvzBmDvZVbk7KNYZRGJNiqbzbbcD/H9zFvPRBdAEw/dgE6NgYN2Fk8sVpeFuDNd20DS2g==
X-Received: by 2002:aa7:8a1a:0:b029:2d4:a24:8967 with SMTP id m26-20020aa78a1a0000b02902d40a248967mr5982882pfa.11.1621538001187;
        Thu, 20 May 2021 12:13:21 -0700 (PDT)
Received: from [192.168.1.2] ([103.196.78.23])
        by smtp.gmail.com with ESMTPSA id a24sm2629526pgv.76.2021.05.20.12.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 12:13:20 -0700 (PDT)
Subject: Re: [PATCH] staging: emxx_udc: Fixed coding style in places where
 lines should not end in '('
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Sean Behan <codebam@riseup.net>,
        Colin Ian King <colin.king@canonical.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210520174701.8370-1-hridayhegde1999@gmail.com>
 <20210520181838.GI1955@kadam>
From:   Hriday Hegde <hridayhegde1999@gmail.com>
Message-ID: <a1c0247c-9cfe-b03a-86eb-a8313be25e55@gmail.com>
Date:   Fri, 21 May 2021 00:43:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520181838.GI1955@kadam>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-2021 23:48, Dan Carpenter wrote:
> On Thu, May 20, 2021 at 10:46:57AM -0700, Hriday Hegde wrote:
>> The fixes were for the following checkpatch outputs:
>>
>> CHECK: Lines should not end with a '('
>> 1076: FILE: drivers/staging/emxx_udc/emxx_udc.c:1076:
>> +				_nbu2ss_writel(
>>
>> CHECK: Lines should not end with a '('
>> 1228: FILE: drivers/staging/emxx_udc/emxx_udc.c:1228:
>> +		length = _nbu2ss_readl(
>>
>> CHECK: Lines should not end with a '('
>> 1465: FILE: drivers/staging/emxx_udc/emxx_udc.c:1465:
>> +			regdata = _nbu2ss_readl(
>>
>> Signed-off-by: Hriday Hegde <hridayhegde1999@gmail.com>
>> ---
>>  drivers/staging/emxx_udc/emxx_udc.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
>> index 741147a4f0fe..8364316c1d25 100644
>> --- a/drivers/staging/emxx_udc/emxx_udc.c
>> +++ b/drivers/staging/emxx_udc/emxx_udc.c
>> @@ -1073,8 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
>>  		i_word_length = length / sizeof(u32);
>>  		if (i_word_length > 0) {
>>  			for (i = 0; i < i_word_length; i++) {
>> -				_nbu2ss_writel(
>> -					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
>> +				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1]
>> +					.EP_WRITE,
>>  					p_buf_32->dw);
> No, this is worse than before.
>
> regards,
> dan carpenter
>
Yes sorry, didn't really take into account readability.

Thanks
Hriday

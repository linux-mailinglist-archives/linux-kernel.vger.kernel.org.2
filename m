Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3BC401DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbhIFQBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhIFQBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:01:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C746CC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:00:02 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s3so12033849ljp.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=twGtmfDzBAHKvF2VlmhhZjcU0XdG5QkPmLUmZIfBd9M=;
        b=cg1Zl9vw6PAmX1heiKgpoamPuYY+GjEHjZiY9YEUJAARcXycY+FkSjeLqMrKvQ2i2d
         OeydYLRYbIJSGYZXYEsqKIuUkkaxRkoDOEbgfLFElQX45twLfS0Jqfkr0Ny2vkeyFZIg
         IhC9RZ4lJMdtdtEQEst/ovba4P2PCLK0u9WslyuC75sC9BS+rJPHNsMSV3KkwQ6TQK5O
         FZOHXhqrOK2M2+JdbpkfoAI41ChHJTaWQOoXF5JAQEuo5VguslxpVRxg6wLkJcvoAHzd
         VGzedP7SDV0fcjQ/tderm5PubQhljnAiYBQbfuyjYZVn+dtgAil1EUbV4MEJUS4B88oM
         xxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=twGtmfDzBAHKvF2VlmhhZjcU0XdG5QkPmLUmZIfBd9M=;
        b=NBtAV0Nnd7T31Vv+3jgdJ37VtaD6B+rnCx41j4cMNpGA2V7CKXJC/PD5Xw/Vh088LQ
         AvKfnvdemByuZmhO6O/WDfu1QmcQdPKupGlx9TuqgiVhLDo2FXnzQQgTfyk6Fknr2abB
         bBpXtJVUr1P3+VxSCSJjU+HvsPh9SsXa4Bv61WoxVfyqDOAsi+YwTol7FnZmc0SYb3Ig
         dCHEwELHWTeyvvYol5spbW0czwEYbAC1+cAV5H9kFS+z5epxjzVPzSZ2SulRtJu/raxE
         8ZkVHR9ipVx8Sg5VmUUMXr5Gl7a7WqGzhuIE/cEXmrrdh3OBmRb0DEmZyec7Fy7w0S8D
         +Glw==
X-Gm-Message-State: AOAM532rmskSmVDQYV5wK9Oi5/xIRudScG5zgQoSsHPp5WsJcNzrMzkm
        0SuITIHJQ1dqP/GVr3zJW04=
X-Google-Smtp-Source: ABdhPJx+6euSSK9xV5ERLg3qVdUOaGMMAUNxtfkUYSfuvogXZjwh2D4jgs+mt4WJM1P2Ueb930dlAg==
X-Received: by 2002:a2e:9455:: with SMTP id o21mr11054506ljh.103.1630944001118;
        Mon, 06 Sep 2021 09:00:01 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.70])
        by smtp.gmail.com with UTF8SMTPSA id z16sm771345lfd.21.2021.09.06.09.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 09:00:00 -0700 (PDT)
Message-ID: <0f13057d-f33a-9efa-4cae-937169abbcd8@gmail.com>
Date:   Mon, 6 Sep 2021 18:59:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] staging: r8188eu: fix type mismacth
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210905205216.24831-1-paskripkin@gmail.com>
 <20210906065650.GD1957@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20210906065650.GD1957@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 09:56, Dan Carpenter wrote:
> On Sun, Sep 05, 2021 at 11:52:16PM +0300, Pavel Skripkin wrote:
>> smatch says:
>> rtw_cmd.c:1165 rtw_setassocsta_cmd() warn: struct type mismatch 'set_stakey_rsp vs set_assocsta_rsp'
>> 
>> Since psetassocsta_rsp has struct set_stakey_rsp * type, it looks like
>> copy-paste failure. This error didn't cause any bugs, because
>> sizeof(struct set_assocsta_parm) > sizeof(struct set_stakey_rsp), but
>> there is no reason for allocation extra unused memory
>> 
>> Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>> ---
>>  drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
>> index fee4208dacba..afe6c7fa594d 100644
>> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
>> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
>> @@ -1162,7 +1162,7 @@ u8 rtw_setassocsta_cmd(struct adapter  *padapter, u8 *mac_addr)
>>  		goto exit;
>>  	}
>>  
>> -	psetassocsta_rsp = kzalloc(sizeof(struct set_assocsta_rsp), GFP_ATOMIC);
>> +	psetassocsta_rsp = kzalloc(sizeof(struct set_stakey_rsp), GFP_ATOMIC);
>>  	if (!psetassocsta_rsp) {
>>  		kfree(ph2c);
>>  		kfree(psetassocsta_para);
> 
> I'm not sure this is correct.  Might be, might be not.  But we use
> sizeof(struct set_assocsta_rsp) later in the function so it likely leads
> to memory corruption.
> 
>          ph2c->rsp = (u8 *)psetassocsta_rsp;
>          ph2c->rspsz = sizeof(struct set_assocsta_rsp);
> 

Hi, Dan!


Unfortunately, this function is unused, so I will just remove it in v2 :)


With regards,
Pavel Skripkin

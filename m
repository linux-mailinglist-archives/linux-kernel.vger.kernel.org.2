Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6211342485A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbhJFU5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhJFU5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:57:31 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC786C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 13:55:38 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id n64so5932862oih.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JvTa2lKBoI8pDHEiWBkxH9Br7TgFSzn7gNvMea8puyE=;
        b=GHKG4f+JDyBw783UV6ULROcl/lb/K5rec7Me193E2Cz3VdjF9s4lYC1jmlGbFMV1Nt
         Qq6Nn8d/3JKLDPjKiNUH/GLZLpRUhAXzPss6G1JN3VH7S7eweRd1sxuXWNxZD315d7EN
         PFyIb5ARTlTUSievJPL7tj4LJ4ydtt1xbLyzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JvTa2lKBoI8pDHEiWBkxH9Br7TgFSzn7gNvMea8puyE=;
        b=cz7nahp8Hx37qGfEW+0GzMQTInNmVWlmIIGR/c/EqtlPo31zNmfgagQs3BRSZN5Jya
         ef4ZTgP6G3AoGaAUji15+S+M6/wD9OMteWX1olBxhX0QLeNlltuN/ayeKsieQj9aei5A
         f5Bjtja7/ce+SbGR8WipJ55y0c4ukQXgW+MK8JtPtnyENZRdHOhNjmkB901HMusBcADQ
         kRN1STst4brx/9+GDLt6PnYn5hxL3mPry95D6mMGuAVzPV9OnRb+qjFXmInXX+cmkWvW
         1wyMn6R15SuHVSutsHo+XVaWmrvfTt6rI5snqVN/VxSVKHigvZuEEz7kaYFPWt/d5GHm
         ZgaQ==
X-Gm-Message-State: AOAM533ebvDN9Ns2NHUowzKhibpWqJsoHyjrn9ekzIKsYy2B6ivUHdjS
        U3Grpk4+nRVfkUdA+4JIvneBVA==
X-Google-Smtp-Source: ABdhPJzkTmkeqt1d1IgAw8uqylMn+U2CKvyQpd1md95wOPaS5qvtKnrya6+H/PaGK2fiqa20u55PRA==
X-Received: by 2002:aca:dbc2:: with SMTP id s185mr305618oig.141.1633553738147;
        Wed, 06 Oct 2021 13:55:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l1sm3351258oop.28.2021.10.06.13.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 13:55:37 -0700 (PDT)
Subject: Re: dm: change dm_get_target_type() to check for module load error
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211004200641.378496-1-skhan@linuxfoundation.org>
 <YV4IecLg56NpzkYx@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f1eebe07-492e-3152-8070-ea622d36bd33@linuxfoundation.org>
Date:   Wed, 6 Oct 2021 14:55:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YV4IecLg56NpzkYx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 2:35 PM, Mike Snitzer wrote:
> On Mon, Oct 04 2021 at  4:06P -0400,
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> dm_get_target_type() doesn't check error return from request_module().
>> Change to check for error and return NULL instead of trying to get
>> target type again which would fail.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   drivers/md/dm-target.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
>> index 64dd0b34fcf4..0789e9f91d3a 100644
>> --- a/drivers/md/dm-target.c
>> +++ b/drivers/md/dm-target.c
>> @@ -41,17 +41,22 @@ static struct target_type *get_target_type(const char *name)
>>   	return tt;
>>   }
>>   
>> -static void load_module(const char *name)
>> +static int load_module(const char *name)
>>   {
>> -	request_module("dm-%s", name);
>> +	return request_module("dm-%s", name);
>>   }
>>   
>>   struct target_type *dm_get_target_type(const char *name)
>>   {
>>   	struct target_type *tt = get_target_type(name);
>> +	int ret;
>>   
>>   	if (!tt) {
>> -		load_module(name);
>> +		ret = load_module(name);
>> +		if (ret < 0) {
>> +			pr_err("Module %s load failed %d\n", name, ret);
>> +			return NULL;
>> +		}
>>   		tt = get_target_type(name);
>>   	}
>>   
>> -- 
>> 2.30.2
>>
> 
> While I appreciate your intent, the reality is that multiple targets
> may be made available in a given module.  And so loading one dm module
> may bring in access to N targets.  There isn't a rigid 1:1 mapping of
> target modules to names.  And there may not even be a loadable module
> that has the name dm-${name} -- but that doesn't mean the target_type
> won;t have been loaded into DM for it to access.
> 

Thanks for the explanation.

-- Shuah


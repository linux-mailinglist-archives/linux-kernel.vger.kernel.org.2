Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782933F96BD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbhH0JRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbhH0JRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:17:19 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED37C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:16:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g13so12978026lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VwzfECxpCdVoPZvMBUhjsZ1CU0bHcG8tMQUcJoB03Mc=;
        b=U6YJzYHhiIzC093S977N4kojGE2WwMIjAs6xGSKaleQLY4hI+jPjthAivr0L/Gglbw
         rMS8U5STB3QsD9UWWCSfk44W4FuDQfh5Wu8apnVfbkJG2LPYy1wbRLzhdEgNHKpuaFnm
         hLNC4JjpVY+xFm68Tcdh/Bo+E/4edjIbq+9Talzc7BYXyOyI7SDEknfVB/k2QSbRJBwM
         5Oj2GYe2HnqMJfM7QHWRDHau5p0hiyiIypJ5SIG4A4M6WDMSoZAGExo5TW1Au22D6g24
         3hPbgoxNVgzSN+HjavzL4o8xdIw819E6P1kv4qQwznfPyroedtmLrhBIMCLld5O3cNFa
         OGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VwzfECxpCdVoPZvMBUhjsZ1CU0bHcG8tMQUcJoB03Mc=;
        b=ZVaJviuPtMPq6iUyRVK7qHn6k7WEfEsh83GXd+/d3EelSvCEM7ymKv97FQRXIHKYUI
         NbU/phT8ZM8lNZSbWnUr6MsR1loqPHsQmaO7svVAC+DtVFFsU27SLzwvqZ0lZt1AUDVs
         AVRMTvgBr5Txq1X2dD8OYofPCIJM6y2UbJNFZrj4rJSbCFRbNA/JuRoNA3i7Dgc5xRLA
         v21npsHLgkoHqdVFdUkxegCBXsOwqBDTd0jGUWfTf0C1tOmBaP0OB2kdzUjXgfKi0b1W
         f7+9dKtb3YtZITSgjtpcBFYoDqkEDhXLPq/kwIIv5g3bzczLFwFbfYVgXUp1wcu0sfY2
         PhWw==
X-Gm-Message-State: AOAM532dqwY+k99ELstex3z6cSI1hpSX8GotUNVzZxfGu0IswdCqaWdo
        ctam1EYN9mDAK2SURz5L1vGd3r0jM9luiA==
X-Google-Smtp-Source: ABdhPJycNrabdok/Z8eft5BVQ9a42ip6dQ5f2EGgX78UHL4HQER2tKNGQSgPBTtYULu8nrHnjYWp4A==
X-Received: by 2002:ac2:5456:: with SMTP id d22mr6112299lfn.139.1630055788705;
        Fri, 27 Aug 2021 02:16:28 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id m28sm615005ljc.46.2021.08.27.02.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 02:16:28 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] staging: r8188eu: add error handling of rtw_read8
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1629789580.git.paskripkin@gmail.com>
 <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
 <20210827090706.GA12231@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <84e04d0e-8a07-aedd-117a-6b6337b865c7@gmail.com>
Date:   Fri, 27 Aug 2021 12:16:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827090706.GA12231@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 12:07 PM, Dan Carpenter wrote:
> On Tue, Aug 24, 2021 at 10:27:27AM +0300, Pavel Skripkin wrote:
>> @@ -83,7 +83,12 @@ int proc_get_read_reg(char *page, char **start,
>>  
>>  	switch (proc_get_read_len) {
>>  	case 1:
>> -		len += snprintf(page + len, count - len, "rtw_read8(0x%x)=0x%x\n", proc_get_read_addr, rtw_read8(padapter, proc_get_read_addr));
>> +		error = rtw_read8(padapter, proc_get_read_addr, (u8 *) &tmp);
>> +		if (error)
>> +			return len;
>> +
>> +		len += snprintf(page + len, count - len, "rtw_read8(0x%x)=0x%x\n",
>> +				proc_get_read_addr, (u8) tmp);
>>  		break;
> 
> Oh my goodness...  :P
> 
> If you look at what proc_get_read_addr is, it turns out it's a 32bit
> address which is controlled by the user in proc_set_read_reg().  LOL!
> Just a giant security hole.
> 
> My advise is just delete this dead code.  No one is using it so how
> necessary can it be?


Yep, it's dead code as was already mentioned. My plan is to convert all 
this code to sysfs. One thing I am wondering about should I include 
these changes into this series?...





With regards,
Pavel Skripkin

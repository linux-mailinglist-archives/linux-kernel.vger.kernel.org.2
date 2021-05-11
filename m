Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E28F37B2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhEKXwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKXw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:52:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E83C061574;
        Tue, 11 May 2021 16:51:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gj14so12549048pjb.5;
        Tue, 11 May 2021 16:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jRIv26CWSKa/axySwYhnWGK/F55PS2gCs4qGxABhBpw=;
        b=L+RUX6/9ROIpoSbjzvEGm1ekokvTeuZ+JzDa6HSJcxTO/mSCsXYwJ/COSTG1Z0EVnZ
         6kiXLLWlw9KI6ooBoLfKGVRkx+HjklxJHnvk3eh2S8fn0u7/GGGPtvoa1KE2NYfOuq/m
         VWE3O0n7dl8icmi2YlMLHqwmRcmfFZI6FgNVB9Tx6eKeGP0O1G/FUXeqPxhB0mc6JSwB
         csH/XJR7v4XPVEDOPu5kuOQme3TKKElywhwvgL+KNOL3dh60t+25DyEWY7zlMkjl9XYu
         tFlbp0Pl4WepMT0pYc0oo/m8mqbCmZAG2drWXXSyLBYgA4kecCwwMDr1iEhX/Gf0CHlj
         8SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jRIv26CWSKa/axySwYhnWGK/F55PS2gCs4qGxABhBpw=;
        b=H+8FMyYq/785Z0e21fqlPGNjOKZYA9TqNdYtWOQCGsBbyNoe+u3A3hKO1uhFvrPSiE
         bha5Liwpe/NJD0wcqh4IU67b5S4SwReRnCH4NNqFLwH9YG9Cs/XyIqRRJ0JUMJYuS8o+
         b11b/xzaOqA3iW6N/P1NCr+7bD4Z2WgexPTpQwIMzlGeeBdcYUvZBzN17b2jmFNoAyQW
         F8+u7Oe/D+idpssa9ezY3p4QZmz2bDODP8eJ3OBOGtTVLW0AFK8M2HomiF9XAET2bFEX
         dXJ5B2o1w1Na3KxVOniK3+p4uNomoP0QnIvZTti8gTHyU+2wlSt4TO6cKIrI6pSEUl8u
         02CQ==
X-Gm-Message-State: AOAM533gZVOXTEFYhBB+ckfZH6ZRT5RpzGC3hqBcNqDQm2vZZ23J++zW
        g6NpryWmoGzDDCYZQZnCEF9JpaFVJkKUnj2239tMgg==
X-Google-Smtp-Source: ABdhPJzhVDdRW0ZRALecZ/6mY1DXiY/a7BhLkd2VMh37ds8bwHGN+H0bwjj042iTbqIjoJTnw/dtBA==
X-Received: by 2002:a17:90b:508:: with SMTP id r8mr18562120pjz.152.1620777081496;
        Tue, 11 May 2021 16:51:21 -0700 (PDT)
Received: from [10.71.15.213] ([111.223.96.126])
        by smtp.gmail.com with ESMTPSA id q21sm14417935pfl.152.2021.05.11.16.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 16:51:21 -0700 (PDT)
Subject: Re: [PATCH] Remove link to nonexistent rocket driver docs
To:     Jonathan Corbet <corbet@lwn.net>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210511134937.2442291-1-desmondcheongzx@gmail.com>
 <87bl9hdwxt.fsf@meer.lwn.net>
From:   Desmond Cheong <desmondcheongzx@gmail.com>
Message-ID: <d58cf981-4162-1756-1e1e-fa9516e35a1d@gmail.com>
Date:   Tue, 11 May 2021 19:51:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87bl9hdwxt.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 1:03 pm, Jonathan Corbet wrote:
> Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com> writes:
> 
>> Fixes: 3b00b6af7a5b ("tty: rocket, remove the driver")
>> The rocket driver and documentation were removed in this commit, but
>> the corresponding entry in index.rst was not removed.
>>
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> 
> Please note: the "Fixes" tag should be down at the end with your
> signoff.
> 
>>   Documentation/driver-api/serial/index.rst | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/driver-api/serial/index.rst b/Documentation/driver-api/serial/index.rst
>> index 21351b8c95a4..8f7d7af3b90b 100644
>> --- a/Documentation/driver-api/serial/index.rst
>> +++ b/Documentation/driver-api/serial/index.rst
>> @@ -19,7 +19,6 @@ Serial drivers
>>   
>>       moxa-smartio
>>       n_gsm
>> -    rocket
>>       serial-iso7816
>>       serial-rs485
> 
> Otherwise this looks like a good fix.  I've applied it (with Fixes in
> the right place), thanks.
> 
> jon
> 

Thanks for the feedback and the amendment, Jon. I will take note in the 
future.

Best wishes,
Desmond


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03073266CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBZSRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZSRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:17:22 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC3C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 10:16:42 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id u20so10566742iot.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 10:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=++70fAlAOH2s61QgMcTjkJmnOFcHIUa2TWnJxzUPnsQ=;
        b=U/cgqgeFEP7+jbZav60kIxVxhmp/WjepC70KAl79RUsnNypDQ7vIB9AKjaFuD1XImn
         +EsEWWlsekQYuYCc2I2X63/p8j7L9nOWK3h3XpoYp8m2cpLkVNlggFKqWZmCe0zHFiyt
         smEFFEssVXqte3MwHGZ/XtnMxduVXf8l/guIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=++70fAlAOH2s61QgMcTjkJmnOFcHIUa2TWnJxzUPnsQ=;
        b=CTWBLmMiJos7G1uCvq5Vzq2Cw7TdySJcVP/5sJdu+X9tNS8oicV9NzsJUDK1IcDrvk
         xZWdX0a73fu49AVxX1hyNS67k+d0pWHKAVe2to6FlbGKAo+HpWOcqHJzNoNux0GbiZTv
         QqnvTUARUjAK6JLaj9v2MTjudNl1d5FrFdeglVtaC0VgDIp6c5zLI7nuaz3GX8xpW/OT
         F1gBkUEYT/tS2Fp1bYNboaYSH55h69ddLMMLiVq9dcuFlF8Cs+DrSiwcnCKdRgTObMiB
         e3DUNTtGH7yKzYEHs9oEVZuvcYBKx8Ju74NS84cOePbye1DpiU2bLyGq/+8rMNvqHdGM
         KV3g==
X-Gm-Message-State: AOAM530CCraWwZPWJvIkwKMYh28EkMQScPK8zeOEIOdSoHW2vtQwJL0w
        zSKOcNfmwpm1O4rXJW2Nwoe7+Q==
X-Google-Smtp-Source: ABdhPJwpHZPEqcg0TRe5ho36fp9HDmq8putkCfuc32ip2fHjH1r7zpddswLZ6FdnDWpXc758aSMEqA==
X-Received: by 2002:a05:6638:e93:: with SMTP id p19mr4134186jas.10.1614363402047;
        Fri, 26 Feb 2021 10:16:42 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m11sm2318054iop.11.2021.02.26.10.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 10:16:41 -0800 (PST)
Subject: Re: [PATCH v2 2/3] lockdep: add lockdep lock state defines
To:     Johannes Berg <johannes@sipsolutions.net>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1614355914.git.skhan@linuxfoundation.org>
 <af1511df953fe49f95953cbc23d86fb7cdaff58d.1614355914.git.skhan@linuxfoundation.org>
 <4a997ea7b6625428c21dc3e423e96ee54d6785e2.camel@sipsolutions.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bb815b1d-5377-95a1-9610-827a30cb8525@linuxfoundation.org>
Date:   Fri, 26 Feb 2021 11:16:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4a997ea7b6625428c21dc3e423e96ee54d6785e2.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/21 11:03 AM, Johannes Berg wrote:
> 
>> @@ -5475,7 +5476,7 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
>>   		/* avoid false negative lockdep_assert_not_held()
>>   		 * and lockdep_assert_held()
>>   		 */
>> -		return -1;
>> +		return LOCK_STATE_UNKNOWN;
> 
> I'd argue that then the other two return places here should also be
> changed.
> 

Makes sense.

Since lock_is_held_type() simply returns what  __lock_is_held() for the
other cases, __lock_is_held() is the one that needs changes to use these 
defines.

thanks,
-- Shuah





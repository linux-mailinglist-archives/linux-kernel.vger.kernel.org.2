Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863F335740C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355146AbhDGSP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355145AbhDGSPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:15:47 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A442FC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 11:15:35 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n8so19650569oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uoEi3BP3d29vcJAQRKbNC4SG8iDtnjjh94HE5FU651c=;
        b=K83N5rh9ut515leNqDhrXT9JgDlyPDxDpX77guxK/mO9vXGV3Jbe8iKqVkZHOC5lm3
         h0RIqlqvs4vpnd7fztqsO4S62/zNapA/6Q/Jz2FC1x2TDQHiF6zPY2h4rqSKJAiWWkXg
         +wo5BpbBT+qCOujgsniETQRNPwduzfyciOZvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uoEi3BP3d29vcJAQRKbNC4SG8iDtnjjh94HE5FU651c=;
        b=NrLZp/efkm9iLU+C7brltJ9vPf0UjSajYD/Yf2SEkHwygcT5pcwOjR/hOet9mLjtGQ
         qMTB8bSzViSIQenAJDqFk7hIFG/T0VKu46bDgfxa/WPNHFIUt5oAsvvGZaG2BTSA1uSD
         JpToA/L+7qn4wnmMnHrUehV/OHWIYWHaoxgfeBsaLcweDBTcbV3PGqOXe5dQ7OoKyNos
         rYw/JkzIALN1JuBygx79xMLaSSnhQxKqpENNtJiNrfm5rhO6p/U+wehABEcvqh6OyiRh
         7R11WMnhJWiTqzPfnhpeoC4thNNNzY3i/ouqTQ523s4q3Tr9tI5J3dx14+Jw60zQI9yy
         tH6w==
X-Gm-Message-State: AOAM5317VNHErbotQbRBuBTHyAC+2wIBA7S8B8LLwssGytROyfK+9mrU
        QgNsVbrZw/+8Pv5/NGjsT5Cx375AWxEL4Q==
X-Google-Smtp-Source: ABdhPJwuzgvRhgvbMl5pTOzFGcrVdkaCXJC/0TY6RWsoDgz8FNEjiObb1YugHss+uSxcImQRZ7yyPA==
X-Received: by 2002:aca:4a95:: with SMTP id x143mr3106178oia.59.1617819335056;
        Wed, 07 Apr 2021 11:15:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k24sm4416554oic.51.2021.04.07.11.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 11:15:34 -0700 (PDT)
Subject: Re: [PATCH] selftests/resctrl: Change a few printed messages
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210406005242.3248706-1-fenghua.yu@intel.com>
 <67062f6c-d09a-f8e0-4d22-49c4452d0552@linuxfoundation.org>
 <YG3n7gsIhqOGjltv@otcwcpicx3.sc.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9c38f6fd-d53f-0f79-f5fe-456090368330@linuxfoundation.org>
Date:   Wed, 7 Apr 2021 12:15:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YG3n7gsIhqOGjltv@otcwcpicx3.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 11:12 AM, Fenghua Yu wrote:
> Hi, Shuah,
> 
> On Wed, Apr 07, 2021 at 08:33:23AM -0600, Shuah Khan wrote:
>> On 4/5/21 6:52 PM, Fenghua Yu wrote:
>>> -	ksft_print_msg("%s cache miss rate within %d%%\n",
>>> -		       ret ? "Fail:" : "Pass:", max_diff_percent);
>>> +	ksft_print_msg("Check cache miss rate within %d%%\n", max_diff_percent);
>>
>> You need %s and pass in the ret ? "Fail:" : "Pass:" result for the
>> message to read correctly.
> 
> Should I keep the ":" after "Pass"/"Fail"?
> 

Yes please.

>>
>> I am seeing:
>>
>> # Check kernel support for resctrl filesystem
>>
>> It should say the following:
>>
>> # Fail Check kernel support for resctrl filesystem
> 
> i.e. should the printed messages be like the following?
> # Fail: Check kernel support for resctrl filesystem
> or
> # Pass: Check kernel support for resctrl filesystem
> 

This looks good.

thanks,
-- Shuah



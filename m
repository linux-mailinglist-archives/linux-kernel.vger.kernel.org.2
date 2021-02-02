Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335BF30B3FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhBBAQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhBBAQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:16:20 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BBCC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:15:39 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e1so17442161ilu.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 16:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TtPkc8bpmMTneY15LywBNFRCOF1XpYt1CfluJTqK46Q=;
        b=fPs73iLwE/3/OQNCm5DLJZOGRdIHOzGY//w4JelVoihQ5TScKdW8kp4cEY4RdMrGTH
         3COXxd7PHsD5skxi98iBMDq6PQvs3VShUQ5XGwTNCu/j62lC6aqi5xOqe9dN1klN54z3
         7+YZ9UdiFRtz/An/zU80C+zrj5Dhw/f4OnyF07rcKRwCLvIhq16CKKnEixRZEMEFKoXp
         hw4VL07l7AYmTRw1GJgykvDw5bOZfv48i/2tP1PU4zBEcI10Ikv3TkyjT+9eE4e12Gmt
         b9D+8A87o2yEQcVyJZhcEOEyCF+LKwMWDWDzOq7NcsljCSXbKV4VSLcXIS6fbPX5orKu
         ySiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TtPkc8bpmMTneY15LywBNFRCOF1XpYt1CfluJTqK46Q=;
        b=oDZe4iv+GWfFgu91Yc+Cozo5qtv4VVcgQ89WYE3SCVxNSQnE0TQrkGZTTBI/WsW3+Z
         gwfmfflo/Jja79DMhh0qe7K039dfK+9myhJGZcUJQ0anHj9Ow9fURxF15PcdkeE73Cr6
         qTFJYHNrXTIbfOhNqfdBnW5xh2qhcWeFtVGYZzUruEgoyTG6PhKSsMR+m3X+DQ5RWmVm
         y7p/ADL9PognbCDnh43nouI6c2oxE1Q82jE1MuHxRlkmLWI71nsyh4JFXaofr1xcwIYa
         9v5dwFYu5ZKWtd7BdJLyvEb+skcFEJMnLCi+yNUJN8aZpnjtMHBVp6wwIuEEsNytpH2g
         VS5w==
X-Gm-Message-State: AOAM530LNoOYUqnjgUpO5lSl2SLeO8FUWpD2zrYVd9XPqVRNx8E0DAla
        um61IPLTFaLmmpVzXv/FouiiXciZq13qJQ==
X-Google-Smtp-Source: ABdhPJyQCMOZlh2c2kD+gonRir9By4SErR8TcJ6rsDlABjViJlwdqdfP88WMXwhP77L2Tc6VhKSH1Q==
X-Received: by 2002:a92:a303:: with SMTP id a3mr14297577ili.114.1612224938937;
        Mon, 01 Feb 2021 16:15:38 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id m11sm22907iln.44.2021.02.01.16.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 16:15:38 -0800 (PST)
Subject: Re: [PATCH net 3/4] net: ipa: use the right accessor in
 ipa_endpoint_status_skip()
To:     Amy Parker <enbyamy@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, elder@kernel.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210201232609.3524451-1-elder@linaro.org>
 <20210201232609.3524451-4-elder@linaro.org>
 <CAE1WUT6VOx=sS1K1PaJG+Ks06CMpoz_efCyNhFQhD83_YNLk5A@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <5a415ba4-9d69-5479-3be0-c5e6167b0f8a@linaro.org>
Date:   Mon, 1 Feb 2021 18:15:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAE1WUT6VOx=sS1K1PaJG+Ks06CMpoz_efCyNhFQhD83_YNLk5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 6:02 PM, Amy Parker wrote:
> On Mon, Feb 1, 2021 at 3:32 PM Alex Elder <elder@linaro.org> wrote:
>>
>> When extracting the destination endpoint ID from the status in
>> ipa_endpoint_status_skip(), u32_get_bits() is used.  This happens to
>> work, but it's wrong: the structure field is only 8 bits wide
>> instead of 32.
>>
>> Fix this by using u8_get_bits() to get the destination endpoint ID.
> 
> Isn't

(I saw your second message.)

>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>   drivers/net/ipa/ipa_endpoint.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
>> index 448d89da1e456..612afece303f3 100644
>> --- a/drivers/net/ipa/ipa_endpoint.c
>> +++ b/drivers/net/ipa/ipa_endpoint.c
>> @@ -1164,8 +1164,8 @@ static bool ipa_endpoint_status_skip(struct ipa_endpoint *endpoint,
>>                  return true;
> 
> A few lines above this, endpoint_id is initialized as u32. If we're
> going for "correctness", endpoint_id should be a u8. But of course,
> this would contrast with ipa_endpoint having it as a u32.

You are correct, endpoint_id is *defined* as type u32.

But the issue here is that the field status->endp_dst_idx
has type u8.  u32_get_bits() assumes the field it is
passed has type u32; while u8_get_bits() takes a u8.

The return value of u8_get_bits() is u8, as you might
suspect.  The C standard guarantees that the u8 value
will be promoted to the u32 target type here.

>>          if (!status->pkt_len)
>>                  return true;
>> -       endpoint_id = u32_get_bits(status->endp_dst_idx,
>> -                                  IPA_STATUS_DST_IDX_FMASK);
>> +       endpoint_id = u8_get_bits(status->endp_dst_idx,
>> +                                 IPA_STATUS_DST_IDX_FMASK);
>>          if (endpoint_id != endpoint->endpoint_id)
>>                  return true;
>>
>> --
>> 2.27.0
>>
> 
> As far as I see it, using u32_get_bits instead of u8_get_bits simply
> eliminates confusion about the type of endpoint_id. Perhaps instead of
> this patch, send a patch with a comment that while u32_get_bits is
> used, the field is only 8 bits?

No.  We really want to extract a sub-field from the u8
value passed to u8_get_bits() (not u32_get_bits()).

Does that make sense?

					-Alex


> Best regards,
> Amy Parker
> (she/her/hers)
> 


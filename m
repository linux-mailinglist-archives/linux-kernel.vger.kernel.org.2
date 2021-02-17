Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A023231E04E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhBQU3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhBQU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:29:08 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AF3C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:28:27 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y202so6784240iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 12:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SPUsxNYOqrjc6yzppnQTsrX18OHvrnDQxeQrl3Z/QyQ=;
        b=UOzhDngDTYPyFp+8BBBv/5jwzLWBu6Pj+SJEp7sRSJv67zw1R50FNPBel8lvpfJsar
         58P9swwlymB0Ns0IVqctY+GDabeXda+G5lLmEn+qZzXGk69e13EcBHJryUxB1MIHTOUQ
         jNObPNjioN90MW/eEriJTA9/PpYLPXfkETGBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SPUsxNYOqrjc6yzppnQTsrX18OHvrnDQxeQrl3Z/QyQ=;
        b=rxES9jPUQ/JViExc5NmjP01ZVaR8UZ/4BGMa38xXLuxjb6rGlizYTf3vyB62z4LRDa
         Ut8gg7yRIf0vkLH+4JImcFuo5ThF6lz/JAxqNGV4+tI0GBZyBIenPo7w8bBDEk3WC8+N
         SzEt1LBjxuzJWbxuPqKaTyOu7PBvCY9kaPHI/OKord/wT+QbCfcD4eA/RonKwjJI2Yij
         T1YGFsHP/f/e/Sv0sC6HtClEyx2i/p/3hHRycIV+0Te6bd4iNvPAs4AxyLLENAAkd7s7
         UtIQmidxaRDStdjGTeLWg0pN3cxKUzE269wHlDbbI2wDDcfABgx0dJczDKSzSI2iPoDj
         w5HA==
X-Gm-Message-State: AOAM531e5kEbiJ+gNYPZLMABAZ3rto1lSz9BR1wMGzVIvqktIfXQwqsi
        P4qcQ+iE6t1LtYnPFP6owrMKzw==
X-Google-Smtp-Source: ABdhPJxCxxtl2LO3zSwzUplyfCS+xcPKQ30PbjuNpNDojM61C10ViLWbDPBC/OvUHVk3GGMM06Lgwg==
X-Received: by 2002:a05:6602:2e84:: with SMTP id m4mr654624iow.43.1613593707308;
        Wed, 17 Feb 2021 12:28:27 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 144sm2195441ioc.41.2021.02.17.12.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 12:28:26 -0800 (PST)
Subject: Re: [PATCH 2/2] ath9k: fix ath_tx_process_buffer() potential null ptr
 dereference
To:     Kalle Valo <kvalo@codeaurora.org>, Felix Fietkau <nbd@nbd.name>
Cc:     davem@davemloft.net, kuba@kernel.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <43ed9abb9e8d7112f3cc168c2f8c489e253635ba.1613090339.git.skhan@linuxfoundation.org>
 <20210216070336.D138BC43463@smtp.codeaurora.org>
 <0fd9a538-e269-e10e-a7f9-02d4c5848420@nbd.name>
 <caac2b21-d5de-32ac-0fe0-75af8fb80bbb@linuxfoundation.org>
 <878s7nqhg0.fsf@codeaurora.org>
 <6bbeb37f-620e-d92d-d042-a507bbb39808@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5d70b0ab-0627-74a1-3602-98a7c71b871a@linuxfoundation.org>
Date:   Wed, 17 Feb 2021 13:28:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <6bbeb37f-620e-d92d-d042-a507bbb39808@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/21 7:56 AM, Shuah Khan wrote:
> On 2/17/21 12:30 AM, Kalle Valo wrote:
>> Shuah Khan <skhan@linuxfoundation.org> writes:
>>
>>> On 2/16/21 12:53 AM, Felix Fietkau wrote:
>>>>
>>>> On 2021-02-16 08:03, Kalle Valo wrote:
>>>>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>
>>>>>> ath_tx_process_buffer() references ieee80211_find_sta_by_ifaddr()
>>>>>> return pointer (sta) outside null check. Fix it by moving the code
>>>>>> block under the null check.
>>>>>>
>>>>>> This problem was found while reviewing code to debug RCU warn from
>>>>>> ath10k_wmi_tlv_parse_peer_stats_info() and a subsequent manual audit
>>>>>> of other callers of ieee80211_find_sta_by_ifaddr() that don't hold
>>>>>> RCU read lock.
>>>>>>
>>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>>>>
>>>>> Patch applied to ath-next branch of ath.git, thanks.
>>>>>
>>>>> a56c14bb21b2 ath9k: fix ath_tx_process_buffer() potential null ptr 
>>>>> dereference
>>>> I just took another look at this patch, and it is completely bogus.
>>>> Not only does the stated reason not make any sense (sta is simply 
>>>> passed
>>>> to other functions, not dereferenced without checks), but this also
>>>> introduces a horrible memory leak by skipping buffer completion if sta
>>>> is NULL.
>>>> Please drop it, the code is fine as-is.
>>>

Felix,

I looked at the code path again and found the following path that
can become a potential dereference downstream. My concern is
about potential dereference downstream.

First path: ath_tx_complete_buf()

1. ath_tx_process_buffer() passes sta to ath_tx_complete_buf()
2. ath_tx_complete_buf() doesn't check or dereference sta
    Passes it on to ath_tx_complete()
3. ath_tx_complete() doesn't check or dereference sta, but assigns
    it to tx_info->status.status_driver_data[0]
    tx_info->status.status_driver_data[0] = sta;

ath_tx_complete_buf() should be fixed to check sta perhaps?

This assignment without checking could lead to dereference at some
point in the future.

Second path: ath_tx_complete_aggr()

1. ath_tx_process_buffer() passes sta to ath_tx_complete_aggr()
2. No problems in this path as ath_tx_complete_aggr() checks
    sta before use.

I can send the revert as it moves more code than necessary under
the null check. As you pointed out, it could lead to memory leak.
Not knowing this code well, I can't really tell where. However,
my original concern is valid for ath_tx_complete_buf() path.

Sending revert as requested.

thanks,
-- Shuah


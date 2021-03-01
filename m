Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEAA328326
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 17:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbhCAQK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 11:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbhCAQFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:05:35 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8007C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 08:04:54 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id g27so16937781iox.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 08:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EKrTHUD8nTlc92mQngo8dvkuTImbzwvaVzeVetCu0jw=;
        b=OzKMNXek+I8inLFREphZnBTEPyMtKFd05n2jkhYEACrXQV50yWIreQxlvXh+bFeZdj
         m3mnr4ReYJxUEjpJoUUPkkWeMqnfuBbkfXQTCvtwielou8eZA/Yjk2ftF0lc2+EZb7gz
         AhJs+aZXzWmdcKcQYYgS9wuGbmOU0SNPmtXgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EKrTHUD8nTlc92mQngo8dvkuTImbzwvaVzeVetCu0jw=;
        b=cuT7h34L3/Xn4PTOj8VV5doNFcGXySV9nz4+M1i3nOszr0JKBHkB/0gxl8AWxn+f35
         8gleKsrwqwmhACOjksMRz0lF7JIYbr485RJwNc0xoja9ID3ub/IPHbW/dQMk8Jxvosd8
         eQMBliq8ncPcqEaDOAP+76nRO0poNXvXaStuTEPaPVhdQBfW3dCoGDAsGvRRqs41P7S3
         hGuFJbRQgVqXobC3ARvQ2QrGA0fLcyWLjT6OZ6GetEJr+N+jcmqqAg/VRfh7gMGKDqMw
         z5TxoRpXt31PL3xl4FjPGJAgukuZMMu8C6ZIhmtpG7KA2BnJMRmLFjTquju3ZAzwQxIz
         aZSg==
X-Gm-Message-State: AOAM531494nFhJ8cBaArhd/9vOHsnmhBLcjKRELNaFyOwD/3kw+RKxB8
        CCtKFqQEAJlgPJdNfCRSWe9GS6OstRN3kQ==
X-Google-Smtp-Source: ABdhPJyHDG0iYVZlSzcNqnmMybFrQ2QGhS+B6rbmCLoGXy1bRb60o28gANXZXohEvaUxVInLWPvkRg==
X-Received: by 2002:a6b:b2cd:: with SMTP id b196mr1301123iof.67.1614614694219;
        Mon, 01 Mar 2021 08:04:54 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y3sm570760iot.15.2021.03.01.08.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 08:04:53 -0800 (PST)
Subject: Re: [PATCH v3 0/3] Add lockdep_assert_not_held()
To:     Kalle Valo <kvalo@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        mingo@redhat.com, kuba@kernel.org, will@kernel.org,
        davem@davemloft.net, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1614383025.git.skhan@linuxfoundation.org>
 <YDyn+6N6EfgWJ5GV@hirez.programming.kicks-ass.net>
 <878s779s9f.fsf@codeaurora.org>
 <YDy1j+hMLGUWKKV6@hirez.programming.kicks-ass.net>
 <87sg5f87df.fsf@codeaurora.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5a34de30-6de2-8985-ef6f-5873228a3231@linuxfoundation.org>
Date:   Mon, 1 Mar 2021 09:04:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87sg5f87df.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 4:02 AM, Kalle Valo wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
>> On Mon, Mar 01, 2021 at 10:45:32AM +0200, Kalle Valo wrote:
>>> Peter Zijlstra <peterz@infradead.org> writes:
>>>
>>>> On Fri, Feb 26, 2021 at 05:06:57PM -0700, Shuah Khan wrote:
>>>>> Shuah Khan (3):
>>>>>    lockdep: add lockdep_assert_not_held()
>>>>>    lockdep: add lockdep lock state defines
>>>>>    ath10k: detect conf_mutex held ath10k_drain_tx() calls
>>>>
>>>> Thanks!
>>>
>>> Via which tree should these go?
>>
>> I've just queued the lot for locking/core, which will show up in tip
>> when the robots don't hate on it.
>>
>> Does that work for you?
> 
> That's perfect, thanks! Just making sure that the patches don't get
> lost.
> 

Awesome. Thank you.

thanks,
-- Shuah

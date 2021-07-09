Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF02E3C28C3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhGIR4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhGIR4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:56:36 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AA9C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:53:51 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id z3so12303751oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zLxkdjtVusv/ZmQVZ4iCLZGlL3DhiDtN/24rpl5e9Po=;
        b=Jmk1KrT22esMTDMff/q6gPRxlNbpUbpgVRB1K+3sDxuP5iODhBehyJkqZZwUlJQbuQ
         S+nGj3hq5eHLabJQYXTtK+bN8/jbECHYh11ecNkNW0egWIjwHBm6z0e7zfRUwyscl9Aq
         uc677BDPkScv188hYaXwCJ+GYspslGu2LTAJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zLxkdjtVusv/ZmQVZ4iCLZGlL3DhiDtN/24rpl5e9Po=;
        b=Nptpyo0FB34GCNfARn9SzKWRkT6lPfeYF1yIi7WU46DvBAiuc+hL4PU1YPX9S1kMl/
         bs+n2vqdnoCID/rsFADcZwCY3fKAKUmcJ02FBgqLLdDrkgEj1aTpIxfQ4zQLSF8sh+pW
         aeokRriHiZlAUij6UDLYtvruDSLwI9PaewySaJf6p/AwEZpivi5tS4wmCgb+dzuvO99X
         0jzT7i6jBO9VSd+wbZef0cQ3kI6H4xnba5gghGCp0UpOmLOAZkHTBjZW0zpsOf3p+dlm
         lTRjmRz6BKZtqtxfVVjCUOFP3bz/kYWinwIRJYNZt37qkhYHKg8j8LtkheG0aWNfyIc+
         OH4w==
X-Gm-Message-State: AOAM531AWlmmueEZsElY5qDx3f2tbHKxN0rRvcZi1YlQQK5CqNHTWnW2
        QN+NuRQAcSmwVatdNXdOWAp3ow==
X-Google-Smtp-Source: ABdhPJz/je1iuU/YrUgYW4DcEYCmE1xjTe7nIC9RIVYpmmX/Hp+ZLbdYnL+b9U8qP5uenBT9NmMUtg==
X-Received: by 2002:aca:5714:: with SMTP id l20mr134179oib.74.1625853231331;
        Fri, 09 Jul 2021 10:53:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q13sm1133896oov.6.2021.07.09.10.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 10:53:50 -0700 (PDT)
Subject: Re: [PATCHv2] selftests: Use kselftest skip code for skipped tests
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        linux-kselftest@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>, ast@kernel.org,
        Petr Machata <petrm@nvidia.com>, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, hawk@kernel.org,
        nikolay@nvidia.com, gnault@redhat.com, vladimir.oltean@nxp.com,
        idosch@nvidia.com, baowen.zheng@corigine.com, danieller@nvidia.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210525113316.25416-1-po-hsu.lin@canonical.com>
 <87y2c1swnz.fsf@nvidia.com>
 <CAMy_GT_4dqEuSfUGND9GTBxGORcwf480-a46Z=J736YHo2RkDA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1f4e4c5a-9544-3339-0aef-1f0889e4a422@linuxfoundation.org>
Date:   Fri, 9 Jul 2021 11:53:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMy_GT_4dqEuSfUGND9GTBxGORcwf480-a46Z=J736YHo2RkDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/21 10:18 PM, Po-Hsu Lin wrote:
> On Wed, May 26, 2021 at 4:54 PM Petr Machata <petrm@nvidia.com> wrote:
>>
>>
>> Po-Hsu Lin <po-hsu.lin@canonical.com> writes:
>>
>>> There are several test cases still using exit 0 when they need to be
>>> skipped. Use kselftest framework skip code instead so it can help us
>>> to distinguish the proper return status.
>>>
>>> Criterion to filter out what should be fixed in selftests directory:
>>>    grep -r "exit 0" -B1 | grep -i skip
>>>
>>> This change might cause some false-positives if people are running
>>> these test scripts directly and only checking their return codes,
>>> which will change from 0 to 4. However I think the impact should be
>>> small as most of our scripts here are already using this skip code.
>>> And there will be no such issue if running them with the kselftest
>>> framework.
>>>
>>> V2: router_mpath_nh.sh and outer_mpath_nh_res.sh sources lib.sh,
>>> there is no need to assign ksft_skip value in these two.
>>>
>>> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>>
>> I want to note that defining ksft_skip=4 in every test separately is the
>> current practice. I agree with Willem (in a parallel thread) that this
>> stuff should live in a library of its own, but there is none currently.
>> When there is, it looks like the conversion would be mechanical.
>>
>> Which is to say, IMHO this patch makes sense on its own as an
>> incremental improvement.
>>
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
> 
> Hello folks,
> any other comment on this patch? Or if I should break this down to
> smaller patches for different suites in kselftests?
> Thanks!
> PHLin
> 

Yes plase, break them into individual patches.

Breaking this into individual patches makes it easier to pull them
in and allows us handle dependencies better.

thanks,
-- Shuah


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15E03EDCB0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhHPR5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhHPR5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:57:14 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B1CC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:56:42 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r6so18379620ilt.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UHeEL37pku4HOreD+wBckxjETJz5QqCAx8V1P9VHsAo=;
        b=y67JzR4PNZVPGNmW5CuQAyLtq6CodFO0mG0t6TIL/LGVMBenQ8NR3ZQ0XQvqkljkAa
         ZmTHD3bU3MsZ0Nnhoa4Vqbc36cotlNbRxWWSPbTnpS2TV5O3OKeEt1dx2O5p2FEwjHeB
         aytyZ2NfnrnATOAMB2BhHvvJrxGrhdtSJDulNFSOLWBO4yiSFhfN8cktU3kY8k8mpTmJ
         AdbGCVXMFczBCzRmZ/vgt46FIQb90jVwQBnuk8cThYJDDO+NrioXA1YXPvItQ27UJPzQ
         UHLf447t9SSg+rE9nCgFNNQn+2FKmxMdDqlvQK9Tmzzd4bQRarpYBPWtq8acmwWONW1C
         41xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UHeEL37pku4HOreD+wBckxjETJz5QqCAx8V1P9VHsAo=;
        b=YqHskuvoIQsNqN9fc29S3toyr00nsBogL+e/5LZWvIP5QmHGjV/z14ODUBnoW+wC79
         M0mUSy0SY17j8HKf/DmBRELtJZjk2sWVK5VTfvdwMvUh8xzqQnjT735hnLjsYOlAFDYO
         cyIJNnGRBpAx/BelI8V1htQREJmP3/WCWSAHgB4U06I5griDS/pZSgG0pBkovvQr9krs
         F2ffkFUTEoNGJus07rehaYojjr8FUskWlRJXmg2JmoCVSjD1TB1FuPRyYvGSjOkD3Au8
         Fhe4B2fz07sJngrOOlWwg+noK1kymYziRZM3X82Xm/wC1zDdiakSqp9IeVIo3VLdvtIa
         zfSw==
X-Gm-Message-State: AOAM530YL9Vxc6NKDbrqIgarTqX7IkcR1VdsOgdgaudUl+GlUdBsg/bD
        IjWIWhaPKjXhQNhe5S1ioi/gcxSHT4RNkXAm
X-Google-Smtp-Source: ABdhPJxyuaHbRL2wYCOShCCne37hQw2zTTUJDFAjROgaDdN7zpSQe45H1snJwqFHYtaXBglZsgOo2Q==
X-Received: by 2002:a92:b711:: with SMTP id k17mr3119ili.247.1629136602006;
        Mon, 16 Aug 2021 10:56:42 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id z26sm1603739iol.6.2021.08.16.10.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 10:56:41 -0700 (PDT)
Subject: Re: [PATCH net-next 4/6] net: ipa: ensure hardware has power in
 ipa_start_xmit()
From:   Alex Elder <elder@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210812195035.2816276-1-elder@linaro.org>
 <20210812195035.2816276-5-elder@linaro.org>
 <20210813174655.1d13b524@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <3a9e82cc-c09e-62e8-4671-8f16d4f6a35b@linaro.org>
 <20210816071543.39a44815@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <b6b1ca41-36de-bcb1-30ca-6e8d8bfcc5a9@linaro.org>
Message-ID: <ebc4e7af-8300-307c-9278-25fdd6bf1e65@linaro.org>
Date:   Mon, 16 Aug 2021 12:56:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b6b1ca41-36de-bcb1-30ca-6e8d8bfcc5a9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 9:20 AM, Alex Elder wrote:
> On 8/16/21 9:15 AM, Jakub Kicinski wrote:
>> On Fri, 13 Aug 2021 21:25:23 -0500 Alex Elder wrote:
>>>> This is racy, what if the pm work gets scheduled on another CPU and
>>>> calls wake right here (i.e. before you call netif_stop_queue())?
>>>> The queue may never get woken up?
>>>
>>> I haven't been seeing this happen but I think you may be right.
>>>
>>> I did think about this race, but I think I was relying on the
>>> PM work queue to somehow avoid the problem.  I need to think
>>> about this again after a good night's sleep.  I might need
>>> to add an atomic flag or something.
>>
>> Maybe add a spin lock?  Seems like the whole wake up path will be
>> expensive enough for a spin lock to be in the noise. You can always
>> add complexity later.
> 
> Exactly what I just decided after trying to work out a
> clever way without using a spinlock...  I'll be sending
> out a fix today.  Thanks.

I'm finding this isn't an easy problem to solve (or even think
about).  While I ponder the best course of action I'm going
to send out another series (i.e., *before* I send a fix for
this issue) because I'd like to get everything I have out
for review this week.  I *will* address this potential race
one way or another, possibly later today.

					-Alex

> 
>                      -Alex
> 


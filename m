Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE30397D1D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhFAXpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 19:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhFAXpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 19:45:06 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00860C061574;
        Tue,  1 Jun 2021 16:43:22 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id k4so716754qkd.0;
        Tue, 01 Jun 2021 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LOfyTvzBlduQM6r6bBzDtQHy05UJJgLn5jYaGzsmD/U=;
        b=nUjIdHZFKCGWbp8oi5u8CAD4grNNKv9hdLxU6gDSERpvmU4Dyw6r1jzJRRZkoyoY/k
         B2D5yuJdAPdUCWN5ZsLIuZ4gW8StzTzC6j0hHZ51DieQmxI/RmbQfuNO0LHvsKcU22kl
         Or9r5MkVq2IJR1qEd3dvXTFNqUjdBTqOMEOK6IZSx7LXvKSJ998b1LQToeO1yM9v+T85
         VXvnEWDvau/HwLHlOJ0N5Zf6MlrovbU8knTyYzSuOUEa/voTHGQo6xH3RGK6+uqkVtdn
         pjNTb+rJbWOC51xPrvIagPMcxnFyUROLvyyi9YfB9UXEP6EwXyUOJ7LS4TeKv+P4vkU1
         LOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LOfyTvzBlduQM6r6bBzDtQHy05UJJgLn5jYaGzsmD/U=;
        b=gXpwuFbBWhGzcQSqKrnOBZ7K75796IADV2GCDi5TjzeHiMGDS5cqI0ZYxA8CFliM6Y
         cKo444jMJ9/glArOU4B4OFh9PEqA5frOxOConK/KYBux+67GQqVUSNyAEFz5b3hWVj5z
         1G1p6J8vmZ3RIWbqYtnIImEzIs1M2iDV5d99jtCaaPbwUtZ7BL6IZq7H7vIBlFZOI+hY
         vGELkuvwP0si5W8R99a+yZ80BzzGjQfBd675Q8fiCNiiK7if5umzJ4SMZreMz1pUV2Dq
         NXClzRUJR2FuMVcmyNFJix7/paaj198O7IIu78MPyU0tUUMUwWyTbJ5+zSIEGRy9E9D3
         uQRQ==
X-Gm-Message-State: AOAM531sN413hW6fSkMyO3Gws2lfr7m6/N/nTX2h2ngD/L2Y95mPkXFX
        vXWwiqV1AtXzZ4B4xm+qawwqX5KWrHA=
X-Google-Smtp-Source: ABdhPJw8669buwbP4TtbDzmypkGjLKydn7Mi0vzlV4kQNcIO+PdJaYpy13sXtRHL6ysu+8UPyhwabQ==
X-Received: by 2002:a37:5d46:: with SMTP id r67mr23827219qkb.72.1622591001976;
        Tue, 01 Jun 2021 16:43:21 -0700 (PDT)
Received: from ?IPv6:2804:14c:125:811b:fbbc:3360:40c4:fb64? ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.gmail.com with ESMTPSA id d11sm12410089qkk.110.2021.06.01.16.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 16:43:21 -0700 (PDT)
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jani Nikula <jani.nikula@linux.intel.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <87r1hlrfhk.fsf@intel.com> <1b1e0e07-d438-0902-a28a-e346cba53518@gmail.com>
 <20210601215723.7kwakixrrizba3bu@begin>
From:   Igor Torrente <igormtorrente@gmail.com>
Message-ID: <9932ed69-685a-e5ce-0180-bf030ca4b608@gmail.com>
Date:   Tue, 1 Jun 2021 20:43:18 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210601215723.7kwakixrrizba3bu@begin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On 6/1/21 6:57 PM, Samuel Thibault wrote:
> Igor Torrente, le mar. 01 juin 2021 12:11:26 -0300, a ecrit:
>>>> +| acntsa -- Accent SA
>>>> +| acntpc -- Accent PC
>>>> +| apollo -- Apollo
>>>> +| audptr -- Audapter
>>>> +| bns -- Braille 'n Speak
>>>> +| dectlk -- DecTalk Express (old and new, db9 serial only)
>>>> +| decext -- DecTalk (old) External
>>>> +| dtlk -- DoubleTalk PC
>>>> +| keypc -- Keynote Gold PC
>>>> +| ltlk -- DoubleTalk LT, LiteTalk, or external Tripletalk (db9 serial only)
>>>> +| spkout -- Speak Out
>>>> +| txprt -- Transport
>>>> +| dummy -- Plain text terminal
>>>
>>> Looks like a definition list?
>>>
>>> https://docutils.sourceforge.io/docs/user/rst/quickref.html#definition-lists
>>
>> If the '|' is replaced by definition-list, I'll have to skip a line to each
>> item so the sphinx doesn't concatenate them into a single line. Like this:
>>
>> keywords
>>    acntsa -- Accent SA
>>
>>    acntpc -- Accent PC
>>
>>    apollo -- Apollo
>>    [...]
>>
>>
>> There's a way to do that without these blank lines?
> 
> The blank line isn't really a problem.
> 
>>>> +Document License
>>>> +================
>>>> +
>>>
>>> Using SPDX might be nice.
>>
>> I was just trying to respect the original text as much as possible, but I
>> don't mind change it if everybody agrees with it.
> 
> SPDX should be fine.

I have two questions about it.

1 - Should I only make this change when we have the 'acks' from all the 
previous contributors? Or can I change it to the v3?

2 - Is '.. SPDX-License-Identifier: GPL-2.0' at the beginning is enough?

> 
> Samuel
> 

Thanks,
---
Igor M. A. Torrente

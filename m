Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF63F39C90A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFEO1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 10:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229957AbhFEO1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 10:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622903158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKpVQsFxlUjGbbInkX9CTrcAmJCiKIsDRxv633gSOQ8=;
        b=YrZyWBSQIR1ZAi3LSwcBwoGKV6mgz2qhlX7gq1dn1tfumXnmGDW0eyX2pfQFSgeE9dfuBN
        eYK3wWSEXlr2a+kLIxMDGMbC5nwaOB3+Ms3jmIvUc8TerhyoBHQYEjn13y2QwN4wxA6iNs
        qhFaYOocX1MsECb/JOYaJihAfDJQRuw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-icJeaGOcOtentVPDQo23ig-1; Sat, 05 Jun 2021 10:25:56 -0400
X-MC-Unique: icJeaGOcOtentVPDQo23ig-1
Received: by mail-qv1-f69.google.com with SMTP id n17-20020ad444b10000b02902157677ec50so8936968qvt.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 07:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vKpVQsFxlUjGbbInkX9CTrcAmJCiKIsDRxv633gSOQ8=;
        b=l0u6IgP2L/H4kQixJBJKV1ywMibd70kpIUXMyB8WooVkFtmlgVRgPin68fizMqyh9O
         rTEQU5gRkJ4ImvtZ8AOah/Zl23x6WjF3fPi58Bowlf5jR7lbjazalpoM/UWGI6iny6RY
         oPlqY97wI2gi0b3c5f54LaTJe2xTHgjcWl/N+2SBXDezuCF6u3EfkHdqUhmfZe5Au2Xz
         HhH4i7kTGk6j07PGhuC1jUQ78rFOA+/z3HNRGledog5vEmupRzvNWbXb5+dm0Tm34r25
         h27Liv/fDB+pY6yS73cPigZT7rk1hZQfhanu0nNzmxVbnnrNbPwTel3BDNZl24iNhpOF
         Zl1Q==
X-Gm-Message-State: AOAM533EV3LdOE++Sx6AqQJGaBltcd7TWFzx/AEDJzmprzgSy9Q4yawW
        6sndeUCkC5x5KaX0LN9SlpEybc8a9NH3Bzbvd2dNkZk7XgzGSCiQcrIFFfW7cEnGPMMLUhikm/t
        KSw8Qx+gG60c5brRixL9KwVGj
X-Received: by 2002:a37:a682:: with SMTP id p124mr9166583qke.23.1622903155838;
        Sat, 05 Jun 2021 07:25:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk5truWswzeDqTF+HnCioosTPiWBJZaBMfIliNSTONSdtYhIaBJc9sfLJTwQE/QbLvtFiSaw==
X-Received: by 2002:a37:a682:: with SMTP id p124mr9166558qke.23.1622903155528;
        Sat, 05 Jun 2021 07:25:55 -0700 (PDT)
Received: from [192.168.0.106] ([24.225.235.43])
        by smtp.gmail.com with ESMTPSA id 137sm5174039qko.29.2021.06.05.07.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 07:25:55 -0700 (PDT)
Subject: Re: [PATCH net-next] net: tipc: fix FB_MTU eat two pages
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     ying.xue@windriver.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        tipc-discussion@lists.sourceforge.net,
        Menglong Dong <dong.menglong@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210604074419.53956-1-dong.menglong@zte.com.cn>
 <e997a058-9f6e-86a0-8591-56b0b89441aa@redhat.com>
 <CADxym3ZostCAY0GwUpTxEHcOPyOj5Lmv4F7xP-Q4=AEAVaEAxw@mail.gmail.com>
From:   Jon Maloy <jmaloy@redhat.com>
Message-ID: <998cce2c-b18d-59c1-df64-fc62856c63a1@redhat.com>
Date:   Sat, 5 Jun 2021 10:25:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CADxym3ZostCAY0GwUpTxEHcOPyOj5Lmv4F7xP-Q4=AEAVaEAxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/21 9:28 PM, Menglong Dong wrote:
> Hello Maloy,
>
> On Sat, Jun 5, 2021 at 3:20 AM Jon Maloy <jmaloy@redhat.com> wrote:
>>
> [...]
>> Please don't add any extra file just for this little fix. We have enough
>> files.
>> Keep the macros in msg.h/c where they used to be.  You can still add
>> your copyright line to those files.
>> Regarding the macros kept inside msg.c, they are there because we design
>> by the principle of minimal exposure, even among our module internal files.
>> Otherwise it is ok.
>>
> I don't want to add a new file too, but I found it's hard to define FB_MTU. I
> tried to define it in msg.h, and 'crypto.h' should be included, which
> 'BUF_HEADROOM' is defined in. However, 'msg.h' is already included in
> 'crypto.h', so it doesn't work.
>
> I tried to define FB_MTU in 'crypto.h', but it feels weird to define
> it here. And
> FB_MTU is also used in 'bcast.c', so it can't be defined in 'msg.c'.
>
> I will see if there is a better solution.
I think we can leverage the fact that this by definition is a node local 
message, and those are never encrypted.
So, if you base FB_MTU on the non-crypto versions of BUF_HEADROOM and 
BUF_TAILROOM we should be safe.
That will even give us better utilization of the space available.

///jon

>
> Thanks!
> Menglong Dong
>
>>> @@ -0,0 +1,55 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright 2021 ZTE Corporation.
>>> + * All rights reserved.
>>> + *
>>> + * Redistribution and use in source and binary forms, with or without
>>> + * modification, are permitted provided that the following conditions are met:
>>> + *
>>> + * 1. Redistributions of source code must retain the above copyright
>>> + *    notice, this list of conditions and the following disclaimer.
>>> + * 2. Redistributions in binary form must reproduce the above copyright
>>> + *    notice, this list of conditions and the following disclaimer in the
>>> + *    documentation and/or other materials provided with the distribution.
>>> + * 3. Neither the names of the copyright holders nor the names of its
>>> + *    contributors may be used to endorse or promote products derived from
>>> + *    this software without specific prior written permission.
>>> + *
>>> + * Alternatively, this software may be distributed under the terms of the
>>> + * GNU General Public License ("GPL") version 2 as published by the Free
>>> + * Software Foundation.
>>> + *
>>> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
>>> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
>>> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
>>> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
>>> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>>> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
>>> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
>>> + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
>>> + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
>>> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
>>> + * POSSIBILITY OF SUCH DAMAGE.
>>> + */
>>> +
>>> +#ifndef _TIPC_MTU_H
>>> +#define _TIPC_MTU_H
>>> +
>>> +#include <linux/tipc.h>
>>> +#include "crypto.h"
>>> +
>>> +#ifdef CONFIG_TIPC_CRYPTO
>>> +#define BUF_HEADROOM ALIGN(((LL_MAX_HEADER + 48) + EHDR_MAX_SIZE), 16)
>>> +#define BUF_TAILROOM (TIPC_AES_GCM_TAG_SIZE)
>>> +#define FB_MTU       (PAGE_SIZE - \
>>> +              SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - \
>>> +              SKB_DATA_ALIGN(BUF_HEADROOM + BUF_TAILROOM + 3))
>>> +#else
>>> +#define BUF_HEADROOM (LL_MAX_HEADER + 48)
>>> +#define BUF_TAILROOM 16
>>> +#define FB_MTU       (PAGE_SIZE - \
>>> +              SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - \
>>> +              SKB_DATA_ALIGN(BUF_HEADROOM + 3))
>>> +#endif
>>> +
>>> +#endif


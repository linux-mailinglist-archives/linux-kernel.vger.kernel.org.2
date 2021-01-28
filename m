Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53616307D85
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhA1SMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:12:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231536AbhA1SHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611857180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLpGMEsWUFtvOGdp4Bl4045lZDRmMlzwwfBz1eKojT4=;
        b=hPCUs+7FhA9REhCz1wtcNERYwYaz1B1+re17nZGRTEk8uBr8W5NFHORZxyM70bHnTBtypD
        rFA2LaJRnZqndY0ouwCGJ64tkhvJaSU2K3EphIZANQKovNoNo+6kYWwU871CDVC52N7T3F
        pP/aYC0QJATqHzAMY2haOaBcAt6+ods=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-z5PpwGCAPn26VFYs_O4BIw-1; Thu, 28 Jan 2021 13:06:18 -0500
X-MC-Unique: z5PpwGCAPn26VFYs_O4BIw-1
Received: by mail-ed1-f70.google.com with SMTP id y6so3572141edc.17
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rLpGMEsWUFtvOGdp4Bl4045lZDRmMlzwwfBz1eKojT4=;
        b=Y8TMrqytg+iKlL41mYOcaQqjOpvrArqZi61ZOZJYZguEHJtr5iqrmuCMhRTi70Wy/6
         SlDJqPWiYIoA35ZNmQJXSe84co4ckGnw0z/Id+tE5stpHg76ZrcD9Tl/2Gbgj9Fa9Whe
         UcGKs4wk1Og5n8xWNAmwRWHhG8FxGYiU8kzKEasX4CCMyGIe7UhBx+cdHr7c7runrtRB
         xs0x8LrF1gpR+EQb0oUWXD6hYlkvYh5Qy4vQlVwpfZ5eykgHlNT8hx1EQ+a4P38Aurt3
         WVwNMeBsFqV9sM5Edl1FU4uIfJCZX9X0Bnrhq6WsQ4v/NoovDqHsmkBj51RHFoxpD27v
         Rv5A==
X-Gm-Message-State: AOAM530G6anUp3f7PRWpm21+NyBKxJH3KgWAwJCCeV/61PqOfBmxJGK6
        1wjeLstFZLr0yAWZr/PbKd2tzAXb6W6nr+rocJ63uutE5s+A65p+WoOJzzwLOUM9N8rsSH8c53u
        THEUuj8o4hFdpeg+hQpIsK5vn
X-Received: by 2002:a17:906:a48:: with SMTP id x8mr626106ejf.444.1611857177303;
        Thu, 28 Jan 2021 10:06:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHfUKevTd/4l9Cq7zXQgMsfc9UehVxY6ry045/wWY1PjhtT8vA4WzaKXdxYCtMCcp0FrzTOA==
X-Received: by 2002:a17:906:a48:: with SMTP id x8mr626095ejf.444.1611857177168;
        Thu, 28 Jan 2021 10:06:17 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p15sm2652745ejd.121.2021.01.28.10.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 10:06:16 -0800 (PST)
Subject: Re: [PATCH v14 00/13] Introduce support for guest CET feature
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        yu.c.zhang@linux.intel.com
References: <20201106011637.14289-1-weijiang.yang@intel.com>
 <c6e87502-6443-62f7-5df8-d7fcee0bca58@redhat.com>
 <YBL8wOsgzTtKWXgU@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32c9cdf7-7432-1212-2fe4-fe35ad27105a@redhat.com>
Date:   Thu, 28 Jan 2021 19:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBL8wOsgzTtKWXgU@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/21 19:04, Sean Christopherson wrote:
> On Thu, Jan 28, 2021, Paolo Bonzini wrote:
>> On 06/11/20 02:16, Yang Weijiang wrote:
>>> Control-flow Enforcement Technology (CET) provides protection against
>>> Return/Jump-Oriented Programming (ROP/JOP) attack. There're two CET
>>> sub-features: Shadow Stack (SHSTK) and Indirect Branch Tracking (IBT).
>>> SHSTK is to prevent ROP programming and IBT is to prevent JOP programming.
> 
> ...
> 
>> I reviewed the patch and it is mostly okay.  However, if I understand it
>> correctly, it will not do anything until host support materializes, because
>> otherwise XSS will be 0.
> 
> IIRC, it won't even compile due to the X86_FEATURE_SHSTK and X86_FEATURE_IBT
> dependencies.

Of course, but if that was the only issue I would sort it out with Boris 
as usual.  OTOH if it is dead code I won't push it to Linus.

Paolo

>> If this is the case, I plan to apply locally v15 and hold on it until the
>> host code is committed.
>>
>> Paolo
>>
> 


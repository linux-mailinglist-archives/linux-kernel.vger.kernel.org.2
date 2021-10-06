Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C1542399D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbhJFIWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237411AbhJFIWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633508424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgZihBRv/isGHyINl2U/NxKNojcHSNuLKT+jIKlViXY=;
        b=Pzy7sz2bgoT4OxJcCcpS7XYGMsETmJClQFI0fUZJdm2xTi2IcrVEsc7IhWrsz1VZ3YsbeK
        3ktyj3cOmkyToWoXIPv6qmo+HvJ5XVdgGo7KJNMTbImtOiPNPOjYlUfdstnrIxtO+nolKt
        AZlqW7qR6A05zxPPiweSvJuY2cN2LLE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-UpaEPkscPP6ru9e_-C_j5Q-1; Wed, 06 Oct 2021 04:20:23 -0400
X-MC-Unique: UpaEPkscPP6ru9e_-C_j5Q-1
Received: by mail-wr1-f69.google.com with SMTP id r25-20020adfab59000000b001609ddd5579so1367588wrc.21
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XgZihBRv/isGHyINl2U/NxKNojcHSNuLKT+jIKlViXY=;
        b=y8z/l7GI7WeAoQmLPOnBkJWMo9Ok5DIZofJp5BOboyMCqfomzSsxCLT1Km4VsyemPx
         pSEPWi3v3fdhVcp4vAhDijrICBKhjUIFbETw55kFDynDAtrGhIqMgmuFAxyOsVigzPrj
         f//b4oWfhJJCChlXiJUMrg5lBC6u2YoPQeVHFrw1lH0NZCCgMZZ+e2mLdMIrrDAhRB1A
         HXKNcQWQDKuuVyqldpuIs7k5FAEG/RW9007rg40c3lFUjratJ3NYmadXLpQu/yWIHYNC
         DDTLsYhRdihSpa2RxChIpERRv7XRlZw2wO2TRWVinoGQDqZRraojBnIX/K7KL5vxvpmN
         dhGg==
X-Gm-Message-State: AOAM530F0bEu87kBR7vXCNRnkvEjnVlBm3xi3QNN66qPbZlkQ0E41cSj
        G5bpSAS27+nboDW14tUe9WuHGZ5+VM7KUdT64Mn6hIXvQJZ0wsuR6wkQmxZmnkPddYrlhD6+VJN
        3N+hIVpa7gw9JEkQ6+KUQAsPntboWIFg5Uk2m0qOhxId5doXGMVC2HS4JWdvSqFOD9dkj1gfQ
X-Received: by 2002:a5d:453b:: with SMTP id j27mr27480395wra.324.1633508422224;
        Wed, 06 Oct 2021 01:20:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVnSut8qR7L4PGDXaoJYCehhWQOCoST+P/pR8NdwcnYPsfcaRZdg1Xae+PRCRuP9la5JxGag==
X-Received: by 2002:a5d:453b:: with SMTP id j27mr27480366wra.324.1633508421919;
        Wed, 06 Oct 2021 01:20:21 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6529.dip0.t-ipconnect.de. [91.12.101.41])
        by smtp.gmail.com with ESMTPSA id o1sm5616439wmq.26.2021.10.06.01.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 01:20:21 -0700 (PDT)
Subject: Re: [PATCH] mm/huge_memory: disable thp if thp page size is too large
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <CAPm50aLBfe7N_udxCkS3-PKbTmUvSpqu0sL7U6qHXZ=OWGQnTQ@mail.gmail.com>
 <914a0b38-cb44-f4be-43aa-bc42bee1553b@redhat.com>
 <CAPm50aKRTg2=WMDw+vWvXA5+wADfSo8Kk-PHpAagftGypArU+g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6813b6fa-5587-7967-1f16-87b1c49084a1@redhat.com>
Date:   Wed, 6 Oct 2021 10:20:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPm50aKRTg2=WMDw+vWvXA5+wADfSo8Kk-PHpAagftGypArU+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.21 10:16, Hao Peng wrote:
> On Thu, Sep 30, 2021 at 9:19 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 30.09.21 04:14, Hao Peng wrote:
>>> From: Peng Hao <flyingpeng@tencent.com>
>>
>> "disable thp if thp page size is too large" you disable thp if there is
>> not sufficient memory installed in the system (and for that, you use THP
>> size), something doesn't add up here.
>>
> In addition, if THP is enabled, min_free_kbytes will be recalculated.
> At this time,
> min_free_kbytes is calculated based on the size of THP. If the size of
> THP is too l
> arge, OOM will easily be triggered.

Right, I was pointing at the misleading $subject. What about something like:

"mm/huge_memory: disable THP with large THP size on small present memory" ?

>>>
>>> After seting the page size to 64k on ARM64, the supported huge page
>>
>> s/seting/setting/
>>
>> Fortunately, most distributions already switched to 4k, because 512MB
>> THP is pretty much useless, especially on any system that doesn't have
>> memory in the range of hundreds of megabytes or terrabytes.
> But the ARM64 Server distribution version I use, such as CentOS for ARM64,
>   has a page size of 16KB or 64KB.

Yeah, RHEL8 and CENTOS8 are the last remaining "recent distirbutions" 
I'm aware of.


-- 
Thanks,

David / dhildenb


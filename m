Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4F8387D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbhERQYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345891AbhERQYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621354966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5RJYPLqAYSF7PeEx+nR3RgNKQgQ5XhiMT8l2SDsZYU=;
        b=EI8iLG7gQ7KvpkzYNTLm9uCaHfPTJoQn5dw2b/M8xuS1bLttR+5TYdszDBzSWOQ4T/xz4Z
        mKhOV7QWjR45G0LC/RyeblgJyn2DiLO5XdxaZUek4MJab4vwQXbhqEgy/hdwfybKcuwXzk
        nLWv3hmrAsWW+vKZB5Wjul49TLs7g58=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-RdPrvt-6PGGrwVIAg7dToQ-1; Tue, 18 May 2021 12:22:45 -0400
X-MC-Unique: RdPrvt-6PGGrwVIAg7dToQ-1
Received: by mail-wm1-f70.google.com with SMTP id y193-20020a1c32ca0000b029014cbf30c3f2so714745wmy.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=f5RJYPLqAYSF7PeEx+nR3RgNKQgQ5XhiMT8l2SDsZYU=;
        b=SgXh6iM2YLTIWpqxymYwadMEUkMwiCuK3yJBS1uxBKLiRbUhnd+vYoLPKrzlbFrv8n
         6qTg+z7MaJYtJGvIuMVj59iyLhDjLsu/laKExV3vqYm0jLYowUfXjIiUd7yXl2hBtRet
         /s/vLTK4YzYFJmAh19euNQCkkGDOl2zc7DiVfh/Gkw2aurT2g6XtmaCbIHn7FxsopGuf
         5scWOT1NGM9PvCZrm/u2/0uwCbqZsDBxDYH+AnYsyitgCVrzGXoeDzgSbL0jJ+10UPw6
         wv1Jk35bxptPe057AbrooOWkBTLTS5Bi355+EnivDuod2++CEIu4sCHnBwQUdsA6Owmm
         Hgcg==
X-Gm-Message-State: AOAM533rw0V9WVqru253Jsd9cm8hmaC9/wMMIbSJdXftcUY+QwNdndAD
        kos6P9rm9gyZEwVVPTdc3v9EcDtEd5e8YEskaLXerWnR5o7pMe+U5j8Ig8ly8HdEzWDXyGkVXdF
        pvGO4d0+wvc89dr5y3swD359/IIpNu/fl+g7rMoqKxKt2qZ2GzYO3/vw2POIGdAXbplHVjZCo
X-Received: by 2002:a05:6000:1368:: with SMTP id q8mr8169217wrz.342.1621354963294;
        Tue, 18 May 2021 09:22:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJXTyLbbe+j8G/6H/hwqiNFjexjmfC5GXKyFTrPfr1NMUTkplW/NkFtTn2Aiu3BABVg2Cz+Q==
X-Received: by 2002:a05:6000:1368:: with SMTP id q8mr8169190wrz.342.1621354963029;
        Tue, 18 May 2021 09:22:43 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fd.dip0.t-ipconnect.de. [91.12.100.253])
        by smtp.gmail.com with ESMTPSA id f7sm17857348wmq.30.2021.05.18.09.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 09:22:42 -0700 (PDT)
Subject: Re: [PATCH v1 00/11] KVM: s390: pv: implement lazy destroy
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     kvm@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210517200758.22593-1-imbrenda@linux.ibm.com>
 <20210518170537.58b32ffe.cohuck@redhat.com> <20210518173624.13d043e3@ibm-vm>
 <20210518180411.4abf837d.cohuck@redhat.com> <20210518181922.52d04c61@ibm-vm>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a38192d5-0868-8e07-0a34-c1615e1997fc@redhat.com>
Date:   Tue, 18 May 2021 18:22:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518181922.52d04c61@ibm-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.21 18:19, Claudio Imbrenda wrote:
> On Tue, 18 May 2021 18:04:11 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Tue, 18 May 2021 17:36:24 +0200
>> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
>>
>>> On Tue, 18 May 2021 17:05:37 +0200
>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>    
>>>> On Mon, 17 May 2021 22:07:47 +0200
>>>> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
>>
>>>>> This means that the same address space can have memory
>>>>> belonging to more than one protected guest, although only one
>>>>> will be running, the others will in fact not even have any
>>>>> CPUs.
>>>>
>>>> Are those set-aside-but-not-yet-cleaned-up pages still possibly
>>>> accessible in any way? I would assume that they only belong to
>>>> the
>>>
>>> in case of reboot: yes, they are still in the address space of the
>>> guest, and can be swapped if needed
>>>    
>>>> 'zombie' guests, and any new or rebooted guest is a new entity
>>>> that needs to get new pages?
>>>
>>> the rebooted guest (normal or secure) will re-use the same pages of
>>> the old guest (before or after cleanup, which is the reason of
>>> patches 3 and 4)
>>
>> Took a look at those patches, makes sense.
>>
>>>
>>> the KVM guest is not affected in case of reboot, so the userspace
>>> address space is not touched.
>>
>> 'guest' is a bit ambiguous here -- do you mean the vm here, and the
>> actual guest above?
>>
> 
> yes this is tricky, because there is the guest OS, which terminates or
> reboots, then there is the "secure configuration" entity, handled by the
> Ultravisor, and then the KVM VM
> 
> when a secure guest reboots, the "secure configuration" is dismantled
> (in this case, in a deferred way), and the KVM VM (and its memory) is
> not directly affected
> 
> what happened before was that the secure configuration was dismantled
> synchronously, and then re-created.
> 
> now instead, a new secure configuration is created using the same KVM
> VM (and thus the same mm), before the old secure configuration has been
> completely dismantled. hence the same KVM VM can have multiple secure
> configurations associated, sharing the same address space.
> 
> of course, only the newest one is actually running, the other ones are
> "zombies", without CPUs.
> 

Can a guest trigger a DoS?

-- 
Thanks,

David / dhildenb


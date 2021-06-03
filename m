Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A19399814
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhFCCjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhFCCjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622687837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxm0/+m5dcFG2sDWbRYCYBLYAMI7JPbdvwfiFb7Glz8=;
        b=jPUVQjCqHaVQqDqa33ItVh8ZmLjwc97mhnlftCiGf26RFpvXYkndxB+x1YPP2w3RiAAnLy
        Yi0HcLNfAlmc7So5YI22dqbSgA0Aim8+bqqkZL7OiTJXow2F3bjH2I+fllvIWtjwjbz8S2
        Hj6o9FBazMCA0+4UXT8yHRB4Vnc/hsU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-HQtqnpoAOJCjKo3eLaEnNg-1; Wed, 02 Jun 2021 22:37:16 -0400
X-MC-Unique: HQtqnpoAOJCjKo3eLaEnNg-1
Received: by mail-pj1-f72.google.com with SMTP id j1-20020a17090a7381b02901605417540bso2401897pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 19:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uxm0/+m5dcFG2sDWbRYCYBLYAMI7JPbdvwfiFb7Glz8=;
        b=h7+2HNdAk/GxQ2RD6cx2Qr/MFgsutVQraLuNkbLZxy++OeDtoUywSeg5+efkngbKlF
         254BxbHvKauzumWymRLbe3DR59484+LZVRb3FGVf/p+DhOvE7Yhn1KkqrhgNrkbAU2BM
         Uy0dCSaQdCSJuABhMr6xQ637uT2g5JmYtOWtdpgrCsDkQwkiHodWyQk3o0TCudXeP/Gx
         r6Jb8n6LG3mkG66YT5GeFQxLkTdwHxrQkl2iYjpMsHcra0f4wWMdSczrOgRCjPa37Nk3
         eAH/xlbkdOac0TqXz6vY4GPetuipf0fGnqVFEkVs8lteTMIj3mabK7Ny2j27uMjKpVaW
         PY0A==
X-Gm-Message-State: AOAM530c1OiuSNfefT9670y7j74Gh1NDz4bL12FTV0/I5etbqbBT4tnl
        5HJAWK7+WZAWyTIooSqj9FHHnXib+CAxmvMXJgCN95hnfzWrr7ay/CXkho3QJ7evCZaobUhSWyg
        QueJohtJhxAmIn1qZhDM3zJz2zDhY1BIuQ+oLuXR3vpnCWiaER5iOEI7WWCI5pRQv4RQEr0zu4O
        Ak
X-Received: by 2002:a63:7a01:: with SMTP id v1mr3478951pgc.307.1622687834853;
        Wed, 02 Jun 2021 19:37:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztGLN1yD3vajwb+JLkpQMmH6Ptgg5CL3UiebwVquPa3KIGm5002XUJvK1+Nc1pzYyR5Kivcw==
X-Received: by 2002:a63:7a01:: with SMTP id v1mr3478922pgc.307.1622687834579;
        Wed, 02 Jun 2021 19:37:14 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x6sm767172pfd.173.2021.06.02.19.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 19:37:14 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] virtio: Add boundary checks to virtio ring
To:     Andi Kleen <ak@linux.intel.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-3-ak@linux.intel.com>
 <4be00b3a-a15f-7fee-317b-ddabed3c1347@redhat.com>
 <ccf32bdc-a487-040b-5fe6-fcc8e71a57da@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6a5cae8f-0a29-8401-34b9-d9c977d11513@redhat.com>
Date:   Thu, 3 Jun 2021 10:36:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <ccf32bdc-a487-040b-5fe6-fcc8e71a57da@linux.intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/3 ÉÏÎç10:18, Andi Kleen Ð´µÀ:
>
>> It looks to me all the evils came from the fact that we depends on 
>> the descriptor ring.
>>
>> So the checks in this patch could is unnecessary if we don't even 
>> read from the descriptor ring which could be manipulated by the device.
>>
>> This is what my series tries to achieve:
>>
>> https://www.spinics.net/lists/kvm/msg241825.html
>
> I would argue that you should boundary check in any case. It was 
> always a bug to not have boundary checks in such a data structure with 
> multiple users, trust or not.
>
> But yes your patch series is interesting and definitely makes sense 
> for TDX too.
>
> Best would be to have both I guess, and always check the boundaries 
> everywhere.


I agree but some of the checks are unnecessary in we do this series on 
top of my series.


>
> So what's the merge status of your series?


If I understand correctly from Michael, I will send a formal series and 
he will try to merge it for the 5.14.

Thanks


>
> -Andi
>
>


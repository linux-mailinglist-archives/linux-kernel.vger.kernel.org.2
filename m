Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F763FE1D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346688AbhIASLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237001AbhIASLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630519809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NKf3uO34AvCSRdJEV//9X5/WuVnzohW4EzO2VLlwhk=;
        b=FKh9pXjyrA5VUcTjVMLEwJV8w4aGM34Y5zt9AJLrLHzAnZOeV0gXU374Uc30UofLDsnfBJ
        LuGBLM5qv5cldwkKCuu/D3xLMvG9P5xpg+mKNcHNHQeevTv1EuQ5NNe84ViGUmocM4oCma
        zXVvM/0SRtqLDXbBDGC9fi+tyZZhxz8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-holvuHEQPfaZ753tav3XCg-1; Wed, 01 Sep 2021 14:10:08 -0400
X-MC-Unique: holvuHEQPfaZ753tav3XCg-1
Received: by mail-wm1-f70.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so153389wmj.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9NKf3uO34AvCSRdJEV//9X5/WuVnzohW4EzO2VLlwhk=;
        b=faR7qxITe1U3rxc064dTyRUttAufigvETuJsngX8qpZcPa1dJDs4kdAFGXAsyzzhIh
         ifgE7R+etM1LxuNXi7hwoWHCCj2R0ClV2PTgKALm4m7KciBJw0RdFQ6aNjf3AYU9QVLr
         B4ppBvu3yNVx6Qyg9e20LVjE7C93wy/CpC4mR/6ffm0eqGJk1GvWTUFwgpI8OZrtwoay
         OFhdreSCxoTUy9mZ8rVW/K3B7RZnb2sTA6YyQLLP4BWEXaKd1f+t2dUYJeALOBorrwKp
         SGIw+gu+dDhAgLW47Y8MjIWimGxY1ftVemIG/E5B4+1sVlyfCWDXtFHv3ohoAAxr1Imc
         q0oA==
X-Gm-Message-State: AOAM531ZXLGNdrEA0xfCIbwrCjFYGfKHzjdmMREqO4A56lTiFHY09K/I
        5DuTtv2lUw+pRkNRsUNPZZjtH8ZHJ9U+ZLqiJvmi9VXt0ILnzHNeC/GrIIAD03Pv0nYeo9/d7Ia
        sXj9Cyw4JUW4pVhTCOlp6/2NF
X-Received: by 2002:adf:c3c3:: with SMTP id d3mr762073wrg.373.1630519807444;
        Wed, 01 Sep 2021 11:10:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+M43pfhuaLKye8YBTMT45+0fbZOP2iZhzz9o/djvCwsKzzBpvEOE73hmUgETCVRm8npRcXg==
X-Received: by 2002:adf:c3c3:: with SMTP id d3mr762051wrg.373.1630519807306;
        Wed, 01 Sep 2021 11:10:07 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id c13sm165598wru.73.2021.09.01.11.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 11:10:06 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
References: <20210901135314.GA1859446@nvidia.com>
 <0c9766c9-6e8b-5445-83dc-9f2b71a76b4f@redhat.com>
 <20210901153247.GJ1721383@nvidia.com>
 <7789261d-6a64-c47b-be6c-c9be680e5d33@redhat.com>
 <20210901161613.GN1721383@nvidia.com>
 <e8ebb0bb-b268-c43b-6fc1-e5240dc085c9@redhat.com>
 <20210901171039.GO1721383@nvidia.com>
 <ef7a722d-0bc0-1c68-b11b-9ede073516e0@redhat.com>
 <20210901175547.GP1721383@nvidia.com>
 <52ba8125-0382-3270-a958-ed113ae1db2a@redhat.com>
 <20210901180914.GS1200268@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <01754b36-12c6-48dc-4f84-c289b7aa47ec@redhat.com>
Date:   Wed, 1 Sep 2021 20:10:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901180914.GS1200268@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 20:09, Jason Gunthorpe wrote:
> On Wed, Sep 01, 2021 at 07:58:47PM +0200, David Hildenbrand wrote:
>> You'll most likely have to touch each and every place either way, for
>> example when suddenly returning "null" instead of a pte. It's just a matter
>> of making this easier to review and the changes as minimal and as clear as
>> possible.
> 
> I imagine the leading series to add the simplified API would include
> the null return already - the THP race avoidance requires it anyhow.
> 

Okay, so we're on the same page.

> So you end up with a simpler self contained series that is a stand
> alone improvement followed by a much smaller series here that doesn't
> got back and re-touch the first series's changes.

Exactly.


-- 
Thanks,

David / dhildenb


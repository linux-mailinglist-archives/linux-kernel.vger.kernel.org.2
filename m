Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106E536D46D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbhD1JFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237331AbhD1JFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619600678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zy/Tt/0rdk34PfJBg6ggCnjTL4icF91iTv6QpcHj3wY=;
        b=FTTP1+tDphGRKReR7h7duMj6r6aBJ5qhooEoWGwz0PzgzKEkBQtwHW5KZgdaVUlZ4IONvJ
        i+qQ8Rr1F74T66KQlB9ifk5tuDvfXYpxOSurVIp2I6Q8TqkdF8e4ghrMZtX/SOZ4TaQbNn
        vIdo1p/vYztw20g1CavFQ59ameO2iCo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-jDRC57c2OdKEG3kJH88pCA-1; Wed, 28 Apr 2021 05:04:36 -0400
X-MC-Unique: jDRC57c2OdKEG3kJH88pCA-1
Received: by mail-wr1-f70.google.com with SMTP id 67-20020adf81490000b029010756d109e6so10430851wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 02:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Zy/Tt/0rdk34PfJBg6ggCnjTL4icF91iTv6QpcHj3wY=;
        b=OMNgj0ldgk6ImP0p/Xvf4LMndbL74r9WQBw6sDc1N4sL5IZ/N2Nb7ntD6cXrybVn53
         OrLfsV87gjlthCUMoielSh0TzSSEEd9nUdknR3yt/UuACHzqgo39gbvDclW8RsSguo6g
         Dhaqr8fI6gx9TDwJlqLt6mwwHS3gN4lZPThx+yM12z48ubPwjKBeR1pTEfWR3aR6zE8c
         9tFkyiWpyrlasZrWimayG9rjgM4UFuXgCGR5SJB7OcEqLqZHQuwnhPaf0Av/V1+WpfUm
         v6IQptwulsY1mfReNzNTFDdXRQzxhwAR4IpY0TsBjgJfqc+cAOmC6UElStbxzpfG/386
         zn5w==
X-Gm-Message-State: AOAM533oqVVqx4cFSjkFJIv2jcwERf9d8YGLStaAF6GN4IAmqHGFiUPu
        TzJIEpfJFAypQUA43mQlcV5k9uzbYXMdyp4OW/LV8GyM43qoySxei5vZV8qRnaE2LDWG1+PS7ox
        wPs9MvtsXy90uNKKOe+3Tq2Ex
X-Received: by 2002:a05:600c:20c:: with SMTP id 12mr3192308wmi.138.1619600675472;
        Wed, 28 Apr 2021 02:04:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyHQN1kXxwPITyG57p5yBf6PwQPqB7SzwurYnctESLQPRWN6ybBTj8o2+iODN0NtgGzZQI8g==
X-Received: by 2002:a05:600c:20c:: with SMTP id 12mr3192278wmi.138.1619600675202;
        Wed, 28 Apr 2021 02:04:35 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id f24sm5734617wmb.32.2021.04.28.02.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:04:34 -0700 (PDT)
To:     "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        peifengl55 <peifengl55@gmail.com>,
        schwidefsky <schwidefsky@de.ibm.com>,
        "heiko.carstens" <heiko.carstens@de.ibm.com>,
        zhangshiming <zhangshiming@oppo.com>,
        zhouhuacai <zhouhuacai@oppo.com>,
        guoweichao <guoweichao@oppo.com>, guojian <guojian@oppo.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20210414023803.937-1-lipeifeng@oppo.com>
 <a7bb16c0-31b2-6aa5-2186-8c957955649e@suse.cz>
 <c289b9dc-1259-c829-8ee4-1bee94d7d73d@redhat.com>
 <2021042611194631963076@oppo.com>
 <7dcc87f5-9ae5-613a-0cf4-820334592b90@redhat.com>
 <20210426181947189100132@oppo.com>
 <9808e36a-9e4e-d1e2-da49-beb567681a8b@redhat.com>
 <2021042812031720737751@oppo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] mm: support multi_freearea to the reduction of external
 fragmentation
Message-ID: <ebc8310e-05ea-0a2a-bcdd-9072e5bf0f86@redhat.com>
Date:   Wed, 28 Apr 2021 11:04:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2021042812031720737751@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  >> Essentially CONFIG_SPARSEMEM, whereby we can have huge holes in physical
>  >> memory layout and memory areas coming/going with memory hot(un)plug.
>  >> Usually we manage all metadata per section. For example, pageblocks are
>  >> allocated per section. We avoid arrays that depend on the
>  >> initial/maximum physical memory size.
> 
> CONFIG_SPRSEMEM has been opened in some of our product with 
> Qcom-platform and
> MTK platform. AFAIK, multi_freearea would not bring problem to 
> it？because the patch
> just manage the physical memory of zone to serveral section(free_area) 
> and adjust the
> the range of pages-PFN for buddy-alloc-pages by the alloction-order. 
> With memory
> hot(un)plug, we would initialize the members of "multi_freearea" in zone.

 From your description only I cannot tell how that would really work. 
Your description of 1) indicated that we are dealing with an array to 
manage memory segments, and arrays are a bad data structure when it 
comes to sparsity.

> 
> The patch has been merged in the baseline of our product that has been 
> sold all over the
> world with Linux-4.4/4.9/4.19 so that i don't think there will be too 
> much risk. Of course,
> i might be wrong.

Just always keep in mind that upstream Linux has a very broad community. 
What might be "good enough" for smartphones might not be well suited for 
servers, VMs, embedded devices, other archs ... just imagine the RAM 
size differences, sparse layout, dynamic memory changes, ...

Adding additional complexity to the buddy has to have a compelling 
benefit; keep in mind that any complexity we introduce has to be 
maintained in the long term.

Having that said, starting with small steps is IMHO the right approach.

-- 
Thanks,

David / dhildenb


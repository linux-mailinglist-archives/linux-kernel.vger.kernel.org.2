Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18405376150
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhEGHl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235525AbhEGHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620373227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cytpn5HUqqHMQi7fHCbchsnpUSL44ZuNU5lozqiis8I=;
        b=Vj7VxN4KJSZLyja15lpWInfSGG3t2c5YptbWcP/AfwgzhrhmlM+ATPBnR730OWHtHKQnHY
        J0WNSHSCv6z/5JnAfyvYSpVDASJKKK3GhbBsdLjPvwGKtKh2IHk56/JBYfprDPquZhBCda
        NXobOMEmlfQgX6gYENnKO8kvTUVhq5A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-59BLuhTmM6WLZQv2Lx-HRQ-1; Fri, 07 May 2021 03:40:25 -0400
X-MC-Unique: 59BLuhTmM6WLZQv2Lx-HRQ-1
Received: by mail-wm1-f72.google.com with SMTP id x82-20020a1c63550000b0290158057efb6dso95060wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cytpn5HUqqHMQi7fHCbchsnpUSL44ZuNU5lozqiis8I=;
        b=e7+FJcPdnED274NyqJQYxTOOEzCPAwP6qgyBpLmp9yVQckdr2fdO41ao3Mz4y0/dG+
         95bOeuIzsY/ipx7Bvh2mIW4kImsnY9IMPgwAftIoouWH1vKS4M90XQLB6VvTsiI6YCLu
         3egaEyndzz2S93i+3oojPlMPo5+0X7nSo5f67QACyCN2tsdkEfPX8sqZysgXEsgtrMHb
         wRPOZJRbILpRPEObJsPGy0Mzgys/+J4wUdbcH7foheftN4BVtSPWxaa5AQ+ymKn84e0Z
         yQJY98Yi2Z/lzgf23IgEjS5EWLpwxRgaiZk00p+wBRHhb3rN2nyW2DTQg5F742HWpvC/
         jdLw==
X-Gm-Message-State: AOAM531j0kYW34TdwOrA21yelxybmCnAPQrJvwr91I7BGDACDQCStXCQ
        3S0aL6hay59ae3/vHGYSXMSfTlTn1rtK2gerVe1wyYtJD7l7Uf4HAQamkM6VR3hcasjtUVj6F5X
        lBTLvenLw7UtUrlnE17XgcIBZ
X-Received: by 2002:a5d:4532:: with SMTP id j18mr10234867wra.223.1620373224754;
        Fri, 07 May 2021 00:40:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzKBTGBiLC4DaItIJ6x7hljljQiDIHXoHip9FQtBMJTCeRTrmEtRTYf6EtYcNjww90epWJyg==
X-Received: by 2002:a5d:4532:: with SMTP id j18mr10234842wra.223.1620373224509;
        Fri, 07 May 2021 00:40:24 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63c0.dip0.t-ipconnect.de. [91.12.99.192])
        by smtp.gmail.com with ESMTPSA id x8sm7313019wru.70.2021.05.07.00.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 00:40:24 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] Lazily allocate memslot rmaps
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
References: <20210506184241.618958-1-bgardon@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <05848766-b13c-2a58-81da-0f1e839a6cd0@redhat.com>
Date:   Fri, 7 May 2021 09:40:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506184241.618958-1-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 20:42, Ben Gardon wrote:
> This series enables KVM to save memory when using the TDP MMU by waiting
> to allocate memslot rmaps until they are needed. To do this, KVM tracks
> whether or not a shadow root has been allocated. In order to get away
> with not allocating the rmaps, KVM must also be sure to skip operations
> which iterate over the rmaps. If the TDP MMU is in use and we have not
> allocated a shadow root, these operations would essentially be op-ops
> anyway. Skipping the rmap operations has a secondary benefit of avoiding
> acquiring the MMU lock in write mode in many cases, substantially
> reducing MMU lock contention.
> 
> This series was tested on an Intel Skylake machine. With the TDP MMU off
> and on, this introduced no new failures on kvm-unit-tests or KVM selftests.
> 

Happy to see this change pop up, I remember discussing this with Paolo 
recently.

Another step to reduce the rmap overhead could be looking into using a 
dynamic datastructure to manage the rmap, instead of allocating a 
fixed-sized array. That could also significantly reduce memory overhead 
in some setups and give us more flexibility, for example, for resizing 
or splitting slots atomically.

-- 
Thanks,

David / dhildenb


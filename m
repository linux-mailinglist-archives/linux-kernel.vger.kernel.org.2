Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972ED4345D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTHZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhJTHZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634714576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBVyUUUV2qr6b1veT83eC89VUSUZjroodvAkLtziDVA=;
        b=TmolDWuHItMlaBF6klwM3YYCtP6H+TbjCqIW8rHoTXO9GifgK3ooqmxFcdAExGl3Lj8OJo
        /tsjP3CY/+lH7UZh89m2GBi37HOMY+CiPma0iF7JEB1kiRTZssh9h2yWQm3R0Gaa99lz9P
        U246+qnoD+BCMr2fEh1oYNy54TtvWlk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-hSX6i_CLPA273J-8NNcl7A-1; Wed, 20 Oct 2021 03:22:54 -0400
X-MC-Unique: hSX6i_CLPA273J-8NNcl7A-1
Received: by mail-wm1-f72.google.com with SMTP id d16-20020a1c1d10000000b0030d738feddfso2610365wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 00:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=bBVyUUUV2qr6b1veT83eC89VUSUZjroodvAkLtziDVA=;
        b=4MYZdBwn+SNggHjGZ2Qhj3C9BgXmht9Cl7P1mLVhwMdrnnKgmQDmIN3UI5mFzKMUus
         wuoTFrNTdpIfXYHj+qok1qzI1eQoBc9KpLFTRwta4gApe4w47Us8N34mGDbp7pWzWD1J
         NiFsw/Jpy0FqMBj8cyxo2qN7XE/81FqtTycgcY45TG3C6zViduRzhDAC9UtOoPNYWb4e
         60UQU8M3bk3UH6dX2Wj2wB3ZbNGj8CXCQAJGw5JzNBctlkENpWW6vNFcRFVw6CP/6XVx
         ZVj3j3Nh1mcOjKmxec1n5VU5hx4o+2AAh8/0hHtsvGD3O9PzSmYla5h0EzxQC1cbXfDO
         QUEA==
X-Gm-Message-State: AOAM533PTeTm9OgrJH0TK0rbnacBv0iNcuZSzE81UxhYEuSga7JS+tm7
        78CaV8MTo3BFFnDoSPKXVe1OFaug/hFbNog03eqxHHjy+2q++9bU+fTj0WjS1fvVgJOECawuenO
        FU/vGV0ONbcAliHF6wZvtsdy2
X-Received: by 2002:a05:600c:4305:: with SMTP id p5mr11655069wme.185.1634714573611;
        Wed, 20 Oct 2021 00:22:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeECWzXPEd6kpPWo92LCpCrKx1bckrlG3iRkGHpqTIVNWqvjHwGgZjeXNONhoiuRwi8ryzQg==
X-Received: by 2002:a05:600c:4305:: with SMTP id p5mr11655045wme.185.1634714573394;
        Wed, 20 Oct 2021 00:22:53 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63d4.dip0.t-ipconnect.de. [91.12.99.212])
        by smtp.gmail.com with ESMTPSA id 3sm1257425wms.5.2021.10.20.00.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 00:22:52 -0700 (PDT)
Message-ID: <99b496b7-c465-eac3-d7ad-18a615fe94a7@redhat.com>
Date:   Wed, 20 Oct 2021 09:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20211019031407.GB7910@xsang-OptiPlex-9020>
 <87wnm9ovz2.fsf@disp2133>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [mm] 6128b3af2a: UBSAN:shift-out-of-bounds_in(null)
In-Reply-To: <87wnm9ovz2.fsf@disp2133>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.21 17:49, Eric W. Biederman wrote:
> kernel test robot <oliver.sang@intel.com> writes:
> 
>> Greeting,
>>
>> FYI, we noticed the following commit (built with clang-14):
>>
>> commit: 6128b3af2a5e42386aa7faf37609b57f39fb7d00 ("mm: ignore MAP_DENYWRITE in ksys_mmap_pgoff()")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> I believe this failure is misattributed.  Perhaps your reproducer
> only intermittently reproduces the problem?
> 
> The change in question only contains
> 
> 	flags &= ~MAP_DENYWRITE
> 
> After all of the other users of MAP_DENYWRITE had been removed from the
> kernel.  So I don't see how it could possibly be responsible for the
> reported shift out of bounds problem.
> 
> Eric

Thanks for looking into this Eric while I spent the last couple of days
in bed feeling miserable. :)


So we get 9 new instances of "UBSAN:shift-out-of-bounds_in(null)" (NULL
pointer dereference) on 6128b3af2a compared to 6128b3af2a^ (8d0920bde5),
apparently inside ksys_mmap_pgoff() on 32bit.

As we're dealing with a fuzzer, is there any reproducer as sometimes
provided by syzkaller? The report itself is not very helpful when
judging if that patch is actually responsible for what we're seeing.

I agree with Eric that it's rather unlikely that when we stop masking
off a bit that's ignored throughout the kernel, that we suddenly trigger
a NULL pointer de-reference. But I learned that everything is possible ;)

-- 
Thanks,

David / dhildenb


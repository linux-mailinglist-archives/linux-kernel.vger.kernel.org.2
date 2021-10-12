Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B755042A2DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhJLLLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236004AbhJLLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634036971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4tr+WT1IxgZxfPSMgT77kTtr4zb6xglyk4OS2F3Jl0=;
        b=U6PCpwePlMj9vVRkz4zszyay/Y4GV8kyR5/C61F/GjVCRp3vbM78WjLc43jgpesD//XZMK
        lb7fssI1Z5+cbCGMGW9QrY3L/rEPcna7ph5zuPYtxJOUWCyOE10bHCeN2acIvpZSfrOaj0
        N2yqFwukx2zvTQmgwdWHAZpH4Ghiz1c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-SM0MPAUEMq2thOOZrJuCgw-1; Tue, 12 Oct 2021 07:09:30 -0400
X-MC-Unique: SM0MPAUEMq2thOOZrJuCgw-1
Received: by mail-wr1-f70.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso15434340wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 04:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=A4tr+WT1IxgZxfPSMgT77kTtr4zb6xglyk4OS2F3Jl0=;
        b=VPdJL5maErMaflXbfSCRn2bmiz4Iq5mtZrBGebrRgrFouB5u6sbMHZHtKQSGTWJFwl
         ShNl7cghMBLHJIPCyyzPxb98rX1Q1Ve4pzR/IHn3+/6Z9lZdadYJNz6rWSKgLQz1CtcP
         8ng4+4+l4peAVdETuV2inE8K466f/8gyxngYwsl8nlgmvVFzGAWlJXE6+BBtHKC8bB8U
         Mb+mXQT3g7+k7yL+98W6yQPjSbycQhPMz5ivwnAwayaOLnsaiP8HWE9f0jwKpnkLEYTy
         172Rq65uu3ZnQ1fWW8vuvUKQYKw+tjm8e5KmdMCSSrHtmE9xJsqHip3lLV4aiWWDwqYt
         qcqw==
X-Gm-Message-State: AOAM533CRumkE5OmAMGJfTCWi3tk2thxYC4BDXj2wuvhar7CEXNqrIKn
        yKkkpmb1Y1K0kPfEwxzwiQ6pwqVucmw6/bRCpgAhb5bwHVBWIaYwiY10AS9H9lX0ffJtvRTcyiQ
        gynCX+/kuKi0Q1721MA5hWisv
X-Received: by 2002:adf:f243:: with SMTP id b3mr27633248wrp.60.1634036969029;
        Tue, 12 Oct 2021 04:09:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygxbR8TZi995RillXEzlYF5xWuVLmUYBvwoxySOHwlJfQ8XK3bdv479X7rqn+gjR5inWbuyw==
X-Received: by 2002:adf:f243:: with SMTP id b3mr27633215wrp.60.1634036968803;
        Tue, 12 Oct 2021 04:09:28 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a12.dip0.t-ipconnect.de. [91.12.106.18])
        by smtp.gmail.com with ESMTPSA id l20sm3150399wmq.42.2021.10.12.04.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 04:09:28 -0700 (PDT)
Subject: Re: [PATCH memcg] mm/page_alloc.c: avoid statistic update with 0
To:     Vasily Averin <vvs@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>
References: <b2371951-bb8a-e62e-8d33-10830bbf6275@virtuozzo.com>
 <29155011-f884-b0e5-218e-911039568acb@suse.cz>
 <f52c5cd3-9b74-0fd5-2b7b-83ca21c52b2a@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0a707990-f12c-3c60-2a96-e1d531e100a6@redhat.com>
Date:   Tue, 12 Oct 2021 13:09:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f52c5cd3-9b74-0fd5-2b7b-83ca21c52b2a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.21 12:42, Vasily Averin wrote:
> On 08.10.2021 14:47, Vlastimil Babka wrote:
>> On 10/8/21 11:24, Vasily Averin wrote:
>>> __alloc_pages_bulk can call __count_zid_vm_events and zone_statistics
>>> with nr_account = 0.
>>
>> But that's not a bug, right? Just an effective no-op that's not commonly
>> happening, so is it worth the check?
> 
> Why not?
> 
> Yes, it's not a bug, it just makes the kernel a bit more efficient in a very unlikely case.
> However, it looks strange and makes uninformed code reviewers like me worry about possible
> problems inside the affected functions. No one else calls these functions from 0.
>   

If it's not a BUG we'd better leave "Fixes:" tags away., it tends to 
confuse people looking for actual BUGs.

I'm also not sure if this micro-optimization is worth it. "bit more 
efficient in a very unlikely case" doesn't sound very compelling ... and 
personally I'd assume accounting functions can deal with a delta of 0.

-- 
Thanks,

David / dhildenb

